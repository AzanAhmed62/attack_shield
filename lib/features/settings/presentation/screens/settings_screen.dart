import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/constants/constants.dart';
import 'package:attackshield/features/settings/presentation/widgets/ai_settings_section.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgAsync = ref.watch(organizationProfileProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final riskScoreAsync = ref.watch(organizationRiskScoreProvider);
    final coverageAsync = ref.watch(riskEngineCoveragePercentageProvider);
    final allTechAsync = ref.watch(allTechniquesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Organization Profile ────────────────────────────────────
          const _SectionTitle('Organization Profile'),
          orgAsync.when(
            data: (org) => org == null
                ? _NoOrgCard(ref: ref)
                : _OrgProfileCard(org: org, ref: ref),
            loading: () => const LoadingWidget(message: 'Loading profile…'),
            error: (_, _) => _NoOrgCard(ref: ref),
          ),
          const SizedBox(height: 24),

          // ── Current Posture Summary ─────────────────────────────────
          const _SectionTitle('Security Posture Summary'),
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
                          error: (_, _) => const Text('—'),
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
                          error: (_, _) => const Text('—'),
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
                          error: (_, _) => const Text('—'),
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
          const _SectionTitle('App Preferences'),
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
                  activeThumbColor: AppTheme.primaryColor,
                  onChanged: (value) {
                    ref.read(appThemeModeProvider.notifier).toggle();
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
                    decoration: const BoxDecoration(
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
          const _SectionTitle('MITRE ATT&CK Framework'),
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
                        'ATT&CK Version',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _InfoRow('Framework', 'MITRE ATT&CK® Enterprise'),
                  const _InfoRow('Version', 'v14 (2023)'),
                  const _InfoRow('Tactics', '14 (Recon → Impact)'),
                  allTechAsync.when(
                    data: (t) => _InfoRow(
                      'Techniques',
                      '${t.length} parent + '
                          '${t.fold(0, (s, e) => s + e.subTechniques.length)} sub-techniques',
                    ),
                    loading: () => const _InfoRow('Techniques', 'Loading…'),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                  const _InfoRow('Data Source', 'Embedded dataset (offline)'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          AppConstants.mitrAttackUrl,
                          style: TextStyle(
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
          const _SectionTitle('Risk Engine'),
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
                  const _FormulaLine(
                    'Exposure',
                    'riskScore × coverageMultiplier',
                  ),
                  const _FormulaLine('Covered', '× 0.0  (no exposure)'),
                  const _FormulaLine('Partial', '× 0.5  (50% exposure)'),
                  const _FormulaLine('Unknown', '× 0.7  (assumed gap)'),
                  const _FormulaLine('Not Covered', '× 1.0  (full exposure)'),
                  const Divider(height: 20),
                  const _FormulaLine(
                    'Tactic Risk',
                    'mean(Exposure) per tactic',
                  ),
                  const _FormulaLine(
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
          const _SectionTitle('Data Management'),
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
                  onTap: () => _exportCoverageData(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.upload_file,
                    color: AppTheme.successColor,
                  ),
                  title: const Text('Import Coverage'),
                  subtitle: const Text('Paste exported coverage JSON'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showImportDialog(context, ref),
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

          // ── AI Settings ──────────────────────────────────────────────
          const AISettingsSection(),
          const SizedBox(height: 24),

          // ── About ────────────────────────────────────────────────────
          const _SectionTitle('About'),
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

  Future<void> _exportCoverageData(BuildContext context, WidgetRef ref) async {
    final statuses = await ref.read(allCoverageStatusesProvider.future);
    final payload = jsonEncode({
      'app': AppConstants.appName,
      'version': AppConstants.appVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'coverageStatuses': statuses.map((status) => status.toJson()).toList(),
    });

    await Share.share(payload, subject: 'AttackShield Coverage Export');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${statuses.length} coverage status'
            '${statuses.length == 1 ? '' : 'es'}',
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    }
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

  void _showImportDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Import Coverage'),
        content: SizedBox(
          width: 560,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paste a previous AttackShield coverage export. Existing coverage entries with the same technique ID will be replaced.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 12,
                decoration: const InputDecoration(
                  hintText: '{"coverageStatuses":[...]}',
                  alignLabelWithHint: true,
                ),
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
              final raw = controller.text.trim();
              if (raw.isEmpty) return;

              try {
                final decoded = jsonDecode(raw);
                final dynamic items = decoded is Map<String, dynamic>
                    ? decoded['coverageStatuses']
                    : decoded;

                if (items is! List) {
                  throw const FormatException(
                    'Invalid coverage export payload',
                  );
                }

                for (final item in items) {
                  final status = CoverageStatus.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  );
                  await ref.read(updateCoverageStatusProvider(status).future);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Imported ${items.length} coverage statuses',
                      ),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Import failed: $error'),
                      backgroundColor: AppTheme.dangerColor,
                    ),
                  );
                }
              }
            },
            child: const Text('Import'),
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
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(clearAllAlertsProvider.future);
              await ref.read(clearAllSimulationDataProvider.future);
              await ref.read(clearAllReportsProvider.future);
              await ref.read(clearAllBookmarksProvider.future);
              await ref.read(clearAllCoverageStatusesProvider.future);
              await ref.read(clearAllAssetsProvider.future);
              ref.invalidate(openAlertCountProvider);
              ref.invalidate(criticalAlertCountProvider);
              ref.invalidate(latestReportProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All operational data cleared'),
                    backgroundColor: AppTheme.dangerColor,
                  ),
                );
              }
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
                        _contextLabel(AppContextX.fromString(org.context)),
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
            if (org.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                org.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (org.preferredSectors.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: org.preferredSectors
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
    text: existing != null
        ? _contextLabel(AppContextX.fromString(existing.context))
        : '',
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
              context: _contextFromLabel(ctxCtrl.text.trim()).value,
              description: descCtrl.text.trim(),
              sector: existing?.sector ?? OrgSector.sme,
              orgSize: existing?.orgSize ?? OrgSize.small,
              techStack: existing?.techStack ?? const [],
              currentControls: existing?.currentControls ?? const [],
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

String _contextLabel(AppContext context) => context.label;

AppContext _contextFromLabel(String label) => AppContextX.fromLabel(label);
