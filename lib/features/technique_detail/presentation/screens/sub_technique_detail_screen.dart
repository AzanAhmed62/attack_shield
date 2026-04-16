import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/shared/providers/providers.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text(subTechniqueId)),
      body: parentAsync.when(
        data: (parent) {
          if (parent == null) {
            return const EmptyStateWidget(
              title: 'Parent Technique Not Found',
              subtitle: 'The parent technique for this sub-technique is missing.',
              icon: Icons.account_tree_outlined,
            );
          }

          AttackSubTechnique? subTechnique;
          for (final candidate in parent.subTechniques) {
            if (candidate.id == subTechniqueId) {
              subTechnique = candidate;
              break;
            }
          }

          if (subTechnique == null) {
            return EmptyStateWidget(
              title: 'Sub-Technique Not Found',
              subtitle: '$subTechniqueId does not exist under $parentTechniqueId.',
              icon: Icons.search_off,
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SubTechniqueHeader(
                  parentTechnique: parent,
                  subTechnique: subTechnique,
                ),
                const SizedBox(height: 16),
                CoverageEditorCard(
                  techniqueId: subTechnique.id,
                  riskScore: subTechnique.riskScore,
                  title: 'Sub-Technique Coverage',
                  subtitle:
                      'Tracked independently from the parent technique for finer ATT&CK coverage.',
                ),
                const SizedBox(height: 16),
                _DetailSection(
                  title: 'Description',
                  child: Text(
                    subTechnique.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailSection(
                  title: 'Parent Technique',
                  icon: Icons.call_split,
                  child: InkWell(
                    onTap: () => context.push('/technique/$parentTechniqueId'),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.22),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parent.id,
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  parent.name,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (parent.tactics.isNotEmpty) ...[
                  _DetailSection(
                    title: 'Parent Tactics',
                    icon: Icons.flag_outlined,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: parent.tactics
                          .map(
                            (tactic) => ActionChip(
                              label: Text(tactic),
                              onPressed: () => context.push(
                                '/library?tactic=${Uri.encodeComponent(tactic)}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (subTechnique.platforms.isNotEmpty) ...[
                  _DetailSection(
                    title: 'Affected Platforms',
                    icon: Icons.devices_outlined,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: subTechnique.platforms
                          .map((platform) => Chip(label: Text(platform)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.open_in_new,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'https://attack.mitre.org/techniques/${subTechnique.id.replaceAll('.', '/')}/',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(message: 'Loading sub-technique...'),
        error: (error, _) => EmptyStateWidget(
          title: 'Error',
          subtitle: error.toString(),
          icon: Icons.error_outline,
        ),
      ),
    );
  }
}

class _SubTechniqueHeader extends StatelessWidget {
  final AttackTechnique parentTechnique;
  final AttackSubTechnique subTechnique;

  const _SubTechniqueHeader({
    required this.parentTechnique,
    required this.subTechnique,
  });

  Color get _riskColor {
    if (subTechnique.riskScore >= 8.5) return AppTheme.dangerColor;
    if (subTechnique.riskScore >= 7.0) return AppTheme.accentColor;
    if (subTechnique.riskScore >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subTechnique.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subTechnique.id,
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Child of ${parentTechnique.id} · ${parentTechnique.name}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _riskColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    subTechnique.riskScore.toStringAsFixed(1),
                    style: TextStyle(
                      color: _riskColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      color: _riskColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;

  const _DetailSection({
    required this.title,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppTheme.primaryColor),
              const SizedBox(width: 6),
            ],
            Text(title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
