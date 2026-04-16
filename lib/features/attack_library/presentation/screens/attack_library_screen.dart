import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class AttackLibraryScreen extends ConsumerStatefulWidget {
  /// When navigating from coverage matrix with a tactic pre-selected,
  /// pass the tactic name here. It will pre-set the filter on first build.
  final String? initialTactic;

  const AttackLibraryScreen({super.key, this.initialTactic});

  @override
  ConsumerState<AttackLibraryScreen> createState() =>
      _AttackLibraryScreenState();
}

class _AttackLibraryScreenState extends ConsumerState<AttackLibraryScreen> {
  @override
  void initState() {
    super.initState();
    // Pre-set tactic filter if navigated from coverage matrix
    if (widget.initialTactic != null && widget.initialTactic!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(selectedTacticProvider.notifier)
            .select(widget.initialTactic!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredAsync = ref.watch(filteredTechniquesProvider);
    final allTacticsAsync = ref.watch(allTacticsProvider);
    final selectedTactic = ref.watch(selectedTacticProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);
    final sortOption = ref.watch(techniqueSortProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ATT&CK Technique Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Filter & Sort',
            onPressed: () => _showFilterSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SearchField(
              hintText: 'Search by name, ID, tactic…',
              onChanged: (v) =>
                  ref.read(searchQueryProvider.notifier).update(v),
            ),
          ),

          // ── Tactic chips ──────────────────────────────────────────────
          allTacticsAsync.when(
            data: (tactics) => SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: tactics.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    final isAll = selectedTactic.isEmpty;
                    return FilterChip(
                      label: const Text('All'),
                      selected: isAll,
                      onSelected: (_) =>
                          ref.read(selectedTacticProvider.notifier).clear(),
                      selectedColor:
                          AppTheme.primaryColor.withValues(alpha: 0.2),
                      checkmarkColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isAll ? AppTheme.primaryColor : null,
                        fontSize: 12,
                      ),
                    );
                  }
                  final tactic = tactics[i - 1];
                  final isSel = selectedTactic == tactic.name;
                  return FilterChip(
                    label: Text(tactic.name),
                    selected: isSel,
                    onSelected: (_) => isSel
                        ? ref.read(selectedTacticProvider.notifier).clear()
                        : ref
                            .read(selectedTacticProvider.notifier)
                            .select(tactic.name),
                    selectedColor:
                        AppTheme.primaryColor.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color: isSel ? AppTheme.primaryColor : null,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            loading: () => const SizedBox(height: 48),
            error: (_, __) => const SizedBox(height: 48),
          ),

          // ── Stats bar ─────────────────────────────────────────────────
          filteredAsync.when(
            data: (filtered) => allTechAsync.when(
              data: (all) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                child: Row(
                  children: [
                    Text(
                      '${filtered.length} technique${filtered.length == 1 ? '' : 's'}',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                    ),
                    if (selectedTactic.isNotEmpty)
                      Text(
                        ' in $selectedTactic',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    const Spacer(),
                    Text(
                      '${all.fold(0, (s, t) => s + t.subTechniques.length)} sub-techniques · ${_sortLabel(sortOption)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // ── List ──────────────────────────────────────────────────────
          Expanded(
            child: filteredAsync.when(
              data: (techniques) => techniques.isEmpty
                  ? EmptyStateWidget(
                      title: 'No Techniques Found',
                      subtitle:
                          'Try a different search or clear the filter',
                      icon: Icons.search_off,
                      actionLabel: 'Clear Filters',
                      onActionPressed: () {
                        ref.read(searchQueryProvider.notifier).clear();
                        ref.read(selectedTacticProvider.notifier).clear();
                        ref.read(minRiskFilterProvider.notifier).clear();
                      },
                    )
                  : ListView.separated(
                      itemCount: techniques.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 1, indent: 16, endIndent: 16),
                      itemBuilder: (_, i) =>
                          _TechniqueListItem(technique: techniques[i]),
                    ),
              loading: () =>
                  const LoadingWidget(message: 'Loading techniques…'),
              error: (e, _) => EmptyStateWidget(
                title: 'Error',
                subtitle: e.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FilterSheet(outerRef: ref),
    );
  }

  String _sortLabel(TechniqueSortOption option) {
    switch (option) {
      case TechniqueSortOption.nameAsc:
        return 'A-Z';
      case TechniqueSortOption.subTechniqueCountDesc:
        return 'Most subs';
      case TechniqueSortOption.riskDesc:
        return 'Risk';
    }
  }
}

// ─── Technique list tile with coverage dot ────────────────────────────────────

class _TechniqueListItem extends ConsumerWidget {
  final AttackTechnique technique;
  const _TechniqueListItem({required this.technique});

  Color get _riskColor {
    if (technique.riskScore >= 8.5) return AppTheme.dangerColor;
    if (technique.riskScore >= 7.0) return AppTheme.accentColor;
    if (technique.riskScore >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  String get _riskLabel {
    if (technique.riskScore >= 8.5) return 'Critical';
    if (technique.riskScore >= 7.0) return 'High';
    if (technique.riskScore >= 5.0) return 'Medium';
    return 'Low';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = _riskColor;
    // Coverage dot — shows green/yellow/red per technique in list
    final coverageAsync =
        ref.watch(techniqueCoverageStatusProvider(technique.id));

    return InkWell(
      onTap: () => context.push('/technique/${technique.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Risk bar
            Container(
              width: 4,
              height: 54,
              decoration: BoxDecoration(
                  color: c, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        technique.id,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      if (technique.subTechniques.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '+${technique.subTechniques.length}',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    technique.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    technique.tactics.join(' · '),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Coverage status dot
            coverageAsync.when(
              data: (cov) {
                final dotColor = _coverageColor(
                    cov?.level ?? CoverageLevel.notCovered);
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: dotColor, shape: BoxShape.circle),
                );
              },
              loading: () => const SizedBox(width: 18),
              error: (_, __) => const SizedBox(width: 18),
            ),
            // Risk badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(_riskLabel,
                      style: TextStyle(
                          color: c,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 3),
                Text(
                  technique.riskScore.toStringAsFixed(1),
                  style: TextStyle(
                      color: c,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 20, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Color _coverageColor(CoverageLevel level) {
    switch (level) {
      case CoverageLevel.covered:
        return AppTheme.successColor;
      case CoverageLevel.partiallyCovered:
        return AppTheme.warningColor;
      case CoverageLevel.unknown:
        return Colors.grey;
      case CoverageLevel.notCovered:
        return AppTheme.dangerColor;
    }
  }
}

// ─── Filter sheet ─────────────────────────────────────────────────────────────

class _FilterSheet extends ConsumerWidget {
  final WidgetRef outerRef;
  const _FilterSheet({required this.outerRef});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPlatformsAsync = ref.watch(allPlatformsProvider);
    final selectedPlatform = ref.watch(selectedPlatformProvider);
    final minRisk = ref.watch(minRiskFilterProvider);
    final sortOption = ref.watch(techniqueSortProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Text('Filter Techniques',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text('Platform',
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          allPlatformsAsync.when(
            data: (platforms) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: selectedPlatform.isEmpty,
                  onSelected: (_) => ref
                      .read(selectedPlatformProvider.notifier)
                      .clear(),
                ),
                ...platforms.map(
                  (p) => FilterChip(
                    label:
                        Text(p, style: const TextStyle(fontSize: 12)),
                    selected: selectedPlatform == p,
                    onSelected: (_) => selectedPlatform == p
                        ? ref
                            .read(selectedPlatformProvider.notifier)
                            .clear()
                        : ref
                            .read(selectedPlatformProvider.notifier)
                            .select(p),
                  ),
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 20),
          Text(
            'Min Risk: ${minRisk == 0.0 ? 'Any' : minRisk.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Slider(
            value: minRisk,
            min: 0.0,
            max: 9.0,
            divisions: 18,
            activeColor: AppTheme.primaryColor,
            onChanged: (v) =>
                ref.read(minRiskFilterProvider.notifier).setMin(v),
          ),
          const SizedBox(height: 20),
          Text(
            'Sort By',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Risk Score'),
                selected: sortOption == TechniqueSortOption.riskDesc,
                onSelected: (_) => ref
                    .read(techniqueSortProvider.notifier)
                    .setSort(TechniqueSortOption.riskDesc),
              ),
              ChoiceChip(
                label: const Text('Technique Name'),
                selected: sortOption == TechniqueSortOption.nameAsc,
                onSelected: (_) => ref
                    .read(techniqueSortProvider.notifier)
                    .setSort(TechniqueSortOption.nameAsc),
              ),
              ChoiceChip(
                label: const Text('Sub-technique Count'),
                selected:
                    sortOption == TechniqueSortOption.subTechniqueCountDesc,
                onSelected: (_) => ref
                    .read(techniqueSortProvider.notifier)
                    .setSort(TechniqueSortOption.subTechniqueCountDesc),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref
                        .read(selectedPlatformProvider.notifier)
                        .clear();
                    ref.read(minRiskFilterProvider.notifier).clear();
                    ref.read(selectedTacticProvider.notifier).clear();
                    ref.read(searchQueryProvider.notifier).clear();
                    ref
                        .read(techniqueSortProvider.notifier)
                        .setSort(TechniqueSortOption.riskDesc);
                    Navigator.pop(context);
                  },
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
