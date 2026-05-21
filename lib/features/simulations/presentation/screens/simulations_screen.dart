// lib/features/simulations/presentation/screens/simulations_screen.dart
// FULL REPLACEMENT — ATT&CK Navigator-style tactic matrix heatmap,
// scenario builder, Gemini narrative, simulation history chart.

import 'dart:math';
import 'package:attackshield/features/simulation/providers/simulation_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/models/attack_technique.dart';
import '../../../../shared/models/coverage_status.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../shared/widgets/shimmer_loader.dart';
import '../../../../core/engine/risk_engine.dart';
import '../../../../data/services/gemini_service.dart';

part 'simulations_screen.g.dart';

// ─── Built-in scenarios ───────────────────────────────────────────────────────
class _Scenario {
  final String id, name, description, icon;
  final List<String> tacticFocus; // shortNames to highlight
  final List<String> techniques; // T-IDs included in scenario
  final String threatActor;

  const _Scenario({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.tacticFocus,
    required this.techniques,
    required this.threatActor,
  });
}

const _scenarios = [
  _Scenario(
    id: 'ransomware',
    name: 'Ransomware Attack',
    description:
        'Simulates a modern ransomware intrusion chain from phishing to encryption.',
    icon: '🔒',
    threatActor: 'Conti / LockBit TTPs',
    tacticFocus: [
      'initial-access',
      'execution',
      'persistence',
      'lateral-movement',
      'impact',
    ],
    techniques: [
      'T1566',
      'T1059',
      'T1547',
      'T1486',
      'T1490',
      'T1027',
      'T1083',
      'T1021',
    ],
  ),
  _Scenario(
    id: 'apt29',
    name: 'APT29 (Cozy Bear)',
    description:
        'Nation-state espionage campaign targeting credentials and sensitive data.',
    icon: '🕵️',
    threatActor: 'APT29 / SVR',
    tacticFocus: [
      'initial-access',
      'credential-access',
      'collection',
      'exfiltration',
      'command-and-control',
    ],
    techniques: [
      'T1566',
      'T1078',
      'T1003',
      'T1056',
      'T1041',
      'T1071',
      'T1105',
      'T1560',
    ],
  ),
  _Scenario(
    id: 'supply_chain',
    name: 'Supply Chain Compromise',
    description:
        'Attacker compromises a trusted software vendor to reach targets.',
    icon: '📦',
    threatActor: 'SolarWinds-style TTP',
    tacticFocus: [
      'initial-access',
      'persistence',
      'defense-evasion',
      'lateral-movement',
    ],
    techniques: ['T1195', 'T1059', 'T1036', 'T1055', 'T1078', 'T1021', 'T1070'],
  ),
  _Scenario(
    id: 'insider_threat',
    name: 'Insider Threat',
    description: 'Malicious or negligent insider abusing legitimate access.',
    icon: '👤',
    threatActor: 'Insider / Compromised Account',
    tacticFocus: [
      'collection',
      'exfiltration',
      'discovery',
      'credential-access',
    ],
    techniques: ['T1078', 'T1083', 'T1005', 'T1041', 'T1114', 'T1087', 'T1213'],
  ),
  _Scenario(
    id: 'cloud_attack',
    name: 'Cloud Infrastructure Attack',
    description:
        'Targets cloud-hosted resources through misconfiguration and credential abuse.',
    icon: '☁️',
    threatActor: 'Cloud-native adversary',
    tacticFocus: [
      'initial-access',
      'privilege-escalation',
      'collection',
      'exfiltration',
    ],
    techniques: ['T1078', 'T1190', 'T1098', 'T1530', 'T1619', 'T1552', 'T1537'],
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────
class SimulationsScreen extends HookConsumerWidget {
  const SimulationsScreen({super.key});

  static const _tabs = ['Matrix', 'Scenarios', 'History'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState(0);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text(
          'Simulations',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Row(
            children: _tabs.asMap().entries.map((e) {
              final selected = e.key == tabIndex.value;
              return Expanded(
                child: GestureDetector(
                  onTap: () => tabIndex.value = e.key,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected ? cs.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      e.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: selected ? cs.primary : cs.outline,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      body: [
        const _MatrixTab(),
        const _ScenariosTab(),
        const _HistoryTab(),
      ][tabIndex.value],
    );
  }
}

// ─── Tab 1: Matrix Heatmap ────────────────────────────────────────────────────
class _MatrixTab extends HookConsumerWidget {
  const _MatrixTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tacticsAsync = ref.watch(allTacticsProvider);
    final byTacticAsync = ref.watch(techniquesByTacticProvider);
    final coverageMap = ref.watch(coverageMapProvider);
    final cs = Theme.of(context).colorScheme;

    return tacticsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (tactics) => byTacticAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (byTactic) {
          final covMap = coverageMap.value ?? {};
          return Column(
            children: [
              // Legend
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    _LegendDot(color: Colors.green.shade500, label: 'Covered'),
                    const SizedBox(width: 12),
                    _LegendDot(color: Colors.amber.shade500, label: 'Partial'),
                    const SizedBox(width: 12),
                    _LegendDot(
                      color: Colors.red.shade400,
                      label: 'Not Covered',
                    ),
                    const SizedBox(width: 12),
                    _LegendDot(color: cs.outlineVariant, label: 'Unknown'),
                    const Spacer(),
                    Text(
                      'Tap a cell to view technique',
                      style: TextStyle(fontSize: 10, color: cs.outline),
                    ),
                  ],
                ),
              ),
              // Matrix
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tactics.map((tactic) {
                      final techs = byTactic[tactic.shortName] ?? [];
                      return _TacticColumn(
                        tactic: tactic,
                        techniques: techs,
                        covMap: covMap,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TacticColumn extends StatelessWidget {
  final AttackTactic tactic;
  final List<AttackTechnique> techniques;
  final Map<String, CoverageLevel> covMap;
  const _TacticColumn({
    required this.tactic,
    required this.techniques,
    required this.covMap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = techniques.length;
    final covered = techniques
        .where((t) => covMap[t.id] == CoverageLevel.covered)
        .length;
    final pct = total > 0 ? covered / total : 0.0;

    return Container(
      width: 108,
      margin: const EdgeInsets.only(right: 6),
      child: Column(
        children: [
          // Tactic header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  tactic.name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: cs.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 3,
                    backgroundColor: cs.primaryContainer,
                    valueColor: AlwaysStoppedAnimation(Colors.green.shade500),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$covered/$total',
                  style: TextStyle(
                    fontSize: 9,
                    color: cs.onPrimaryContainer.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Technique cells
          ...techniques.map((t) {
            final cov = covMap[t.id] ?? CoverageLevel.unknown;
            final color = _cellColor(cov, t.riskScore);
            return GestureDetector(
              onTap: () => context.push('/library/${t.id}'),
              child: Tooltip(
                message: '${t.id}: ${t.name}',
                child: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    t.id,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _cellColor(CoverageLevel cov, double riskScore) {
    switch (cov) {
      case CoverageLevel.covered:
        return Colors.green.shade600;
      case CoverageLevel.partiallyCovered:
        return Colors.amber.shade600;
      case CoverageLevel.notCovered:
        // Shade red by risk score — higher risk = darker red
        final intensity = (riskScore / 10.0).clamp(0.3, 1.0);
        return Color.lerp(Colors.red.shade300, Colors.red.shade800, intensity)!;
      case CoverageLevel.unknown:
        return Colors.grey.shade400;
    }
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

// ─── Tab 2: Scenarios ─────────────────────────────────────────────────────────
class _ScenariosTab extends HookConsumerWidget {
  const _ScenariosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final running = useState(false);
    final selectedScenario = useState<_Scenario?>(null);
    final result = useState<_SimResult?>(null);
    final narrative = useState<String?>(null);
    final narrativeLoading = useState(false);

    final allTechsAsync = ref.watch(allTechniquesProvider);
    final coverageMap = ref.watch(coverageMapProvider);
    final cs = Theme.of(context).colorScheme;

    Future<void> runScenario(_Scenario scenario) async {
      running.value = true;
      selectedScenario.value = scenario;
      result.value = null;
      narrative.value = null;

      await Future.delayed(const Duration(milliseconds: 600));

      final allTechs = allTechsAsync.value ?? [];
      final covMap = coverageMap.value ?? {};

      final scenTechs = allTechs
          .where((t) => scenario.techniques.contains(t.id))
          .toList();

      int passed = 0, failed = 0;
      final gaps = <String>[];
      for (final t in scenTechs) {
        final cov = covMap[t.id] ?? CoverageLevel.unknown;
        if (cov == CoverageLevel.covered) {
          passed++;
        } else {
          failed++;
          gaps.add(t.id);
        }
      }

      final total = scenTechs.length;
      final readiness = total > 0 ? (passed / total) * 100.0 : 0.0;

      result.value = _SimResult(
        scenario: scenario,
        total: total,
        passed: passed,
        failed: failed,
        gaps: gaps,
        readiness: readiness,
        timestamp: DateTime.now(),
      );
      running.value = false;

      // Fetch Gemini narrative
      narrativeLoading.value = true;
      try {
        final gemini = ref.read(geminiServiceProvider);
        final r = await gemini.generateSimulationNarrative(
          scenarioName: scenario.name,
          uncoveredTechniques: gaps,
          readinessScore: readiness,
        );
        if (r.isSuccess) narrative.value = r.text;
      } finally {
        narrativeLoading.value = false;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (result.value == null) ...[
            Text(
              'Select a Scenario',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'Run a simulation to see how your coverage holds up against real attack patterns.',
              style: TextStyle(fontSize: 12, color: cs.outline),
            ),
            const SizedBox(height: 14),

            ..._scenarios.map(
              (s) => _ScenarioCard(
                scenario: s,
                isRunning: running.value && selectedScenario.value?.id == s.id,
                onRun: () => runScenario(s),
              ),
            ),
          ] else ...[
            // Result view
            _SimResultCard(
              result: result.value!,
              narrative: narrative.value,
              narrativeLoading: narrativeLoading.value,
              onReset: () {
                result.value = null;
                narrative.value = null;
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final _Scenario scenario;
  final bool isRunning;
  final VoidCallback onRun;
  const _ScenarioCard({
    required this.scenario,
    required this.isRunning,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Text(scenario.icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  scenario.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.outline,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 12,
                      color: cs.outline,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      scenario.threatActor,
                      style: TextStyle(fontSize: 11, color: cs.outline),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.layers_outlined, size: 12, color: cs.outline),
                    const SizedBox(width: 4),
                    Text(
                      '${scenario.techniques.length} techniques',
                      style: TextStyle(fontSize: 11, color: cs.outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          isRunning
              ? const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : FilledButton.tonal(
                  onPressed: onRun,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Run', style: TextStyle(fontSize: 12)),
                ),
        ],
      ),
    );
  }
}

class _SimResultCard extends StatelessWidget {
  final _SimResult result;
  final String? narrative;
  final bool narrativeLoading;
  final VoidCallback onReset;
  const _SimResultCard({
    required this.result,
    required this.narrative,
    required this.narrativeLoading,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final readiness = result.readiness;
    final color = readiness >= 75
        ? Colors.green.shade600
        : readiness >= 50
        ? Colors.amber.shade600
        : Colors.red.shade600;
    final label = readiness >= 75
        ? 'Well Protected'
        : readiness >= 50
        ? 'Partially Ready'
        : 'High Exposure';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Simulation Result',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.arrow_back_rounded, size: 14),
              label: const Text('Back'),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Score card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: readiness / 100,
                      strokeWidth: 7,
                      backgroundColor: cs.outlineVariant,
                      color: color,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Text(
                    '${readiness.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.scenario.icon + '  ' + result.scenario.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${result.passed} covered',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.close_rounded,
                          size: 14,
                          color: Colors.red.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${result.failed} exposed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Exposed techniques
        if (result.gaps.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: Colors.red.shade600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Exposed Techniques (${result.gaps.length})',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: result.gaps
                      .map(
                        (id) => ActionChip(
                          label: Text(id, style: const TextStyle(fontSize: 11)),
                          backgroundColor: Colors.red.shade100,
                          side: BorderSide(
                            color: Colors.red.shade300,
                            width: 0.5,
                          ),
                          onPressed: () => context.push('/library/$id'),
                          avatar: const Icon(
                            Icons.open_in_new_rounded,
                            size: 11,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // AI narrative
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_awesome_rounded, size: 15, color: cs.primary),
                  const SizedBox(width: 6),
                  Text(
                    'AI Attack Narrative',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              narrativeLoading
                  ? const ShimmerLoader(height: 60)
                  : narrative == null
                  ? Text(
                      'AI service unavailable. Configure your Gemini API key in Settings.',
                      style: TextStyle(fontSize: 12, color: cs.outline),
                    )
                  : Text(
                      narrative!,
                      style: const TextStyle(fontSize: 13, height: 1.5),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Action button
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.map_outlined, size: 16),
            label: const Text('Fix these gaps in Coverage Map'),
            onPressed: () => context.push('/coverage'),
          ),
        ),
      ],
    );
  }
}

// ─── Tab 3: History ───────────────────────────────────────────────────────────
class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simulation history from repository
    final historyAsync = ref.watch(simulationHistoryProvider);
    final cs = Theme.of(context).colorScheme;

    return historyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (history) {
        if (history.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history_rounded, size: 48, color: cs.outlineVariant),
                const SizedBox(height: 12),
                Text(
                  'No simulations run yet.',
                  style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 6),
                Text(
                  'Run a scenario from the Scenarios tab.',
                  style: TextStyle(fontSize: 12, color: cs.outline),
                ),
              ],
            ),
          );
        }

        final spots = history
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.readiness))
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Readiness Trend',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Simulation readiness scores over time',
                style: TextStyle(fontSize: 12, color: cs.outline),
              ),
              const SizedBox(height: 16),

              // Line chart
              SizedBox(
                height: 180,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 100,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) =>
                          FlLine(color: cs.outlineVariant, strokeWidth: 0.5),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 36,
                          getTitlesWidget: (v, _) => Text(
                            '${v.toInt()}%',
                            style: TextStyle(fontSize: 10, color: cs.outline),
                          ),
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: cs.primary,
                        barWidth: 2.5,
                        dotData: FlDotData(
                          getDotPainter: (spot, _, __, ___) =>
                              FlDotCirclePainter(
                                radius: 4,
                                color: cs.primary,
                                strokeWidth: 2,
                                strokeColor: cs.surface,
                              ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: cs.primary.withOpacity(.08),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // History list
              ...history.reversed.map((h) {
                final color = h.readiness >= 75
                    ? Colors.green.shade600
                    : h.readiness >= 50
                    ? Colors.amber.shade600
                    : Colors.red.shade600;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.outlineVariant, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        h.scenarioIcon,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              h.scenarioName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${h.timestamp.day}/${h.timestamp.month}/${h.timestamp.year}  '
                              '· ${h.totalTechniques} techniques assessed',
                              style: TextStyle(fontSize: 11, color: cs.outline),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${h.readiness.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

// ─── Internal result model ────────────────────────────────────────────────────
class _SimResult {
  final _Scenario scenario;
  final int total, passed, failed;
  final List<String> gaps;
  final double readiness;
  final DateTime timestamp;

  const _SimResult({
    required this.scenario,
    required this.total,
    required this.passed,
    required this.failed,
    required this.gaps,
    required this.readiness,
    required this.timestamp,
  });
}

// ─── Simulation history provider (stub — wire to SimulationRepository) ────────
// Replace this with your real simulationRepository data once the repo is set up.
@riverpod
Future<List<SimulationHistoryEntry>> simulationHistory(Ref ref) async {
  final repo = ref.watch(simulationRepositoryProvider);
  return repo.getSimulationHistory();
}

class SimulationHistoryEntry {
  final String scenarioName, scenarioIcon;
  final int totalTechniques;
  final double readiness;
  final DateTime timestamp;

  const SimulationHistoryEntry({
    required this.scenarioName,
    required this.scenarioIcon,
    required this.totalTechniques,
    required this.readiness,
    required this.timestamp,
  });
}
