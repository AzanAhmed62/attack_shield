import 'package:attackshield/core/widgets/common_widgets.dart';
import 'package:attackshield/core/widgets/custom_widgets.dart';
import 'package:attackshield/shared/providers/technique_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class AttackLibraryScreen extends ConsumerWidget {
  const AttackLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTechniquesAsync = ref.watch(filteredTechniquesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ATT&CK Technique Library')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchField(
              hintText: 'Search techniques...',
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: filteredTechniquesAsync.when(
              data: (techniques) {
                if (techniques.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No Techniques Found',
                    subtitle: 'Try adjusting your search or filters',
                    icon: Icons.search_off,
                  );
                }
                return ListView.builder(
                  itemCount: techniques.length,
                  itemBuilder: (context, index) {
                    final technique = techniques[index];
                    return TechniqueTile(
                      techniqueId: technique.id,
                      techniqueName: technique.name,
                      tactic: technique.tactics.isNotEmpty
                          ? technique.tactics.first
                          : null,
                      riskScore: technique.riskScore,
                      onTap: () {
                        context.push('/technique/${technique.id}');
                      },
                    );
                  },
                );
              },
              loading: () =>
                  const LoadingWidget(message: 'Loading techniques...'),
              error: (err, st) => EmptyStateWidget(
                title: 'Error',
                subtitle: err.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
