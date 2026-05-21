import 'package:attackshield/shared/models/attack_technique.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/core/services/ai_service.dart';

/// Drop-in AI explainer section for technique_detail_screen.
/// Placed below the coverage toggle, above description.
class AIExplainerSection extends ConsumerWidget {
  final AttackTechnique technique;

  const AIExplainerSection({super.key, required this.technique});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final explainerState = ref.watch(techniqueExplainerStateProvider);
    final hasKey = ref.watch(apiKeyConfiguredProvider);

    if (!hasKey) {
      return _NoKeyPrompt();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AI Explanation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (explainerState != null)
                  TextButton(
                    onPressed: () => ref
                        .read(techniqueExplainerStateProvider.notifier)
                        .reset(),
                    child: const Text('Clear'),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Personalised explanation powered by Claude AI',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),

            // ── Content ──────────────────────────────────────────────
            if (explainerState == null) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.auto_awesome, size: 16),
                  label: const Text('Explain This Technique with AI'),
                  onPressed: () async {
                    final org = await ref.read(
                      organizationProfileProvider.future,
                    );
                    ref
                        .read(techniqueExplainerStateProvider.notifier)
                        .explain(technique: technique, orgProfile: org);
                  },
                ),
              ),
            ] else ...[
              explainerState.when(
                loading: () => const _LoadingExplainer(),
                error: (e, _) => _ErrorDisplay(error: e.toString()),
                data: (explanation) =>
                    _ExplanationContent(explanation: explanation),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Loading state ────────────────────────────────────────────────────────────

class _LoadingExplainer extends StatelessWidget {
  const _LoadingExplainer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          strokeWidth: 2,
        ),
        const SizedBox(height: 12),
        Text(
          'Claude is analysing this technique…',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ─── Error display ────────────────────────────────────────────────────────────

class _ErrorDisplay extends StatelessWidget {
  final String error;
  const _ErrorDisplay({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.dangerColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppTheme.dangerColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: AppTheme.dangerColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── No API key prompt ────────────────────────────────────────────────────────

class _NoKeyPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.grey, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Add your Anthropic API key in Settings to unlock AI-powered explanations.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Explanation content ──────────────────────────────────────────────────────

class _ExplanationContent extends StatelessWidget {
  final TechniqueExplanation explanation;
  const _ExplanationContent({required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Plain summary — highlighted at top for non-technical users
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person, color: AppTheme.primaryColor, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  explanation.plainSummary,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        _AIBlock(
          icon: Icons.movie_outlined,
          color: AppTheme.warningColor,
          title: 'Real-World Example',
          content: explanation.realWorldStory,
        ),
        _AIBlock(
          icon: Icons.visibility,
          color: AppTheme.primaryColor,
          title: 'What It Looks Like (Defender View)',
          content: explanation.whatItLooksLike,
        ),
        _AIBlock(
          icon: Icons.people,
          color: AppTheme.accentColor,
          title: 'Who Uses This Attack',
          content: explanation.whoUsesIt,
        ),
        _AIBlock(
          icon: Icons.radar,
          color: AppTheme.successColor,
          title: 'Check Right Now',
          content: explanation.checkRightNow,
        ),
        _AIBlock(
          icon: Icons.shield,
          color: AppTheme.successColor,
          title: '⭐ Most Important Defense',
          content: explanation.topDefense,
          highlighted: true,
        ),
        if (explanation.sectorRelevance.isNotEmpty)
          _AIBlock(
            icon: Icons.business,
            color: AppTheme.primaryColor,
            title: 'Relevance to Your Organization',
            content: explanation.sectorRelevance,
          ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.auto_awesome, size: 12, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              'Generated by Claude AI · Verify with your security team',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

class _AIBlock extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String content;
  final bool highlighted;

  const _AIBlock({
    required this.icon,
    required this.color,
    required this.title,
    required this.content,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlighted ? color.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlighted
              ? color.withValues(alpha: 0.4)
              : Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
