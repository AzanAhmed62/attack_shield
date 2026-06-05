// lib/features/settings/presentation/screens/settings_screen.dart
// FULL REPLACEMENT — Gemini + OSINT API key management, org profile, cache.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/services/gemini_service.dart';
import '../../../../data/services/osint_service.dart';
import '../../../../data/repositories/attack_technique_repository.dart';
import '../../../../shared/providers/repository_providers.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = GetStorage();
    final orgName = useState(storage.read<String>('org_name') ?? '');
    final sector = useState(storage.read<String>('org_sector') ?? '');

    // API keys
    final geminiCtrl = useTextEditingController(
      text: GeminiService().apiKey ?? '',
    );
    final otxCtrl = useTextEditingController(text: OsintService().otxKey ?? '');
    final abuseCtrl = useTextEditingController(
      text: OsintService().abuseIpKey ?? '',
    );
    final vtCtrl = useTextEditingController(
      text: OsintService().virusTotalKey ?? '',
    );
    final showKeys = useState(false);

    final geminiStatus = useState<String?>(null);
    final isTesting = useState(false);
    final cs = Theme.of(context).colorScheme;

    Future<void> saveGeminiKey() async {
      await GeminiService().setApiKey(geminiCtrl.text.trim());
      geminiStatus.value = 'saved';
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gemini API key saved'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    Future<void> testGeminiKey() async {
      isTesting.value = true;
      geminiStatus.value = null;
      final result = await GeminiService().generate(
        prompt: 'Reply: OK',
        maxTokens: 10,
      );
      geminiStatus.value = result.isSuccess ? 'valid' : 'invalid';
      isTesting.value = false;
    }

    Future<void> saveOsintKeys() async {
      final osint = OsintService();
      if (otxCtrl.text.trim().isNotEmpty)
        await osint.setOtxKey(otxCtrl.text.trim());
      if (abuseCtrl.text.trim().isNotEmpty)
        await osint.setAbuseIpKey(abuseCtrl.text.trim());
      if (vtCtrl.text.trim().isNotEmpty)
        await osint.setVirusTotalKey(vtCtrl.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OSINT API keys saved'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    Future<void> clearCache() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Clear STIX Cache?'),
          content: const Text(
            'ATT\u0026CK data will be re-parsed on next launch (a few seconds).',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Clear'),
            ),
          ],
        ),
      );
      if (confirmed == true) {
        final repo =
            ref.read(attackTechniqueRepositoryProvider)
                as AttackTechniqueRepositoryImpl;
        await repo.clearCache();
        OsintService().clearSessionCache();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cache cleared'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }

    Future<void> resetOnboarding() async {
      await storage.write('hasCompletedOnboarding', false);
      if (context.mounted) context.go('/onboarding');
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
        children: [
          // ── Organisation ───────────────────────────────────────────────
          const _SectionLabel('Organisation'),
          _Card(
            children: [
              _EditTile(
                icon: Icons.business_outlined,
                label: 'Organisation',
                value: orgName.value.isEmpty ? 'Tap to set' : orgName.value,
                onTap: () => _editDialog(
                  context,
                  'Organisation Name',
                  orgName.value,
                  (v) async {
                    await storage.write('org_name', v);
                    orgName.value = v;
                  },
                ),
              ),
              const Divider(height: 1, indent: 48),
              _EditTile(
                icon: Icons.category_outlined,
                label: 'Industry Sector',
                value: sector.value.isEmpty ? 'Tap to set' : sector.value,
                onTap: () => _editDialog(
                  context,
                  'Industry Sector',
                  sector.value,
                  (v) async {
                    await storage.write('org_sector', v);
                    sector.value = v;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Gemini AI ──────────────────────────────────────────────────
          const _SectionLabel('AI Settings — Gemini'),
          _InfoBanner(
            'Required for AI explanations, report narratives, and simulation analysis. '
            'Get a free key at aistudio.google.com → Get API key.',
            color: cs.primaryContainer,
          ),
          const SizedBox(height: 8),
          _Card(
            children: [
              _ApiKeyTile(
                label: 'Gemini API Key',
                controller: geminiCtrl,
                visible: showKeys.value,
                onToggle: () => showKeys.value = !showKeys.value,
                status: geminiStatus.value,
                onSave: saveGeminiKey,
                onTest: testGeminiKey,
                isTesting: isTesting.value,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── OSINT APIs ─────────────────────────────────────────────────
          const _SectionLabel('OSINT Intelligence APIs'),
          _InfoBanner(
            'Optional. When configured, technique detail pages show live threat intelligence '
            'from AlienVault OTX (campaigns), NVD (CVEs), AbuseIPDB (IP lookup), '
            'and VirusTotal (IOC analysis). All free tier.',
            color: cs.secondaryContainer,
          ),
          const SizedBox(height: 8),
          _Card(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OsintKeyField(
                      label: 'AlienVault OTX Key',
                      hint: 'From otx.alienvault.com',
                      controller: otxCtrl,
                      show: showKeys.value,
                    ),
                    const SizedBox(height: 10),
                    _OsintKeyField(
                      label: 'AbuseIPDB Key',
                      hint: 'From abuseipdb.com/api',
                      controller: abuseCtrl,
                      show: showKeys.value,
                    ),
                    const SizedBox(height: 10),
                    _OsintKeyField(
                      label: 'VirusTotal Key',
                      hint: 'From virustotal.com',
                      controller: vtCtrl,
                      show: showKeys.value,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Spacer(),
                        FilledButton.icon(
                          icon: const Icon(Icons.save_outlined, size: 15),
                          label: const Text('Save OSINT Keys'),
                          onPressed: saveOsintKeys,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'NVD/CVE data (NIST) requires no key — it is always available.',
                      style: TextStyle(fontSize: 11, color: cs.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Data & Cache ────────────────────────────────────────────────
          const _SectionLabel('Data & Cache'),
          _Card(
            children: [
              _ActionTile(
                icon: Icons.cleaning_services_outlined,
                label: 'Clear STIX & OSINT Cache',
                subtitle:
                    'Force re-parse of ATT\u0026CK data + reset session OSINT cache',
                onTap: clearCache,
              ),
              const Divider(height: 1, indent: 48),
              _ActionTile(
                icon: Icons.refresh_rounded,
                label: 'Reset Setup Wizard',
                subtitle: 'Run onboarding again to update org profile',
                onTap: resetOnboarding,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── About ───────────────────────────────────────────────────────
          const _SectionLabel('About'),
          const _Card(
            children: [
              _InfoTile(
                icon: Icons.shield_rounded,
                label: 'App',
                value: 'ATT\u0026CK Shield',
              ),
              Divider(height: 1, indent: 48),
              _InfoTile(
                icon: Icons.dataset_outlined,
                label: 'MITRE Data',
                value: 'Enterprise ATT\u0026CK v14.5',
              ),
              Divider(height: 1, indent: 48),
              _InfoTile(
                icon: Icons.auto_awesome_rounded,
                label: 'AI Engine',
                value: 'Gemini 1.5 Flash',
              ),
              Divider(height: 1, indent: 48),
              _InfoTile(
                icon: Icons.radar_rounded,
                label: 'OSINT Sources',
                value: 'OTX · NVD · AbuseIPDB · VT',
              ),
              Divider(height: 1, indent: 48),
              _InfoTile(
                icon: Icons.code_rounded,
                label: 'Framework',
                value: 'Flutter + Riverpod',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _editDialog(
    BuildContext context,
    String label,
    String current,
    Future<void> Function(String) onSave,
  ) async {
    final ctrl = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, ctrl.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) await onSave(result.trim());
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: .4,
      ),
    ),
  );
}

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String text;
  final Color color;
  const _InfoBanner(this.text, {required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(.35),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 0.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: 14,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

class _EditTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final VoidCallback? onTap;
  const _EditTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 18, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
            Text(value, style: TextStyle(fontSize: 13, color: cs.outline)),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.chevron_right_rounded, size: 16, color: cs.outline),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(value, style: TextStyle(fontSize: 13, color: cs.outline)),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final VoidCallback onTap;
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 18, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14)),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: cs.outline),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 16, color: cs.outline),
          ],
        ),
      ),
    );
  }
}

class _ApiKeyTile extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool visible, isTesting;
  final String? status;
  final VoidCallback onToggle, onSave, onTest;
  const _ApiKeyTile({
    required this.label,
    required this.controller,
    required this.visible,
    required this.isTesting,
    required this.status,
    required this.onToggle,
    required this.onSave,
    required this.onTest,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: !visible,
            style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
            decoration: InputDecoration(
              hintText: 'API key...',
              border: const OutlineInputBorder(),
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(
                  visible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
                onPressed: onToggle,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: isTesting
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.wifi_tethering_rounded, size: 15),
                  label: const Text('Test'),
                  onPressed: isTesting ? null : onTest,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.save_outlined, size: 15),
                  label: const Text('Save'),
                  onPressed: onSave,
                ),
              ),
            ],
          ),
          if (status != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  status == 'valid'
                      ? Icons.check_circle_outline_rounded
                      : status == 'saved'
                      ? Icons.save_rounded
                      : Icons.error_outline_rounded,
                  size: 14,
                  color: status == 'invalid' ? cs.error : Colors.green.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  status == 'valid'
                      ? 'Key is working ✓'
                      : status == 'saved'
                      ? 'Saved. Tap Test to verify.'
                      : 'Invalid — check and retry.',
                  style: TextStyle(
                    fontSize: 12,
                    color: status == 'invalid'
                        ? cs.error
                        : Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _OsintKeyField extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final bool show;
  const _OsintKeyField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.show,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: !show,
          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
