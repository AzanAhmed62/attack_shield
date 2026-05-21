// lib/features/library/presentation/screens/attack_library_screen.dart
// FULL REPLACEMENT — virtualized list, 300ms debounced search, tactic filters,
// platform filters, sub-technique tree, real data from STIX providers.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/attack_technique.dart';
import '../../../../shared/models/coverage_status.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/widgets/shimmer_loader.dart';

class AttackLibraryScreen extends HookConsumerWidget {
  const AttackLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final debounceTimer = useRef<Timer?>(null);
    final tacticsAsync = ref.watch(allTacticsProvider);
    final platformsAsync = ref.watch(allPlatformsProvider);
    final filteredAsync = ref.watch(filteredTechniquesProvider);
    final selectedTactic = ref.watch(selectedTacticProvider);
    final selectedPlats = ref.watch(selectedPlatformsProvider);
    final showSubs = ref.watch(showSubTechniquesProvider);
    final coverageMap = ref.watch(coverageMapProvider);

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // ── Search App Bar ─────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: cs.surface,
            title: Text(
              'Technique Library',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search techniques, IDs, descriptions...',
                    hintStyle: TextStyle(fontSize: 13, color: cs.outline),
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              searchCtrl.clear();
                              ref.read(searchQueryProvider.notifier).clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: cs.surfaceContainerHighest,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) {
                    debounceTimer.value?.cancel();
                    debounceTimer.value = Timer(
                      const Duration(milliseconds: 300),
                      () => ref.read(searchQueryProvider.notifier).update(val),
                    );
                  },
                ),
              ),
            ),
          ),

          // ── Filter bar ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Tactic chips
                tacticsAsync.when(
                  loading: () => const SizedBox(height: 44),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (tactics) => SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tactics.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 6),
                      itemBuilder: (_, i) {
                        if (i == 0) {
                          // "All" chip
                          final isAll = selectedTactic.isEmpty;
                          return FilterChip(
                            label: const Text('All'),
                            selected: isAll,
                            onSelected: (_) => ref
                                .read(selectedTacticProvider.notifier)
                                .clear(),
                          );
                        }
                        final tactic = tactics[i - 1];
                        final selected = selectedTactic == tactic.shortName;
                        return FilterChip(
                          label: Text(tactic.name),
                          selected: selected,
                          onSelected: (_) => selected
                              ? ref
                                    .read(selectedTacticProvider.notifier)
                                    .clear()
                              : ref
                                    .read(selectedTacticProvider.notifier)
                                    .select(tactic.shortName),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Platform + sub-technique row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Sub-techniques toggle
                      GestureDetector(
                        onTap: () => ref
                            .read(showSubTechniquesProvider.notifier)
                            .toggle(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: showSubs
                                ? cs.primaryContainer
                                : cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: showSubs ? cs.primary : cs.outlineVariant,
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.subdirectory_arrow_right_rounded,
                                size: 14,
                                color: showSubs
                                    ? cs.primary
                                    : cs.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Sub-techniques',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: showSubs
                                      ? cs.primary
                                      : cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Platform filter
                      platformsAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (platforms) => GestureDetector(
                          onTap: () => _showPlatformFilter(
                            context,
                            ref,
                            platforms,
                            selectedPlats,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: selectedPlats.isNotEmpty
                                  ? cs.secondaryContainer
                                  : cs.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedPlats.isNotEmpty
                                    ? cs.secondary
                                    : cs.outlineVariant,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.devices_rounded,
                                  size: 14,
                                  color: selectedPlats.isNotEmpty
                                      ? cs.secondary
                                      : cs.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  selectedPlats.isEmpty
                                      ? 'Platform'
                                      : '${selectedPlats.length} selected',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: selectedPlats.isNotEmpty
                                        ? cs.secondary
                                        : cs.onSurfaceVariant,
                                  ),
                                ),
                                if (selectedPlats.isNotEmpty) ...[
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(
                                          selectedPlatformsProvider.notifier,
                                        )
                                        .clear(),
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 12,
                                      color: cs.secondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Result count
                      filteredAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (list) => Text(
                          '${list.length} techniques',
                          style: TextStyle(fontSize: 11, color: cs.outline),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // ── Technique list ─────────────────────────────────────────────
          filteredAsync.when(
            loading: () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ShimmerLoader(height: 72),
                ),
                childCount: 12,
              ),
            ),
            error: (e, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(child: Text('Error loading techniques: $e')),
              ),
            ),
            data: (techniques) {
              if (techniques.isEmpty) {
                return SliverToBoxAdapter(child: _EmptyState());
              }
              final covMap = coverageMap.value ?? {};
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList.builder(
                  itemCount: techniques.length,
                  itemBuilder: (ctx, i) {
                    final t = techniques[i];
                    final coverage = covMap[t.id] ?? CoverageLevel.unknown;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Parent technique group header
                        if (!t.isSubTechnique && i > 0)
                          const SizedBox(height: 6),
                        _TechniqueCard(
                          technique: t,
                          coverage: coverage,
                          onTap: () => ctx.push('/library/${t.id}'),
                        ),
                        const SizedBox(height: 4),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showPlatformFilter(
    BuildContext context,
    WidgetRef ref,
    List<String> all,
    List<String> selected,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PlatformFilterSheet(
        allPlatforms: all,
        selectedPlatforms: selected,
        onToggle: (p) => ref.read(selectedPlatformsProvider.notifier).toggle(p),
        onClear: () => ref.read(selectedPlatformsProvider.notifier).clear(),
      ),
    );
  }
}

// ─── Technique Card ───────────────────────────────────────────────────────────
class _TechniqueCard extends StatelessWidget {
  final AttackTechnique technique;
  final CoverageLevel coverage;
  final VoidCallback onTap;
  const _TechniqueCard({
    required this.technique,
    required this.coverage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final coverColor = _coverageColor(coverage);
    final score = technique.riskScore;
    final riskColor = score >= 8
        ? Colors.red.shade500
        : score >= 6
        ? Colors.orange.shade500
        : score >= 4
        ? Colors.amber.shade500
        : Colors.green.shade500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: technique.isSubTechnique
              ? cs.surfaceContainerLowest
              : cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Row(
          children: [
            // Coverage indicator
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: coverColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),

            // Sub-technique indentation
            if (technique.isSubTechnique) const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // T-ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          technique.id,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: cs.primary,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Sub-technique indicator
                      if (technique.isSubTechnique)
                        Icon(
                          Icons.subdirectory_arrow_right_rounded,
                          size: 12,
                          color: cs.outline,
                        ),
                      const Spacer(),
                      // Risk badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: riskColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          score.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    technique.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Tactic chips (first 2)
                      ...technique.tactics
                          .take(2)
                          .map(
                            (t) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: cs.secondaryContainer.withOpacity(.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t.replaceAll('-', ' '),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: cs.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      if (technique.tactics.length > 2)
                        Text(
                          '+${technique.tactics.length - 2}',
                          style: TextStyle(fontSize: 9, color: cs.outline),
                        ),
                      const Spacer(),
                      // Sub-technique count
                      if (technique.subTechniqueIds.isNotEmpty)
                        Text(
                          '${technique.subTechniqueIds.length} subs',
                          style: TextStyle(fontSize: 9, color: cs.outline),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: cs.outline, size: 18),
          ],
        ),
      ),
    );
  }

  Color _coverageColor(CoverageLevel level) {
    switch (level) {
      case CoverageLevel.covered:
        return Colors.green.shade500;
      case CoverageLevel.partiallyCovered:
        return Colors.amber.shade500;
      case CoverageLevel.notCovered:
        return Colors.red.shade400;
      case CoverageLevel.unknown:
        return Colors.grey.shade300;
    }
  }
}

// ─── Platform Filter Sheet ────────────────────────────────────────────────────
class _PlatformFilterSheet extends StatelessWidget {
  final List<String> allPlatforms, selectedPlatforms;
  final void Function(String) onToggle;
  final VoidCallback onClear;
  const _PlatformFilterSheet({
    required this.allPlatforms,
    required this.selectedPlatforms,
    required this.onToggle,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.45,
      maxChildSize: 0.6,
      builder: (_, ctrl) => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Text(
                  'Filter by Platform',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (selectedPlatforms.isNotEmpty)
                  TextButton(
                    onPressed: onClear,
                    child: const Text('Clear all'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: ctrl,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: allPlatforms.map((p) {
                final selected = selectedPlatforms.contains(p);
                return CheckboxListTile(
                  title: Text(p, style: const TextStyle(fontSize: 14)),
                  value: selected,
                  dense: true,
                  onChanged: (_) => onToggle(p),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  selectedPlatforms.isEmpty
                      ? 'Show all platforms'
                      : 'Apply filter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 52, color: cs.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'No techniques match your filters',
              style: TextStyle(
                fontSize: 15,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try a different search term or clear the filters.',
              style: TextStyle(fontSize: 12, color: cs.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
