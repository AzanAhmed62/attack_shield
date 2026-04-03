import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class ThreatMappingScreen extends ConsumerWidget {
  const ThreatMappingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(allAlertsProvider);
    final assetsAsync = ref.watch(allAssetsProvider);
    final reportsAsync = ref.watch(allReportsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Coverage & Threat Mapping')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk Score Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Organization Risk Score',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _RiskScoreWidget(
                            score: 42,
                            label: 'Risk Level',
                            context: context,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Critical: 5',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'High: 12',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.orange),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Medium: 18',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.yellow[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Coverage Overview
            reportsAsync.when(
              data: (reports) {
                if (reports.isEmpty) {
                  return const SizedBox.shrink();
                }
                final latest = reports.isNotEmpty ? reports.first : null;
                if (latest == null) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coverage Overview',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${latest.coveragePercentage.toStringAsFixed(1)}%',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                      Text(
                                        'Overall Coverage',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ProgressRing(
                                    percentage: latest.coveragePercentage,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            // Coverage by Technique Category
            Text(
              'Coverage by Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _CoverageListTile(
                    title: 'Initial Access',
                    covered: 12,
                    total: 18,
                    context: context,
                  ),
                  const Divider(),
                  _CoverageListTile(
                    title: 'Execution',
                    covered: 15,
                    total: 21,
                    context: context,
                  ),
                  const Divider(),
                  _CoverageListTile(
                    title: 'Persistence',
                    covered: 8,
                    total: 16,
                    context: context,
                  ),
                  const Divider(),
                  _CoverageListTile(
                    title: 'Defense Evasion',
                    covered: 11,
                    total: 19,
                    context: context,
                  ),
                  const Divider(),
                  _CoverageListTile(
                    title: 'Credential Access',
                    covered: 9,
                    total: 14,
                    context: context,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Asset Type Distribution
            assetsAsync.when(
              data: (assets) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Asset Type Distribution',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Column(
                        children: [
                          _RiskDistributionTile(
                            title: 'Network Assets',
                            count: assets
                                .where((a) => a.type == 'Network')
                                .length,
                            color: Colors.red,
                          ),
                          const Divider(),
                          _RiskDistributionTile(
                            title: 'Server Assets',
                            count: assets
                                .where((a) => a.type == 'Server')
                                .length,
                            color: Colors.orange,
                          ),
                          const Divider(),
                          _RiskDistributionTile(
                            title: 'Workstation Assets',
                            count: assets
                                .where((a) => a.type == 'Workstation')
                                .length,
                            color: Colors.yellow[700]!,
                          ),
                          const Divider(),
                          _RiskDistributionTile(
                            title: 'Application Assets',
                            count: assets
                                .where((a) => a.type == 'Application')
                                .length,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const LoadingWidget(message: 'Loading assets...'),
              error: (err, st) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            // Top Threats
            alertsAsync.when(
              data: (alerts) {
                final topThreats = alerts
                    .where(
                      (a) =>
                          a.priority == AlertPriority.critical ||
                          a.priority == AlertPriority.high,
                    )
                    .take(5)
                    .toList();

                if (topThreats.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Active Threats',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ...topThreats.map((threat) {
                      final severityColor =
                          threat.priority == AlertPriority.critical
                          ? Colors.red
                          : Colors.orange;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 4,
                            decoration: BoxDecoration(
                              color: severityColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          title: Text(threat.title),
                          subtitle: Text(
                            threat.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Chip(
                            label: Text(
                              threat.priority.toString().split('.').last,
                            ),
                            backgroundColor: severityColor.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
              loading: () => const LoadingWidget(message: 'Loading threats...'),
              error: (err, st) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiskScoreWidget extends StatelessWidget {
  final int score;
  final String label;
  final BuildContext context;

  const _RiskScoreWidget({
    required this.score,
    required this.label,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final color = score > 70
        ? Colors.red
        : score > 40
        ? Colors.orange
        : Colors.yellow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: score / 100,
                  minHeight: 24,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$score',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CoverageListTile extends StatelessWidget {
  final String title;
  final int covered;
  final int total;
  final BuildContext context;

  const _CoverageListTile({
    required this.title,
    required this.covered,
    required this.total,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (covered / total * 100).toStringAsFixed(1);

    return ListTile(
      title: Text(title),
      subtitle: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: covered / total,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            covered / total > 0.7 ? Colors.green : Colors.orange,
          ),
        ),
      ),
      trailing: Text(
        '$covered/$total ($percentage%)',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class _RiskDistributionTile extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _RiskDistributionTile({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$count',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
