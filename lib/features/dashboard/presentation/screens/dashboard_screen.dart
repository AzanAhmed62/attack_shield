import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/core/services/risk_engine.dart';
import 'package:attackshield/features/dashboard/presentation/widgets/threat_profile_card.dart';

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
    final hasProfileAsync = ref.watch(hasCompleteThreatProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ATT&CK Defender'),
        elevation: 0,
        actions: [
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
          ref.invalidate(riskEngineCoveragePercentageProvider);
          ref.invalidate(allCoverageStatusesProvider);
          ref.invalidate(threatProfileProvider);
          ref.invalidate(allAlertsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Threat Profile Card (Phase 2 — personalized) ──────
              hasProfileAsync.when(
                data: (hasProfile) => hasProfile
                    ? const ThreatProfileCard(compact: true)
                    : const ThreatProfileCard(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),

              // ── Risk Score Hero ────────────────────────────────────
              _RiskHeroCard(
                riskScoreAsync: riskScoreAsync,
                riskLabelAsync: riskLabelAsync,
                coverageAsync: coverageAsync,
                breakdownAsync: breakdownAsync,
                onTap: () => context.push('/coverage'),
              ),
              const SizedBox(height: 16),

              // ── Metric row ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: allTechAsync.when(
                      data: (t) => _MetricTile(
                        label: 'Techniques',
                        value: '${t.length}',
                        sub: '+${t.fold(0, (s, e) => s + e.subTechniques.length)} sub',
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
                        onTap: () => context.push('/assets'),
                      ),
                      loading: () => const _MetricTileSkeleton(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Top Risk Gaps ──────────────────────────────────────
              SectionHeader(
                title: 'Priority Risk Gaps',
                showViewAll: true,
                onViewAllPressed: () => context.push('/coverage'),
              ),
              const SizedBox(height: 10),
              topGapsAsync.when(
                data: (gaps) => gaps.isEmpty
                    ? const _GreenStatusCard(
                        message: 'No critical gaps detected. All techniques covered!')
                    : Column(
                        children: gaps
                            .map((g) => _RiskGapTile(
                                  gap: g,
                                  onTap: () => context.push(
                                      '/technique/${g.technique.id}'),
                                ))
                            .toList(),
                      ),
                loading: () => const LoadingWidget(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),

              // ── Quick Actions ──────────────────────────────────────
              const SectionHeader(title: 'Quick Actions'),
              const SizedBox(height: 10),
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
                    onTap: () => context.push('/simulations'),
                  ),
                  _QuickAction(
                    label: 'Reports',
                    icon: Icons.assessment,
                    color: AppTheme.accentColor,
                    onTap: () => context.push('/reports'),
                  ),
                  _QuickAction(
                    label: 'Bookmarks',
                    icon: Icons.bookmark,
                    color: AppTheme.primaryColor,
                    onTap: () => context.push('/bookmarks'),
                  ),
                  _QuickAction(
                    label: 'Assets',
                    icon: Icons.layers,
                    color: AppTheme.successColor,
                    onTap: () => context.push('/assets'),
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

// ─── Risk Hero Card ───────────────────────────────────────────────────────────

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
                      color: AppTheme.primaryColor, size: 18),
                  const SizedBox(width: 8),
                  Text('Security Posture',
                      style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle,
                            size: 7, color: AppTheme.successColor),
                        SizedBox(width: 4),
                        Text('LIVE',
                            style: TextStyle(
                                color: AppTheme.successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: riskScoreAsync.when(
                      data: (score) {
                        final c = _riskColor(score);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Risk Score',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text(
                                  score.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: c),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 6),
                                  child: Text('/100',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13)),
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
                                        fontSize: 11)),
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
              const SizedBox(height: 12),
              riskScoreAsync.when(
                data: (score) {
                  final c = _riskColor(score);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: score / 100.0,
                      minHeight: 5,
                      backgroundColor: c.withValues(alpha: 0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(c),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 10),
              breakdownAsync.when(
                data: (b) => Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _BreakChip('✓ ${b['covered']}', AppTheme.successColor),
                    _BreakChip('~ ${b['partiallyCovered']}', AppTheme.warningColor),
                    _BreakChip('✗ ${b['notCovered']}', AppTheme.dangerColor),
                    _BreakChip('? ${b['unknown']}', Colors.grey),
                  ],
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'View full coverage →',
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
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

// ─── Smaller widgets ──────────────────────────────────────────────────────────

class _MetricTile extends StatelessWidget {
  final String label, value, sub;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MetricTile({
    required this.label, required this.value, required this.sub,
    required this.icon, required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(height: 6),
              Text(value,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
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

class _MetricTileSkeleton extends StatelessWidget {
  const _MetricTileSkeleton();
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 18, height: 18,
                  color: Colors.grey.withValues(alpha: 0.3)),
              const SizedBox(height: 6),
              Container(width: 36, height: 20,
                  color: Colors.grey.withValues(alpha: 0.3)),
            ],
          ),
        ),
      );
}

class _RiskGapTile extends StatelessWidget {
  final RiskGap gap;
  final VoidCallback onTap;
  const _RiskGapTile({required this.gap, required this.onTap});

  Color get _color {
    switch (gap.riskLabel) {
      case 'Critical': return AppTheme.dangerColor;
      case 'High':     return AppTheme.accentColor;
      case 'Medium':   return AppTheme.warningColor;
      default:         return AppTheme.successColor;
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
              width: 4, height: 44,
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
                  Text(gap.technique.tactics.take(2).join(' · '),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(gap.riskLabel,
                      style: TextStyle(
                          color: c, fontSize: 11,
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
            Icon(Icons.chevron_right, size: 18,
                color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

class _GreenStatusCard extends StatelessWidget {
  final String message;
  const _GreenStatusCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppTheme.successColor.withValues(alpha: 0.4)),
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

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.label, required this.icon,
    required this.color, required this.onTap,
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
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 5),
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