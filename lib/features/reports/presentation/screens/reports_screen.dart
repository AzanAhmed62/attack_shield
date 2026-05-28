// lib/features/reports/presentation/screens/reports_screen.dart
// FIX: added missing import for RiskReport from core/engine/risk_engine.dart
// FIX: _buildPdf now correctly typed and uses real coverage data

import 'package:flutter/material.dart';
import 'dart:typed_data' show Uint8List;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// FIX: import RiskReport — was missing, caused compile error
import '../../../../core/engine/risk_engine.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/repository_providers.dart';

class ReportsScreen extends HookConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riskReport = ref.watch(riskReportProvider);
    final isGenerating = useState(false);
    final statusMsg = useState<String?>(null);
    final cs = Theme.of(context).colorScheme;

    Future<void> generateReport() async {
      isGenerating.value = true;
      statusMsg.value = 'Gathering coverage data...';
      try {
        final report = await ref.read(riskReportProvider.future);
        final allTechs = await ref.read(allTechniquesProvider.future);
        final orgName =
            GetStorage().read<String>('org_name') ?? 'Your Organisation';
        final sector = GetStorage().read<String>('org_sector') ?? '';

        final topGapNames = report.topGaps.map((id) {
          final t = allTechs.where((x) => x.id == id).firstOrNull;
          return t != null ? '$id — ${t.name}' : id;
        }).toList();

        statusMsg.value = 'Generating AI executive summary...';
        String narrative = '';
        final gemini = ref.read(geminiServiceProvider);
        final aiResult = await gemini.generateReportNarrative(
          orgName: orgName,
          coveragePercent: report.coveragePercent,
          totalTechniques: report.totalTechniques,
          coveredCount: report.coveredCount,
          criticalGaps: report.uncoveredCount,
          topUncoveredTechniques: topGapNames,
        );
        if (aiResult.isSuccess) narrative = aiResult.text ?? '';

        statusMsg.value = 'Building PDF...';
        final pdfBytes = await _buildPdf(
          orgName: orgName,
          sector: sector,
          report: report,
          topGapNames: topGapNames,
          narrative: narrative,
        );

        statusMsg.value = null;
        await Printing.sharePdf(
          bytes: Uint8List.fromList(pdfBytes),
          filename:
              'ATTCKShield_${DateTime.now().toIso8601String().substring(0, 10)}.pdf',
        );
      } catch (e) {
        statusMsg.value = 'Error: $e';
      } finally {
        isGenerating.value = false;
      }
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text(
          'Reports',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          riskReport.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error loading data: $e'),
            data: (r) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Preview card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cs.outlineVariant, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 20,
                            color: cs.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ATT\u0026CK Shield Security Report',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Generated ${DateTime.now().toString().substring(0, 10)}',
                        style: TextStyle(fontSize: 12, color: cs.outline),
                      ),
                      const Divider(height: 24),

                      _ReportStat(
                        icon: Icons.security_rounded,
                        label: 'Risk Score',
                        value: '${r.orgRiskScore.toStringAsFixed(0)}/100',
                        color: r.orgRiskScore >= 75
                            ? Colors.red.shade600
                            : r.orgRiskScore >= 50
                            ? Colors.orange.shade600
                            : Colors.green.shade600,
                      ),
                      const SizedBox(height: 10),
                      _ReportStat(
                        icon: Icons.verified_user_outlined,
                        label: 'Coverage',
                        value:
                            '${r.coveragePercent.toStringAsFixed(0)}% (${r.coveredCount} covered, ${r.uncoveredCount} gaps)',
                        color: cs.primary,
                      ),
                      const SizedBox(height: 10),
                      _ReportStat(
                        icon: Icons.dataset_outlined,
                        label: 'Techniques',
                        value: '${r.totalTechniques} across 14 tactics',
                        color: cs.primary,
                      ),
                      const SizedBox(height: 10),
                      _ReportStat(
                        icon: Icons.auto_awesome_rounded,
                        label: 'AI Summary',
                        value: ref.read(geminiServiceProvider).hasApiKey
                            ? 'Will be generated by Gemini'
                            : 'Configure API key in Settings',
                        color: ref.read(geminiServiceProvider).hasApiKey
                            ? Colors.green.shade600
                            : cs.outline,
                      ),
                      const Divider(height: 24),

                      Text(
                        'Report includes:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...[
                        'Cover page with org name and date',
                        'AI-generated executive summary',
                        'Risk score with label',
                        'Coverage breakdown by tactic',
                        'Top 10 highest-risk uncovered techniques',
                      ].map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: Colors.green.shade600,
                              ),
                              const SizedBox(width: 6),
                              Text(item, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                if (statusMsg.value != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          statusMsg.value!,
                          style: TextStyle(fontSize: 13, color: cs.onSurface),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: isGenerating.value
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.picture_as_pdf_rounded),
                    label: Text(
                      isGenerating.value
                          ? 'Generating...'
                          : 'Generate & Export PDF',
                    ),
                    onPressed: isGenerating.value ? null : generateReport,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (!isGenerating.value)
                  Text(
                    'PDF will open the share sheet — save, email, or print.',
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.outline,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FIX: explicit RiskReport type (import now present)
  Future<List<int>> _buildPdf({
    required String orgName,
    required String sector,
    required RiskReport report,
    required List<String> topGapNames,
    required String narrative,
  }) async {
    final doc = pw.Document();
    final date = DateTime.now().toString().substring(0, 10);
    final riskColor = report.orgRiskScore >= 75
        ? PdfColors.red700
        : report.orgRiskScore >= 50
        ? PdfColors.orange700
        : PdfColors.green700;

    // Cover page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(32),
              color: PdfColors.blueGrey900,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'ATT&CK Shield',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Security Posture Report',
                    style: const pw.TextStyle(
                      color: PdfColors.blueGrey100,
                      fontSize: 16,
                    ),
                  ),
                  pw.SizedBox(height: 24),
                  pw.Text(
                    orgName,
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  if (sector.isNotEmpty)
                    pw.Text(
                      sector,
                      style: const pw.TextStyle(
                        color: PdfColors.blueGrey200,
                        fontSize: 13,
                      ),
                    ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Generated: $date',
                    style: const pw.TextStyle(
                      color: PdfColors.blueGrey300,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 32),
            pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Organisation Risk Score',
                      style: pw.TextStyle(
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      '${report.orgRiskScore.toStringAsFixed(0)}/100',
                      style: pw.TextStyle(
                        fontSize: 36,
                        fontWeight: pw.FontWeight.bold,
                        color: riskColor,
                      ),
                    ),
                    pw.Text(
                      report.riskLabel,
                      style: pw.TextStyle(fontSize: 14, color: riskColor),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _pdfStat(
                      'Coverage',
                      '${report.coveragePercent.toStringAsFixed(0)}%',
                    ),
                    _pdfStat('Covered', '${report.coveredCount} techniques'),
                    _pdfStat('Gaps', '${report.uncoveredCount} techniques'),
                    _pdfStat(
                      'Assessed',
                      '${report.totalTechniques} techniques',
                    ),
                  ],
                ),
              ],
            ),
            pw.Divider(),
            if (narrative.isNotEmpty) ...[
              pw.SizedBox(height: 8),
              pw.Text(
                'Executive Summary',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                narrative,
                style: const pw.TextStyle(fontSize: 11, lineSpacing: 4),
              ),
            ],
          ],
        ),
      ),
    );

    // Breakdown page
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Tactic Risk Breakdown',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.blueGrey100,
                  ),
                  children: [
                    _pdfCell('Tactic', header: true),
                    _pdfCell('Risk Score', header: true),
                    _pdfCell('Covered', header: true),
                    _pdfCell('Total', header: true),
                  ],
                ),
                ...report.tacticBreakdown.map(
                  (t) => pw.TableRow(
                    children: [
                      _pdfCell(t.tacticShortName.replaceAll('-', ' ')),
                      _pdfCell('${t.score.toStringAsFixed(0)}/100'),
                      _pdfCell('${t.coveredCount}'),
                      _pdfCell('${t.techniqueCount}'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Top 10 High-Risk Coverage Gaps',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            ...topGapNames
                .take(10)
                .toList()
                .asMap()
                .entries
                .map(
                  (e) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 4),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          '${e.key + 1}. ',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        pw.Text(
                          e.value,
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Text(
              'Generated by ATT\u0026CK Shield using MITRE ATT\u0026CK Enterprise v14.5. Risk formula: ExposedRisk = riskScore × coverageMultiplier, aggregated by tactic weight.',
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
            ),
          ],
        ),
      ),
    );

    return doc.save();
  }

  pw.Widget _pdfStat(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.Row(
      children: [
        pw.Text(
          '$label: ',
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
      ],
    ),
  );

  pw.Widget _pdfCell(String text, {bool header = false}) => pw.Padding(
    padding: const pw.EdgeInsets.all(6),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: header ? pw.FontWeight.bold : null,
      ),
    ),
  );
}

class _ReportStat extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _ReportStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: cs.outline)),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
