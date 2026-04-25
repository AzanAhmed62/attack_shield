import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/core/services/ai_service.dart';

/// AI Coverage Advisor card — placed in the reports screen.
/// Generates personalized coverage recommendations on demand.
class AICoverageAdvisorCard extends ConsumerWidget {
  const AICoverageAdvisorCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advisorState = ref.watch(coverageAdvisorStateProvider);
    final hasKey = ref.watch(apiKeyConfiguredProvider);

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
                  child: const Icon(Icons.auto_awesome,
                      color: AppTheme.primaryColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text('AI Coverage Advisor',
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                if (advisorState != null)
                  TextButton(
                    onPressed: () => ref
                        .read(coverageAdvisorStateProvider.notifier)
                        .reset(),
                    child: const Text('Refresh'),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Personalised recommendations based on your threat profile and coverage gaps',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),

            if (!hasKey)
              _buildNoKeyPrompt(context)
            else if (advisorState == null)
              _buildGenerateButton(context, ref)
            else
              advisorState.when(
                loading: () => _buildLoading(context),
                error: (e, _) => _buildError(e.toString()),
                data: (advice) => _buildAdvice(context, advice),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoKeyPrompt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Add your Anthropic API key in Settings to get AI-powered coverage recommendations.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.auto_awesome, size: 16),
        label: const Text('Generate AI Recommendations'),
        onPressed: () async {
          final org = await ref.read(organizationProfileProvider.future);
          if (org == null) return;

          final gaps =
              await ref.read(topRiskGapsProvider(limit: 10).future);
          final coverage = await ref.read(
              riskEngineCoveragePercentageProvider.future);
          final risk =
              await ref.read(organizationRiskScoreProvider.future);

          ref.read(coverageAdvisorStateProvider.notifier).generateAdvice(
                orgProfile: org,
                topGaps: gaps,
                currentCoverage: coverage,
                riskScore: risk,
              );
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          strokeWidth: 2,
        ),
        const SizedBox(height: 12),
        Text(
          'Claude is analysing your coverage gaps and generating recommendations…',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildError(String error) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.dangerColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(error,
          style: const TextStyle(color: AppTheme.dangerColor)),
    );
  }

  Widget _buildAdvice(BuildContext context, CoverageAdvice advice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Executive summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            advice.executiveSummary,
            style: const TextStyle(
                color: AppTheme.primaryColor, fontSize: 13),
          ),
        ),
        const SizedBox(height: 14),

        // Risk reduction estimate
        Row(
          children: [
            const Icon(Icons.trending_down,
                color: AppTheme.successColor, size: 16),
            const SizedBox(width: 6),
            Text(
              'Potential risk reduction: ${advice.estimatedRiskReduction}',
              style: const TextStyle(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Priority recommendations
        Text('Priority Actions',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        ...advice.priorityRecommendations.map(
          (rec) => _RecommendationCard(rec: rec),
        ),
        const SizedBox(height: 12),

        // Quick wins
        if (advice.quickWins.isNotEmpty) ...[
          Text('Quick Wins (No Budget Needed)',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          ...advice.quickWins.map(
            (win) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.bolt,
                      color: AppTheme.warningColor, size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(win,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Next milestone
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppTheme.successColor.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.flag, color: AppTheme.successColor, size: 14),
                  SizedBox(width: 6),
                  Text(
                    '30-Day Milestone',
                    style: TextStyle(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(advice.nextMilestone,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.auto_awesome, size: 11, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              'Generated by Claude AI · Consult your security team before implementing',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final PriorityRecommendation rec;
  const _RecommendationCard({required this.rec});

  Color get _effortColor {
    switch (rec.effort) {
      case 'Low':  return AppTheme.successColor;
      case 'High': return AppTheme.dangerColor;
      default:     return AppTheme.warningColor;
    }
  }

  Color get _impactColor {
    switch (rec.impact) {
      case 'High': return AppTheme.successColor;
      case 'Low':  return AppTheme.dangerColor;
      default:     return AppTheme.warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  '${rec.priority}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(rec.title,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(rec.description,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12)),
          const SizedBox(height: 8),
          // Metadata row
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _Tag('Effort: ${rec.effort}', _effortColor),
              _Tag('Impact: ${rec.impact}', _impactColor),
              _Tag('⏱ ${rec.timeToImplement}', Colors.grey),
              if (rec.techniquesCovered.isNotEmpty)
                _Tag(
                    'Covers: ${rec.techniquesCovered.take(2).join(', ')}${rec.techniquesCovered.length > 2 ? '+${rec.techniquesCovered.length - 2}' : ''}',
                    AppTheme.primaryColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
