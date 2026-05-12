// lib/features/attack_library/presentation/screens/attack_library_screen.dart
//
// Replaces the MVP hardcoded list with live MITRE STIX data.
// Shows all 1000+ techniques + sub-techniques with tactic filter,
// live search, plain/expert mode toggle, and full detail view.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/services/mitre_stix_data_service.dart';
import 'package:attackshield/shared/providers/mitre_data_providers.dart';
import 'package:attackshield/shared/providers/plain_language_providers.dart';

// ═══════════════════════════════════════════════════════════════
// STATE: selected tactic filter + search query
// ═══════════════════════════════════════════════════════════════

final _selectedTacticProvider = StateProvider<String?>((ref) => null);
final _searchQueryProvider = StateProvider<String>((ref) => '');

// ═══════════════════════════════════════════════════════════════
// ATTACK LIBRARY SCREEN
// ═══════════════════════════════════════════════════════════════

class AttackLibraryScreen extends ConsumerWidget {
  const AttackLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final query = ref.watch(_searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appMode == AppMode.expertMode
              ? 'ATT&CK Library'
              : '🛡️ Threat Library',
        ),
        actions: [
          // Mode toggle chip
          _ModeToggleButton(appMode: appMode),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _SearchBar(),
        ),
      ),
      body: Column(
        children: [
          // Tactic filter chips
          _TacticFilterRow(),
          // Technique list
          Expanded(
            child: query.isNotEmpty ? _SearchResultsList() : _TechniqueList(),
          ),
        ],
      ),
    );
  }
}

// ─── mode toggle ──────────────────────────────────────────────

class _ModeToggleButton extends ConsumerWidget {
  final AppMode appMode;
  const _ModeToggleButton({required this.appMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlain = appMode == AppMode.plainLanguageMode;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ActionChip(
        avatar: Text(isPlain ? '📱' : '🔧'),
        label: Text(isPlain ? 'Plain' : 'Expert'),
        onPressed: () =>
            ref.read(organizationProfileV2Provider.notifier).toggleAppMode(),
      ),
    );
  }
}

// ─── search bar ───────────────────────────────────────────────

class _SearchBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(_searchQueryProvider));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(_searchQueryProvider);
    if (_controller.text != query) {
      _controller.value = _controller.value.copyWith(
        text: query,
        selection: TextSelection.collapsed(offset: query.length),
        composing: TextRange.empty,
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search techniques… (e.g. "phishing", "T1566")',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _debounce?.cancel();
                    _controller.clear();
                    ref.read(_searchQueryProvider.notifier).state = '';
                  },
                )
              : null,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
        ),
        onChanged: (value) {
          _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 250), () {
            ref.read(_searchQueryProvider.notifier).state = value.trim();
          });
        },
      ),
    );
  }
}

// ─── tactic filter ────────────────────────────────────────────

class _TacticFilterRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tactics = ref.watch(allTacticsProvider);
    final selected = ref.watch(_selectedTacticProvider);

    return tactics.when(
      loading: () => const SizedBox(
        height: 40,
        child: Center(child: LinearProgressIndicator()),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (tacticList) {
        return SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            children: [
              // "All" chip
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FilterChip(
                  label: const Text('All'),
                  selected: selected == null,
                  onSelected: (_) =>
                      ref.read(_selectedTacticProvider.notifier).state = null,
                ),
              ),
              ...tacticList.map(
                (tac) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text(tac.name),
                    selected: selected == tac.shortname,
                    onSelected: (_) {
                      ref.read(_selectedTacticProvider.notifier).state =
                          selected == tac.shortname ? null : tac.shortname;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── main technique list ──────────────────────────────────────

class _TechniqueList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTactic = ref.watch(_selectedTacticProvider);
    final appMode = ref.watch(appModeProvider);
    final allTechniques = ref.watch(allTechniquesAndSubsProvider).valueOrNull;
    final subTechniqueCounts = _buildSubTechniqueCounts(allTechniques);

    final techsAsync = selectedTactic != null
        ? ref.watch(techniquesByTacticProvider(selectedTactic))
        : ref.watch(allTechniquesProvider);

    return techsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (techniques) {
        // Show only top-level unless a tactic is selected
        final displayed = selectedTactic == null
            ? techniques.where((t) => !t.isSubTechnique).toList()
            : techniques;

        if (displayed.isEmpty) {
          return const Center(child: Text('No techniques found'));
        }

        return ListView.separated(
          itemCount: displayed.length,
          separatorBuilder: (_, _) => const Divider(height: 1, indent: 16),
          itemBuilder: (context, index) {
            final tech = displayed[index];
            return _TechniqueListTile(
              technique: tech,
              subTechniqueCount: subTechniqueCounts[tech.attackId] ?? 0,
              isPlainMode: appMode == AppMode.plainLanguageMode,
            );
          },
        );
      },
    );
  }
}

// ─── search results list ──────────────────────────────────────

class _SearchResultsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(_searchQueryProvider);
    final appMode = ref.watch(appModeProvider);
    final allTechniques = ref.watch(allTechniquesAndSubsProvider).valueOrNull;
    final subTechniqueCounts = _buildSubTechniqueCounts(allTechniques);
    final results = ref.watch(searchTechniquesProvider(query));

    return results.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (techniques) {
        if (techniques.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🔍', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text('No results for "$query"'),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                '${techniques.length} results for "$query"',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: techniques.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, indent: 16),
                itemBuilder: (context, index) => _TechniqueListTile(
                  technique: techniques[index],
                  subTechniqueCount:
                      subTechniqueCounts[techniques[index].attackId] ?? 0,
                  isPlainMode: appMode == AppMode.plainLanguageMode,
                  highlightQuery: query,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── technique list tile ──────────────────────────────────────

Map<String, int> _buildSubTechniqueCounts(List<StixTechnique>? techniques) {
  final counts = <String, int>{};
  if (techniques == null) {
    return counts;
  }

  for (final technique in techniques) {
    if (!technique.isSubTechnique) {
      continue;
    }

    final attackId = technique.attackId;
    if (attackId == null || !attackId.contains('.')) {
      continue;
    }

    final parentAttackId = attackId.split('.').first;
    counts[parentAttackId] = (counts[parentAttackId] ?? 0) + 1;
  }

  return counts;
}

class _TechniqueListTile extends StatelessWidget {
  final StixTechnique technique;
  final int subTechniqueCount;
  final bool isPlainMode;
  final String? highlightQuery;

  const _TechniqueListTile({
    required this.technique,
    required this.subTechniqueCount,
    required this.isPlainMode,
    this.highlightQuery,
  });

  @override
  Widget build(BuildContext context) {
    final plainName = _plainName(technique.attackId ?? '');

    return ListTile(
      leading: _TacticColorDot(
        tacticShortname: technique.tacticShortnames.isNotEmpty
            ? technique.tacticShortnames.first
            : '',
      ),
      title: Text(
        isPlainMode ? plainName : technique.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          if (technique.attackId != null)
            Text(
              technique.attackId!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          if (subTechniqueCount > 0) ...[
            const SizedBox(width: 8),
            Chip(
              label: Text(
                '$subTechniqueCount sub-techniques',
                style: const TextStyle(fontSize: 10),
              ),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.push(
          '/library/technique/${Uri.encodeComponent(technique.attackId ?? technique.id)}',
        );
      },
    );
  }

  String _plainName(String id) {
    const m = {
      'T1110': 'Someone Tries Many Passwords',
      'T1566': 'Fake Emails That Trick You',
      'T1486': 'Files Get Locked (Ransomware)',
      'T1078': 'Stolen or Default Passwords Used',
      'T1059': 'Attacker Runs Commands on Your System',
      'T1005': 'Your Data Gets Collected',
      'T1040': 'Network Traffic Is Listened To',
      'T1098': 'Account Permissions Changed',
      'T1570': 'Attacker Moves Across Your Network',
      'T1003': 'Passwords Stolen from Memory',
      'T1195': 'Trusted Software Is Compromised',
    };
    return m[id] ?? technique.name;
  }
}

// ─── tactic colour dot ────────────────────────────────────────

class _TacticColorDot extends StatelessWidget {
  final String tacticShortname;

  const _TacticColorDot({required this.tacticShortname});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: _tacticColor(tacticShortname),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _tacticColor(String shortname) {
    const colors = {
      'reconnaissance': Color(0xFF9E9E9E),
      'resource-development': Color(0xFF78909C),
      'initial-access': Color(0xFFE53935),
      'execution': Color(0xFFD81B60),
      'persistence': Color(0xFF8E24AA),
      'privilege-escalation': Color(0xFF3949AB),
      'defense-evasion': Color(0xFF1E88E5),
      'credential-access': Color(0xFF00ACC1),
      'discovery': Color(0xFF00897B),
      'lateral-movement': Color(0xFF43A047),
      'collection': Color(0xFF7CB342),
      'command-and-control': Color(0xFFFB8C00),
      'exfiltration': Color(0xFFF4511E),
      'impact': Color(0xFF6D4C41),
    };
    return colors[shortname] ?? Colors.grey;
  }
}

// ═══════════════════════════════════════════════════════════════
// TECHNIQUE DETAIL SCREEN
// Full STIX data: description, detection, APTs, malware,
// mitigations, sub-techniques, coverage status
// ═══════════════════════════════════════════════════════════════

class TechniqueDetailScreen extends ConsumerWidget {
  /// ATT&CK ID passed as route param, e.g. "T1566"
  final String attackId;

  const TechniqueDetailScreen({super.key, required this.attackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final techAsync = ref.watch(techniqueByAttackIdProvider(attackId));
    final appMode = ref.watch(appModeProvider);

    return techAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (tech) {
        if (tech == null) {
          return Scaffold(
            body: Center(child: Text('Technique $attackId not found')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _DetailAppBar(technique: tech, appMode: appMode),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ATT&CK ID + tactic badges
                      _TechniqueHeader(technique: tech),
                      const SizedBox(height: 20),

                      // Description
                      if (tech.description != null) ...[
                        _SectionTitle(
                          appMode == AppMode.plainLanguageMode
                              ? '📖 What It Means'
                              : 'Description',
                        ),
                        Text(tech.description!),
                        const SizedBox(height: 20),
                      ],

                      // Detection
                      if (tech.detection != null) ...[
                        _SectionTitle(
                          appMode == AppMode.plainLanguageMode
                              ? '🔍 How To Detect It'
                              : 'Detection',
                        ),
                        Text(tech.detection!),
                        const SizedBox(height: 20),
                      ],

                      // Platforms
                      if (tech.platforms.isNotEmpty) ...[
                        const _SectionTitle('Platforms'),
                        Wrap(
                          spacing: 6,
                          children: tech.platforms
                              .map(
                                (p) => Chip(
                                  label: Text(p),
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Sub-techniques
                      _SubTechniquesSection(
                        parentAttackId: attackId,
                        appMode: appMode,
                      ),
                      const SizedBox(height: 20),

                      // Threat groups (APTs)
                      _ThreatGroupsSection(
                        attackId: attackId,
                        appMode: appMode,
                      ),
                      const SizedBox(height: 20),

                      // Malware
                      _MalwareSection(attackId: attackId),
                      const SizedBox(height: 20),

                      // Mitigations
                      _MitigationsSection(attackId: attackId, appMode: appMode),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── detail app bar ───────────────────────────────────────────

class _DetailAppBar extends StatelessWidget {
  final StixTechnique technique;
  final AppMode appMode;

  const _DetailAppBar({required this.technique, required this.appMode});

  @override
  Widget build(BuildContext context) {
    final tacticShort = technique.tacticShortnames.isNotEmpty
        ? technique.tacticShortnames.first
        : '';

    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _tacticColor(tacticShort),
                _tacticColor(tacticShort).withValues(alpha: 0.7),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technique.attackId ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    technique.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _tacticColor(String s) {
    const m = {
      'initial-access': Color(0xFFE53935),
      'execution': Color(0xFFD81B60),
      'persistence': Color(0xFF8E24AA),
      'privilege-escalation': Color(0xFF3949AB),
      'defense-evasion': Color(0xFF1E88E5),
      'credential-access': Color(0xFF00ACC1),
      'discovery': Color(0xFF00897B),
      'lateral-movement': Color(0xFF43A047),
      'collection': Color(0xFF7CB342),
      'command-and-control': Color(0xFFFB8C00),
      'exfiltration': Color(0xFFF4511E),
      'impact': Color(0xFF6D4C41),
    };
    return m[s] ?? const Color(0xFF607D8B);
  }
}

// ─── technique header ─────────────────────────────────────────

class _TechniqueHeader extends StatelessWidget {
  final StixTechnique technique;
  const _TechniqueHeader({required this.technique});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: technique.tacticShortnames
          .map(
            (t) => Chip(
              label: Text(
                _tacticLabel(t),
                style: const TextStyle(fontSize: 11),
              ),
              visualDensity: VisualDensity.compact,
            ),
          )
          .toList(),
    );
  }

  String _tacticLabel(String s) {
    const m = {
      'initial-access': 'Initial Access',
      'execution': 'Execution',
      'persistence': 'Persistence',
      'privilege-escalation': 'Privilege Escalation',
      'defense-evasion': 'Defense Evasion',
      'credential-access': 'Credential Access',
      'discovery': 'Discovery',
      'lateral-movement': 'Lateral Movement',
      'collection': 'Collection',
      'command-and-control': 'C2',
      'exfiltration': 'Exfiltration',
      'impact': 'Impact',
      'reconnaissance': 'Recon',
      'resource-development': 'Resource Dev',
    };
    return m[s] ?? s;
  }
}

// ─── sub-techniques section ───────────────────────────────────

class _SubTechniquesSection extends ConsumerWidget {
  final String parentAttackId;
  final AppMode appMode;
  const _SubTechniquesSection({
    required this.parentAttackId,
    required this.appMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subs = ref.watch(subTechniquesForParentProvider(parentAttackId));

    return subs.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Sub-Techniques (${list.length})'),
            ...list.map(
              (sub) => ListTile(
                dense: true,
                leading: Text(
                  sub.attackId ?? '',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
                title: Text(sub.name, style: const TextStyle(fontSize: 13)),
                trailing: const Icon(Icons.chevron_right, size: 16),
                onTap: () => context.push(
                  '/library/technique/${Uri.encodeComponent(sub.attackId ?? sub.id)}',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── threat groups section ────────────────────────────────────

class _ThreatGroupsSection extends ConsumerWidget {
  final String attackId;
  final AppMode appMode;
  const _ThreatGroupsSection({required this.attackId, required this.appMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(threatGroupsForTechniqueProvider(attackId));

    return groups.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        final label = appMode == AppMode.plainLanguageMode
            ? '🚨 ${list.length} Hacker Groups Use This'
            : 'Threat Groups (${list.length})';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(label),
            if (appMode == AppMode.plainLanguageMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'These known hacker groups have used this technique in real attacks:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: list
                  .take(15)
                  .map(
                    (g) => ActionChip(
                      label: Text(g.name, style: const TextStyle(fontSize: 12)),
                      onPressed: () {},
                    ),
                  )
                  .toList(),
            ),
            if (list.length > 15)
              Text(
                '+ ${list.length - 15} more groups',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
          ],
        );
      },
    );
  }
}

// ─── malware section ──────────────────────────────────────────

class _MalwareSection extends ConsumerWidget {
  final String attackId;
  const _MalwareSection({required this.attackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final malwareList = ref.watch(malwareForTechniqueProvider(attackId));

    return malwareList.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Known Malware (${list.length})'),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: list
                  .take(10)
                  .map(
                    (m) => Chip(
                      label: Text(m.name, style: const TextStyle(fontSize: 11)),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.red.shade50,
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

// ─── mitigations section ──────────────────────────────────────

class _MitigationsSection extends ConsumerWidget {
  final String attackId;
  final AppMode appMode;
  const _MitigationsSection({required this.attackId, required this.appMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mits = ref.watch(mitigationsForTechniqueProvider(attackId));

    return mits.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        final label = appMode == AppMode.plainLanguageMode
            ? '✅ How To Protect Yourself (${list.length})'
            : 'Mitigations (${list.length})';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(label),
            ...list.map(
              (m) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (m.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        m.description!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── shared section title ─────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
