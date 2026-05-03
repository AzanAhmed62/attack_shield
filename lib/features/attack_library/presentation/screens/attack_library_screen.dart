// lib/features/attack_library/presentation/screens/attack_library_screen.dart
//
// Replaces the MVP hardcoded list with live MITRE STIX data.
// Shows all 1000+ techniques + sub-techniques with tactic filter,
// live search, plain/expert mode toggle, and full detail view.

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
final _searchQueryProvider     = StateProvider<String>((ref) => '');

// ═══════════════════════════════════════════════════════════════
// ATTACK LIBRARY SCREEN
// ═══════════════════════════════════════════════════════════════

class AttackLibraryScreen extends ConsumerWidget {
  const AttackLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final query   = ref.watch(_searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(appMode == AppMode.expertMode
            ? 'ATT&CK Library'
            : '🛡️ Threat Library'),
        actions: [
          _ModeToggleButton(appMode: appMode),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _SearchBar(),
        ),
      ),
      body: Column(
        children: [
          _TacticFilterRow(),
          Expanded(
            child: query.isNotEmpty
                ? _SearchResultsList()
                : _TechniqueList(),
          ),
        ],
      ),
    );
  }
}

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
        onPressed: () => ref
            .read(organizationProfileV2Provider.notifier)
            .toggleAppMode(),
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search techniques… (e.g. "phishing", "T1566")',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ref.watch(_searchQueryProvider).isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () =>
                      ref.read(_searchQueryProvider.notifier).state = '',
                )
              : null,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
        ),
        onChanged: (v) => ref.read(_searchQueryProvider.notifier).state = v,
      ),
    );
  }
}

class _TacticFilterRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tactics = ref.watch(allTacticsProvider);
    final selected = ref.watch(_selectedTacticProvider);

    return tactics.when(
      loading: () => const SizedBox(height: 40,
          child: Center(child: LinearProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (tacticList) {
        return SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FilterChip(
                  label: const Text('All'),
                  selected: selected == null,
                  onSelected: (_) =>
                      ref.read(_selectedTacticProvider.notifier).state = null,
                ),
              ),
              ...tacticList.map((tac) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FilterChip(
                  label: Text(tac.name),
                  selected: selected == tac.shortname,
                  onSelected: (_) {
                    ref.read(_selectedTacticProvider.notifier).state =
                        selected == tac.shortname ? null : tac.shortname;
                  },
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}

class _TechniqueList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTactic = ref.watch(_selectedTacticProvider);
    final appMode        = ref.watch(appModeProvider);

    final techsAsync = selectedTactic != null
        ? ref.watch(techniquesByTacticProvider(selectedTactic))
        : ref.watch(allTechniquesProvider);

    return techsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:   (e, _) => Center(child: Text('Error: $e')),
      data: (techniques) {
        final displayed = selectedTactic == null
            ? techniques.where((t) => !t.isSubTechnique).toList()
            : techniques;

        if (displayed.isEmpty) {
          return const Center(child: Text('No techniques found'));
        }

        return ListView.separated(
          itemCount: displayed.length,
          separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
          itemBuilder: (context, index) {
            final tech = displayed[index];
            return _TechniqueListTile(
              technique: tech,
              isPlainMode: appMode == AppMode.plainLanguageMode,
            );
          },
        );
      },
    );
  }
}

class _SearchResultsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query   = ref.watch(_searchQueryProvider);
    final appMode = ref.watch(appModeProvider);
    final results = ref.watch(searchTechniquesProvider(query));

    return results.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:   (e, _) => Center(child: Text('Error: $e')),
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: techniques.length,
                separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
                itemBuilder: (context, index) => _TechniqueListTile(
                  technique: techniques[index],
                  isPlainMode: appMode == AppMode.plainLanguageMode,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TechniqueListTile extends ConsumerWidget {
  final StixTechnique technique;
  final bool isPlainMode;

  const _TechniqueListTile({
    required this.technique,
    required this.isPlainMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCount = ref
        .watch(subTechniquesForParentProvider(technique.attackId ?? ''))
        .maybeWhen(data: (l) => l.length, orElse: () => 0);

    return ListTile(
      leading: _TacticColorDot(
        tacticShortname: technique.tacticShortnames.isNotEmpty
            ? technique.tacticShortnames.first
            : '',
      ),
      title: Text(
        technique.name,
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
          if (subCount > 0) ...[
            const SizedBox(width: 8),
            Chip(
              label: Text('$subCount sub',
                  style: const TextStyle(fontSize: 10)),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(
        '/library/${Uri.encodeComponent(technique.attackId ?? technique.id)}',
      ),
    );
  }
}

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
      'reconnaissance':       Color(0xFF9E9E9E),
      'resource-development': Color(0xFF78909C),
      'initial-access':       Color(0xFFE53935),
      'execution':            Color(0xFFD81B60),
      'persistence':          Color(0xFF8E24AA),
      'privilege-escalation': Color(0xFF3949AB),
      'defense-evasion':      Color(0xFF1E88E5),
      'credential-access':    Color(0xFF00ACC1),
      'discovery':            Color(0xFF00897B),
      'lateral-movement':     Color(0xFF43A047),
      'collection':           Color(0xFF7CB342),
      'command-and-control':  Color(0xFFFB8C00),
      'exfiltration':         Color(0xFFF4511E),
      'impact':               Color(0xFF6D4C41),
    };
    return colors[shortname] ?? Colors.grey;
  }
}

class TechniqueDetailScreen extends ConsumerWidget {
  final String attackId;
  const TechniqueDetailScreen({super.key, required this.attackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final techAsync = ref.watch(techniqueByAttackIdProvider(attackId));

    return techAsync.when(
      loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (tech) {
        if (tech == null) {
          return Scaffold(
              body: Center(child: Text('Technique $attackId not found')));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(tech.attackId ?? 'Technique'),
            elevation: 0,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tech.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        children: tech.tacticShortnames
                            .map((t) =>
                                Chip(label: Text(t),
                                    visualDensity: VisualDensity.compact))
                            .toList(),
                      ),
                      const SizedBox(height: 24),

                      // Description
                      if (tech.description != null) ...[
                        Text('Description',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(tech.description!),
                        const SizedBox(height: 24),
                      ],

                      // Detection
                      if (tech.detection != null) ...[
                        Text('Detection',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(tech.detection!),
                        const SizedBox(height: 24),
                      ],

                      // Platforms
                      if (tech.platforms.isNotEmpty) ...[
                        Text('Platforms',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: tech.platforms
                              .map((p) => Chip(label: Text(p),
                                  visualDensity: VisualDensity.compact))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Sub-Techniques
                      _SubTechniquesSection(parentAttackId: attackId),
                      const SizedBox(height: 24),

                      // Threat Groups
                      _ThreatGroupsSection(attackId: attackId),
                      const SizedBox(height: 24),

                      // Mitigations
                      _MitigationsSection(attackId: attackId),
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

class _SubTechniquesSection extends ConsumerWidget {
  final String parentAttackId;
  const _SubTechniquesSection({required this.parentAttackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subs = ref.watch(subTechniquesForParentProvider(parentAttackId));

    return subs.when(
      loading: () => const SizedBox.shrink(),
      error:   (_, __) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sub-Techniques (${list.length})',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...list.map((sub) => ListTile(
                  dense: true,
                  title: Text(sub.name, style: const TextStyle(fontSize: 13)),
                  subtitle: Text(sub.attackId ?? ''),
                  onTap: () => context.push(
                    '/library/${Uri.encodeComponent(sub.attackId ?? sub.id)}',
                  ),
                )),
          ],
        );
      },
    );
  }
}

class _ThreatGroupsSection extends ConsumerWidget {
  final String attackId;
  const _ThreatGroupsSection({required this.attackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(threatGroupsForTechniqueProvider(attackId));

    return groups.when(
      loading: () => const SizedBox.shrink(),
      error:   (_, __) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Threat Groups (${list.length})',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: list
                  .take(10)
                  .map((g) => Chip(label: Text(g.name,
                      style: const TextStyle(fontSize: 12))))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class _MitigationsSection extends ConsumerWidget {
  final String attackId;
  const _MitigationsSection({required this.attackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mits = ref.watch(mitigationsForTechniqueProvider(attackId));

    return mits.when(
      loading: () => const SizedBox.shrink(),
      error:   (_, __) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mitigations (${list.length})',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...list
                .take(5)
                .map((m) => ListTile(
                      title: Text(m.name),
                      subtitle: m.description != null
                          ? Text(m.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis)
                          : null,
                    )),
          ],
        );
      },
    );
  }
}
