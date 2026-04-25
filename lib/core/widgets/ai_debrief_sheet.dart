import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/services/ai_service.dart';

/// Shows an AI-generated debrief after a simulation result is recorded.
/// Call via showModalBottomSheet.
class AIDebriefSheet extends ConsumerStatefulWidget {
  final SimulationScenario scenario;
  final SimulationResult result;

  const AIDebriefSheet({
    super.key,
    required this.scenario,
    required this.result,
  });

  @override
  ConsumerState<AIDebriefSheet> createState() => _AIDebriefSheetState();
}

class _AIDebriefSheetState extends ConsumerState<AIDebriefSheet> {
  @override
  void initState() {
    super.initState();
    // Auto-start debrief generation on open if API key is present
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(apiKeyConfiguredProvider)) {
        _generate();
      }
    });
  }

  Future<void> _generate() async {
    final org = await ref.read(organizationProfileProvider.future);
    ref.read(simulationDebriefStateProvider.notifier).generateDebrief(
          scenario: widget.scenario,
          result: widget.result,
          orgProfile: org,
        );
  }

  @override
  Widget build(BuildContext context) {
    final debriefState = ref.watch(simulationDebriefStateProvider);
    final hasKey = ref.watch(apiKeyConfiguredProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(16),
          children: [
            // Drag handle
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

            // Header
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
                Text('AI Exercise Debrief',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 4),
            Text(widget.scenario.name,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),

            if (!hasKey) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Add your Anthropic API key in Settings to get AI-generated debriefs.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ] else if (debriefState == null) ...[
              ElevatedButton.icon(
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: const Text('Generate AI Debrief'),
                onPressed: _generate,
              ),
            ] else ...[
              debriefState.when(
                loading: () => Column(
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor),
                      strokeWidth: 2,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Claude is writing your debrief…',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                error: (e, _) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.dangerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(e.toString(),
                      style: const TextStyle(
                          color: AppTheme.dangerColor)),
                ),
                data: (debrief) =>
                    _DebriefContent(debrief: debrief),
              ),
            ],

            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                ref
                    .read(simulationDebriefStateProvider.notifier)
                    .reset();
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebriefContent extends StatelessWidget {
  final SimulationDebrief debrief;
  const _DebriefContent({required this.debrief});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Score and headline
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _scoreColor(debrief.score)
                    .withValues(alpha: 0.12),
                border: Border.all(
                    color: _scoreColor(debrief.score), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    debrief.score,
                    style: TextStyle(
                        color: _scoreColor(debrief.score),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text('/10',
                      style: TextStyle(
                          color: _scoreColor(debrief.score)
                              .withValues(alpha: 0.7),
                          fontSize: 9)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                debrief.headline,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        _DebriefBlock(
          icon: Icons.check_circle,
          color: AppTheme.successColor,
          title: 'What Worked',
          content: debrief.whatWorked,
        ),
        _DebriefBlock(
          icon: Icons.cancel,
          color: AppTheme.dangerColor,
          title: 'What Failed',
          content: debrief.whatFailed,
        ),
        _DebriefBlock(
          icon: Icons.psychology,
          color: AppTheme.warningColor,
          title: 'Root Cause',
          content: debrief.rootCause,
        ),
        _DebriefBlock(
          icon: Icons.radar,
          color: AppTheme.accentColor,
          title: 'Detection Gap',
          content: debrief.detectionGap,
        ),

        // MTTR
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.timer,
                  color: AppTheme.primaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Mean Time to Respond: ${debrief.mttrEstimate}',
                style: const TextStyle(
                    color: AppTheme.primaryColor, fontSize: 12),
              ),
            ],
          ),
        ),

        // Immediate actions
        Text('Immediate Actions (24h)',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 6),
        ...debrief.immediateActions.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_right,
                    color: AppTheme.dangerColor, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(a,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Longer term fixes
        Text('30-Day Improvements',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 6),
        ...debrief.longerTermFixes.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_right,
                    color: AppTheme.successColor, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(f,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Next exercise
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppTheme.successColor.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.science,
                      color: AppTheme.successColor, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Next Exercise',
                    style: TextStyle(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(debrief.nextExercise,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.auto_awesome, size: 11, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              'Generated by Claude AI',
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

  Color _scoreColor(String score) {
    final n = double.tryParse(score) ?? 5.0;
    if (n >= 8) return AppTheme.successColor;
    if (n >= 5) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }
}

class _DebriefBlock extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String content;

  const _DebriefBlock({
    required this.icon,
    required this.color,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(title,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ],
          ),
          const SizedBox(height: 5),
          Text(content,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
