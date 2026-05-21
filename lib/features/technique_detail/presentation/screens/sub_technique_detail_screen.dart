import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/shared/providers/technique_providers.dart';

/// Placeholder for sub-technique details.
class SubTechniqueDetailScreen extends ConsumerWidget {
  final String parentTechniqueId;
  final String subTechniqueId;

  const SubTechniqueDetailScreen({
    super.key,
    required this.parentTechniqueId,
    required this.subTechniqueId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parentAsync = ref.watch(techniqueByIdProvider(parentTechniqueId));
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(backgroundColor: cs.surface, title: Text(subTechniqueId)),
      body: parentAsync.when(
        data: (parent) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 64, color: cs.outline),
                const SizedBox(height: 16),
                Text(
                  'Sub-Technique Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sub-technique breakdowns are part of the main technique view.\n'
                  'Enhanced sub-technique support coming soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.outline),
                ),
                const SizedBox(height: 24),
                if (parent != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).push('/technique/$parentTechniqueId');
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to Technique'),
                  ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: cs.error),
              const SizedBox(height: 16),
              Text('Error', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(error.toString(), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
