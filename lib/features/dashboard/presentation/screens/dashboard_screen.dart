import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/core/services/risk_engine.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riskScoreAsync = ref.watch(organizationRiskScoreProvider);
    final riskLabelAsync = ref.watch(organizationRiskLabelProvider);
    final coverageAsync = ref.watch(riskEngineCoveragePercentageProvider);
    final breakdownAsync = ref.watch(riskCoverageBreakdownProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);
    final alertCountAsync = ref.watch(openAlertCountProvider);
    final criticalAsync = ref.watch(criticalAlertCountProvider);
    final allAssetsAsync = ref.watch(allAssetsProvider);
    final topGapsAsync = ref.watch(topRiskGapsProvider(limit: 5));
    final allAlertsAsync = ref.watch(allAlertsProvider);
    final latestReportAsync = ref.watch(latestReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ATT&CK Defender'),
        elevation: 0,
        actions: [
          // Critical alert badge
          criticalAsync.when(
            data: (n) => n > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Badge(
                      label: Text('$n'),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_active),
                        onPressed: () => context.push('/alerts'),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(organizationRiskScoreProvider);
          ref.invalidate(organizationRiskLabelProvider);
          ref.invalidate(riskEngineCoveragePercentageProvider);
          ref.invalidate(riskCoverageBreakdownProvider);
          ref.invalidate(allTechniquesProvider);
          ref.invalidate(openAlertCountProvider);
          ref.invalidate(criticalAlertCountProvider);
          ref.invalidate(allAssetsProvider);
          ref.invalidate(topRiskGapsProvider(limit: 5));
          ref.invalidate(allAlertsProvider);
          ref.invalidate(latestReportProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // ── Risk Score Hero card ───────────────────────────────────
            _RiskHeroCard(
              riskScoreAsync: riskScoreAsync,
              riskLabelAsync: riskLabelAsync,
              coverageAsync: coverageAsync,
              breakdownAsync: breakdownAsync,
              onTap: () => context.push('/coverage'),
            ),
            const SizedBox(height: 20),

            // ── Metric row ────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: allTechAsync.when(
                    data: (t) => _MetricTile(
                      label: 'Techniques',
                      value: '${t.length}',
                      sub:
                          '+${t.fold(0, (s, e) => s + e.subTechniques.length)} sub',
                      icon: Icons.category,
                      color: AppTheme.primaryColor,
                      onTap: () => context.push('/library'),
                    ),
                    loading: () => const _MetricTileSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: alertCountAsync.when(
                    data: (n) => _MetricTile(
                      label: 'Open Alerts',
                      value: '$n',
                      sub: 'Active',
                      icon: Icons.warning_amber,
                      color: AppTheme.warningColor,
                      onTap: () => context.push('/alerts'),
                    ),
                    loading: () => const _MetricTileSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: allAssetsAsync.when(
                    data: (a) => _MetricTile(
                      label: 'Assets',
                      value: '${a.length}',
                      sub: 'Monitored',
                      icon: Icons.layers,
                      color: AppTheme.successColor,
                      onTap: () => context.push('/more/assets'),
                    ),
                    loading: () => const _MetricTileSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Top Risk Gaps ─────────────────────────────────────────
            SectionHeader(
              title: 'Top Priority Gaps',
              showViewAll: true,
              onViewAllPressed: () => context.push('/coverage'),
            ),
            const SizedBox(height: 12),
            topGapsAsync.when(
              data: (gaps) => gaps.isEmpty
                  ? const _GreenStatusCard(
                      message:
                          'No critical gaps detected. All techniques covered!')
                  : Column(
                      children: gaps
                          .map((g) => _RiskGapTile(
                                gap: g,
                                onTap: () => context
                                    .push('/technique/${g.technique.id}'),
                              ))
                          .toList(),
                    ),
              loading: () => const LoadingWidget(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Recent Activity'),
            const SizedBox(height: 12),
            _RecentActivityCard(
              alertsAsync: allAlertsAsync,
              latestReportAsync: latestReportAsync,
            ),
            const SizedBox(height: 20),

            // ── Quick Actions ─────────────────────────────────────────
            const SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0,
              children: [
                _QuickAction(
                  label: 'Library',
                  icon: Icons.library_books,
                  color: AppTheme.primaryColor,
                  onTap: () => context.push('/library'),
                ),
                _QuickAction(
                  label: 'Coverage',
                  icon: Icons.shield,
                  color: AppTheme.successColor,
                  onTap: () => context.push('/coverage'),
                ),
                _QuickAction(
                  label: 'Simulations',
                  icon: Icons.science,
                  color: AppTheme.warningColor,
                  onTap: () => context.push('/more/simulations'),
                ),
                _QuickAction(
                  label: 'Reports',
                  icon: Icons.assessment,
                  color: AppTheme.accentColor,
                  onTap: () => context.push('/more/reports'),
                ),
                _QuickAction(
                  label: 'Alerts',
                  icon: Icons.notifications,
                  color: AppTheme.dangerColor,
                  onTap: () => context.push('/alerts'),
                ),
                _QuickAction(
                  label: 'Settings',
                  icon: Icons.settings,
                  color: Colors.grey,
                  onTap: () => context.push('/more/settings'),
                ),
              ],
                ),
                const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Risk Hero Card ──────────────────────────────────────────────────────────

class _RiskHeroCard extends StatelessWidget {
  final AsyncValue<double> riskScoreAsync;
  final AsyncValue<String> riskLabelAsync;
  final AsyncValue<double> coverageAsync;
  final AsyncValue<Map<String, int>> breakdownAsync;
  final VoidCallback onTap;

  const _RiskHeroCard({
    required this.riskScoreAsync,
    required this.riskLabelAsync,
    required this.coverageAsync,
    required this.breakdownAsync,
    required this.onTap,
  });

  Color _riskColor(double s) {
    if (s >= 80) return AppTheme.dangerColor;
    if (s >= 60) return AppTheme.accentColor;
    if (s >= 40) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  Color _covColor(double p) {
    if (p >= 70) return AppTheme.successColor;
    if (p >= 40) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.monitor_heart,
                      color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text('Security Posture',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle,
                            size: 8, color: AppTheme.successColor),
                        SizedBox(width: 4),
                        Text('LIVE',
                            style: TextStyle(
                                color: AppTheme.successColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Risk + Coverage row
              Row(
                children: [
                  // Risk score
                  Expanded(
                    child: riskScoreAsync.when(
                      data: (score) {
                        final c = _riskColor(score);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Risk Score',
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  score.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: c),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text('/100',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                            riskLabelAsync.when(
                              data: (label) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: c.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(label,
                                    style: TextStyle(
                                        color: c,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ),
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        );
                      },
                      loading: () => const LoadingWidget(),
                      error: (_, __) => const Text('—'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Coverage ring
                  coverageAsync.when(
                    data: (pct) => ProgressRing(
                      percentage: pct,
                      progressColor: _covColor(pct),
                      label: 'Coverage',
                    ),
                    loading: () => const LoadingWidget(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Risk bar
              riskScoreAsync.when(
                data: (score) {
                  final c = _riskColor(score);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: score / 100.0,
                      minHeight: 6,
                      backgroundColor: c.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(c),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 12),

              // Coverage breakdown chips
              breakdownAsync.when(
                data: (b) => Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _BreakChip('✓ ${b['covered']}', AppTheme.successColor),
                    _BreakChip('~ ${b['partiallyCovered']}',
                        AppTheme.warningColor),
                    _BreakChip(
                        '✗ ${b['notCovered']}', AppTheme.dangerColor),
                    _BreakChip('? ${b['unknown']}', Colors.grey),
                  ],
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('View full coverage →',
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreakChip extends StatelessWidget {
  final String label;
  final Color color;
  const _BreakChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

// ─── Metric tile ──────────────────────────────────────────────────────────────

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.sub,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final numericValue = double.tryParse(value);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              if (numericValue != null)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: numericValue),
                  duration: const Duration(milliseconds: 700),
                  builder: (context, animatedValue, _) => Text(
                    animatedValue % 1 == 0
                        ? animatedValue.toInt().toString()
                        : animatedValue.toStringAsFixed(1),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              Text(sub,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 10)),
              const SizedBox(height: 2),
              Text(label,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  final AsyncValue<List<AlertItem>> alertsAsync;
  final AsyncValue<ReportSummary?> latestReportAsync;

  const _RecentActivityCard({
    required this.alertsAsync,
    required this.latestReportAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            latestReportAsync.when(
              data: (report) {
                if (report == null) {
                  return Text(
                    'No report generated yet.',
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                }
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.assessment_outlined,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text(report.title),
                  subtitle: Text('Latest report snapshot'),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const Divider(height: 20),
            alertsAsync.when(
              data: (alerts) {
                final recentAlerts = [...alerts]
                  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                if (recentAlerts.isEmpty) {
                  return Text(
                    'No recent alerts.',
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                }
                return Column(
                  children: recentAlerts
                      .take(3)
                      .map(
                        (alert) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppTheme.warningColor,
                          ),
                          title: Text(alert.title),
                          subtitle: Text(
                            '${alert.priority.name} · ${alert.status.name}',
                          ),
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTileSkeleton extends StatelessWidget {
  const _MetricTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 20, height: 20, color: Colors.grey.withValues(alpha: 0.3)),
            const SizedBox(height: 8),
            Container(
                width: 40, height: 22, color: Colors.grey.withValues(alpha: 0.3)),
            const SizedBox(height: 4),
            Container(
                width: 60, height: 12, color: Colors.grey.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}

// ─── Risk gap tile ────────────────────────────────────────────────────────────

class _RiskGapTile extends StatelessWidget {
  final RiskGap gap;
  final VoidCallback onTap;

  const _RiskGapTile({required this.gap, required this.onTap});

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
    final c = _color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 44,
              decoration: BoxDecoration(
                  color: c, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gap.technique.id,
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  Text(gap.technique.name,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(
                    gap.technique.tactics.take(2).join(' · '),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(gap.riskLabel,
                      style: TextStyle(
                          color: c,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                Text(gap.exposedRiskScore.toStringAsFixed(1),
                    style: TextStyle(
                        color: c,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 18, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

// ─── Green status card (all covered) ─────────────────────────────────────────

class _GreenStatusCard extends StatelessWidget {
  final String message;
  const _GreenStatusCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.successColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user, color: AppTheme.successColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message,
                style: const TextStyle(color: AppTheme.successColor)),
          ),
        ],
      ),
    );
  }
}

// ─── Quick action ─────────────────────────────────────────────────────────────

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
