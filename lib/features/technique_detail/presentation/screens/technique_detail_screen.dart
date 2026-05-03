import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/core/widgets/ai_explainer_section.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

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
        title: Text(techniqueId),
        actions: [
          isBookmarkedAsync.when(
            data: (isBookmarked) => IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: AppTheme.primaryColor,
              ),
              tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark technique',
              onPressed: () async {
                if (isBookmarked) {
                  await ref.read(removeBookmarkProvider(techniqueId).future);
                } else {
                  final technique = await ref.read(
                    techniqueByIdProvider(techniqueId).future,
                  );
                  if (technique != null) {
                    await ref.read(
                      addBookmarkProvider(techniqueId, technique.name).future,
                    );
                  }
                }
                ref.invalidate(isTechniqueBookmarkedProvider(techniqueId));
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: techniqueAsync.when(
        data: (technique) {
          if (technique == null) {
            return EmptyStateWidget(
              title: 'Technique Not Found',
              subtitle: 'ID: $techniqueId was not found in the dataset',
              icon: Icons.search_off,
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header card ──────────────────────────────────────────
                _HeaderCard(technique: technique),
                const SizedBox(height: 16),

                CoverageEditorCard(
                  techniqueId: technique.id,
                  riskScore: technique.riskScore,
                  subtitle:
                      'Update status, add analyst notes, and track related defensive controls.',
                ),
                const SizedBox(height: 16),

                AIExplainerSection(technique: technique),
                const SizedBox(height: 16),

                // ── Description ──────────────────────────────────────────
                _Section(
                  title: 'Description',
                  child: Text(
                    technique.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Tactics ──────────────────────────────────────────────
                if (technique.tactics.isNotEmpty)
                  _Section(
                    title: 'Tactics',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: technique.tactics
                          .map(
                            (t) => ActionChip(
                              label: Text(t),
                              backgroundColor: AppTheme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              labelStyle: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 12,
                              ),
                              onPressed: () {
                                ref
                                    .read(selectedTacticProvider.notifier)
                                    .select(t);
                                context.push('/library');
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 16),

                // ── Platforms ─────────────────────────────────────────────
                if (technique.platforms.isNotEmpty)
                  _Section(
                    title: 'Affected Platforms',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: technique.platforms
                          .map(
                            (p) => Chip(
                              label: Text(
                                p,
                                style: const TextStyle(fontSize: 12),
                              ),
                              avatar: const Icon(Icons.computer, size: 14),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 16),

                // ── Sub-techniques ────────────────────────────────────────
                if (technique.subTechniques.isNotEmpty) ...[
                  _Section(
                    title: 'Sub-Techniques (${technique.subTechniques.length})',
                    icon: Icons.account_tree,
                    child: Column(
                      children: technique.subTechniques
                          .map(
                            (s) => _SubTechCard(
                              parentTechniqueId: technique.id,
                              sub: s,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Detection notes ───────────────────────────────────────
                if (technique.detectionNotes.isNotEmpty) ...[
                  _Section(
                    title: 'Detection Guidance',
                    icon: Icons.radar,
                    iconColor: AppTheme.warningColor,
                    child: Column(
                      children: technique.detectionNotes
                          .map(
                            (n) =>
                                _Bullet(text: n, color: AppTheme.warningColor),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Mitigation notes ──────────────────────────────────────
                if (technique.mitigationNotes.isNotEmpty) ...[
                  _Section(
                    title: 'Mitigation Guidance',
                    icon: Icons.shield,
                    iconColor: AppTheme.successColor,
                    child: Column(
                      children: technique.mitigationNotes
                          .map(
                            (n) =>
                                _Bullet(text: n, color: AppTheme.successColor),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── MITRE reference ───────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
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
                          'https://attack.mitre.org/techniques/${techniqueId.replaceAll('.', '/')}/',
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
                const SizedBox(height: 32),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(message: 'Loading technique…'),
        error: (e, _) => EmptyStateWidget(
          title: 'Error',
          subtitle: e.toString(),
          icon: Icons.error_outline,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final AttackTechnique technique;
  const _HeaderCard({required this.technique});

  Color get _c {
    if (technique.riskScore >= 8.5) return AppTheme.dangerColor;
    if (technique.riskScore >= 7.0) return AppTheme.accentColor;
    if (technique.riskScore >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  String get _label {
    if (technique.riskScore >= 8.5) return 'Critical';
    if (technique.riskScore >= 7.0) return 'High';
    if (technique.riskScore >= 5.0) return 'Medium';
    return 'Low';
  }

  @override
  Widget build(BuildContext context) {
    final c = _c;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        technique.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        technique.id,
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c.withValues(alpha: 0.12),
                    border: Border.all(color: c, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        technique.riskScore.toStringAsFixed(1),
                        style: TextStyle(
                          color: c,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _label,
                        style: TextStyle(
                          color: c,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: technique.riskScore / 10.0,
                minHeight: 6,
                backgroundColor: c.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(c),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Risk: ${technique.riskScore.toStringAsFixed(1)}/10',
                  style: TextStyle(color: c, fontSize: 12),
                ),
                if (technique.subTechniques.isNotEmpty) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${technique.subTechniques.length} sub-techniques',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sub-technique card ───────────────────────────────────────────────────────

class _SubTechCard extends StatelessWidget {
  final String parentTechniqueId;
  final AttackSubTechnique sub;
  const _SubTechCard({required this.parentTechniqueId, required this.sub});

  Color get _c {
    if (sub.riskScore >= 8.5) return AppTheme.dangerColor;
    if (sub.riskScore >= 7.0) return AppTheme.accentColor;
    if (sub.riskScore >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/technique/$parentTechniqueId/sub/${sub.id}'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: _c,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        sub.id,
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        sub.riskScore.toStringAsFixed(1),
                        style: TextStyle(
                          color: _c,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(sub.name, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    sub.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// ─── Section / Bullet helpers ─────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;
  final Color? iconColor;

  const _Section({
    required this.title,
    required this.child,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: iconColor ?? AppTheme.primaryColor),
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

class _Bullet extends StatelessWidget {
  final String text;
  final Color color;
  const _Bullet({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
