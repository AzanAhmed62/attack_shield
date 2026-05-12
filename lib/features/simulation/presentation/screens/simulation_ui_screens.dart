import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/shared/models/simulation_models.dart';

// ════════════════════════════════════════════════════════════════════════════════
// GUIDED SIMULATION UI SCREENS
//
// Walk users through attack scenarios step-by-step with evidence collection
// ════════════════════════════════════════════════════════════════════════════════

/// Main simulation screen that orchestrates the entire flow
class GuidedSimulationScreen extends ConsumerWidget {
  final GuidedSimulationScenario scenario;

  const GuidedSimulationScreen({super.key, required this.scenario});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(scenario.title), elevation: 0),
      body: _SimulationFlow(scenario: scenario),
    );
  }
}

/// Internal widget that manages the simulation state flow
class _SimulationFlow extends ConsumerStatefulWidget {
  final GuidedSimulationScenario scenario;

  const _SimulationFlow({required this.scenario});

  @override
  ConsumerState<_SimulationFlow> createState() => _SimulationFlowState();
}

class _SimulationFlowState extends ConsumerState<_SimulationFlow> {
  late PageController _pageController;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (currentStep < widget.scenario.checkpoints.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentStep++);
    } else {
      _showCompletionDialog();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentStep--);
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Simulation Complete!'),
        content: const Text(
          'You have completed all checkpoints. View your results?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showResults();
            },
            child: const Text('View Results'),
          ),
        ],
      ),
    );
  }

  void _showResults() {
    // Navigate to results screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _SimulationResultsScreen(scenario: widget.scenario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress indicator
        _ProgressIndicator(
          current: currentStep,
          total: widget.scenario.checkpoints.length,
        ),
        const SizedBox(height: 16),

        // Main content
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => currentStep = index),
            children: [
              // First page: Introduction & Narrative
              _IntroductionPage(scenario: widget.scenario),

              // Checkpoint pages
              ...widget.scenario.checkpoints.asMap().entries.map(
                (entry) => _CheckpointPage(
                  checkpoint: entry.value,
                  checkpointNumber: entry.key + 1,
                  totalCheckpoints: widget.scenario.checkpoints.length,
                ),
              ),
            ],
          ),
        ),

        // Navigation buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: currentStep > 0 ? _previousStep : null,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
              ),
              Text(
                'Step ${currentStep + 1}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              ElevatedButton.icon(
                onPressed: _nextStep,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  currentStep == widget.scenario.checkpoints.length
                      ? 'View Results'
                      : 'Next',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Introduction page with attack narrative
class _IntroductionPage extends StatelessWidget {
  final GuidedSimulationScenario scenario;

  const _IntroductionPage({required this.scenario});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scenario info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scenario.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Difficulty & Duration
          Row(
            children: [
              _InfoChip(
                icon: Icons.trending_up,
                label: _difficultyLabel(scenario.difficulty),
                color: _difficultyColor(scenario.difficulty),
              ),
              const SizedBox(width: 8),
              _InfoChip(
                icon: Icons.access_time,
                label: '~${scenario.estimatedDurationMinutes} min',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Narrative section
          Text(
            'Attack Narrative',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade50,
            ),
            child: Text(
              scenario.attackNarrative,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ),

          const SizedBox(height: 24),

          // Threat info
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  title: 'Threat Actor',
                  value: scenario.threatActorProfile,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InfoCard(
                  title: 'Targeted Sectors',
                  value: scenario.targetedSectors.join(', '),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Techniques involved
          Text(
            'Techniques in This Attack',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: scenario.involvedTechniques
                .map(
                  (technique) => Chip(
                    label: Text(technique),
                    backgroundColor: Colors.blue.shade100,
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 24),

          // Call to action
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.amber.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'How This Works',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'You\'ll walk through each step of this attack. At each checkpoint, you\'ll see what to look for and can submit evidence (screenshots, logs, or yes/no answers) showing whether your defenses detected it. Ready?',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _difficultyLabel(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return 'Beginner';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      default:
        return 'Unknown';
    }
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

/// Individual checkpoint page for collecting evidence
class _CheckpointPage extends ConsumerStatefulWidget {
  final SimulationCheckpoint checkpoint;
  final int checkpointNumber;
  final int totalCheckpoints;

  const _CheckpointPage({
    required this.checkpoint,
    required this.checkpointNumber,
    required this.totalCheckpoints,
  });

  @override
  ConsumerState<_CheckpointPage> createState() => _CheckpointPageState();
}

class _CheckpointPageState extends ConsumerState<_CheckpointPage> {
  late TextEditingController _logController;
  bool? _yesNoAnswer;
  bool _hasSubmittedEvidence = false;

  @override
  void initState() {
    super.initState();
    _logController = TextEditingController();
  }

  @override
  void dispose() {
    _logController.dispose();
    super.dispose();
  }

  void _submitEvidence() {
    // Validation
    if (widget.checkpoint.evidenceType == 'yes_no' && _yesNoAnswer == null) {
      _showErrorSnackbar('Please select Yes or No');
      return;
    }

    if (widget.checkpoint.evidenceType == 'log_excerpt' &&
        _logController.text.isEmpty) {
      _showErrorSnackbar('Please paste a log excerpt');
      return;
    }

    setState(() => _hasSubmittedEvidence = true);

    // Would submit to backend/database here
    _showSuccessSnackbar('Evidence submitted! Evaluating...');
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step indicator
          Text(
            'Step ${widget.checkpointNumber} of ${widget.totalCheckpoints}',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Checkpoint title
          Text(
            widget.checkpoint.techniqueName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            widget.checkpoint.techniqueId,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),

          const SizedBox(height: 16),

          // Attack step narrative
          _SectionCard(
            title: 'What\'s Happening',
            content: widget.checkpoint.attackStepNarrative,
          ),

          const SizedBox(height: 16),

          // What to check
          _SectionCard(
            title: 'What To Check',
            content: widget.checkpoint.whatToCheck,
            highlight: true,
          ),

          const SizedBox(height: 16),

          // Indicators
          Text(
            'What to look for:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          ...widget.checkpoint.indicatorExamples.map(
            (indicator) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      indicator,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Evidence submission based on type
          _buildEvidenceInput(),

          const SizedBox(height: 24),

          // Submit button
          if (!_hasSubmittedEvidence)
            ElevatedButton(
              onPressed: _submitEvidence,
              child: const Text('Submit Evidence'),
            )
          else
            const _EvaluationCard(), // Shows evaluation result

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEvidenceInput() {
    switch (widget.checkpoint.evidenceType) {
      case 'yes_no':
        return _YesNoInput(
          onChanged: (value) => setState(() => _yesNoAnswer = value),
          value: _yesNoAnswer,
        );

      case 'log_excerpt':
        return _LogExcerptInput(
          controller: _logController,
          tool: widget.checkpoint.detectionTool,
        );

      case 'screenshot':
        return const _ScreenshotInput();

      default:
        return Container();
    }
  }
}

/// Yes/No evidence input
class _YesNoInput extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool? value;

  const _YesNoInput({this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Did your defenses detect this attack?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(label: Text('Yes'), value: true),
                      ButtonSegment(label: Text('No'), value: false),
                    ],
                    selected: {?value},
                    onSelectionChanged: (selection) {
                      onChanged?.call(selection.first);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Log excerpt input
class _LogExcerptInput extends StatelessWidget {
  final TextEditingController controller;
  final String tool;

  const _LogExcerptInput({required this.controller, required this.tool});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paste evidence from: $tool',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Examples: Windows Event ID, email gateway log, EDR alert, DNS query, etc.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Paste your log excerpt here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Screenshot input (simplified)
class _ScreenshotInput extends StatelessWidget {
  const _ScreenshotInput();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload a screenshot showing detection',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Would open image picker
              },
              icon: const Icon(Icons.image),
              label: const Text('Choose Screenshot'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Results screen after simulation completion
class _SimulationResultsScreen extends StatelessWidget {
  final GuidedSimulationScenario scenario;

  const _SimulationResultsScreen({required this.scenario});

  @override
  Widget build(BuildContext context) {
    // Mock score - would come from engine
    const score = 75.0;
    const detected = 3;
    const missed = 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Simulation Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score card
            const _ScoreCard(
              percentage: score,
              grade: 'B',
              readinessLevel: 'Proficient',
            ),

            const SizedBox(height: 24),

            // Detection summary
            const Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Detected',
                    value: '$detected',
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Missed',
                    value: '$missed',
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Remediation playbook
            Text(
              'Recommended Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const _RemediationList(),

            const SizedBox(height: 32),

            // Action buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Scenarios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════════
// REUSABLE UI COMPONENTS
// ════════════════════════════════════════════════════════════════════════════════

class _ProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const _ProgressIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress', style: Theme.of(context).textTheme.bodySmall),
              Text(
                '${current + 1}/$total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (current + 1) / (total + 1),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color?.withValues(alpha: 0.1),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;
  final bool highlight;

  const _SectionCard({
    required this.title,
    required this.content,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: highlight ? Colors.amber : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
        color: highlight ? Colors.amber.shade50 : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final double percentage;
  final String grade;
  final String readinessLevel;

  const _ScoreCard({
    required this.percentage,
    required this.grade,
    required this.readinessLevel,
  });

  @override
  Widget build(BuildContext context) {
    final color = percentage >= 80
        ? Colors.green
        : percentage >= 60
        ? Colors.orange
        : Colors.red;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Grade: $grade',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                readinessLevel,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(color: color),
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _EvaluationCard extends StatelessWidget {
  const _EvaluationCard();

  @override
  Widget build(BuildContext context) {
    // Mock evaluation result
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detection Successful',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your defenses caught this attack.',
                    style: Theme.of(context).textTheme.bodySmall,
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

class _RemediationList extends StatelessWidget {
  const _RemediationList();

  @override
  Widget build(BuildContext context) {
    // Mock remediations
    final remediations = [
      'Enable MFA on all admin accounts',
      'Deploy EDR to all workstations',
      'Enable logging for PowerShell execution',
    ];

    return Column(
      children: remediations
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(entry.value)),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
