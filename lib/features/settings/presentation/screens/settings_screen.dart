// lib/features/settings/presentation/screens/settings_screen.dart
// FULL REPLACEMENT — Gemini API key config, cache management, org info, about.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/services/gemini_service.dart';
import '../../../../data/repositories/attack_technique_repository.dart';
import '../../../../shared/providers/repository_providers.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage       = GetStorage();
    final orgName       = useState(storage.read<String>('org_name') ?? '');
    final sector        = useState(storage.read<String>('org_sector') ?? '');
    final apiKeyCtrl    = useTextEditingController(text: GeminiService().apiKey ?? '');
    final apiKeyVisible = useState(false);
    final apiKeyStatus  = useState<String?>(null); // null | 'saved' | 'valid' | 'invalid'
    final isTesting     = useState(false);
    final cs            = Theme.of(context).colorScheme;

    Future<void> saveApiKey() async {
      final key = apiKeyCtrl.text.trim();
      if (key.isEmpty) return;
      await GeminiService().setApiKey(key);
      apiKeyStatus.value = 'saved';
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('API key saved'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ));
      }
    }

    Future<void> testApiKey() async {
      isTesting.value = true;
      apiKeyStatus.value = null;
      try {
        final result = await GeminiService().generate(
          prompt: 'Reply with only the word: OK',
          maxTokens: 10,
        );
        apiKeyStatus.value = result.isSuccess ? 'valid' : 'invalid';
      } finally {
        isTesting.value = false;
      }
    }

    Future<void> clearCache() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Clear STIX Cache?'),
          content: const Text(
            'MITRE ATT&CK data will be re-parsed on the next launch. '
            'This takes a few seconds.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true),
                child: const Text('Clear')),
          ],
        ),
      );
      if (confirmed == true) {
        final repo = ref.read(attackTechniqueRepositoryProvider)
            as AttackTechniqueRepositoryImpl;
        await repo.clearCache();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Cache cleared — re-parsing on next launch'),
            behavior: SnackBarBehavior.floating,
          ));
        }
      }
    }

    Future<void> resetOnboarding() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Reset Onboarding?'),
          content: const Text('You will be taken through the setup wizard again.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true),
                child: const Text('Reset')),
          ],
        ),
      );
      if (confirmed == true) {
        await storage.write('hasCompletedOnboarding', false);
        if (context.mounted) context.go('/onboarding');
      }
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text('Settings',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
        children: [

          // ── Organisation ───────────────────────────────────────────────
          _SectionHeader('Organisation'),
          _Card(children: [
            _InfoTile(
              icon: Icons.business_outlined, label: 'Organisation',
              value: orgName.value.isEmpty ? 'Tap to set' : orgName.value,
              onTap: () => _editDialog(context, 'Organisation Name',
                  orgName.value, (v) async {
                await storage.write('org_name', v);
                orgName.value = v;
              }),
            ),
            const Divider(height: 1, indent: 48),
            _InfoTile(
              icon: Icons.category_outlined, label: 'Industry Sector',
              value: sector.value.isEmpty ? 'Tap to set' : sector.value,
              onTap: () => _editDialog(context, 'Industry Sector',
                  sector.value, (v) async {
                await storage.write('org_sector', v);
                sector.value = v;
              }),
            ),
          ]),
          const SizedBox(height: 20),

          // ── AI / Gemini ─────────────────────────────────────────────────
          _SectionHeader('AI Settings'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withOpacity(.35),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cs.primary.withOpacity(.2)),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.info_outline_rounded, size: 15, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(child: Text(
                'AI features (plain-English explanations, report narratives, '
                'simulation analysis) require a Gemini API key. '
                'Get one free at aistudio.google.com → Get API key.',
                style: TextStyle(fontSize: 12, color: cs.onSurface, height: 1.4),
              )),
            ]),
          ),
          _Card(children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Gemini API Key',
                  style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.w500, color: cs.onSurface)),
                const SizedBox(height: 8),
                TextField(
                  controller:  apiKeyCtrl,
                  obscureText: !apiKeyVisible.value,
                  style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: 'AIzaSy...',
                    border:   const OutlineInputBorder(),
                    isDense:  true,
                    suffixIcon: IconButton(
                      icon: Icon(apiKeyVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined, size: 18),
                      onPressed: () =>
                          apiKeyVisible.value = !apiKeyVisible.value,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: isTesting.value
                        ? const SizedBox(width: 14, height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.wifi_tethering_rounded, size: 15),
                      label: const Text('Test'),
                      onPressed: isTesting.value ? null : testApiKey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.icon(
                      icon:  const Icon(Icons.save_outlined, size: 15),
                      label: const Text('Save'),
                      onPressed: saveApiKey,
                    ),
                  ),
                ]),
                if (apiKeyStatus.value != null) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(
                      apiKeyStatus.value == 'valid'
                        ? Icons.check_circle_outline_rounded
                        : apiKeyStatus.value == 'saved'
                          ? Icons.save_rounded
                          : Icons.error_outline_rounded,
                      size: 14,
                      color: apiKeyStatus.value == 'invalid'
                          ? cs.error : Colors.green.shade600,
                    ),
                    const SizedBox(width: 6),
                    Expanded(child: Text(
                      apiKeyStatus.value == 'valid'
                        ? 'API key is working ✓'
                        : apiKeyStatus.value == 'saved'
                          ? 'Saved. Tap Test to verify.'
                          : 'Invalid key — check and retry.',
                      style: TextStyle(fontSize: 12,
                        color: apiKeyStatus.value == 'invalid'
                            ? cs.error : Colors.green.shade600),
                    )),
                  ]),
                ],
              ]),
            ),
          ]),
          const SizedBox(height: 20),

          // ── Data ────────────────────────────────────────────────────────
          _SectionHeader('Data & Cache'),
          _Card(children: [
            _ActionTile(
              icon:     Icons.cleaning_services_outlined,
              label:    'Clear STIX Cache',
              subtitle: 'Force re-parse of ATT&CK data on next launch',
              onTap:    clearCache,
            ),
            const Divider(height: 1, indent: 48),
            _ActionTile(
              icon:     Icons.refresh_rounded,
              label:    'Reset Setup Wizard',
              subtitle: 'Run onboarding again to update org profile',
              onTap:    resetOnboarding,
            ),
          ]),
          const SizedBox(height: 20),

          // ── About ───────────────────────────────────────────────────────
          _SectionHeader('About'),
          _Card(children: [
            _InfoTile(icon: Icons.shield_rounded,
                label: 'App', value: 'ATT&CK Shield'),
            const Divider(height: 1, indent: 48),
            _InfoTile(icon: Icons.dataset_outlined,
                label: 'MITRE Data', value: 'Enterprise ATT&CK v14.5'),
            const Divider(height: 1, indent: 48),
            _InfoTile(icon: Icons.auto_awesome_rounded,
                label: 'AI Engine', value: 'Gemini 1.5 Flash'),
            const Divider(height: 1, indent: 48),
            _InfoTile(icon: Icons.code_rounded,
                label: 'Framework', value: 'Flutter + Riverpod'),
          ]),
        ],
      ),
    );
  }

  Future<void> _editDialog(
    BuildContext context, String label, String current,
    Future<void> Function(String) onSave,
  ) async {
    final ctrl   = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: ctrl, autofocus: true,
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, ctrl.text),
              child: const Text('Save')),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) await onSave(result.trim());
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary, letterSpacing: 0.4)),
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

class _InfoTile extends StatelessWidget {
  final IconData icon; final String label, value; final VoidCallback? onTap;
  const _InfoTile({required this.icon, required this.label,
      required this.value, this.onTap});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(value, style: TextStyle(fontSize: 13, color: cs.outline)),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, size: 16, color: cs.outline),
          ],
        ]),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon; final String label, subtitle; final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.label,
      required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: cs.outline)),
            ])),
          Icon(Icons.chevron_right_rounded, size: 16, color: cs.outline),
        ]),
      ),
    );
  }
}