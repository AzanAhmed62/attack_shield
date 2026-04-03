import 'package:attackshield/core/widgets/common_widgets.dart';
import 'package:attackshield/shared/providers/technique_providers.dart';
import 'package:attackshield/shared/providers/bookmark_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TechniqueDetailScreen extends ConsumerWidget {
  final String techniqueId;

  const TechniqueDetailScreen({super.key, required this.techniqueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final techniqueAsync = ref.watch(techniqueByIdProvider(techniqueId));
    final isBookmarkedAsync = ref.watch(
      isTechniqueBookmarkedProvider(techniqueId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Technique Details'),
        actions: [
          isBookmarkedAsync.when(
            data: (isBookmarked) => IconButton(
              icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () {
                if (isBookmarked) {
                  ref.read(removeBookmarkProvider(techniqueId));
                } else {
                  techniqueAsync.whenData((technique) {
                    if (technique != null) {
                      ref.read(
                        addBookmarkProvider(techniqueId, technique.name),
                      );
                    }
                  });
                }
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: techniqueAsync.when(
        data: (technique) {
          if (technique == null) {
            return EmptyStateWidget(
              title: 'Technique Not Found',
              subtitle: 'The requested technique could not be found',
              icon: Icons.search_off,
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  technique.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  technique.id,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                RiskScoreBadge(riskScore: technique.riskScore),
                const SizedBox(height: 24),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  technique.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                if (technique.tactics.isNotEmpty) ...[
                  Text(
                    'Tactics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: technique.tactics
                        .map((tactic) => Chip(label: Text(tactic)))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                if (technique.platforms.isNotEmpty) ...[
                  Text(
                    'Platforms',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: technique.platforms
                        .map((platform) => Chip(label: Text(platform)))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(message: 'Loading technique...'),
        error: (err, st) => EmptyStateWidget(
          title: 'Error Loading Technique',
          subtitle: err.toString(),
          icon: Icons.error_outline,
        ),
      ),
    );
  }
}
