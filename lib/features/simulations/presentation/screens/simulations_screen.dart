import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class SimulationsScreen extends ConsumerWidget {
  const SimulationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenariosAsync = ref.watch(allSimulationScenariosProvider);
    final readinessAsync = ref.watch(readinessPercentageProvider);
    final readinessMapAsync = ref.watch(simulationReadinessProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Readiness Simulations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReadinessCard(
              readinessAsync: readinessAsync,
              readinessMapAsync: readinessMapAsync,
            ),
            const SizedBox(height: 24),
            _SuggestedScenariosCard(ref: ref),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Test Scenarios'),
            const SizedBox(height: 12),
            scenariosAsync.when(
              data: (scenarios) => scenarios.isEmpty
                  ? EmptyStateWidget(
                      title: 'No Scenarios Yet',
                      subtitle:
                          'Create defensive exercises linked to ATT&CK techniques to track readiness.',
                      icon: Icons.science_outlined,
                      actionLabel: 'Create Scenario',
                      onActionPressed: () => _showCreateSheet(context, ref),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: scenarios.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _ScenarioCard(
                        scenario: scenarios[i],
                        ref: ref,
                        onDelete: () async {
                          await ref.read(
                            deleteSimulationScenarioProvider(scenarios[i].id).future,
                          );
                        },
                      ),
                    ),
              loading: () => const LoadingWidget(message: 'Loading scenarios…'),
              error: (e, _) => EmptyStateWidget(
                title: 'Error',
                subtitle: e.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSheet(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Scenario'),
      ),
    );
  }

  void _showCreateSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _CreateScenarioSheet(ref: ref),
    );
  }
}

// ─── Readiness overview card ──────────────────────────────────────────────────

class _ReadinessCard extends StatelessWidget {
  final AsyncValue<double> readinessAsync;
  final AsyncValue<Map<String, int>> readinessMapAsync;
  const _ReadinessCard({required this.readinessAsync, required this.readinessMapAsync});

  Color _color(double p) {
    if (p >= 70) return AppTheme.successColor;
    if (p >= 40) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }

  String _label(double p) {
    if (p >= 70) return 'Well-prepared';
    if (p >= 40) return 'Partially ready';
    return 'Needs improvement';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified_user, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text('Overall Readiness',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            readinessAsync.when(
              data: (pct) => Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${pct.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: _color(pct),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(_label(pct),
                            style: TextStyle(color: _color(pct), fontSize: 13)),
                        const SizedBox(height: 10),
                        readinessMapAsync.when(
                          data: (m) => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _StatusChip('Passed', m['passed'] ?? 0, AppTheme.successColor),
                              _StatusChip('Partial', m['partiallyPassed'] ?? 0, AppTheme.warningColor),
                              _StatusChip('Failed', m['failed'] ?? 0, AppTheme.dangerColor),
                              _StatusChip('Not Tested', m['notTested'] ?? 0, Colors.grey),
                            ],
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  ProgressRing(
                    percentage: pct,
                    progressColor: _color(pct),
                    label: 'Ready',
                  ),
                ],
              ),
              loading: () => const LoadingWidget(),
              error: (_, __) => const Text('No data yet'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatusChip(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ─── ATT&CK-linked suggested scenarios ───────────────────────────────────────

class _SuggestedScenariosCard extends StatelessWidget {
  final WidgetRef ref;
  const _SuggestedScenariosCard({required this.ref});

  static const _suggestions = [
    (
      name: 'Phishing Awareness Test',
      desc: 'Simulate a spearphishing campaign and measure detection/response time.',
      techniques: ['T1566', 'T1566.001', 'T1566.002'],
      obj: 'Verify email filtering, user reporting, and incident response to phishing.',
      expected: 'Email blocked or flagged within 5 min. User reports suspicious email.',
    ),
    (
      name: 'Credential Dumping Detection',
      desc: 'Test whether LSASS access and credential dumping triggers EDR alerts.',
      techniques: ['T1003', 'T1003.001', 'T1558'],
      obj: 'Verify Credential Guard, LSASS audit policies, and EDR behavioral detection.',
      expected: 'Alert generated within 2 minutes. LSASS access blocked or logged.',
    ),
    (
      name: 'Lateral Movement via RDP',
      desc: 'Test detection of lateral movement using Remote Desktop Protocol.',
      techniques: ['T1021', 'T1021.001', 'T1550.002'],
      obj: 'Verify network segmentation, RDP logging, and anomalous login detection.',
      expected: 'Unusual RDP connection flagged. Pass-the-hash attempt blocked.',
    ),
    (
      name: 'Ransomware Readiness Check',
      desc: 'Validate backup integrity and recovery against ransomware simulation.',
      techniques: ['T1486', 'T1490', 'T1562.001'],
      obj: 'Test backup restoration, shadow copy protection, and AV/EDR ransomware detection.',
      expected: 'Encryption attempt blocked. Backup restore completes in under 4 hours.',
    ),
    (
      name: 'Defense Evasion Detection',
      desc: 'Test detection of log clearing, UAC bypass, and obfuscated scripts.',
      techniques: ['T1070.001', 'T1548.002', 'T1027'],
      obj: 'Verify SIEM alerting on log tampering and EDR detection of UAC bypass.',
      expected: 'Log clear event triggers alert. UAC bypass attempt detected.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: AppTheme.warningColor),
                const SizedBox(width: 8),
                Text('ATT&CK Scenario Templates',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 4),
            Text('Pre-built defensive exercises. Tap + to add.',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            ..._suggestions.map(
              (s) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(s.name,
                    style: Theme.of(context).textTheme.titleSmall),
                subtitle: Text(
                  s.techniques.join(', '),
                  style: const TextStyle(
                      color: AppTheme.primaryColor, fontSize: 11),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppTheme.primaryColor),
                  onPressed: () async {
                    final scenario = SimulationScenario(
                      id: const Uuid().v4(),
                      name: s.name,
                      description: s.desc,
                      relatedTechniques: List<String>.from(s.techniques),
                      objectives: s.obj,
                      expectedOutcomes: s.expected,
                      createdAt: DateTime.now(),
                    );
                    await ref.read(
                        createSimulationScenarioProvider(scenario).future);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added: ${s.name}'),
                          backgroundColor: AppTheme.successColor,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Scenario card ────────────────────────────────────────────────────────────

class _ScenarioCard extends ConsumerWidget {
  final SimulationScenario scenario;
  final WidgetRef ref;
  final VoidCallback onDelete;

  const _ScenarioCard({
    required this.scenario,
    required this.ref,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef watchRef) {
    final resultsAsync = watchRef.watch(resultsByScenarioProvider(scenario.id));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(scenario.name,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      size: 20, color: Colors.grey),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),
            Text(
              scenario.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if ((scenario.relatedTechniques ?? []).isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: (scenario.relatedTechniques ?? [])
                    .map(
                      (t) => GestureDetector(
                        onTap: () => context.push('/technique/$t'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t,
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: 8),

            // Results history
            resultsAsync.when(
              data: (results) => results.isEmpty
                  ? Text('No test results yet.',
                      style: Theme.of(context).textTheme.bodySmall)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('History',
                            style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(height: 4),
                        ...results.reversed.take(3).map((r) => _ResultRow(result: r)),
                      ],
                    ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.play_circle_outline, size: 16),
                label: const Text('Record Test Result'),
                onPressed: () => _showRecordSheet(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Scenario?'),
        content: Text('Delete "${scenario.name}"? This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Delete',
                style: TextStyle(color: AppTheme.dangerColor)),
          ),
        ],
      ),
    );
  }

  void _showRecordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RecordResultSheet(scenario: scenario, ref: ref),
    );
  }
}

// ─── Result row ───────────────────────────────────────────────────────────────

class _ResultRow extends StatelessWidget {
  final SimulationResult result;
  const _ResultRow({required this.result});

  Color get _color {
    switch (result.result) {
      case TestResult.passed:
        return AppTheme.successColor;
      case TestResult.failed:
        return AppTheme.dangerColor;
      case TestResult.partiallyPassed:
        return AppTheme.warningColor;
      case TestResult.notTested:
        return Colors.grey;
    }
  }

  String get _label {
    switch (result.result) {
      case TestResult.passed:
        return '✓ Passed';
      case TestResult.failed:
        return '✗ Failed';
      case TestResult.partiallyPassed:
        return '~ Partial';
      case TestResult.notTested:
        return '○ Not Tested';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(_label,
              style: TextStyle(
                  color: _color, fontWeight: FontWeight.bold, fontSize: 12)),
          const Spacer(),
          Text(DateFormat('MMM d, yyyy').format(result.testedAt),
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ─── Record result sheet ──────────────────────────────────────────────────────

class _RecordResultSheet extends StatefulWidget {
  final SimulationScenario scenario;
  final WidgetRef ref;
  const _RecordResultSheet({required this.scenario, required this.ref});

  @override
  State<_RecordResultSheet> createState() => _RecordResultSheetState();
}

class _RecordResultSheetState extends State<_RecordResultSheet> {
  TestResult _result = TestResult.notTested;
  final _obsCtrl = TextEditingController();
  final _recCtrl = TextEditingController();
  final _testerCtrl = TextEditingController();

  @override
  void dispose() {
    _obsCtrl.dispose();
    _recCtrl.dispose();
    _testerCtrl.dispose();
    super.dispose();
  }

  static const _resultColors = {
    TestResult.passed: AppTheme.successColor,
    TestResult.failed: AppTheme.dangerColor,
    TestResult.partiallyPassed: AppTheme.warningColor,
    TestResult.notTested: Colors.grey,
  };

  static const _resultLabels = {
    TestResult.passed: '✓ Pass',
    TestResult.failed: '✗ Fail',
    TestResult.partiallyPassed: '~ Partial',
    TestResult.notTested: '○ Not Tested',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Text('Record Test Result',
                style: Theme.of(context).textTheme.titleLarge),
            Text(widget.scenario.name,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),

            if (widget.scenario.objectives?.isNotEmpty == true) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Objectives',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text(widget.scenario.objectives!,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            Text('Test Outcome', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: TestResult.values.map((r) {
                final isSelected = _result == r;
                final c = _resultColors[r]!;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _result = r),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? c.withValues(alpha: 0.2)
                            : c.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: isSelected ? c : c.withValues(alpha: 0.3),
                            width: isSelected ? 2 : 1),
                      ),
                      child: Text(
                        _resultLabels[r]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: c,
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _testerCtrl,
              decoration: const InputDecoration(
                  labelText: 'Tester / Team',
                  prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _obsCtrl,
              decoration: const InputDecoration(
                  labelText: 'Observations',
                  prefixIcon: Icon(Icons.notes)),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _recCtrl,
              decoration: const InputDecoration(
                  labelText: 'Recommendations',
                  prefixIcon: Icon(Icons.lightbulb_outline)),
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Save Result'),
                onPressed: () async {
                  final simResult = SimulationResult(
                    id: const Uuid().v4(),
                    scenarioId: widget.scenario.id,
                    result: _result,
                    observations: _obsCtrl.text.isEmpty
                        ? 'No observations recorded.'
                        : _obsCtrl.text,
                    recommendations: _recCtrl.text.isEmpty
                        ? 'No recommendations recorded.'
                        : _recCtrl.text,
                    testedAt: DateTime.now(),
                    testedBy: _testerCtrl.text.isEmpty
                        ? 'Security Team'
                        : _testerCtrl.text,
                  );
                  await widget.ref
                      .read(createSimulationResultProvider(simResult).future);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Result recorded'),
                          backgroundColor: AppTheme.successColor),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Create scenario sheet ────────────────────────────────────────────────────

class _CreateScenarioSheet extends StatefulWidget {
  final WidgetRef ref;
  const _CreateScenarioSheet({required this.ref});

  @override
  State<_CreateScenarioSheet> createState() => _CreateScenarioSheetState();
}

class _CreateScenarioSheetState extends State<_CreateScenarioSheet> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _objCtrl = TextEditingController();
  final _techCtrl = TextEditingController();
  final List<String> _techniques = [];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _objCtrl.dispose();
    _techCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Text('Create Test Scenario',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: _nameCtrl,
              decoration:
                  const InputDecoration(labelText: 'Scenario Name *'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _objCtrl,
              decoration: const InputDecoration(
                  labelText: 'Objectives',
                  hintText: 'What defensive controls are you testing?'),
              maxLines: 2,
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _techCtrl,
                    decoration: const InputDecoration(
                        labelText: 'ATT&CK Technique ID',
                        hintText: 'e.g. T1566'),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle,
                      color: AppTheme.primaryColor),
                  onPressed: () {
                    final id = _techCtrl.text.trim().toUpperCase();
                    if (id.isNotEmpty && !_techniques.contains(id)) {
                      setState(() => _techniques.add(id));
                      _techCtrl.clear();
                    }
                  },
                ),
              ],
            ),
            if (_techniques.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _techniques
                    .map(
                      (t) => Chip(
                        label: Text(t,
                            style: const TextStyle(
                                color: AppTheme.primaryColor)),
                        deleteIconColor: AppTheme.primaryColor,
                        onDeleted: () =>
                            setState(() => _techniques.remove(t)),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Create Scenario'),
                onPressed: () async {
                  if (_nameCtrl.text.trim().isEmpty) return;
                  final scenario = SimulationScenario(
                    id: const Uuid().v4(),
                    name: _nameCtrl.text.trim(),
                    description: _descCtrl.text.trim(),
                    relatedTechniques: List.from(_techniques),
                    objectives: _objCtrl.text.trim(),
                    expectedOutcomes: '',
                    createdAt: DateTime.now(),
                  );
                  await widget.ref.read(
                      createSimulationScenarioProvider(scenario).future);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Scenario created'),
                          backgroundColor: AppTheme.successColor),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}