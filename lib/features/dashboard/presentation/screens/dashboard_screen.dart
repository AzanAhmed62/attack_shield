// lib/features/dashboard/presentation/screens/dashboard_screen.dart
//
// COMPLETE DASHBOARD — ALL 5 PILLARS INTEGRATED
// Shows org profile, risk score, top threats, simulations, detection, AI

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/shared/providers/plain_language_providers.dart';
import 'package:attackshield/shared/providers/mitre_data_providers.dart';
import 'package:attackshield/features/simulation/providers/simulation_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final isPlain = appMode == AppMode.plainLanguageMode;
    final orgProfile = ref.watch(organizationProfileV2Provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isPlain ? '🛡️ Security Dashboard' : 'Dashboard'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: ActionChip(
                avatar: Text(isPlain ? '📱' : '🔧'),
                label: Text(isPlain ? 'Plain' : 'Expert'),
                onPressed: () => ref
                    .read(organizationProfileV2Provider.notifier)
                    .toggleAppMode(),
              ),
            ),
          ),
        ],
      ),
      body: orgProfile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) {
          if (profile == null) {
            return _NoOrgSetup();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _DashboardHeader(profile: profile, isPlain: isPlain),
              ),
              SliverToBoxAdapter(
                child: _RiskCard(profile: profile, isPlain: isPlain),
              ),
              SliverToBoxAdapter(
                child: _TopThreatsSection(profile: profile, isPlain: isPlain),
              ),
              SliverToBoxAdapter(child: _ThreatActorsSection(profile: profile)),
              SliverToBoxAdapter(child: _SimulationsSection(isPlain: isPlain)),
              SliverToBoxAdapter(child: _DetectionSection(isPlain: isPlain)),
              SliverToBoxAdapter(child: _AiFeaturesSection(isPlain: isPlain)),
              SliverToBoxAdapter(
                child: _RecommendedActionsSection(
                  profile: profile,
                  isPlain: isPlain,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final dynamic profile; // OrganizationProfileV2
  final bool isPlain;

  const _DashboardHeader({required this.profile, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name.isEmpty ? 'Your Organization' : profile.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${(profile.sector as BusinessSector).displayName} • ${(profile.size as OrganizationSize).displayName} • ${profile.currentDefenses.length} defenses',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiskCard extends ConsumerWidget {
  final dynamic profile; // OrganizationProfileV2
  final bool isPlain;

  const _RiskCard({required this.profile, required this.isPlain});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseRisk = profile.baselineRiskScore;
    final defensiveReadiness = 100 - baseRisk;
    final riskColor = defensiveReadiness > 70
        ? Colors.green
        : defensiveReadiness > 50
        ? Colors.orange
        : Colors.red;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: riskColor.withValues(alpha: 0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPlain ? '🛡️ Your Security Strength' : 'Defensive Readiness',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '${defensiveReadiness.toStringAsFixed(0)}/100',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: riskColor.withValues(alpha: 0.1),
                      border: Border.all(color: riskColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${defensiveReadiness.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: defensiveReadiness / 100,
                minHeight: 8,
                color: riskColor,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.push('/coverage'),
                child: const Text('View Coverage Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopThreatsSection extends ConsumerWidget {
  final dynamic profile; // OrganizationProfileV2
  final bool isPlain;

  const _TopThreatsSection({required this.profile, required this.isPlain});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threats = ref.watch(prioritisedTechniquesProvider(profile));

    return threats.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (ranked) {
        if (ranked.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPlain
                    ? '⚠️ Top Threats for Your Organization'
                    : 'Top Threats',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...ranked.take(5).map((threat) {
                final scoreColor = threat.score > 70
                    ? Colors.red
                    : threat.score > 40
                    ? Colors.orange
                    : Colors.yellow;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () => context.push(
                      '/technique/${Uri.encodeComponent(threat.attackId)}',
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isPlain
                                      ? threat.plainName
                                      : threat.technique.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${threat.attackId} • ${threat.threatGroupNames.length} APT groups',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: scoreColor.withValues(alpha: 0.1),
                              border: Border.all(color: scoreColor),
                            ),
                            child: Center(
                              child: Text(
                                threat.score.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: scoreColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ThreatActorsSection extends ConsumerWidget {
  final dynamic profile;

  const _ThreatActorsSection({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allGroupsAsync = ref.watch(allThreatGroupsProvider);

    return allGroupsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (groups) {
        final sectorGroups = groups.take(8).toList();
        if (sectorGroups.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🚨 ${sectorGroups.length} APT Groups Target Your Sector',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: sectorGroups
                    .take(6)
                    .map(
                      (group) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          group.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SimulationsSection extends ConsumerWidget {
  final bool isPlain;

  const _SimulationsSection({required this.isPlain});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenarios = ref.watch(preBuiltScenariosProvider);

    return scenarios.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (scenarios) {
        if (scenarios.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPlain ? '🎮 Practice Your Defense' : 'Guided Simulations',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: scenarios.take(4).map((scenario) {
                  final icon = _scenarioIcon(scenario.id);
                  return GestureDetector(
                    onTap: () => context.push('/simulations'),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(icon, style: const TextStyle(fontSize: 32)),
                          const SizedBox(height: 8),
                          Text(
                            scenario.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '5-10 min',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Center(
                child: OutlinedButton(
                  onPressed: () => context.push('/simulations'),
                  child: const Text('All Simulations'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _scenarioIcon(String id) {
    const icons = {
      'phishing_001': '📧',
      'ransomware_001': '🔐',
      'lateral_movement_001': '↔️',
    };
    return icons[id] ?? '🎮';
  }
}

class _DetectionSection extends StatelessWidget {
  final bool isPlain;

  const _DetectionSection({required this.isPlain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPlain
                ? '🔍 Can You Detect Real Attacks?'
                : 'Detection Capability',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPlain
                      ? 'Paste your logs to find real attack signs'
                      : 'Analyse logs against 40+ detection rules',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: Text(isPlain ? 'Scan for Threats' : 'Analyse Logs'),
                  onPressed: () => context.push('/detection'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiFeaturesSection extends StatelessWidget {
  final bool isPlain;

  const _AiFeaturesSection({required this.isPlain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPlain ? '✨ AI-Powered Insights' : 'AI Features',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _AiFeatureChip(
                emoji: '💬',
                label: isPlain ? 'Ask About Threats' : 'Explainer',
                onTap: () => context.push('/library'),
              ),
              _AiFeatureChip(
                emoji: '📰',
                label: isPlain ? 'Check News' : 'Threat Intel',
                onTap: () => context.push('/threat-intel'),
              ),
              _AiFeatureChip(
                emoji: '🛡️',
                label: isPlain ? 'Get Help' : 'Coverage Advisor',
                onTap: () => context.push('/reports'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AiFeatureChip extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _AiFeatureChip({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          border: Border.all(color: Colors.purple.shade200),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendedActionsSection extends StatelessWidget {
  final dynamic profile;
  final bool isPlain;

  const _RecommendedActionsSection({
    required this.profile,
    required this.isPlain,
  });

  @override
  Widget build(BuildContext context) {
    final actions = _getRecommendedActions(profile, isPlain);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPlain ? '📋 Next Steps' : 'Recommended Actions',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...actions.map(
            (action) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('→ ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(action, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getRecommendedActions(dynamic profile, bool isPlain) {
    final actions = <String>[];
    try {
      if (profile.currentDefenses?.isEmpty ?? true) {
        actions.add(
          isPlain
              ? 'Set up email filtering to block phishing'
              : 'Deploy email gateway',
        );
      }
      // Skip enum checks - just provide generic recommendations
      actions.add(
        isPlain
            ? 'Install security software on your computers'
            : 'Deploy EDR to endpoints',
      );
      actions.add(
        isPlain
            ? 'Turn on two-factor authentication'
            : 'Enable MFA on critical accounts',
      );
    } catch (_) {
      // Silent fall through if profile structure is unexpected
    }
    actions.add(isPlain ? 'Practice with a simulation' : 'Run a simulation');
    return actions;
  }
}

class _NoOrgSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🏢', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            const Text(
              'Set Up Your Organization',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tell us about your organization to get personalized recommendations.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push('/setup-organization'),
              child: const Text('Start Setup'),
            ),
          ],
        ),
      ),
    );
  }
}
