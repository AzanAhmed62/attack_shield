// lib/features/simulations/presentation/screens/simulations_screen.dart
// FULL REPLACEMENT — three tabs:
//   1. Matrix   — Navigator-style heatmap (tap cell → technique detail)
//   2. Scenarios — Kill-chain step animator + OTX live intel + Gemini narrative
//   3. History  — Readiness trend line chart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../shared/models/coverage_status.dart';
import '../../../../shared/providers/technique_providers.dart';
import '../../../../shared/providers/coverage_providers.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../shared/providers/simulation_providers.dart';
import '../../../../core/widgets/shimmer_loader.dart';
import '../models/simulation_history_entry.dart';

// ─── Scenario definitions ─────────────────────────────────────────────────────
class _Scenario {
  final String id, name, description, icon, threatActor;
  final List<_KillChainStep> killChain;

  const _Scenario({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.threatActor,
    required this.killChain,
  });

  List<String> get techniqueIds => killChain.map((s) => s.techniqueId).toList();
}

class _KillChainStep {
  final String techniqueId;
  final String tacticLabel;
  final String attackerAction; // what attacker does if not covered
  final String defensiveValue; // what coverage prevents
  const _KillChainStep({
    required this.techniqueId,
    required this.tacticLabel,
    required this.attackerAction,
    required this.defensiveValue,
  });
}

const _scenarios = [
  _Scenario(
    id: 'ransomware',
    name: 'Ransomware Attack',
    icon: '🔒',
    description:
        'Modern ransomware intrusion: phishing → execution → persistence → encryption.',
    threatActor: 'Conti / LockBit TTPs',
    killChain: [
      _KillChainStep(
        techniqueId: 'T1566',
        tacticLabel: 'Initial Access',
        attackerAction:
            'Sends phishing email with malicious attachment to employee',
        defensiveValue:
            'Email filtering + user training blocks the initial entry',
      ),
      _KillChainStep(
        techniqueId: 'T1059',
        tacticLabel: 'Execution',
        attackerAction: 'Runs PowerShell / cmd scripts to download payload',
        defensiveValue: 'Script-block logging + AppLocker stops execution',
      ),
      _KillChainStep(
        techniqueId: 'T1547',
        tacticLabel: 'Persistence',
        attackerAction: 'Adds Run key to survive reboot',
        defensiveValue: 'Autoruns monitoring catches the registry change',
      ),
      _KillChainStep(
        techniqueId: 'T1027',
        tacticLabel: 'Defense Evasion',
        attackerAction: 'Obfuscates payload to evade AV detection',
        defensiveValue:
            'Behavioural detection + sandbox catches obfuscated code',
      ),
      _KillChainStep(
        techniqueId: 'T1083',
        tacticLabel: 'Discovery',
        attackerAction: 'Enumerates file shares and backup locations',
        defensiveValue: 'File access auditing alerts on mass enumeration',
      ),
      _KillChainStep(
        techniqueId: 'T1486',
        tacticLabel: 'Impact',
        attackerAction: 'Encrypts all accessible files; drops ransom note',
        defensiveValue:
            'Immutable backups + honeypot files trigger early detection',
      ),
    ],
  ),
  _Scenario(
    id: 'apt29',
    name: 'APT29 (Cozy Bear)',
    icon: '🕵️',
    description:
        'Nation-state espionage: credential theft → data staging → exfiltration.',
    threatActor: 'SVR — Russian Foreign Intelligence',
    killChain: [
      _KillChainStep(
        techniqueId: 'T1566',
        tacticLabel: 'Initial Access',
        attackerAction:
            'Spear-phishing email targeting executive with SWIFT attachment',
        defensiveValue:
            'Advanced email filtering and exec awareness blocks entry',
      ),
      _KillChainStep(
        techniqueId: 'T1078',
        tacticLabel: 'Valid Accounts',
        attackerAction:
            'Uses stolen credentials from previous breach to log in',
        defensiveValue:
            'MFA and privileged access management block credential reuse',
      ),
      _KillChainStep(
        techniqueId: 'T1003',
        tacticLabel: 'Credential Access',
        attackerAction: 'Dumps LSASS memory to harvest domain credentials',
        defensiveValue:
            'Credential Guard + LSASS protection prevents memory dump',
      ),
      _KillChainStep(
        techniqueId: 'T1560',
        tacticLabel: 'Collection',
        attackerAction:
            'Archives sensitive files into encrypted ZIP for staging',
        defensiveValue: 'DLP + file activity monitoring detects mass archiving',
      ),
      _KillChainStep(
        techniqueId: 'T1041',
        tacticLabel: 'Exfiltration',
        attackerAction:
            'Exfiltrates data over C2 HTTPS channel to cloud storage',
        defensiveValue:
            'Network DLP + proxy inspection intercepts the transfer',
      ),
    ],
  ),
  _Scenario(
    id: 'supply_chain',
    name: 'Supply Chain Attack',
    icon: '📦',
    description:
        'Compromise a trusted software update to reach all downstream customers.',
    threatActor: 'SolarWinds-style TTP',
    killChain: [
      _KillChainStep(
        techniqueId: 'T1195',
        tacticLabel: 'Initial Access',
        attackerAction:
            'Injects malicious code into vendor software build pipeline',
        defensiveValue:
            'SBOM tracking + signed build verification detects tampering',
      ),
      _KillChainStep(
        techniqueId: 'T1036',
        tacticLabel: 'Defense Evasion',
        attackerAction: 'Masquerades malicious binary as legitimate update',
        defensiveValue:
            'Binary signature validation + hash comparison catches mismatch',
      ),
      _KillChainStep(
        techniqueId: 'T1055',
        tacticLabel: 'Execution',
        attackerAction:
            'Injects into trusted process to execute payload silently',
        defensiveValue: 'Process injection detection via EDR halts execution',
      ),
      _KillChainStep(
        techniqueId: 'T1021',
        tacticLabel: 'Lateral Movement',
        attackerAction:
            'Uses remote services to move across network from beachhead',
        defensiveValue:
            'Network segmentation + lateral movement detection limits spread',
      ),
      _KillChainStep(
        techniqueId: 'T1070',
        tacticLabel: 'Defense Evasion',
        attackerAction: 'Clears event logs and footprints to avoid detection',
        defensiveValue:
            'SIEM log forwarding to immutable store preserves evidence',
      ),
    ],
  ),
  _Scenario(
    id: 'insider',
    name: 'Insider Threat',
    icon: '👤',
    description:
        'Malicious employee abusing legitimate access to exfiltrate data.',
    threatActor: 'Privileged Insider / Compromised Account',
    killChain: [
      _KillChainStep(
        techniqueId: 'T1078',
        tacticLabel: 'Valid Accounts',
        attackerAction: 'Logs in with own credentials — no alarm triggered',
        defensiveValue:
            'User behaviour analytics (UBA) detects anomalous activity patterns',
      ),
      _KillChainStep(
        techniqueId: 'T1087',
        tacticLabel: 'Discovery',
        attackerAction: 'Queries AD to discover high-value accounts and shares',
        defensiveValue:
            'LDAP query monitoring alerts on mass account enumeration',
      ),
      _KillChainStep(
        techniqueId: 'T1005',
        tacticLabel: 'Collection',
        attackerAction: 'Copies sensitive documents to personal folder',
        defensiveValue:
            'DLP policies block copying confidential data to unapproved locations',
      ),
      _KillChainStep(
        techniqueId: 'T1041',
        tacticLabel: 'Exfiltration',
        attackerAction:
            'Uploads files to personal cloud storage (Dropbox, GDrive)',
        defensiveValue:
            'CASB monitoring detects and blocks upload to unapproved SaaS',
      ),
    ],
  ),
  _Scenario(
    id: 'cloud',
    name: 'Cloud Attack',
    icon: '☁️',
    description:
        'Exploit cloud misconfiguration to access sensitive data and resources.',
    threatActor: 'Cloud-native adversary / SSRF exploitation',
    killChain: [
      _KillChainStep(
        techniqueId: 'T1190',
        tacticLabel: 'Initial Access',
        attackerAction:
            'Exploits public-facing application vulnerability (SSRF/RCE)',
        defensiveValue:
            'WAF + patching cadence blocks known public-facing exploits',
      ),
      _KillChainStep(
        techniqueId: 'T1552',
        tacticLabel: 'Credential Access',
        attackerAction:
            'Steals cloud metadata credentials from instance metadata service',
        defensiveValue: 'IMDSv2 enforcement prevents credential theft via SSRF',
      ),
      _KillChainStep(
        techniqueId: 'T1098',
        tacticLabel: 'Privilege Escalation',
        attackerAction:
            'Adds IAM permissions to escalate from app role to admin',
        defensiveValue:
            'IAM policy guardrails + CloudTrail alert block privilege escalation',
      ),
      _KillChainStep(
        techniqueId: 'T1530',
        tacticLabel: 'Collection',
        attackerAction:
            'Lists and downloads all S3 buckets with sensitive data',
        defensiveValue:
            'S3 Block Public Access + bucket policies prevent mass download',
      ),
      _KillChainStep(
        techniqueId: 'T1537',
        tacticLabel: 'Exfiltration',
        attackerAction: 'Replicates data to attacker-controlled S3 bucket',
        defensiveValue:
            'Data exfiltration detection + SCPs prevent cross-account replication',
      ),
    ],
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────
class SimulationsScreen extends HookConsumerWidget {
  const SimulationsScreen({super.key});

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
            children: ['Matrix', 'Scenarios', 'History'].asMap().entries.map((
              e,
            ) {
              final sel = e.key == tabIndex.value;
              return Expanded(
                child: GestureDetector(
                  onTap: () => tabIndex.value = e.key,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: sel ? cs.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      e.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                        color: sel ? cs.primary : cs.outline,
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

// ─── Tab 1: Matrix heatmap ────────────────────────────────────────────────────
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                child: Row(
                  children: [
                    _LegDot(Colors.green.shade500, 'Covered'),
                    const SizedBox(width: 10),
                    _LegDot(Colors.amber.shade500, 'Partial'),
                    const SizedBox(width: 10),
                    _LegDot(Colors.red.shade400, 'Not Covered'),
                    const SizedBox(width: 10),
                    _LegDot(Colors.grey.shade400, 'Unknown'),
                    const Spacer(),
                    Text(
                      'Tap cell to view',
                      style: TextStyle(fontSize: 10, color: cs.outline),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tactics.map((tactic) {
                      final techs = (byTactic[tactic.shortName] ?? [])
                          .take(15)
                          .toList();
                      final covered = techs
                          .where((t) => covMap[t.id] == CoverageLevel.covered)
                          .length;
                      final pct = techs.isEmpty ? 0.0 : covered / techs.length;
                      return Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 6),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: cs.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    tactic.name,
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onPrimaryContainer,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      value: pct,
                                      minHeight: 3,
                                      backgroundColor: cs.primaryContainer,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.green.shade500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '$covered/${techs.length}',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: cs.onPrimaryContainer.withOpacity(
                                        .7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...techs.map((t) {
                              final cov = covMap[t.id] ?? CoverageLevel.unknown;
                              final c = _cellColor(cov, t.riskScore);
                              return GestureDetector(
                                onTap: () => context.push('/library/${t.id}'),
                                child: Tooltip(
                                  message: '${t.id}: ${t.name}',
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      t.id,
                                      style: const TextStyle(
                                        fontSize: 8.5,
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

  Color _cellColor(CoverageLevel cov, double risk) {
    switch (cov) {
      case CoverageLevel.covered:
        return Colors.green.shade600;
      case CoverageLevel.partiallyCovered:
        return Colors.amber.shade600;
      case CoverageLevel.notCovered:
        return Color.lerp(
          Colors.red.shade300,
          Colors.red.shade800,
          (risk / 10).clamp(.3, 1.0),
        )!;
      case CoverageLevel.unknown:
        return Colors.grey.shade400;
    }
  }
}

class _LegDot extends StatelessWidget {
  final Color c;
  final String l;
  const _LegDot(this.c, this.l);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 4),
      Text(
        l,
        style: TextStyle(
          fontSize: 9,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}

// ─── Tab 2: Kill-chain Scenarios ──────────────────────────────────────────────
class _ScenariosTab extends HookConsumerWidget {
  const _ScenariosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<_Scenario?>(null);
    final running = useState(false);
    final stepIdx = useState(-1); // -1 = not started, -2 = complete
    final stepResults = useState<List<bool>>([]); // true=blocked, false=exposed
    final narrative = useState<String?>(null);
    final narLoading = useState(false);

    final covMap = ref.watch(coverageMapProvider).value ?? {};
    final cs = Theme.of(context).colorScheme;

    Future<void> runKillChain(_Scenario scenario) async {
      selected.value = scenario;
      running.value = true;
      stepIdx.value = -1;
      stepResults.value = [];
      narrative.value = null;

      await Future.delayed(const Duration(milliseconds: 400));

      final results = <bool>[];
      for (int i = 0; i < scenario.killChain.length; i++) {
        stepIdx.value = i;
        await Future.delayed(const Duration(milliseconds: 900));
        final step = scenario.killChain[i];
        final cov = covMap[step.techniqueId] ?? CoverageLevel.unknown;
        results.add(cov == CoverageLevel.covered);
        stepResults.value = List.from(results);
      }

      stepIdx.value = -2; // complete
      running.value = false;

      // Save to history
      final passed = results.where((r) => r).length;
      final readiness = results.isEmpty ? 0.0 : (passed / results.length) * 100;
      final entry = SimulationHistoryEntry(
        scenarioName: scenario.name,
        scenarioIcon: scenario.icon,
        totalTechniques: scenario.killChain.length,
        readiness: readiness,
        timestamp: DateTime.now(),
      );
      await ref.read(saveSimulationResultProvider(entry).future);

      // Gemini narrative
      narLoading.value = true;
      try {
        final gaps = scenario.killChain
            .where((s) {
              final cov = covMap[s.techniqueId] ?? CoverageLevel.unknown;
              return cov != CoverageLevel.covered;
            })
            .map((s) => s.techniqueId)
            .toList();
        final gemini = ref.read(geminiServiceProvider);
        final result = await gemini.generateSimulationNarrative(
          scenarioName: scenario.name,
          uncoveredTechniques: gaps,
          readinessScore: readiness,
        );
        if (result.isSuccess) narrative.value = result.text;
      } finally {
        narLoading.value = false;
      }
    }

    void reset() {
      selected.value = null;
      stepIdx.value = -1;
      stepResults.value = [];
      narrative.value = null;
    }

    if (selected.value == null) {
      // Scenario selection grid
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          Text(
            'Select an Attack Scenario',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Watch an attack unfold step-by-step and see exactly where your coverage holds or fails.',
            style: TextStyle(fontSize: 12, color: cs.outline),
          ),
          const SizedBox(height: 16),
          ..._scenarios.map(
            (s) => _ScenarioCard(scenario: s, onTap: () => runKillChain(s)),
          ),
        ],
      );
    }

    // Kill-chain animation view
    final scenario = selected.value!;
    final steps = scenario.killChain;
    final cur = stepIdx.value;
    final complete = cur == -2;
    final passed = stepResults.value.where((r) => r).length;
    final total = stepResults.value.length;
    final readiness = total > 0 ? (passed / steps.length) * 100.0 : 0.0;
    final rColor = readiness >= 75
        ? Colors.green.shade600
        : readiness >= 50
        ? Colors.amber.shade600
        : Colors.red.shade600;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          color: cs.surfaceContainerLow,
          child: Row(
            children: [
              Text(scenario.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
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
                    Text(
                      scenario.threatActor,
                      style: TextStyle(fontSize: 11, color: cs.outline),
                    ),
                  ],
                ),
              ),
              if (!running.value)
                TextButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.arrow_back_rounded, size: 14),
                  label: const Text('Back'),
                ),
            ],
          ),
        ),

        // Progress bar
        if (running.value || complete)
          LinearProgressIndicator(
            value: complete ? 1.0 : (cur >= 0 ? (cur + 1) / steps.length : 0),
            minHeight: 3,
            backgroundColor: cs.outlineVariant,
            valueColor: AlwaysStoppedAnimation(complete ? rColor : cs.primary),
          ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Steps
                ...steps.asMap().entries.map((e) {
                  final i = e.key;
                  final step = e.value;
                  final done = i < stepResults.value.length;
                  final active = i == cur;
                  final blocked = done && stepResults.value[i];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: active
                          ? cs.primaryContainer.withOpacity(.3)
                          : done
                          ? (blocked
                                ? Colors.green.shade50
                                : Colors.red.shade50)
                          : cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: active
                            ? cs.primary
                            : done
                            ? (blocked
                                  ? Colors.green.shade300
                                  : Colors.red.shade300)
                            : cs.outlineVariant,
                        width: active ? 1.5 : 0.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step number / result icon
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: active
                                ? cs.primary
                                : done
                                ? (blocked
                                      ? Colors.green.shade500
                                      : Colors.red.shade500)
                                : cs.surfaceContainerHighest,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: active
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : done
                                ? Icon(
                                    blocked
                                        ? Icons.shield_rounded
                                        : Icons.warning_amber_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: cs.outline,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${step.tacticLabel}  ·  ${step.techniqueId}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: active
                                            ? cs.primary
                                            : cs.onSurface,
                                      ),
                                    ),
                                  ),
                                  if (done)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: blocked
                                            ? Colors.green.shade100
                                            : Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        blocked ? '✓ Blocked' : '✗ Exposed',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: blocked
                                              ? Colors.green.shade700
                                              : Colors.red.shade700,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              if (done) ...[
                                Text(
                                  blocked
                                      ? step.defensiveValue
                                      : step.attackerAction,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: blocked
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
                                    height: 1.4,
                                  ),
                                ),
                              ] else if (active) ...[
                                Text(
                                  step.attackerAction,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: cs.outline,
                                    height: 1.4,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  step.attackerAction,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: cs.outline,
                                    height: 1.3,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              if (done) ...[
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () => context.push(
                                    '/library/${step.techniqueId}',
                                  ),
                                  child: Text(
                                    'View ${step.techniqueId} →',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: cs.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Final result
                if (complete) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.outlineVariant, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 72,
                                  height: 72,
                                  child: CircularProgressIndicator(
                                    value: readiness / 100,
                                    strokeWidth: 7,
                                    backgroundColor: cs.outlineVariant,
                                    color: rColor,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                                Text(
                                  '${readiness.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: rColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Simulation Complete',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: cs.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: rColor.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      readiness >= 75
                                          ? 'Well Protected'
                                          : readiness >= 50
                                          ? 'Partially Ready'
                                          : 'High Exposure',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: rColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shield_rounded,
                                        size: 13,
                                        color: Colors.green.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$passed/${steps.length} steps blocked',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        if (narrative.value != null) ...[
                          const Divider(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                size: 14,
                                color: cs.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'AI Attack Narrative',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            narrative.value!,
                            style: const TextStyle(fontSize: 12, height: 1.5),
                          ),
                        ] else if (narLoading.value) ...[
                          const Divider(height: 20),
                          const ShimmerLoader(height: 50),
                        ],

                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.map_outlined, size: 15),
                            label: const Text(
                              'Fix exposed gaps in Coverage Map',
                            ),
                            onPressed: () => context.push('/coverage'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.replay_rounded, size: 15),
                            label: const Text('Run another scenario'),
                            onPressed: reset,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final _Scenario scenario;
  final VoidCallback onTap;
  const _ScenarioCard({required this.scenario, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
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
                    const SizedBox(height: 5),
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
                        Icon(
                          Icons.linear_scale_rounded,
                          size: 12,
                          color: cs.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${scenario.killChain.length}-step kill chain',
                          style: TextStyle(fontSize: 11, color: cs.outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.play_arrow_rounded, color: cs.primary, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Tab 3: History ───────────────────────────────────────────────────────────
class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(simulationHistoryProvider);
    final cs = Theme.of(context).colorScheme;

    return historyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (history) {
        if (history.isEmpty)
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history_rounded, size: 48, color: cs.outlineVariant),
                const SizedBox(height: 12),
                Text(
                  'No simulations yet.',
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

        final spots = history.reversed
            .toList()
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
                'Your simulation readiness scores over time',
                style: TextStyle(fontSize: 12, color: cs.outline),
              ),
              const SizedBox(height: 16),
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
                          FlLine(color: cs.outlineVariant, strokeWidth: .5),
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
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
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
                          getDotPainter: (_, __, ___, ____) =>
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
              ...history.map((h) {
                final c = h.readiness >= 75
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
                    border: Border.all(color: cs.outlineVariant, width: .5),
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
                              '${h.timestamp.day}/${h.timestamp.month}/${h.timestamp.year}  ·  ${h.totalTechniques} steps',
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
                          color: c,
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
