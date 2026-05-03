// AttackTactic is exported from attack_technique.dart via models.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/services/asset_technique_mapper.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/services/risk_engine.dart';

class ThreatMappingScreen extends ConsumerWidget {
  const ThreatMappingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coverage & Risk'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Tactic Matrix'),
              Tab(text: 'Risk Gaps'),
              Tab(text: 'Assets'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _TacticMatrixTab(),
            _RiskGapsTab(),
            _AssetsTab(),
          ],
        ),
      ),
    );
  }
}

// ─── Overview Tab ─────────────────────────────────────────────────────────────

class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riskScoreAsync = ref.watch(organizationRiskScoreProvider);
    final riskLabelAsync = ref.watch(organizationRiskLabelProvider);
    final coveragePctAsync = ref.watch(riskEngineCoveragePercentageProvider);
    final breakdownAsync = ref.watch(riskCoverageBreakdownProvider);
    final tacticRiskAsync = ref.watch(tacticRiskMapProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Risk Score Card ───────────────────────────────────────────
          _RiskScoreCard(
            riskScoreAsync: riskScoreAsync,
            riskLabelAsync: riskLabelAsync,
          ),
          const SizedBox(height: 16),

          // ── Coverage Progress ─────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Defensive Coverage Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  coveragePctAsync.when(
                    data: (pct) => Column(
                      children: [
                        Text(
                          '${pct.toStringAsFixed(1)}%',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: _coverageColor(pct),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        breakdownAsync.when(
                          data: (breakdown) =>
                              CoverageDonutChart(breakdown: breakdown, size: 180),
                          loading: () => const LoadingWidget(),
                          error: (error, _) => Text('Error: $error'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _coverageLabel(pct),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    loading: () => const LoadingWidget(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Coverage Breakdown ────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coverage Breakdown',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  breakdownAsync.when(
                    data: (breakdown) => Column(
                      children: [
                        _CoverageBreakdownRow(
                          label: 'Covered',
                          count: breakdown['covered'] ?? 0,
                          color: AppTheme.successColor,
                          icon: Icons.check_circle,
                        ),
                        _CoverageBreakdownRow(
                          label: 'Partial',
                          count: breakdown['partiallyCovered'] ?? 0,
                          color: AppTheme.warningColor,
                          icon: Icons.remove_circle,
                        ),
                        _CoverageBreakdownRow(
                          label: 'Not Covered',
                          count: breakdown['notCovered'] ?? 0,
                          color: AppTheme.dangerColor,
                          icon: Icons.cancel,
                        ),
                        _CoverageBreakdownRow(
                          label: 'Unknown',
                          count: breakdown['unknown'] ?? 0,
                          color: Colors.grey,
                          icon: Icons.help_outline,
                        ),
                      ],
                    ),
                    loading: () => const LoadingWidget(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Total Techniques ──────────────────────────────────────────
          allTechAsync.when(
            data: (techniques) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Techniques',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${techniques.length} parent + ${techniques.fold(0, (s, t) => s + t.subTechniques.length)} sub-techniques',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Text(
                      '${techniques.length}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const LoadingWidget(),
            error: (e, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          tacticRiskAsync.when(
            data: (tacticRisks) => TacticBarChart(tacticRisks: tacticRisks),
            loading: () => const LoadingWidget(),
            error: (error, _) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }

  Color _coverageColor(double pct) {
    if (pct >= 70) return AppTheme.successColor;
    if (pct >= 40) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }

  String _coverageLabel(double pct) {
    if (pct >= 70) return 'Good coverage — keep monitoring';
    if (pct >= 40) return 'Partial coverage — address gaps';
    return 'Low coverage — immediate action needed';
  }
}

class _AssetsTab extends ConsumerWidget {
  const _AssetsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(allAssetsProvider);
    final techniquesAsync = ref.watch(allTechniquesProvider);

    return assetsAsync.when(
      data: (assets) => techniquesAsync.when(
        data: (techniques) {
          if (assets.isEmpty) {
            return const EmptyStateWidget(
              title: 'No Assets',
              subtitle:
                  'Add security assets to connect your environment to ATT&CK techniques.',
              icon: Icons.layers_outlined,
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Asset Coverage Mapping',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Critical assets mapped to ATT&CK techniques by asset type, platform, and risk relevance.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                ...assets.map((asset) {
                  final related = AssetTechniqueMapper.relatedTechniques(
                    asset,
                    techniques,
                    limit: 4,
                  );
                  final tacticFocus = AssetTechniqueMapper.recommendedTactics(asset);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      asset.name,
                                      style:
                                          Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      '${asset.type} · ${asset.criticality.name}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push('/more/assets'),
                                child: const Text('Manage'),
                              ),
                            ],
                          ),
                          if (tacticFocus.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: tacticFocus
                                  .map((tactic) => Chip(label: Text(tactic)))
                                  .toList(),
                            ),
                          ],
                          const SizedBox(height: 12),
                          if (related.isEmpty)
                            Text(
                              'No related techniques found yet.',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          else
                            ...related.map(
                              (technique) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () =>
                                    context.push('/technique/${technique.id}'),
                                leading: const Icon(
                                  Icons.security,
                                  color: AppTheme.primaryColor,
                                ),
                                title: Text(technique.name),
                                subtitle: Text(technique.tactics.join(' · ')),
                                trailing: Text(
                                  technique.riskScore.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: AppTheme.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
        loading: () => const Center(child: LoadingWidget()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      loading: () => const Center(child: LoadingWidget()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}

// ─── Tactic Matrix Tab ────────────────────────────────────────────────────────

class _TacticMatrixTab extends ConsumerWidget {
  const _TacticMatrixTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tacticRiskAsync = ref.watch(tacticRiskMapProvider);
    final allTacticsAsync = ref.watch(allTacticsProvider);
    final techniqueCountAsync = ref.watch(techniqueCountByTacticProvider);

    return tacticRiskAsync.when(
      data: (tacticRiskMap) => allTacticsAsync.when(
        data: (tactics) => techniqueCountAsync.when(
          data: (countMap) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ATT&CK Tactic Risk Matrix',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Risk score = avg technique risk × coverage gap. Tap a tactic to view techniques.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                ...tactics.map(
                  (tactic) => _TacticMatrixRow(
                    tactic: tactic,
                    riskScore: tacticRiskMap[tactic.name] ?? 0.0,
                    techniqueCount: countMap[tactic.name] ?? 0,
                    onTap: () => context.push(
                      '/library?tactic=${Uri.encodeComponent(tactic.name)}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: LoadingWidget()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
        loading: () => const Center(child: LoadingWidget()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      loading: () => const Center(child: LoadingWidget()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _TacticMatrixRow extends StatelessWidget {
  final AttackTactic tactic;
  final double riskScore;
  final int techniqueCount;
  final VoidCallback onTap;

  const _TacticMatrixRow({
    required this.tactic,
    required this.riskScore,
    required this.techniqueCount,
    required this.onTap,
  });

  Color get _riskColor {
    if (riskScore >= 7.0) return AppTheme.dangerColor;
    if (riskScore >= 5.0) return AppTheme.accentColor;
    if (riskScore >= 3.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  String get _riskLabel {
    if (riskScore >= 7.0) return 'Critical';
    if (riskScore >= 5.0) return 'High';
    if (riskScore >= 3.0) return 'Medium';
    return 'Low';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tactic.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '$techniqueCount techniques • ${tactic.id}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _riskColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _riskColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      _riskLabel,
                      style: TextStyle(
                        color: _riskColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Risk bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: riskScore / 10.0,
                  minHeight: 6,
                  backgroundColor: _riskColor.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(_riskColor),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Exposure: ${riskScore.toStringAsFixed(1)} / 10',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: _riskColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Risk Gaps Tab ────────────────────────────────────────────────────────────

class _RiskGapsTab extends ConsumerWidget {
  const _RiskGapsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gapsAsync = ref.watch(topRiskGapsProvider(limit: 50));
    final breakdownAsync = ref.watch(riskGapsBySeverityProvider);

    return gapsAsync.when(
      data: (gaps) {
        if (gaps.isEmpty) {
          return const EmptyStateWidget(
            title: 'No Risk Gaps Found',
            subtitle: 'All techniques are covered. Great work!',
            icon: Icons.verified_user,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Priority Risk Gaps',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Uncovered techniques sorted by exposure risk. Address highest severity first.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),

              // Severity summary chips
              breakdownAsync.when(
                data: (breakdown) => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SeverityChip(
                      label: 'Critical',
                      count: breakdown['Critical'] ?? 0,
                      color: AppTheme.dangerColor,
                    ),
                    _SeverityChip(
                      label: 'High',
                      count: breakdown['High'] ?? 0,
                      color: AppTheme.accentColor,
                    ),
                    _SeverityChip(
                      label: 'Medium',
                      count: breakdown['Medium'] ?? 0,
                      color: AppTheme.warningColor,
                    ),
                    _SeverityChip(
                      label: 'Low',
                      count: breakdown['Low'] ?? 0,
                      color: AppTheme.successColor,
                    ),
                  ],
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),

              // Gap list
              ...gaps.map((gap) => _RiskGapCard(gap: gap)),
            ],
          ),
        );
      },
      loading: () => const Center(child: LoadingWidget()),
      error: (e, _) => Center(child: Text('Error loading gaps: $e')),
    );
  }
}

class _RiskGapCard extends StatelessWidget {
  final RiskGap gap;

  const _RiskGapCard({required this.gap});

  Color get _color {
    switch (gap.riskLabel) {
      case 'Critical':
        return AppTheme.dangerColor;
      case 'High':
        return AppTheme.accentColor;
      case 'Medium':
        return AppTheme.warningColor;
      default:
        return AppTheme.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk indicator bar
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gap.technique.id,
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          gap.riskLabel,
                          style: TextStyle(
                            color: _color,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    gap.technique.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.warning_amber, size: 12, color: _color),
                      const SizedBox(width: 4),
                      Text(
                        '${gap.coverageLabel} • Exposure: ${gap.exposedRiskScore.toStringAsFixed(1)}/10',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: gap.technique.tactics
                        .take(3)
                        .map(
                          (tac) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tac,
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Supporting widgets ───────────────────────────────────────────────────────

class _RiskScoreCard extends StatelessWidget {
  final AsyncValue<double> riskScoreAsync;
  final AsyncValue<String> riskLabelAsync;

  const _RiskScoreCard({
    required this.riskScoreAsync,
    required this.riskLabelAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organization Risk Score',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Weighted by tactic severity and ATT&CK coverage gaps',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            riskScoreAsync.when(
              data: (score) {
                final color = _riskColor(score);
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          score.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            ' / 100',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        const Spacer(),
                        riskLabelAsync.when(
                          data: (label) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: color.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (_, _) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: score / 100.0,
                        minHeight: 8,
                        backgroundColor: color.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const LoadingWidget(),
              error: (e, _) => Text('Error: $e'),
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
}

class _CoverageBreakdownRow extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _CoverageBreakdownRow({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            '$count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _SeverityChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SeverityChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
