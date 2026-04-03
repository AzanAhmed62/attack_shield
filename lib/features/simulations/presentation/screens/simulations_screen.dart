import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:uuid/uuid.dart';

class SimulationsScreen extends ConsumerWidget {
  const SimulationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenariosAsync = ref.watch(allSimulationScenariosProvider);
    final readinessAsync = ref.watch(readinessPercentageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Readiness Simulations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Readiness summary
            readinessAsync.when(
              data: (readiness) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Overall Readiness',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${readiness.toStringAsFixed(1)}%',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ProgressRing(
                          percentage: readiness,
                          label: 'Ready',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const LoadingWidget(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            // Scenarios list
            SectionHeader(title: 'Test Scenarios'),
            const SizedBox(height: 16),
            scenariosAsync.when(
              data: (scenarios) {
                if (scenarios.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No Scenarios',
                    subtitle: 'Create a defensive exercise to track readiness',
                    icon: Icons.play_arrow,
                    actionLabel: 'Create Scenario',
                    onActionPressed: () =>
                        _showCreateScenarioDialog(context, ref),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: scenarios.length,
                  itemBuilder: (context, index) => _ScenarioCard(
                    scenario: scenarios[index],
                    onTap: () =>
                        _showScenarioDetail(context, scenarios[index], ref),
                  ),
                );
              },
              loading: () =>
                  const LoadingWidget(message: 'Loading scenarios...'),
              error: (err, st) => EmptyStateWidget(
                title: 'Error',
                subtitle: err.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateScenarioDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateScenarioDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _CreateScenarioDialog(
        onCreateScenario: (scenario) {
          ref.read(createSimulationScenarioProvider(scenario));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showScenarioDetail(
    BuildContext context,
    SimulationScenario scenario,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _ScenarioDetailSheet(scenario: scenario, ref: ref),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final SimulationScenario scenario;
  final VoidCallback onTap;

  const _ScenarioCard({required this.scenario, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scenario.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                scenario.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: (scenario.relatedTechniques ?? [])
                    .map((t) => Chip(label: Text(t)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScenarioDetailSheet extends StatefulWidget {
  final SimulationScenario scenario;
  final WidgetRef ref;

  const _ScenarioDetailSheet({required this.scenario, required this.ref});

  @override
  State<_ScenarioDetailSheet> createState() => _ScenarioDetailSheetState();
}

class _ScenarioDetailSheetState extends State<_ScenarioDetailSheet> {
  late TestResult _result;

  @override
  void initState() {
    super.initState();
    _result = TestResult.notTested;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.scenario.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text('Objectives:', style: Theme.of(context).textTheme.labelLarge),
          if (widget.scenario.objectives != null &&
              widget.scenario.objectives!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text('• ${widget.scenario.objectives}'),
            ),
          const SizedBox(height: 16),
          Text(
            'Record Test Result:',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          DropdownButton<TestResult>(
            value: _result,
            isExpanded: true,
            items: TestResult.values
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(r.toString().split('.').last),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _result = value);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              final result = SimulationResult(
                id: const Uuid().v4(),
                scenarioId: widget.scenario.id,
                result: _result,
                observations: 'Test execution completed',
                recommendations: 'Review coverage and gaps',
                testedAt: DateTime.now(),
                testedBy: 'QuickTest',
              );
              widget.ref.read(createSimulationResultProvider(result));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            label: const Text('Record Result'),
          ),
        ],
      ),
    );
  }
}

class _CreateScenarioDialog extends StatefulWidget {
  final Function(SimulationScenario) onCreateScenario;

  const _CreateScenarioDialog({required this.onCreateScenario});

  @override
  State<_CreateScenarioDialog> createState() => _CreateScenarioDialogState();
}

class _CreateScenarioDialogState extends State<_CreateScenarioDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Test Scenario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Scenario Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final scenario = SimulationScenario(
              id: const Uuid().v4(),
              name: _nameController.text,
              description: _descriptionController.text,
              relatedTechniques: [],
              objectives: '',
              expectedOutcomes: '',
              createdAt: DateTime.now(),
            );
            widget.onCreateScenario(scenario);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
