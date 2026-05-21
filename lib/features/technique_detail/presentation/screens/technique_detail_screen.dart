// lib/features/library/presentation/screens/technique_detail_screen.dart
// FULL REPLACEMENT — Technical / Plain English toggle, full STIX fields,
// inline coverage control, Gemini AI explanation, mitigations, sub-techniques.

import 'dart:convert';
import 'package:attackshield/shared/models/alert_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/attack_technique.dart';
import '../../../../shared/models/coverage_status.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../shared/providers/alert_providers.dart';
import '../../../../shared/widgets/shimmer_loader.dart';

class TechniqueDetailScreen extends HookConsumerWidget {
  final String techniqueId;
  const TechniqueDetailScreen({super.key, required this.techniqueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final techniqueAsync = ref.watch(techniqueByIdProvider(techniqueId));
    final coverageAsync = ref.watch(
      techniqueCoverageStatusProvider(techniqueId),
    );

    // Fetch alerts for this technique (get all and filter in widget)
    final allAlertsAsync = ref.watch(alertsProvider);

    // UI state
    final isPlainMode = useState(false);
    final aiExplanation = useState<Map<String, dynamic>?>(null);
    final aiLoading = useState(false);
    final aiError = useState<String?>(null);

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: techniqueAsync.when(
        loading: () => const _DetailSkeleton(),
        error: (e, _) => _ErrorState(message: e.toString()),
        data: (technique) {
          if (technique == null) {
            return const _ErrorState(message: 'Technique not found.');
          }

          // Active alert for this technique
          final activeAlert =
              allAlertsAsync
                  .whenData(
                    (alerts) => alerts
                        .where((a) => a.relatedTechniqueId == techniqueId)
                        .isNotEmpty,
                  )
                  .value ??
              false;

          return CustomScrollView(
            slivers: [
              // ── App bar ─────────────────────────────────────────────
              SliverAppBar(
                pinned: true,
                expandedHeight: 0,
                backgroundColor: cs.surface,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => context.pop(),
                ),
                title: Row(
                  children: [
                    _TechniqueIdBadge(id: technique.id),
                    const SizedBox(width: 8),
                    if (activeAlert)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Text(
                          'ACTIVE ALERT',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
                actions: [
                  // Mode toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(
                          value: false,
                          icon: Icon(Icons.code_rounded, size: 14),
                          label: Text(
                            'Technical',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        ButtonSegment(
                          value: true,
                          icon: Icon(Icons.people_rounded, size: 14),
                          label: Text('Plain', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                      selected: {isPlainMode.value},
                      onSelectionChanged: (s) {
                        isPlainMode.value = s.first;
                        // Auto-fetch AI explanation when switching to plain mode
                        if (s.first &&
                            aiExplanation.value == null &&
                            !aiLoading.value) {
                          _fetchAiExplanation(
                            ref,
                            technique,
                            aiExplanation,
                            aiLoading,
                            aiError,
                          );
                        }
                      },
                      style: SegmentedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  // MITRE URL
                  if (technique.url != null)
                    IconButton(
                      icon: const Icon(Icons.open_in_browser_rounded, size: 20),
                      tooltip: 'Open on MITRE ATT&CK',
                      onPressed: () => launchUrl(Uri.parse(technique.url!)),
                    ),
                  const SizedBox(width: 4),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Title & tactic chips ─────────────────────────
                    Text(
                      technique.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        ...technique.tactics.map((t) => _TacticChip(tactic: t)),
                        ...technique.platforms
                            .take(4)
                            .map((p) => _PlatformChip(platform: p)),
                        if (technique.isSubTechnique)
                          _InfoChip(
                            label: 'Sub-technique',
                            icon: Icons.subdirectory_arrow_right_rounded,
                            color: cs.secondary,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Coverage control ─────────────────────────────
                    coverageAsync.when(
                      loading: () => const ShimmerLoader(height: 72),
                      error: (e, _) => const SizedBox.shrink(),
                      data: (status) => _CoverageControl(
                        techniqueId: techniqueId,
                        current: status?.level ?? CoverageLevel.unknown,
                        notes: status?.notes,
                        ref: ref,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Risk score row ────────────────────────────────
                    _RiskScoreRow(technique: technique),
                    const SizedBox(height: 20),

                    // ── Body: switches between Technical and Plain ────
                    if (isPlainMode.value)
                      _PlainLanguageBody(
                        technique: technique,
                        aiExplanation: aiExplanation.value,
                        isLoading: aiLoading.value,
                        error: aiError.value,
                        onRetry: () => _fetchAiExplanation(
                          ref,
                          technique,
                          aiExplanation,
                          aiLoading,
                          aiError,
                        ),
                      )
                    else
                      _TechnicalBody(technique: technique, ref: ref),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _fetchAiExplanation(
    WidgetRef ref,
    AttackTechnique technique,
    ValueNotifier<Map<String, dynamic>?> aiExplanation,
    ValueNotifier<bool> aiLoading,
    ValueNotifier<String?> aiError,
  ) async {
    aiLoading.value = true;
    aiError.value = null;
    try {
      final gemini = ref.read(geminiServiceProvider);
      final result = await gemini.explainTechniqueSimply(
        techniqueId: technique.id,
        techniqueName: technique.name,
        stixDescription: technique.description,
      );
      if (result.isSuccess && result.text != null) {
        try {
          final clean = result.text!
              .replaceAll('```json', '')
              .replaceAll('```', '')
              .trim();
          aiExplanation.value = jsonDecode(clean) as Map<String, dynamic>;
        } catch (_) {
          // If JSON parsing fails, show raw text
          aiExplanation.value = {'simpleExplanation': result.text};
        }
      } else {
        aiError.value = result.error;
      }
    } catch (e) {
      aiError.value = 'Could not load AI explanation: $e';
    } finally {
      aiLoading.value = false;
    }
  }
}

// ─── Coverage Control ─────────────────────────────────────────────────────────
class _CoverageControl extends StatelessWidget {
  final String techniqueId;
  final CoverageLevel current;
  final String? notes;
  final WidgetRef ref;
  const _CoverageControl({
    required this.techniqueId,
    required this.current,
    required this.notes,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text(
                'Coverage Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showNotesDialog(context),
                icon: Icon(
                  Icons.edit_note_rounded,
                  size: 14,
                  color: cs.outline,
                ),
                label: Text(
                  'Notes',
                  style: TextStyle(fontSize: 11, color: cs.outline),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _CoverageBtn(
                label: 'Not Covered',
                icon: Icons.cancel_outlined,
                color: Colors.red.shade500,
                isActive: current == CoverageLevel.notCovered,
                onTap: () => _setCoverage(context, CoverageLevel.notCovered),
              ),
              const SizedBox(width: 6),
              _CoverageBtn(
                label: 'Partial',
                icon: Icons.remove_circle_outline_rounded,
                color: Colors.amber.shade600,
                isActive: current == CoverageLevel.partiallyCovered,
                onTap: () =>
                    _setCoverage(context, CoverageLevel.partiallyCovered),
              ),
              const SizedBox(width: 6),
              _CoverageBtn(
                label: 'Covered',
                icon: Icons.check_circle_outline_rounded,
                color: Colors.green.shade600,
                isActive: current == CoverageLevel.covered,
                onTap: () => _setCoverage(context, CoverageLevel.covered),
              ),
            ],
          ),
          if (notes != null && notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.sticky_note_2_outlined, size: 13, color: cs.outline),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    notes!,
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.outline,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _setCoverage(BuildContext context, CoverageLevel level) async {
    await ref.read(setCoverageLevelProvider(techniqueId, level).future);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coverage updated — risk score recalculated'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _showNotesDialog(BuildContext context) async {
    final ctrl = TextEditingController(text: notes);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Coverage Notes'),
        content: TextField(
          controller: ctrl,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Add implementation notes, control references...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, ctrl.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      await ref.read(
        setCoverageLevelProvider(
          techniqueId,
          ref.read(techniqueCoverageStatusProvider(techniqueId)).value?.level ??
              CoverageLevel.unknown,
          notes: result,
        ).future,
      );
    }
  }
}

class _CoverageBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;
  const _CoverageBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive
                  ? color
                  : Theme.of(context).colorScheme.outlineVariant,
              width: isActive ? 1.5 : 0.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive ? color : Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive
                      ? color
                      : Theme.of(context).colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Risk Score Row ───────────────────────────────────────────────────────────
class _RiskScoreRow extends StatelessWidget {
  final AttackTechnique technique;
  const _RiskScoreRow({required this.technique});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final score = technique.riskScore;
    final color = score >= 8
        ? Colors.red.shade600
        : score >= 6
        ? Colors.orange.shade600
        : score >= 4
        ? Colors.amber.shade600
        : Colors.green.shade600;
    final label = score >= 8
        ? 'Critical'
        : score >= 6
        ? 'High'
        : score >= 4
        ? 'Medium'
        : 'Low';

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withOpacity(.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department_rounded, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                'Risk: $label (${score.toStringAsFixed(1)}/10)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (technique.dataSources.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${technique.dataSources.length} data sources',
              style: TextStyle(fontSize: 11, color: cs.outline),
            ),
          ),
        const SizedBox(width: 8),
        if (technique.subTechniqueIds.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${technique.subTechniqueIds.length} sub-techniques',
              style: TextStyle(fontSize: 11, color: cs.outline),
            ),
          ),
      ],
    );
  }
}

// ─── Technical Body ───────────────────────────────────────────────────────────
class _TechnicalBody extends StatelessWidget {
  final AttackTechnique technique;
  final WidgetRef ref;
  const _TechnicalBody({required this.technique, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        _Section(
          title: 'Description',
          icon: Icons.article_outlined,
          child: _ExpandableText(text: technique.description),
        ),

        // Sub-techniques
        if (technique.subTechniqueIds.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Sub-techniques (${technique.subTechniqueIds.length})',
            icon: Icons.subdirectory_arrow_right_rounded,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: technique.subTechniqueIds
                  .map(
                    (id) => ActionChip(
                      label: Text(id, style: const TextStyle(fontSize: 12)),
                      onPressed: () => context.push('/library/$id'),
                      avatar: const Icon(Icons.open_in_new_rounded, size: 12),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        // Parent technique
        if (technique.isSubTechnique &&
            technique.parentTechniqueId != null) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Parent Technique',
            icon: Icons.arrow_upward_rounded,
            child: ActionChip(
              label: Text(technique.parentTechniqueId!),
              onPressed: () =>
                  context.push('/library/${technique.parentTechniqueId}'),
              avatar: const Icon(Icons.open_in_new_rounded, size: 12),
            ),
          ),
        ],

        // Platforms
        if (technique.platforms.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Affected Platforms',
            icon: Icons.devices_rounded,
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: technique.platforms
                  .map((p) => _PlatformChip(platform: p))
                  .toList(),
            ),
          ),
        ],

        // Data sources
        if (technique.dataSources.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Detection Data Sources',
            icon: Icons.radar_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: technique.dataSources
                  .map(
                    (ds) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 8,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ds,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        // Mitigations
        if (technique.mitigationIds.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Mitigations (${technique.mitigationIds.length})',
            icon: Icons.health_and_safety_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: technique.mitigationIds
                  .map(
                    (m) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 15,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              m,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        // Related techniques
        if (technique.relatedTechniqueIds.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Related Techniques',
            icon: Icons.link_rounded,
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: technique.relatedTechniqueIds
                  .take(8)
                  .map(
                    (id) => ActionChip(
                      label: Text(id, style: const TextStyle(fontSize: 11)),
                      onPressed: () => context.push('/library/$id'),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        // MITRE metadata
        const SizedBox(height: 16),
        _Section(
          title: 'MITRE Metadata',
          icon: Icons.info_outline_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (technique.created != null)
                _MetaRow(
                  label: 'Created',
                  value: technique.created!.substring(0, 10),
                ),
              if (technique.modified != null)
                _MetaRow(
                  label: 'Modified',
                  value: technique.modified!.substring(0, 10),
                ),
              _MetaRow(label: 'STIX ID', value: technique.stixId),
              if (technique.url != null)
                InkWell(
                  onTap: () => launchUrl(Uri.parse(technique.url!)),
                  child: Row(
                    children: [
                      Text(
                        'ATT&CK URL: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      const Icon(Icons.open_in_new_rounded, size: 12),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ─── Plain Language Body ──────────────────────────────────────────────────────
class _PlainLanguageBody extends StatelessWidget {
  final AttackTechnique technique;
  final Map<String, dynamic>? aiExplanation;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;
  const _PlainLanguageBody({
    required this.technique,
    required this.aiExplanation,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // What is this attack?
        _Section(
          title: 'What Is This Attack?',
          icon: Icons.help_outline_rounded,
          child: isLoading
              ? const ShimmerLoader(height: 60)
              : error != null
              ? _AiError(error: error!, onRetry: onRetry)
              : Text(
                  aiExplanation?['simpleExplanation'] as String? ??
                      technique.description.split('. ').first + '.',
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
        ),
        const SizedBox(height: 16),

        // Real-world example
        if (!isLoading && aiExplanation?['realWorldExample'] != null) ...[
          _Section(
            title: 'Real-World Example',
            icon: Icons.lightbulb_outline_rounded,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.tertiaryContainer.withOpacity(.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                aiExplanation!['realWorldExample'] as String,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: cs.onTertiaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Business impact
        if (!isLoading && aiExplanation?['businessImpact'] != null) ...[
          _Section(
            title: 'Business Impact',
            icon: Icons.business_center_outlined,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    aiExplanation!['businessImpact'] as String,
                    style: const TextStyle(fontSize: 13, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Urgency
        if (!isLoading && aiExplanation?['urgencyLevel'] != null) ...[
          _UrgencyBanner(level: aiExplanation!['urgencyLevel'] as String),
          const SizedBox(height: 16),
        ],

        // What to do
        if (!isLoading) ...[
          _Section(
            title: 'What Should You Do?',
            icon: Icons.task_alt_rounded,
            child: isLoading
                ? const ShimmerLoader(height: 80)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildActionItems(context, cs),
                  ),
          ),
          const SizedBox(height: 16),
        ],

        // Affected systems (plain)
        if (technique.platforms.isNotEmpty) ...[
          _Section(
            title: 'Affected Systems',
            icon: Icons.devices_rounded,
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: technique.platforms
                  .map((p) => _PlatformChip(platform: p))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Expert mode prompt
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 16, color: cs.outline),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Switch to Technical mode to see MITRE ATT&CK data, detection sources, and mitigations.',
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.outline,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  List<Widget> _buildActionItems(BuildContext context, ColorScheme cs) {
    final aiItems = aiExplanation?['topThreeActions'] as List?;
    final items =
        aiItems?.cast<String>() ?? technique.mitigationIds.take(3).toList();
    if (items.isEmpty) {
      return [
        Text(
          'Consult your security team about coverage for ${technique.id}.',
          style: const TextStyle(fontSize: 13),
        ),
      ];
    }
    return items
        .asMap()
        .entries
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${e.key + 1}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.value,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

class _UrgencyBanner extends StatelessWidget {
  final String level;
  const _UrgencyBanner({required this.level});

  @override
  Widget build(BuildContext context) {
    final color = level == 'Critical'
        ? Colors.red.shade600
        : level == 'High'
        ? Colors.orange.shade600
        : level == 'Medium'
        ? Colors.amber.shade600
        : Colors.green.shade600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.bolt_rounded, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            'Urgency: $level',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '— This threat requires $level priority attention.',
              style: TextStyle(fontSize: 12, color: color.withOpacity(.8)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiError extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _AiError({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI explanation unavailable.',
          style: TextStyle(fontSize: 13, color: cs.outline),
        ),
        const SizedBox(height: 4),
        Text(error, style: TextStyle(fontSize: 11, color: cs.error)),
        const SizedBox(height: 6),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded, size: 14),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}

// ─── Shared section widget ────────────────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _Section({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: cs.primary),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _ExpandableText extends HookWidget {
  final String text;
  const _ExpandableText({required this.text});

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    final isLong = text.length > 400;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          expanded.value || !isLong ? text : '${text.substring(0, 400)}...',
          style: const TextStyle(fontSize: 13, height: 1.55),
        ),
        if (isLong) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => expanded.value = !expanded.value,
            child: Text(
              expanded.value ? 'Show less' : 'Read more',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label, value;
  const _MetaRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontSize: 12, color: cs.outline)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 13),
            onPressed: () => Clipboard.setData(ClipboardData(text: value)),
            tooltip: 'Copy',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// ─── Chips ────────────────────────────────────────────────────────────────────
class _TechniqueIdBadge extends StatelessWidget {
  final String id;
  const _TechniqueIdBadge({required this.id});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        id,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: cs.primary,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _TacticChip extends StatelessWidget {
  final String tactic;
  const _TacticChip({required this.tactic});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tactic
            .replaceAll('-', ' ')
            .split(' ')
            .map((w) => w[0].toUpperCase() + w.substring(1))
            .join(' '),
        style: TextStyle(fontSize: 11, color: cs.onSecondaryContainer),
      ),
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String platform;
  const _PlatformChip({required this.platform});

  static const _icons = <String, IconData>{
    'Windows': Icons.window_rounded,
    'macOS': Icons.apple_rounded,
    'Linux': Icons.terminal_rounded,
    'Cloud': Icons.cloud_outlined,
    'Azure AD': Icons.cloud_done_outlined,
    'SaaS': Icons.web_rounded,
    'Network': Icons.router_outlined,
    'Containers': Icons.inventory_2_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final icon = _icons[platform] ?? Icons.devices_rounded;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: cs.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            platform,
            style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _InfoChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}

// ─── Skeleton loader ──────────────────────────────────────────────────────────
class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          ShimmerLoader(height: 28, width: 200),
          SizedBox(height: 12),
          ShimmerLoader(height: 20, width: 300),
          SizedBox(height: 16),
          ShimmerLoader(height: 72),
          SizedBox(height: 12),
          ShimmerLoader(height: 120),
          SizedBox(height: 12),
          ShimmerLoader(height: 80),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
