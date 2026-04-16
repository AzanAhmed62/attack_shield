import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/services/risk_engine.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(allReportsProvider);
    final latestAsync = ref.watch(latestReportProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Security Reports')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Live Security Posture Summary ───────────────────────────
            const _LivePostureCard(),
            const SizedBox(height: 24),
            reportsAsync.when(
              data: (reports) => RiskTrendLineChart(reports: reports),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),

            // ── Latest Saved Report ─────────────────────────────────────
            const SectionHeader(title: 'Latest Report'),
            const SizedBox(height: 12),
            latestAsync.when(
              data: (latest) => latest == null
                  ? _EmptyReportCard(onGenerate: () => _generateReport(context, ref))
                  : _LatestReportCard(
                      report: latest,
                      onExport: () => _exportPdf(context, ref, latest),
                      onView: () => _showDetail(context, latest),
                    ),
              loading: () => const LoadingWidget(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),

            // ── Report History ──────────────────────────────────────────
            const SectionHeader(title: 'Report History'),
            const SizedBox(height: 12),
            reportsAsync.when(
              data: (reports) => reports.isEmpty
                  ? EmptyStateWidget(
                      title: 'No Reports Yet',
                      subtitle: 'Generate a report to track security posture over time',
                      icon: Icons.article_outlined,
                      actionLabel: 'Generate Report',
                      onActionPressed: () => _generateReport(context, ref),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reports.length,
                      itemBuilder: (_, i) => _ReportCard(
                        report: reports[i],
                        onTap: () => _showDetail(context, reports[i]),
                        onExport: () => _exportPdf(context, ref, reports[i]),
                      ),
                    ),
              loading: () => const LoadingWidget(message: 'Loading reports…'),
              error: (e, _) => EmptyStateWidget(
                title: 'Error',
                subtitle: e.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generateReport(context, ref),
        icon: const Icon(Icons.add_chart),
        label: const Text('Generate Report'),
      ),
    );
  }

  // ── Generate a report from live risk engine data ──────────────────────────

  Future<void> _generateReport(BuildContext context, WidgetRef ref) async {
    final techniques = await ref.read(allTechniquesProvider.future);
    final coverageStatuses = await ref.read(allCoverageStatusesProvider.future);

    final riskScore = RiskEngine.organizationRiskScore(techniques, coverageStatuses);
    final coverage = RiskEngine.coveragePercentage(techniques, coverageStatuses);
    final gaps = RiskEngine.topRiskGaps(techniques, coverageStatuses, limit: 10);
    final tacticRisks = RiskEngine.tacticRiskMap(techniques, coverageStatuses);

    // Top risky technique labels
    final topRisky = gaps
        .take(5)
        .map((g) => '${g.technique.id} - ${g.technique.name}')
        .toList();

    // Unresolved gaps (not covered, sorted by risk)
    final unresolvedGaps = gaps
        .where((g) => g.coverageLevel != CoverageLevel.partiallyCovered)
        .take(5)
        .map((g) => 'No detection/mitigation for ${g.technique.id} (${g.technique.name})')
        .toList();

    // Recommendations derived from highest-risk tactics
    final sortedTactics = tacticRisks.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final recommendations = _buildRecommendations(sortedTactics.take(5).toList());

    final report = ReportSummary(
      id: const Uuid().v4(),
      title: 'Security Posture Report — ${DateFormat('MMM d, yyyy').format(DateTime.now())}',
      totalTechniquesReviewed: techniques.length,
      riskScore: riskScore,
      coveragePercentage: coverage,
      topRiskyTechniques: topRisky,
      unresolvedGaps: unresolvedGaps,
      recommendedActions: recommendations,
      generatedAt: DateTime.now(),
      notes:
          'Risk Score: ${riskScore.toStringAsFixed(1)}/100 (${RiskEngine.riskLabel(riskScore)}). '
          'Based on ${techniques.length} ATT&CK techniques across all tactics.',
    );

    await ref.read(generateReportProvider(report).future);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Report generated — coverage ${coverage.toStringAsFixed(1)}%'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  List<String> _buildRecommendations(
    List<MapEntry<String, double>> topRiskyTactics,
  ) {
    const tacticRecommendations = <String, String>{
      'Impact':
          'Implement immutable backups and test recovery procedures to defend against ransomware and data destruction.',
      'Exfiltration':
          'Deploy Data Loss Prevention (DLP) controls and monitor large outbound data transfers.',
      'Command and Control':
          'Enable SSL/TLS inspection at the network boundary and filter known C2 domains via DNS.',
      'Execution':
          'Restrict script interpreters (PowerShell, bash) via policy and enable script block logging.',
      'Credential Access':
          'Enable MFA across all accounts and deploy Windows Credential Guard.',
      'Privilege Escalation':
          'Review and restrict sudo/admin permissions and enable UAC audit logging.',
      'Lateral Movement':
          'Segment the network and enforce MFA for RDP/SSH remote access.',
      'Persistence':
          'Audit autostart locations, scheduled tasks, and new service installations.',
      'Defense Evasion':
          'Deploy EDR with behavioral detection and monitor for security tool termination.',
      'Discovery':
          'Limit internal network scan ability via firewall rules and monitor enumeration commands.',
      'Initial Access':
          'Deploy email security gateway with anti-phishing, attachment sandboxing, and user training.',
      'Reconnaissance':
          'Reduce public footprint and monitor for external scanning of your IP ranges.',
    };

    final recs = <String>[];
    for (final entry in topRiskyTactics) {
      final rec = tacticRecommendations[entry.key];
      if (rec != null && !recs.contains(rec)) recs.add(rec);
    }

    // Always add general recommendations
    if (recs.length < 3) {
      recs.addAll([
        'Conduct quarterly ATT&CK coverage assessments and update defensive controls accordingly.',
        'Enroll all privileged accounts in MFA and rotate credentials on a 90-day cycle.',
        'Establish a Security Operations Center (SOC) process to triage and respond to critical alerts within 1 hour.',
      ]);
    }

    return recs.take(5).toList();
  }

  // ── PDF Export ────────────────────────────────────────────────────────────

  Future<void> _exportPdf(
    BuildContext context,
    WidgetRef ref,
    ReportSummary report,
  ) async {
    final techniques = await ref.read(allTechniquesProvider.future);
    final coverageStatuses = await ref.read(allCoverageStatusesProvider.future);
    final riskScore = RiskEngine.organizationRiskScore(techniques, coverageStatuses);
    final gaps = RiskEngine.topRiskGaps(techniques, coverageStatuses, limit: 10);
    final breakdown = RiskEngine.coverageBreakdown(techniques, coverageStatuses);

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'ATT&CK DEFENDER',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.cyan700,
                      ),
                    ),
                    pw.Text(
                      'Security Posture Report',
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  DateFormat('MMM d, yyyy').format(report.generatedAt ?? DateTime.now()),
                  style: const pw.TextStyle(color: PdfColors.grey600),
                ),
              ],
            ),
            pw.Divider(color: PdfColors.cyan700),
            pw.SizedBox(height: 4),
          ],
        ),
        build: (context) => [
          // ── Title ─────────────────────────────────────────────────────
          pw.Text(
            report.title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            report.notes ?? '',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 20),

          // ── Executive Summary ─────────────────────────────────────────
          _pdfSection('Executive Summary'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              _pdfTableRow(['Metric', 'Value'], isHeader: true),
              _pdfTableRow([
                'Organization Risk Score',
                '${riskScore.toStringAsFixed(1)} / 100 — ${RiskEngine.riskLabel(riskScore)}',
              ]),
              _pdfTableRow([
                'Defensive Coverage',
                '${report.coveragePercentage.toStringAsFixed(1)}%',
              ]),
              _pdfTableRow([
                'Techniques Reviewed',
                '${report.totalTechniquesReviewed}',
              ]),
              _pdfTableRow([
                'Covered',
                '${breakdown['covered']} techniques',
              ]),
              _pdfTableRow([
                'Partially Covered',
                '${breakdown['partiallyCovered']} techniques',
              ]),
              _pdfTableRow([
                'Not Covered',
                '${breakdown['notCovered']} techniques',
              ]),
            ],
          ),
          pw.SizedBox(height: 20),

          // ── Top Risk Gaps ─────────────────────────────────────────────
          _pdfSection('Top Priority Risk Gaps'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            columnWidths: {
              0: const pw.FixedColumnWidth(70),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FixedColumnWidth(70),
              3: const pw.FixedColumnWidth(80),
            },
            children: [
              _pdfTableRow(['ID', 'Technique', 'Risk', 'Coverage'], isHeader: true),
              ...gaps.map(
                (g) => _pdfTableRow([
                  g.technique.id,
                  g.technique.name,
                  '${g.exposedRiskScore.toStringAsFixed(1)} — ${g.riskLabel}',
                  g.coverageLabel,
                ]),
              ),
            ],
          ),
          pw.SizedBox(height: 20),

          // ── Recommendations ───────────────────────────────────────────
          _pdfSection('Recommended Actions'),
          ...report.recommendedActions.asMap().entries.map(
                (e) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${e.key + 1}. ',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          e.value,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          pw.SizedBox(height: 20),

          // ── Footer note ───────────────────────────────────────────────
          pw.Divider(),
          pw.Text(
            'Generated by ATT&CK Defender — Based on MITRE ATT&CK® Framework v14 (Enterprise).\n'
            'MITRE ATT&CK® is a registered trademark of The MITRE Corporation.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'attackshield_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  // ── PDF helpers ───────────────────────────────────────────────────────────

  pw.Widget _pdfSection(String title) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 13,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.cyan800,
          ),
        ),
      );

  pw.TableRow _pdfTableRow(List<String> cells, {bool isHeader = false}) =>
      pw.TableRow(
        decoration: isHeader
            ? const pw.BoxDecoration(color: PdfColors.grey200)
            : null,
        children: cells
            .map(
              (cell) => pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(
                  cell,
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight:
                        isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
                  ),
                ),
              ),
            )
            .toList(),
      );

  void _showDetail(BuildContext context, ReportSummary report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ReportDetailSheet(report: report),
    );
  }
}

// ─── Live Posture Card ────────────────────────────────────────────────────────

class _LivePostureCard extends ConsumerWidget {
  const _LivePostureCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riskAsync = ref.watch(organizationRiskScoreProvider);
    final coverageAsync = ref.watch(riskEngineCoveragePercentageProvider);
    final breakdownAsync = ref.watch(riskCoverageBreakdownProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.monitor_heart, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Live Security Posture',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Risk Score
                Expanded(
                  child: riskAsync.when(
                    data: (score) {
                      final color = _riskColor(score);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Risk Score', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 4),
                          Text(
                            score.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          Text(
                            '/ 100 — ${RiskEngine.riskLabel(score)}',
                            style: TextStyle(color: color, fontSize: 12),
                          ),
                        ],
                      );
                    },
                    loading: () => const LoadingWidget(),
                    error: (_, __) => const Text('—'),
                  ),
                ),
                const SizedBox(width: 16),
                // Coverage Ring
                coverageAsync.when(
                  data: (pct) => ProgressRing(
                    percentage: pct,
                    progressColor: _coverageColor(pct),
                    label: 'Coverage',
                  ),
                  loading: () => const LoadingWidget(),
                  error: (_, __) => const Text('—'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Breakdown chips
            breakdownAsync.when(
              data: (b) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _BreakdownChip('Covered', b['covered'] ?? 0, AppTheme.successColor),
                  _BreakdownChip('Partial', b['partiallyCovered'] ?? 0, AppTheme.warningColor),
                  _BreakdownChip('Not Covered', b['notCovered'] ?? 0, AppTheme.dangerColor),
                  _BreakdownChip('Unknown', b['unknown'] ?? 0, Colors.grey),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            allTechAsync.when(
              data: (t) => Text(
                '${t.length} parent techniques · ${t.fold(0, (s, e) => s + e.subTechniques.length)} sub-techniques',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Color _riskColor(double score) {
    if (score >= 80) return AppTheme.dangerColor;
    if (score >= 60) return AppTheme.accentColor;
    if (score >= 40) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  Color _coverageColor(double pct) {
    if (pct >= 70) return AppTheme.successColor;
    if (pct >= 40) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }
}

// ─── Empty report card ────────────────────────────────────────────────────────

class _EmptyReportCard extends StatelessWidget {
  final VoidCallback onGenerate;
  const _EmptyReportCard({required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No Reports Generated Yet',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Generate your first report to snapshot the current security posture.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onGenerate,
              icon: const Icon(Icons.add_chart),
              label: const Text('Generate First Report'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Latest Report Card ───────────────────────────────────────────────────────

class _LatestReportCard extends StatelessWidget {
  final ReportSummary report;
  final VoidCallback onExport;
  final VoidCallback onView;

  const _LatestReportCard({
    required this.report,
    required this.onExport,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(report.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Generated ${DateFormat('MMM d, yyyy – HH:mm').format(report.generatedAt ?? DateTime.now())}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    label: 'Risk',
                    value: '${report.riskScore.toStringAsFixed(1)}',
                    icon: Icons.monitor_heart_outlined,
                    valueColor: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    label: 'Coverage',
                    value: '${report.coveragePercentage.toStringAsFixed(1)}%',
                    icon: Icons.shield,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MetricCard(
              label: 'Risk Gaps',
              value: report.unresolvedGaps.length.toString(),
              icon: Icons.warning,
              valueColor: AppTheme.dangerColor,
            ),
            if (report.notes != null) ...[
              const SizedBox(height: 8),
              Text(report.notes!, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onView,
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onExport,
                    icon: const Icon(Icons.picture_as_pdf, size: 16),
                    label: const Text('Export PDF'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Report list card ─────────────────────────────────────────────────────────

class _ReportCard extends StatelessWidget {
  final ReportSummary report;
  final VoidCallback onTap;
  final VoidCallback onExport;

  const _ReportCard({
    required this.report,
    required this.onTap,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('MMM d, yyyy').format(
                        report.generatedAt ?? DateTime.now(),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${report.coveragePercentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf, size: 20),
                color: AppTheme.primaryColor,
                onPressed: onExport,
                tooltip: 'Export PDF',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Detail bottom sheet ──────────────────────────────────────────────────────

class _ReportDetailSheet extends StatelessWidget {
  final ReportSummary report;
  const _ReportDetailSheet({required this.report});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ListView(
          controller: controller,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(report.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Generated ${DateFormat('MMM d, yyyy – HH:mm').format(report.generatedAt ?? DateTime.now())}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (report.notes != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(report.notes!, style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
            const SizedBox(height: 20),

            // ── Coverage ─────────────────────────────────────────────────
            const _SheetSection(title: 'Coverage Overview'),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    label: 'Risk',
                    value: '${report.riskScore.toStringAsFixed(1)}',
                    icon: Icons.monitor_heart_outlined,
                    valueColor: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    label: 'Coverage',
                    value: '${report.coveragePercentage.toStringAsFixed(1)}%',
                    icon: Icons.shield,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    label: 'Risk Gaps',
                    value: '${report.unresolvedGaps.length}',
                    icon: Icons.warning_amber_outlined,
                    valueColor: AppTheme.dangerColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Top Risky ────────────────────────────────────────────────
            const _SheetSection(title: 'Top Risky Techniques'),
            ...report.topRiskyTechniques.map(
              (t) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.security, color: AppTheme.accentColor),
                title: Text(t, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            const SizedBox(height: 16),

            // ── Unresolved Gaps ──────────────────────────────────────────
            const _SheetSection(title: 'Unresolved Gaps'),
            ...report.unresolvedGaps.map(
              (g) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.warning_amber, color: AppTheme.dangerColor),
                title: Text(g, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            const SizedBox(height: 16),

            // ── Recommendations ──────────────────────────────────────────
            const _SheetSection(title: 'Recommended Actions'),
            ...report.recommendedActions.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppTheme.primaryColor,
                      child: Text(
                        '${e.key + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(e.value, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetSection extends StatelessWidget {
  final String title;
  const _SheetSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

// ─── Breakdown chip ───────────────────────────────────────────────────────────

class _BreakdownChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _BreakdownChip(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 12)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
