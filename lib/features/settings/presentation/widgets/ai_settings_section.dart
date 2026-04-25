import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';

/// Drop this widget inside the Settings screen's ListView
/// to provide the Google Gemini API key configuration UI.
class AISettingsSection extends ConsumerStatefulWidget {
  const AISettingsSection({super.key});

  @override
  ConsumerState<AISettingsSection> createState() => _AISettingsSectionState();
}

class _AISettingsSectionState extends ConsumerState<AISettingsSection> {
  final _keyCtrl = TextEditingController();
  bool _obscure = true;
  bool _saving = false;

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasKey = ref.watch(apiKeyConfiguredProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'AI Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hasKey ? AppTheme.successColor : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hasKey ? 'Gemini AI connected' : 'No API key configured',
                      style: TextStyle(
                        color: hasKey ? AppTheme.successColor : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  hasKey
                      ? 'AI features are enabled: Technique Explainer, Threat Intel Mapper, Coverage Advisor, Simulation Debrief, and Natural Language Search.'
                      : 'Enter your Google Gemini API key to enable AI-powered features. Get one at ai.google.dev.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 14),

                // Key input
                if (!hasKey) ...[
                  TextField(
                    controller: _keyCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Google Gemini API Key',
                      hintText: 'AIza... or AQ...',
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: _saving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : const Icon(Icons.save, size: 16),
                      label: const Text('Save API Key'),
                      onPressed: _saving
                          ? null
                          : () async {
                              final key = _keyCtrl.text.trim();
                              if ((!key.startsWith('AIza') &&
                                      !key.startsWith('AQ')) ||
                                  key.length < 20) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Invalid API key format. Gemini keys start with AIza or AQ',
                                    ),
                                    backgroundColor: AppTheme.dangerColor,
                                  ),
                                );
                                return;
                              }
                              setState(() => _saving = true);
                              await ref
                                  .read(apiKeyConfiguredProvider.notifier)
                                  .saveKey(key);
                              if (mounted) {
                                setState(() => _saving = false);
                                _keyCtrl.clear();
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'API key saved. AI features are now enabled.',
                                    ),
                                    backgroundColor: AppTheme.successColor,
                                  ),
                                );
                              }
                            },
                    ),
                  ),
                ] else ...[
                  // Features enabled list
                  const SizedBox(height: 4),
                  const _FeatureRow(
                    Icons.auto_awesome,
                    'Technique Explainer — on every technique detail screen',
                  ),
                  const _FeatureRow(
                    Icons.map,
                    'Threat Intel Mapper — paste any threat text → ATT&CK IDs',
                  ),
                  const _FeatureRow(
                    Icons.shield,
                    'Coverage Advisor — personalised recommendations in Reports',
                  ),
                  const _FeatureRow(
                    Icons.science,
                    'Simulation Debrief — AI debrief after each exercise',
                  ),
                  const _FeatureRow(
                    Icons.search,
                    'Natural Language Search — in the technique library',
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.delete_sweep_outlined,
                            size: 14,
                          ),
                          label: const Text('Clear Cache'),
                          onPressed: () => _clearCache(context),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: AppTheme.dangerColor,
                          ),
                          label: const Text(
                            'Remove Key',
                            style: TextStyle(color: AppTheme.dangerColor),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.dangerColor),
                          ),
                          onPressed: () => _confirmRemove(context),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12),
                // Privacy note
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '🔒 Your API key is stored locally on your device only. Data is sent to the Google Gemini API only when you explicitly tap an AI feature button.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _clearCache(BuildContext context) {
    final aiService = ref.read(aiServiceProvider);
    aiService.clearCache();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI response cache cleared. Responses will be fresh.'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remove API Key?'),
        content: const Text(
          'This will disable all AI features. You can add a new key at any time.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppTheme.dangerColor),
            onPressed: () async {
              if (mounted) {
                //  ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
              await ref.read(apiKeyConfiguredProvider.notifier).clearKey();
              if (mounted) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('API key removed')),
                );
              }
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureRow(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.successColor, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
