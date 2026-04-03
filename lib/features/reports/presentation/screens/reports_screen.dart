import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
            // Latest report summary
            latestAsync.when(
              data: (latest) {
                if (latest == null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Reports Generated Yet',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _generateReport(context, ref),
                            child: const Text('Generate First Report'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          latest.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Generated: ${DateFormat('MMM d, yyyy').format(latest.generatedAt ?? DateTime.now())}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: MetricCard(
                                label: 'Coverage',
                                value:
                                    '${latest.coveragePercentage.toStringAsFixed(1)}%',
                                icon: Icons.shield,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: MetricCard(
                                label: 'Gaps',
                                value: latest.unresolvedGaps.length.toString(),
                                icon: Icons.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const LoadingWidget(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            // All reports list
            SectionHeader(title: 'Report History'),
            const SizedBox(height: 16),
            reportsAsync.when(
              data: (reports) {
                if (reports.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No Reports',
                    subtitle:
                        'Generate a report to track your security posture',
                    icon: Icons.article_outlined,
                    actionLabel: 'Generate Report',
                    onActionPressed: () => _generateReport(context, ref),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reports.length,
                  itemBuilder: (context, index) => _ReportCard(
                    report: reports[index],
                    onTap: () => _showReportDetail(context, reports[index]),
                  ),
                );
              },
              loading: () => const LoadingWidget(message: 'Loading reports...'),
              error: (err, st) => EmptyStateWidget(
                title: 'Error',
                subtitle: err.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generateReport(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _generateReport(BuildContext context, WidgetRef ref) {
    final report = ReportSummary(
      id: const Uuid().v4(),
      title:
          'Security Posture Report - ${DateTime.now().toIso8601String().split('T')[0]}',
      totalTechniquesReviewed: 150,
      coveragePercentage: 65.5,
      topRiskyTechniques: [
        'T1566 - Phishing',
        'T1190 - Exploit Public-Facing Application',
      ],
      unresolvedGaps: [
        'Detection for T1195 - Supply Chain Compromise',
        'Mitigation for T1203 - Exploitation for Client Execution',
      ],
      recommendedActions: [
        'Implement email filtering and user awareness training',
        'Deploy EDR solution for better threat detection',
        'Review and update firewall rules',
      ],
      generatedAt: DateTime.now(),
      notes: 'This report was auto-generated from the latest coverage data.',
    );

    ref.read(generateReportProvider(report));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report generated successfully')),
    );
  }

  void _showReportDetail(BuildContext context, ReportSummary report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ReportDetailSheet(report: report),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final ReportSummary report;
  final VoidCallback onTap;

  const _ReportCard({required this.report, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.description, color: Colors.cyan),
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
                    const SizedBox(height: 4),
                    Text(
                      DateFormat(
                        'MMM d, yyyy',
                      ).format(report.generatedAt ?? DateTime.now()),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text('${report.coveragePercentage.toStringAsFixed(1)}%'),
                backgroundColor: Colors.cyan.withValues(alpha: 0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportDetailSheet extends StatelessWidget {
  final ReportSummary report;

  const _ReportDetailSheet({required this.report});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: scrollController,
          children: [
            Text(
              report.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Coverage section
            Text('Coverage', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${report.coveragePercentage.toStringAsFixed(1)}%',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              Text(
                                'Techniques Covered',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ProgressRing(
                            percentage: report.coveragePercentage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Top risky techniques
            Text(
              'Top Risky Techniques',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...report.topRiskyTechniques
                .map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.security, color: Colors.orange),
                      title: Text(t),
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: 16),
            // Unresolved gaps
            Text(
              'Unresolved Gaps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...report.unresolvedGaps
                .map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.warning, color: Colors.red),
                      title: Text(g),
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: 16),
            // Recommendations
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...report.recommendedActions
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.cyan,
                          child: Text(
                            (e.key + 1).toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e.value)),
                      ],
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('Close Report'),
            ),
          ],
        ),
      ),
    );
  }
}
