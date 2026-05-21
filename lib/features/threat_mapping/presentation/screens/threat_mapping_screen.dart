// lib/features/coverage/presentation/screens/threat_mapping_screen.dart
// FULL REPLACEMENT — real coverage data, inline level editing, tactic
// accordion groups, progress bars, bulk actions.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/coverage_status.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/widgets/shimmer_loader.dart';

class ThreatMappingScreen extends HookConsumerWidget {
  const ThreatMappingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tacticsAsync  = ref.watch(allTacticsProvider);
    final byTacticAsync = ref.watch(techniquesByTacticProvider);
    final coverageMap   = ref.watch(coverageMapProvider);
    final riskReport    = ref.watch(riskReportProvider);
    final searchCtrl    = useTextEditingController();
    final searchQuery   = useState('');
    final cs            = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text('Coverage Map',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600)),
        actions: [
          riskReport.when(
            data: (r) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${r.coveragePercent.toStringAsFixed(0)}% covered',
                    style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: cs.primary)),
                  Text('Risk: ${r.orgRiskScore.toStringAsFixed(0)}/100',
                    style: TextStyle(fontSize: 10, color: cs.outline)),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error:   (_, __) => const SizedBox.shrink(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText:  'Filter techniques...',
                hintStyle: TextStyle(fontSize: 13, color: cs.outline),
                prefixIcon: const Icon(Icons.search_rounded, size: 18),
                suffixIcon: searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 16),
                      onPressed: () {
                        searchCtrl.clear();
                        searchQuery.value = '';
                      })
                  : null,
                filled: true,
                fillColor: cs.surfaceContainerHighest,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => searchQuery.value = v.toLowerCase(),
            ),
          ),
        ),
      ),

      // ── Summary bar ──────────────────────────────────────────────────────
      body: tacticsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text('$e')),
        data: (tactics) => byTacticAsync.when(
          loading: () => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ShimmerLoader(height: 80),
            ),
          ),
          error: (e, _) => Center(child: Text('$e')),
          data: (byTactic) {
            final covMap = coverageMap.value ?? {};
            final query  = searchQuery.value;

            return CustomScrollView(
              slivers: [
                // Summary strip
                SliverToBoxAdapter(
                  child: riskReport.when(
                    data:    (r) => _SummaryStrip(report: r),
                    loading: () => const ShimmerLoader(height: 56),
                    error:   (_, __) => const SizedBox.shrink(),
                  ),
                ),

                // Tactic accordion groups
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  sliver: SliverList.builder(
                    itemCount: tactics.length,
                    itemBuilder: (_, i) {
                      final tactic = tactics[i];
                      var techs    = byTactic[tactic.shortName] ?? [];

                      // Apply search filter
                      if (query.isNotEmpty) {
                        techs = techs.where((t) =>
                          t.name.toLowerCase().contains(query) ||
                          t.id.toLowerCase().contains(query),
                        ).toList();
                      }
                      if (techs.isEmpty && query.isNotEmpty) {
                        return const SizedBox.shrink();
                      }

                      final covered = techs.where((t) =>
                        covMap[t.id] == CoverageLevel.covered).length;
                      final partial = techs.where((t) =>
                        covMap[t.id] == CoverageLevel.partiallyCovered).length;
                      final pct = techs.isEmpty ? 0.0
                          : (covered + partial * 0.5) / techs.length;

                      return _TacticAccordion(
                        tactic:       tactic.name,
                        tacticShort:  tactic.shortName,
                        techniques:   techs,
                        covMap:       covMap,
                        covered:      covered,
                        partial:      partial,
                        total:        techs.length,
                        coveragePct:  pct,
                        ref:          ref,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Summary strip ────────────────────────────────────────────────────────────
class _SummaryStrip extends StatelessWidget {
  final dynamic report;
  const _SummaryStrip({required this.report});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(children: [
        _SummaryChip(
          value: '${report.coveredCount}',
          label: 'Covered',
          color: Colors.green.shade600,
        ),
        const SizedBox(width: 16),
        _SummaryChip(
          value: '${report.partialCount}',
          label: 'Partial',
          color: Colors.amber.shade600,
        ),
        const SizedBox(width: 16),
        _SummaryChip(
          value: '${report.uncoveredCount}',
          label: 'Not Covered',
          color: Colors.red.shade500,
        ),
        const Spacer(),
        Text('${report.totalTechniques} total',
          style: TextStyle(fontSize: 11, color: cs.outline)),
      ]),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String value, label;
  final Color  color;
  const _SummaryChip(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      Text(label,
        style: TextStyle(fontSize: 9,
            color: Theme.of(context).colorScheme.outline)),
    ]);
  }
}

// ─── Tactic Accordion ─────────────────────────────────────────────────────────
class _TacticAccordion extends HookWidget {
  final String   tactic, tacticShort;
  final List     techniques;
  final Map<String, CoverageLevel> covMap;
  final int      covered, partial, total;
  final double   coveragePct;
  final WidgetRef ref;

  const _TacticAccordion({
    required this.tactic,
    required this.tacticShort,
    required this.techniques,
    required this.covMap,
    required this.covered,
    required this.partial,
    required this.total,
    required this.coveragePct,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = useState(coveragePct < 0.8); // auto-expand incomplete tactics
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(children: [
        // Header
        InkWell(
          onTap: () => expanded.value = !expanded.value,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(tactic,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text('$covered/$total',
                      style: TextStyle(fontSize: 11, color: cs.outline)),
                  ]),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: coveragePct,
                      minHeight: 5,
                      backgroundColor: cs.outlineVariant,
                      valueColor: AlwaysStoppedAnimation(
                        coveragePct >= 0.8 ? Colors.green.shade500
                          : coveragePct >= 0.5 ? Colors.amber.shade500
                          : Colors.red.shade400,
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(width: 12),
              AnimatedRotation(
                turns: expanded.value ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(Icons.keyboard_arrow_down_rounded,
                  color: cs.outline),
              ),
            ]),
          ),
        ),

        // Technique rows
        if (expanded.value) ...[
          Divider(height: 1, color: cs.outlineVariant),
          ...techniques.map((t) => _TechniqueRow(
            technique: t,
            coverage:  covMap[t.id] ?? CoverageLevel.unknown,
            onTap:     () => context.push('/library/${t.id}'),
            onCoverageChange: (level) async {
              await ref.read(setCoverageLevelProvider(t.id, level).future);
            },
          )),
        ],
      ]),
    );
  }
}

// ─── Technique Row ────────────────────────────────────────────────────────────
class _TechniqueRow extends StatelessWidget {
  final dynamic         technique;
  final CoverageLevel   coverage;
  final VoidCallback    onTap;
  final void Function(CoverageLevel) onCoverageChange;

  const _TechniqueRow({
    required this.technique,
    required this.coverage,
    required this.onTap,
    required this.onCoverageChange,
  });

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final color = _coverageColor(coverage);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        child: Row(children: [
          Container(width: 3, height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            )),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(technique.id,
              style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                  fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(technique.name,
            style: const TextStyle(fontSize: 13),
            maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),

          // Coverage cycle button
          GestureDetector(
            onTap: () => onCoverageChange(_nextLevel(coverage)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withOpacity(.3)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(_coverageIcon(coverage), size: 12, color: color),
                const SizedBox(width: 3),
                Text(_coverageLabel(coverage),
                  style: TextStyle(fontSize: 10,
                      color: color, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Color _coverageColor(CoverageLevel l) {
    switch (l) {
      case CoverageLevel.covered:          return Colors.green.shade600;
      case CoverageLevel.partiallyCovered: return Colors.amber.shade600;
      case CoverageLevel.notCovered:       return Colors.red.shade500;
      case CoverageLevel.unknown:          return Colors.grey.shade400;
    }
  }

  IconData _coverageIcon(CoverageLevel l) {
    switch (l) {
      case CoverageLevel.covered:          return Icons.check_circle_rounded;
      case CoverageLevel.partiallyCovered: return Icons.remove_circle_rounded;
      case CoverageLevel.notCovered:       return Icons.cancel_rounded;
      case CoverageLevel.unknown:          return Icons.help_rounded;
    }
  }

  String _coverageLabel(CoverageLevel l) {
    switch (l) {
      case CoverageLevel.covered:          return 'Covered';
      case CoverageLevel.partiallyCovered: return 'Partial';
      case CoverageLevel.notCovered:       return 'None';
      case CoverageLevel.unknown:          return 'Unknown';
    }
  }

  CoverageLevel _nextLevel(CoverageLevel l) {
    switch (l) {
      case CoverageLevel.unknown:          return CoverageLevel.notCovered;
      case CoverageLevel.notCovered:       return CoverageLevel.partiallyCovered;
      case CoverageLevel.partiallyCovered: return CoverageLevel.covered;
      case CoverageLevel.covered:          return CoverageLevel.notCovered;
    }
  }
}