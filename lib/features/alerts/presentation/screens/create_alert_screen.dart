// lib/features/alerts/presentation/screens/create_alert_screen.dart
// FIX: uses ref.read(alertActionsProvider.notifier).create() instead of
// broken createAlertProvider family pattern.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../shared/models/security_alert.dart';
import '../../../../shared/providers/alert_providers.dart';
import '../../../../shared/providers/technique_providers.dart';

class CreateAlertScreen extends HookConsumerWidget {
  const CreateAlertScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleCtrl  = useTextEditingController();
    final descCtrl   = useTextEditingController();
    final sourceCtrl = useTextEditingController();
    final severity   = useState('medium');
    final linkedTech = useState<String?>(null);
    final isSaving   = useState(false);
    final formKey    = useMemoized(GlobalKey<FormState>.new);

    final allTechsAsync = ref.watch(allTechniquesProvider);
    final cs = Theme.of(context).colorScheme;

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      isSaving.value = true;
      try {
        final alert = SecurityAlert(
          id:               const Uuid().v4(),
          title:            titleCtrl.text.trim(),
          description:      descCtrl.text.trim(),
          severity:         severity.value,
          source:           sourceCtrl.text.trim().isEmpty ? 'Manual' : sourceCtrl.text.trim(),
          linkedTechniqueId: linkedTech.value,
          createdAt:        DateTime.now(),
          isRead:           false,
          status:           'open',
        );
        // FIX: use AlertActions notifier
        await ref.read(alertActionsProvider.notifier).create(alert);
        if (context.mounted) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Alert created'), behavior: SnackBarBehavior.floating));
        }
      } finally {
        isSaving.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Alert'),
        backgroundColor: cs.surface,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: isSaving.value ? null : save,
              child: isSaving.value
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save'),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Alert Title *',
                hintText:  'e.g. Suspicious PowerShell execution detected',
                border:    OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 14),

            Text('Severity', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: ['critical','high','medium','low'].map((s) {
              final selected = severity.value == s;
              final color    = s == 'critical' ? Colors.red.shade600 : s == 'high' ? Colors.orange.shade600 : s == 'medium' ? Colors.amber.shade600 : Colors.blue.shade600;
              return ChoiceChip(
                label: Text(s[0].toUpperCase() + s.substring(1)),
                selected: selected,
                selectedColor: color.withOpacity(.15),
                labelStyle: TextStyle(color: selected ? color : cs.onSurface, fontWeight: selected ? FontWeight.w600 : FontWeight.normal),
                side: BorderSide(color: selected ? color : cs.outlineVariant, width: selected ? 1.5 : 0.5),
                onSelected: (_) => severity.value = s,
              );
            }).toList()),
            const SizedBox(height: 14),

            TextFormField(
              controller: descCtrl, maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText:  'What was observed? What triggered this alert?',
                border:    OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),

            TextFormField(
              controller: sourceCtrl,
              decoration: const InputDecoration(
                labelText: 'Source',
                hintText:  'e.g. SIEM, EDR, Manual investigation',
                border:    OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),

            Text('Link to Technique (optional)', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            allTechsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error:   (_, __) => const SizedBox.shrink(),
              data: (techs) {
                final parents = techs.where((t) => !t.isSubTechnique).toList();
                return DropdownButtonFormField<String>(
                  value: linkedTech.value,
                  decoration: const InputDecoration(hintText: 'Select a MITRE technique', border: OutlineInputBorder()),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(value: null, child: Text('None')),
                    ...parents.take(200).map((t) => DropdownMenuItem(
                      value: t.id,
                      child: Text('${t.id} — ${t.name}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                    )),
                  ],
                  onChanged: (v) => linkedTech.value = v,
                );
              },
            ),
            const SizedBox(height: 24),
            if (linkedTech.value != null)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: cs.primaryContainer.withOpacity(.4), borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  Icon(Icons.link_rounded, size: 14, color: cs.primary),
                  const SizedBox(width: 6),
                  Text('Alert will appear in technique detail for ${linkedTech.value}',
                    style: TextStyle(fontSize: 11, color: cs.onSurface)),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}