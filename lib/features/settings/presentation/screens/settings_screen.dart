import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/constants/constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgAsync = ref.watch(organizationProfileProvider);
    final themeMode = ref.watch(themeMode_Provider);
    final riskScoreAsync = ref.watch(organizationRiskScoreProvider);
    final coverageAsync = ref.watch(riskEngineCoveragePercentageProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Organization Profile ────────────────────────────────────
          _SectionTitle('Organization Profile'),
          orgAsync.when(
            data: (org) => org == null
                ? _NoOrgCard(ref: ref)
                : _OrgProfileCard(org: org, ref: ref),
            loading: () => const LoadingWidget(message: 'Loading profile…'),
            error: (_, __) => _NoOrgCard(ref: ref),
          ),
          const SizedBox(height: 24),

          // ── Current Posture Summary ─────────────────────────────────
          _SectionTitle('Security Posture Summary'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: riskScoreAsync.when(
                          data: (score) {
                            final c = _riskColor(score);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Risk Score',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '${score.toStringAsFixed(1)} / 100',
                                  style: TextStyle(
                                    color: c,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            );
                          },
                          loading: () => const LoadingWidget(),
                          error: (_, __) => const Text('—'),
                        ),
                      ),
                      Expanded(
                        child: coverageAsync.when(
                          data: (pct) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coverage',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '${pct.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          loading: () => const LoadingWidget(),
                          error: (_, __) => const Text('—'),
                        ),
                      ),
                      Expanded(
                        child: allTechAsync.when(
                          data: (t) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Techniques',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '${t.length}',
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          loading: () => const LoadingWidget(),
                          error: (_, __) => const Text('—'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── App Preferences ─────────────────────────────────────────
          _SectionTitle('App Preferences'),
          Card(
            child: Column(
              children: [
                // Dark mode — wired to real provider
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Cybersecurity-optimised dark theme'),
                  secondary: const Icon(
                    Icons.dark_mode,
                    color: AppTheme.primaryColor,
                  ),
                  value: themeMode == ThemeMode.dark,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (value) {
                    ref.read(themeMode_Provider.notifier).toggle();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.palette,
                    color: AppTheme.primaryColor,
                  ),
                  title: const Text('Color Theme'),
                  subtitle: Text(
                    themeMode == ThemeMode.dark
                        ? 'Cyber Dark (Active)'
                        : 'Light Mode',
                  ),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── ATT&CK Framework Info ────────────────────────────────────
          _SectionTitle('MITRE ATT\&CK Framework'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.security, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'ATT\&CK Version',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _InfoRow('Framework', 'MITRE ATT&CK® Enterprise'),
                  _InfoRow('Version', 'v14 (2023)'),
                  _InfoRow('Tactics', '14 (Recon → Impact)'),
                  allTechAsync.when(
                    data: (t) => _InfoRow(
                      'Techniques',
                      '${t.length} parent + '
                          '${t.fold(0, (s, e) => s + e.subTechniques.length)} sub-techniques',
                    ),
                    loading: () => _InfoRow('Techniques', 'Loading…'),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  _InfoRow('Data Source', 'Embedded dataset (offline)'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppConstants.mitrAttackUrl,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Risk Engine Documentation ─────────────────────────────────
          _SectionTitle('Risk Engine'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calculate, color: AppTheme.warningColor),
                      const SizedBox(width: 8),
                      Text(
                        'Scoring Formula',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _FormulaLine('Exposure', 'riskScore × coverageMultiplier'),
                  _FormulaLine('Covered', '× 0.0  (no exposure)'),
                  _FormulaLine('Partial', '× 0.5  (50% exposure)'),
                  _FormulaLine('Unknown', '× 0.7  (assumed gap)'),
                  _FormulaLine('Not Covered', '× 1.0  (full exposure)'),
                  const Divider(height: 20),
                  _FormulaLine('Tactic Risk', 'mean(Exposure) per tactic'),
                  _FormulaLine(
                    'Org Risk',
                    'Σ(TacticRisk × weight) / Σ(weight) × 10',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tactic weights: Impact 1.5 → Recon 0.8',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Data Management ──────────────────────────────────────────
          _SectionTitle('Data Management'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.cloud_download,
                    color: AppTheme.primaryColor,
                  ),
                  title: const Text('Export Coverage Data'),
                  subtitle: const Text('Coverage statuses as JSON'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showExportDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.refresh,
                    color: AppTheme.warningColor,
                  ),
                  title: const Text('Reset Coverage'),
                  subtitle: const Text('Clear all coverage statuses'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showResetCoverageDialog(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Clear All Data'),
                  subtitle: const Text(
                    'Delete all alerts, simulations, reports',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showClearAllDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── About ────────────────────────────────────────────────────
          _SectionTitle('About'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.shield,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.appName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'v${AppConstants.appVersion}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppConstants.appDescription,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'This application is built as an academic final-year thesis project '
                    'demonstrating defensive cybersecurity analysis using the MITRE ATT&CK '
                    'framework. All ATT&CK data is attributed to The MITRE Corporation '
                    '(CC BY 4.0).',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Color _riskColor(double s) {
    if (s >= 80) return AppTheme.dangerColor;
    if (s >= 60) return AppTheme.accentColor;
    if (s >= 40) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text(
          'Data export will be available in the next version. '
          'Use the Reports screen to generate and share PDF reports.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showResetCoverageDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset Coverage?'),
        content: const Text(
          'This will clear all coverage statuses for all techniques. '
          'Risk scores will reset. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppTheme.warningColor),
            onPressed: () async {
              Navigator.pop(context);
              final coverages = await ref.read(
                allCoverageStatusesProvider.future,
              );
              for (final c in coverages) {
                await ref.read(
                  deleteCoverageStatusProvider(c.techniqueId).future,
                );
              }
              ref.invalidate(allCoverageStatusesProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Coverage reset'),
                    backgroundColor: AppTheme.warningColor,
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all alerts, simulation results, '
          'reports, bookmarks, and coverage data. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Data clear is disabled in this version to protect thesis data.',
                  ),
                  backgroundColor: Colors.grey,
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

// ─── Org cards ────────────────────────────────────────────────────────────────

class _NoOrgCard extends StatelessWidget {
  final WidgetRef ref;
  const _NoOrgCard({required this.ref});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Organization Set',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Set up your organization profile to personalize coverage tracking.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_business),
              label: const Text('Set Up Organization'),
              onPressed: () => _showEditDialog(context, ref, null),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    OrganizationProfile? existing,
  ) {
    _showOrgEditDialog(context, ref, existing);
  }
}

class _OrgProfileCard extends StatelessWidget {
  final OrganizationProfile org;
  final WidgetRef ref;
  const _OrgProfileCard({required this.org, required this.ref});

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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        org.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        _contextLabel(org.context),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: AppTheme.primaryColor),
                  onPressed: () => _showOrgEditDialog(context, ref, org),
                ),
              ],
            ),
            if (org.description != null && org.description!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                org.description!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (org.preferredSectors != null &&
                org.preferredSectors!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: org.preferredSectors!
                    .map(
                      (s) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          s,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void _showOrgEditDialog(
  BuildContext context,
  WidgetRef ref,
  OrganizationProfile? existing,
) {
  final nameCtrl = TextEditingController(text: existing?.name ?? '');
  final ctxCtrl = TextEditingController(
    text: existing != null ? _contextLabel(existing.context) : '',
  );
  final descCtrl = TextEditingController(text: existing?.description ?? '');

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        existing == null ? 'Set Up Organization' : 'Edit Organization',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Organization Name *',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ctxCtrl,
              decoration: const InputDecoration(
                labelText: 'Context',
                hintText: 'e.g. Organization, Lab, Personal',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descCtrl,
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
          onPressed: () async {
            if (nameCtrl.text.trim().isEmpty) return;
            final profile = OrganizationProfile(
              id:
                  existing?.id ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              name: nameCtrl.text.trim(),
              context: _contextFromLabel(ctxCtrl.text.trim()),
              description: descCtrl.text.trim(),
              preferredSectors: existing?.preferredSectors ?? [],
              preferredPlatforms: existing?.preferredPlatforms ?? [],
              createdAt: existing?.createdAt ?? DateTime.now(),
              lastModified: DateTime.now(),
            );
            await ref.read(updateOrganizationProfileProvider(profile).future);
            ref.invalidate(organizationProfileProvider);
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Organization saved'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

// ─── Helper widgets ───────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

class _FormulaLine extends StatelessWidget {
  final String label;
  final String formula;
  const _FormulaLine(this.label, this.formula);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              formula,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helper functions for AppContext conversion ────────────────────────────────

String _contextLabel(AppContext context) {
  return switch (context) {
    AppContext.personalLearning => 'Personal Learning',
    AppContext.lab => 'Lab Environment',
    AppContext.organizational => 'Organization',
  };
}

AppContext _contextFromLabel(String label) {
  return switch (label) {
    'Personal Learning' => AppContext.personalLearning,
    'Lab Environment' => AppContext.lab,
    _ => AppContext.organizational,
  };
}
