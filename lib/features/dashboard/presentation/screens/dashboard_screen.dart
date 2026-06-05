// lib/features/dashboard/presentation/screens/dashboard_screen.dart
// FIX: replaced organizationProfileV2Provider.notifier with appModeProvider.notifier
// FIX: correct import path for appModeProvider
// FIX: mode toggle now calls ref.read(appModeProvider.notifier).toggleAppMode()

import 'package:attackshield/shared/providers/plain_language_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/alert_providers.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../shared/models/alert_item.dart';
import '../../../../core/engine/risk_engine.dart';
import '../../../../core/widgets/shimmer_loader.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FIX: watch appModeProvider (AppModeNotifier)
    final appMode = ref.watch(appModeProvider);
    final riskReport = ref.watch(riskReportProvider);
    final alertsAsync = ref.watch(alertsProvider);
    final techCount = ref.watch(techniqueCountProvider);
    final aiSummary = useState<String?>(null);
    final aiLoading = useState(false);

    useEffect(() {
      Future.microtask(() async {
        if (aiSummary.value != null) return;
        final report = await ref.read(riskReportProvider.future);
        final alerts = await ref.read(alertsProvider.future);
        aiLoading.value = true;
        try {
          final gemini = ref.read(geminiServiceProvider);
          final gaps = report.tacticBreakdown
              .where((t) => t.score > 50)
              .map((t) => t.tacticShortName)
              .take(3)
              .toList();
          final result = await gemini.generatePostureSummary(
            riskScore: report.orgRiskScore,
            coveragePercent: report.coveragePercent,
            openAlerts: alerts.length,
            criticalAlerts: alerts
                .where((a) => a.priority == AlertPriority.critical)
                .length,
            tacticGaps: gaps,
          );
          if (result.isSuccess) aiSummary.value = result.text;
        } finally {
          aiLoading.value = false;
        }
      });
      return null;
    }, []);

    final cs = Theme.of(context).colorScheme;
    final isPlain = appMode == AppMode.plainLanguageMode;

    return Scaffold(
      backgroundColor: cs.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(riskReportProvider);
          ref.invalidate(alertsProvider);
          aiSummary.value = null;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 0,
              backgroundColor: cs.surface,
              title: Row(
                children: [
                  Icon(Icons.shield_rounded, color: cs.primary, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'ATT\u0026CK Shield',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              actions: [
                // FIX: mode toggle calls appModeProvider.notifier
                _ModeToggle(isPlain: isPlain, ref: ref),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  tooltip: 'Alerts',
                  onPressed: () => context.push('/alerts'),
                ),
                const SizedBox(width: 4),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _AiPostureBanner(
                    summary: aiSummary.value,
                    isLoading: aiLoading.value,
                    isPlain: isPlain,
                  ),
                  const SizedBox(height: 16),

                  riskReport.when(
                    data: (r) => _RiskScoreCard(report: r, isPlain: isPlain),
                    loading: () => const ShimmerLoader(height: 140),
                    error: (e, _) => _ErrorCard(message: e.toString()),
                  ),
                  const SizedBox(height: 12),

                  riskReport.when(
                    data: (r) => alertsAsync.when(
                      data: (alerts) => techCount.when(
                        data: (count) => _MetricRow(
                          report: r,
                          alertCount: alerts.length,
                          criticalCount: alerts
                              .where(
                                (a) => a.priority == AlertPriority.critical,
                              )
                              .length,
                          techniqueCount: count,
                        ),
                        loading: () => const ShimmerLoader(height: 80),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      loading: () => const ShimmerLoader(height: 80),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    loading: () => const ShimmerLoader(height: 80),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),

                  _QuickActions(isPlain: isPlain),
                  const SizedBox(height: 20),

                  riskReport.when(
                    data: (r) => _CoverageChart(report: r),
                    loading: () => const ShimmerLoader(height: 220),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),

                  riskReport.when(
                    data: (r) => _TacticBreakdown(report: r, isPlain: isPlain),
                    loading: () => const ShimmerLoader(height: 180),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),

                  alertsAsync.when(
                    data: (alerts) => _RecentAlerts(alerts: alerts),
                    loading: () => const ShimmerLoader(height: 160),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Mode Toggle — FIX: uses appModeProvider.notifier ────────────────────────
class _ModeToggle extends StatelessWidget {
  final bool isPlain;
  final WidgetRef ref;
  const _ModeToggle({required this.isPlain, required this.ref});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      // FIX: was organizationProfileV2Provider.notifier → now appModeProvider.notifier
      onTap: () => ref.read(appModeProvider.notifier).state = isPlain
          ? AppMode.expertMode
          : AppMode.plainLanguageMode,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isPlain ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPlain ? cs.primary : cs.outline,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPlain ? Icons.people_rounded : Icons.code_rounded,
              size: 14,
              color: isPlain ? cs.primary : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              isPlain ? 'Plain' : 'Expert',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isPlain ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── AI Posture Banner ────────────────────────────────────────────────────────
class _AiPostureBanner extends StatelessWidget {
  final String? summary;
  final bool isLoading;
  final bool isPlain;
  const _AiPostureBanner({
    required this.summary,
    required this.isLoading,
    required this.isPlain,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (!isLoading && summary == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: 180,
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: 260,
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  )
                : Text(
                    summary ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onPrimaryContainer,
                      height: 1.4,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Risk Score Card ──────────────────────────────────────────────────────────
class _RiskScoreCard extends StatelessWidget {
  final RiskReport report;
  final bool isPlain;
  const _RiskScoreCard({required this.report, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final score = report.orgRiskScore;
    final color = score >= 75
        ? Colors.red.shade600
        : score >= 50
        ? Colors.orange.shade600
        : score >= 25
        ? Colors.amber.shade600
        : Colors.green.shade600;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 8,
                  backgroundColor: cs.outlineVariant,
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    '/100',
                    style: TextStyle(fontSize: 10, color: cs.outline),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${report.riskLabel} Risk',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isPlain
                      ? 'Your organisation is exposed to ${report.riskLabel.toLowerCase()} cyber risk. ${report.topGaps.length} high-priority gaps need attention.'
                      : 'Organisation Risk Score — weighted by tactic severity across ${report.totalTechniques} assessed techniques.',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: report.coveragePercent / 100,
                    minHeight: 6,
                    backgroundColor: cs.outlineVariant,
                    valueColor: AlwaysStoppedAnimation(Colors.green.shade500),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${report.coveragePercent.toStringAsFixed(0)}% coverage  ·  ${report.totalTechniques} techniques',
                  style: TextStyle(fontSize: 11, color: cs.outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Metric Row ───────────────────────────────────────────────────────────────
class _MetricRow extends StatelessWidget {
  final RiskReport report;
  final int alertCount, criticalCount, techniqueCount;
  const _MetricRow({
    required this.report,
    required this.alertCount,
    required this.criticalCount,
    required this.techniqueCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricTile(
            icon: Icons.verified_user_outlined,
            label: 'Covered',
            value: '${report.coveredCount}',
            color: Colors.green.shade600,
            onTap: () => context.push('/coverage'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetricTile(
            icon: Icons.warning_amber_rounded,
            label: 'Gaps',
            value: '${report.uncoveredCount + report.partialCount}',
            color: Colors.orange.shade600,
            onTap: () => context.push('/coverage'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetricTile(
            icon: Icons.notifications_active_outlined,
            label: criticalCount > 0 ? '$criticalCount Critical' : 'Alerts',
            value: '$alertCount',
            color: criticalCount > 0
                ? Colors.red.shade600
                : Colors.blue.shade600,
            onTap: () => context.push('/alerts'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetricTile(
            icon: Icons.dataset_outlined,
            label: 'Techniques',
            value: '$techniqueCount',
            color: Theme.of(context).colorScheme.primary,
            onTap: () => context.push('/library'),
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  final VoidCallback onTap;
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: cs.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Quick Actions ────────────────────────────────────────────────────────────
class _QuickActions extends StatelessWidget {
  final bool isPlain;
  const _QuickActions({required this.isPlain});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _ActionBtn(
              icon: Icons.search_rounded,
              label: isPlain ? 'Explore Threats' : 'Technique Library',
              onTap: () => context.push('/library'),
            ),
            const SizedBox(width: 8),
            _ActionBtn(
              icon: Icons.map_outlined,
              label: isPlain ? 'Fix Gaps' : 'Coverage Plan',
              onTap: () => context.push('/coverage'),
            ),
            const SizedBox(width: 8),
            _ActionBtn(
              icon: Icons.summarize_outlined,
              label: 'Report',
              onTap: () => context.push('/reports'),
            ),
            const SizedBox(width: 8),
            _ActionBtn(
              icon: Icons.science_outlined,
              label: 'Simulate',
              onTap: () => context.push('/simulations'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(.5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: cs.primary.withOpacity(.15), width: 0.5),
          ),
          child: Column(
            children: [
              Icon(icon, size: 22, color: cs.primary),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Coverage Donut ───────────────────────────────────────────────────────────
class _CoverageChart extends StatelessWidget {
  final RiskReport report;
  const _CoverageChart({required this.report});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sections = [
      PieChartSectionData(
        value: report.coveredCount.toDouble(),
        color: Colors.green.shade500,
        title: report.coveredCount > 0 ? '${report.coveredCount}' : '',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        radius: 52,
      ),
      PieChartSectionData(
        value: report.partialCount.toDouble(),
        color: Colors.amber.shade500,
        title: report.partialCount > 0 ? '${report.partialCount}' : '',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        radius: 52,
      ),
      PieChartSectionData(
        value: report.uncoveredCount.toDouble(),
        color: Colors.red.shade400,
        title: report.uncoveredCount > 0 ? '${report.uncoveredCount}' : '',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        radius: 52,
      ),
      if (report.unknownCount > 0)
        PieChartSectionData(
          value: report.unknownCount.toDouble(),
          color: cs.outlineVariant,
          title: '${report.unknownCount}',
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          radius: 52,
        ),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coverage Breakdown',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 42,
                      sectionsSpace: 3,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Legend(
                      color: Colors.green.shade500,
                      label: 'Covered',
                      count: report.coveredCount,
                    ),
                    const SizedBox(height: 8),
                    _Legend(
                      color: Colors.amber.shade500,
                      label: 'Partial',
                      count: report.partialCount,
                    ),
                    const SizedBox(height: 8),
                    _Legend(
                      color: Colors.red.shade400,
                      label: 'Not covered',
                      count: report.uncoveredCount,
                    ),
                    if (report.unknownCount > 0) ...[
                      const SizedBox(height: 8),
                      _Legend(
                        color: cs.outlineVariant,
                        label: 'Unknown',
                        count: report.unknownCount,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => context.push('/coverage'),
            icon: const Icon(Icons.arrow_forward_rounded, size: 15),
            label: const Text('View full coverage map'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  const _Legend({
    required this.color,
    required this.label,
    required this.count,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(
        '$label ($count)',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}

// ─── Tactic Breakdown ─────────────────────────────────────────────────────────
class _TacticBreakdown extends StatelessWidget {
  final RiskReport report;
  final bool isPlain;
  const _TacticBreakdown({required this.report, required this.isPlain});

  static const _plainNames = <String, String>{
    'initial-access': 'Getting In',
    'execution': 'Running Malware',
    'persistence': 'Staying Hidden',
    'privilege-escalation': 'Gaining Admin Access',
    'defense-evasion': 'Avoiding Detection',
    'credential-access': 'Stealing Passwords',
    'discovery': 'Mapping Your Network',
    'lateral-movement': 'Spreading Through Systems',
    'collection': 'Stealing Your Data',
    'command-and-control': 'Remote Control',
    'exfiltration': 'Data Theft',
    'impact': 'Causing Damage',
    'reconnaissance': 'Spying & Recon',
    'resource-development': 'Building Attack Tools',
  };
  static const _expertNames = <String, String>{
    'initial-access': 'Initial Access',
    'execution': 'Execution',
    'persistence': 'Persistence',
    'privilege-escalation': 'Privilege Escalation',
    'defense-evasion': 'Defense Evasion',
    'credential-access': 'Credential Access',
    'discovery': 'Discovery',
    'lateral-movement': 'Lateral Movement',
    'collection': 'Collection',
    'command-and-control': 'Command & Control',
    'exfiltration': 'Exfiltration',
    'impact': 'Impact',
    'reconnaissance': 'Reconnaissance',
    'resource-development': 'Resource Development',
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final top5 = report.tacticBreakdown.take(5).toList();
    if (top5.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPlain ? 'Biggest Risk Areas' : 'Tactic Risk Breakdown',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            isPlain
                ? 'Areas where attackers could cause the most damage'
                : 'Top 5 tactics by weighted exposure score',
            style: TextStyle(fontSize: 12, color: cs.outline),
          ),
          const SizedBox(height: 14),
          ...top5.map((entry) {
            final color = entry.score >= 75
                ? Colors.red.shade500
                : entry.score >= 50
                ? Colors.orange.shade500
                : Colors.amber.shade500;
            final name = isPlain
                ? (_plainNames[entry.tacticShortName] ?? entry.tacticShortName)
                : (_expertNames[entry.tacticShortName] ??
                      entry.tacticShortName);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '${entry.coveredCount}/${entry.techniqueCount} covered',
                        style: TextStyle(fontSize: 11, color: cs.outline),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.score.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: entry.score / 100,
                      minHeight: 5,
                      backgroundColor: cs.outlineVariant,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () => context.push('/simulations'),
            icon: const Icon(Icons.arrow_forward_rounded, size: 15),
            label: Text(isPlain ? 'Run attack simulation' : 'View full matrix'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Recent Alerts ────────────────────────────────────────────────────────────
class _RecentAlerts extends StatelessWidget {
  final List alerts;
  const _RecentAlerts({required this.alerts});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final recent = alerts.take(5).toList();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recent Alerts',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push('/alerts'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('See all'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green.shade400,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No alerts — looking good!',
                      style: TextStyle(color: cs.outline, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          else
            ...recent.map((a) => _AlertTile(alert: a)),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  final AlertItem alert;
  const _AlertTile({required this.alert});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final severity = alert.severity as String? ?? 'medium';
    final color = severity == 'critical'
        ? Colors.red.shade600
        : severity == 'high'
        ? Colors.orange.shade600
        : severity == 'medium'
        ? Colors.amber.shade600
        : Colors.blue.shade600;
    return InkWell(
      onTap: () => context.push('/alerts'),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title ?? 'Alert',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    alert.description ?? '',
                    style: TextStyle(fontSize: 11, color: cs.outline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red.shade600),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(fontSize: 12, color: Colors.red.shade700),
          ),
        ),
      ],
    ),
  );
}
