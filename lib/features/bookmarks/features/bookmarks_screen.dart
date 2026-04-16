import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(allBookmarksProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        actions: [
          bookmarksAsync.when(
            data: (b) => b.isNotEmpty
                ? TextButton(
                    onPressed: () => _confirmClearAll(context, ref),
                    child: const Text('Clear All'),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: bookmarksAsync.when(
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return EmptyStateWidget(
              title: 'No Bookmarks Yet',
              subtitle:
                  'Bookmark techniques from the detail screen to save them here.',
              icon: Icons.bookmark_border,
              actionLabel: 'Browse Library',
              onActionPressed: () => context.push('/library'),
            );
          }

          // Group bookmarks by tactic using technique data
          return allTechAsync.when(
            data: (allTech) {
              final techMap = {for (final t in allTech) t.id: t};
              final grouped = _groupByTactic(bookmarks, techMap);

              return RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(allBookmarksProvider),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Summary
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            AppTheme.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.primaryColor
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark,
                              color: AppTheme.primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${bookmarks.length} technique${bookmarks.length == 1 ? '' : 's'} bookmarked',
                            style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Grouped by tactic
                    ...grouped.entries.map(
                      (entry) => _TacticGroup(
                        tacticName: entry.key,
                        bookmarks: entry.value,
                        techMap: techMap,
                        ref: ref,
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const LoadingWidget(),
            error: (e, _) => EmptyStateWidget(
              title: 'Error',
              subtitle: e.toString(),
              icon: Icons.error_outline,
            ),
          );
        },
        loading: () =>
            const LoadingWidget(message: 'Loading bookmarks…'),
        error: (e, _) => EmptyStateWidget(
          title: 'Error',
          subtitle: e.toString(),
          icon: Icons.error_outline,
        ),
      ),
    );
  }

  Map<String, List<BookmarkItem>> _groupByTactic(
    List<BookmarkItem> bookmarks,
    Map<String, AttackTechnique> techMap,
  ) {
    final grouped = <String, List<BookmarkItem>>{};
    for (final b in bookmarks) {
      final tech = techMap[b.techniqueId];
      final tactic =
          tech?.tactics.isNotEmpty == true ? tech!.tactics.first : 'Other';
      grouped.putIfAbsent(tactic, () => []).add(b);
    }
    // Sort tactics alphabetically
    return Map.fromEntries(
        grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  void _confirmClearAll(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear All Bookmarks?'),
        content: const Text(
            'This will remove all bookmarked techniques. Cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: AppTheme.dangerColor),
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(clearAllBookmarksProvider.future);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

// ─── Tactic group section ─────────────────────────────────────────────────────

class _TacticGroup extends StatelessWidget {
  final String tacticName;
  final List<BookmarkItem> bookmarks;
  final Map<String, AttackTechnique> techMap;
  final WidgetRef ref;

  const _TacticGroup({
    required this.tacticName,
    required this.bookmarks,
    required this.techMap,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 4),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                tacticName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${bookmarks.length}',
                  style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        ...bookmarks.map(
          (b) => _BookmarkCard(
            bookmark: b,
            technique: techMap[b.techniqueId],
            ref: ref,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// ─── Bookmark card ────────────────────────────────────────────────────────────

class _BookmarkCard extends ConsumerWidget {
  final BookmarkItem bookmark;
  final AttackTechnique? technique;
  final WidgetRef ref;

  const _BookmarkCard({
    required this.bookmark,
    required this.technique,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef watchRef) {
    final coverageAsync = watchRef
        .watch(techniqueCoverageStatusProvider(bookmark.techniqueId));
    final riskScore = technique?.riskScore ?? 5.0;

    Color riskColor() {
      if (riskScore >= 8.5) return AppTheme.dangerColor;
      if (riskScore >= 7.0) return AppTheme.accentColor;
      if (riskScore >= 5.0) return AppTheme.warningColor;
      return AppTheme.successColor;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => context.push('/technique/${bookmark.techniqueId}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Coverage dot
              coverageAsync.when(
                data: (cov) {
                  final c = _covColor(cov?.level ?? CoverageLevel.notCovered);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 10),
                    decoration:
                        BoxDecoration(color: c, shape: BoxShape.circle),
                  );
                },
                loading: () => const SizedBox(width: 20),
                error: (_, __) => const SizedBox(width: 20),
              ),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          bookmark.techniqueId,
                          style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: riskColor().withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            riskScore.toStringAsFixed(1),
                            style: TextStyle(
                                color: riskColor(),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      bookmark.techniqueName,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (bookmark.notes != null &&
                        bookmark.notes!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        bookmark.notes!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Delete
              IconButton(
                icon: const Icon(Icons.bookmark_remove,
                    size: 20, color: Colors.grey),
                onPressed: () async {
                  await ref.read(
                      removeBookmarkProvider(bookmark.techniqueId).future);
                },
                tooltip: 'Remove bookmark',
              ),
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Color _covColor(CoverageLevel level) {
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