import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/services/ai_service.dart';

class ThreatIntelMapperScreen extends ConsumerStatefulWidget {
  const ThreatIntelMapperScreen({super.key});

  @override
  ConsumerState<ThreatIntelMapperScreen> createState() =>
      _ThreatIntelMapperScreenState();
}

class _ThreatIntelMapperScreenState
    extends ConsumerState<ThreatIntelMapperScreen> {
  final _textCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapperState = ref.watch(threatIntelMapperStateProvider);
    final hasKey = ref.watch(apiKeyConfiguredProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Threat Intel Mapper'),
        actions: [
          if (mapperState?.hasValue == true)
            TextButton(
              onPressed: () {
                ref.read(threatIntelMapperStateProvider.notifier).reset();
                _textCtrl.clear();
              },
              child: const Text('New'),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header card ───────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Threat Intelligence Mapper',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Paste any threat intel text — news article, CVE, CISA advisory — and get ATT&CK technique mappings.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (!hasKey) ...[
              _NoKeyCard(),
            ] else if (mapperState == null) ...[
              // ── Input form ─────────────────────────────────────────
              _InputSection(
                controller: _textCtrl,
                onAnalyse: () {
                  if (_textCtrl.text.trim().length < 50) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please paste at least 50 characters of threat intel text.',
                        ),
                      ),
                    );
                    return;
                  }
                  ref
                      .read(threatIntelMapperStateProvider.notifier)
                      .analyse(_textCtrl.text.trim());
                },
              ),
            ] else ...[
              mapperState.when(
                loading: () => const _LoadingCard(),
                error: (e, _) => _ErrorCard(error: e.toString()),
                data: (result) => _ResultSection(
                  result: result,
                  isSaving: _saving,
                  onCreateAlert: () => _createAlert(context, result),
                  onViewTechnique: (id) => context.push('/technique/$id'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _createAlert(
    BuildContext context,
    ThreatIntelResult result,
  ) async {
    setState(() => _saving = true);
    try {
      final priority = switch (result.severityLevel) {
        'Critical' => AlertPriority.critical,
        'High' => AlertPriority.high,
        'Low' => AlertPriority.low,
        _ => AlertPriority.medium,
      };

      final relatedId = result.mappedTechniques.isNotEmpty
          ? result.mappedTechniques.first.techniqueId
          : null;

      final alert = AlertItem(
        id: const Uuid().v4(),
        title: result.alertTitle,
        description: result.summary,
        priority: priority,
        status: AlertStatus.open,
        source: 'AI Threat Intel Mapper',
        relatedTechniqueId: relatedId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        notes:
            'Threat actor: ${result.threatActor}\nMapped techniques: ${result.mappedTechniques.map((m) => m.techniqueId).join(', ')}\n\nRecommendations:\n${result.recommendedActions.map((r) => '• $r').join('\n')}',
      );

      await ref.read(createAlertProvider(alert).future);

      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Alert "${alert.title}" created'),
            backgroundColor: AppTheme.successColor,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  context.push('/alerts');
                }
              },
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

// ─── Input section ────────────────────────────────────────────────────────────

class _InputSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAnalyse;

  const _InputSection({required this.controller, required this.onAnalyse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paste Threat Intelligence',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Examples: CISA advisories, security blog posts, CVE descriptions, vendor bulletins, incident reports.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText:
                'Paste threat intelligence text here…\n\nExample: "CISA and FBI have released an advisory about ransomware group X targeting healthcare organizations using spearphishing emails (T1566) and exploiting unpatched VPN vulnerabilities…"',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.auto_awesome, size: 16),
            label: const Text('Analyse & Map to ATT&CK'),
            onPressed: onAnalyse,
          ),
        ),
        const SizedBox(height: 12),
        // Example chips
        Text('Try an example:', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _ExampleChip(
              label: 'Ransomware advisory',
              text:
                  'A ransomware group has been targeting healthcare organizations by sending spearphishing emails with malicious PDF attachments. After initial access, they use PowerShell to download additional payloads, establish persistence via registry run keys, disable Windows Defender, dump LSASS credentials, move laterally via RDP, and finally deploy ransomware that encrypts all files and deletes shadow copies.',
              controller: controller,
            ),
            _ExampleChip(
              label: 'Supply chain attack',
              text:
                  'Attackers compromised a widely-used software update mechanism to distribute malware to thousands of organizations. The initial compromise involved stealing developer credentials via credential phishing, then modifying the build pipeline to inject malicious code into signed software packages distributed to customers.',
              controller: controller,
            ),
          ],
        ),
      ],
    );
  }
}

class _ExampleChip extends StatelessWidget {
  final String label;
  final String text;
  final TextEditingController controller;

  const _ExampleChip({
    required this.label,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      avatar: const Icon(Icons.bolt, size: 14),
      onPressed: () => controller.text = text,
    );
  }
}

// ─── Loading card ─────────────────────────────────────────────────────────────

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Claude is analysing the threat intelligence and mapping to ATT&CK techniques…',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Error card ───────────────────────────────────────────────────────────────

class _ErrorCard extends StatelessWidget {
  final String error;
  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: AppTheme.dangerColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error,
                style: const TextStyle(color: AppTheme.dangerColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── No API key card ──────────────────────────────────────────────────────────

class _NoKeyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.key, color: AppTheme.warningColor),
                SizedBox(width: 8),
                Text(
                  'API Key Required',
                  style: TextStyle(
                    color: AppTheme.warningColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Add your Anthropic API key in Settings → AI Settings to use this feature.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.settings, size: 16),
              label: const Text('Go to Settings'),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Result section ───────────────────────────────────────────────────────────

class _ResultSection extends StatelessWidget {
  final ThreatIntelResult result;
  final bool isSaving;
  final VoidCallback onCreateAlert;
  final ValueChanged<String> onViewTechnique;

  const _ResultSection({
    required this.result,
    required this.isSaving,
    required this.onCreateAlert,
    required this.onViewTechnique,
  });

  Color get _severityColor {
    switch (result.severityLevel) {
      case 'Critical':
        return AppTheme.dangerColor;
      case 'High':
        return AppTheme.accentColor;
      case 'Low':
        return AppTheme.successColor;
      default:
        return AppTheme.warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Summary ───────────────────────────────────────────────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        result.alertTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _severityColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        result.severityLevel,
                        style: TextStyle(
                          color: _severityColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  result.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Threat Actor: ${result.threatActor}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                if (result.targetedSectors.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: result.targetedSectors
                        .map(
                          (s) => Chip(
                            label: Text(
                              s,
                              style: const TextStyle(fontSize: 11),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── Mapped techniques ─────────────────────────────────────────
        Text(
          'Mapped ATT&CK Techniques (${result.mappedTechniques.length})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...result.mappedTechniques.map(
          (m) => _MappedTechCard(
            mapped: m,
            onTap: () => onViewTechnique(m.techniqueId),
          ),
        ),
        const SizedBox(height: 12),

        // ── Recommendations ───────────────────────────────────────────
        if (result.recommendedActions.isNotEmpty) ...[
          Text(
            'Recommended Actions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...result.recommendedActions.asMap().entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppTheme.primaryColor,
                    child: Text(
                      '${e.key + 1}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // ── Action buttons ────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                : const Icon(Icons.add_alert, size: 16),
            label: const Text('Create Alert from This Intel'),
            onPressed: isSaving ? null : onCreateAlert,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.auto_awesome, size: 12, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              'Mapped by Claude AI · Always verify before acting',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

class _MappedTechCard extends StatelessWidget {
  final MappedTechnique mapped;
  final VoidCallback onTap;

  const _MappedTechCard({required this.mapped, required this.onTap});

  Color get _confidenceColor {
    switch (mapped.confidence) {
      case 'high':
        return AppTheme.dangerColor;
      case 'medium':
        return AppTheme.warningColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Confidence indicator
              Container(
                width: 4,
                height: 52,
                decoration: BoxDecoration(
                  color: _confidenceColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mapped.techniqueId,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _confidenceColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${mapped.confidence} confidence',
                            style: TextStyle(
                              color: _confidenceColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mapped.techniqueName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mapped.evidence,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
