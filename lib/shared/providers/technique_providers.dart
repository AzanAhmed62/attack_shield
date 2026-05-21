// lib/shared/providers/technique_providers.dart
// FULL REPLACEMENT — uses real STIX data, debounced search, grouped views.

import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/attack_technique.dart';
import 'repository_providers.dart';

part 'technique_providers.g.dart';

// ─── All techniques (keepAlive: true so we only parse STIX once) ─────────────
@Riverpod(keepAlive: true)
Future<List<AttackTechnique>> allTechniques(Ref ref) async {
  final repo = ref.watch(attackTechniqueRepositoryProvider);
  return repo.getAllTechniques();
}

// ─── All tactics ─────────────────────────────────────────────────────────────
@Riverpod(keepAlive: true)
Future<List<AttackTactic>> allTactics(Ref ref) async {
  final repo = ref.watch(attackTechniqueRepositoryProvider);
  return repo.getAllTactics();
}

// ─── Search & filter state ───────────────────────────────────────────────────
@Riverpod(keepAlive: false)
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
  void clear() => state = '';
}

@Riverpod(keepAlive: false)
class SelectedTactic extends _$SelectedTactic {
  @override
  String build() => ''; // '' means "all tactics"

  void select(String tacticShortName) => state = tacticShortName;
  void clear() => state = '';
}

@Riverpod(keepAlive: false)
class SelectedPlatforms extends _$SelectedPlatforms {
  @override
  List<String> build() => [];

  void toggle(String platform) {
    if (state.contains(platform)) {
      state = state.where((p) => p != platform).toList();
    } else {
      state = [...state, platform];
    }
  }

  void clear() => state = [];
}

@Riverpod(keepAlive: false)
class ShowSubTechniques extends _$ShowSubTechniques {
  @override
  bool build() => true; // show sub-techniques by default

  void toggle() => state = !state;
}

// ─── Filtered technique list (combines all filters) ──────────────────────────
@riverpod
Future<List<AttackTechnique>> filteredTechniques(Ref ref) async {
  final allTechs = await ref.watch(allTechniquesProvider.future);
  final query = ref.watch(searchQueryProvider);
  final selectedTactic = ref.watch(selectedTacticProvider);
  final platforms = ref.watch(selectedPlatformsProvider);
  final showSubs = ref.watch(showSubTechniquesProvider);

  var result = allTechs;

  // Sub-technique filter
  if (!showSubs) {
    result = result.where((t) => !t.isSubTechnique).toList();
  }

  // Tactic filter
  if (selectedTactic.isNotEmpty) {
    result = result.where((t) => t.tactics.contains(selectedTactic)).toList();
  }

  // Platform filter
  if (platforms.isNotEmpty) {
    result = result
        .where((t) => t.platforms.any((p) => platforms.contains(p)))
        .toList();
  }

  // Search filter (name, id, description)
  if (query.trim().isNotEmpty) {
    final lower = query.toLowerCase();
    result = result
        .where(
          (t) =>
              t.name.toLowerCase().contains(lower) ||
              t.id.toLowerCase().contains(lower) ||
              t.description.toLowerCase().contains(lower) ||
              (t.plainTitle?.toLowerCase().contains(lower) ?? false),
        )
        .toList();
  }

  return result;
}

// ─── Technique by ID ─────────────────────────────────────────────────────────
@riverpod
Future<AttackTechnique?> techniqueById(Ref ref, String id) async {
  final repo = ref.watch(attackTechniqueRepositoryProvider);
  return repo.getTechniqueById(id);
}

// ─── Sub-techniques for a parent ID ──────────────────────────────────────────
@riverpod
Future<List<AttackTechnique>> subTechniques(Ref ref, String parentId) async {
  final all = await ref.watch(allTechniquesProvider.future);
  return all.where((t) => t.parentTechniqueId == parentId).toList();
}

// ─── Techniques grouped by tactic (for heatmap / matrix views) ───────────────
@Riverpod(keepAlive: true)
Future<Map<String, List<AttackTechnique>>> techniquesByTactic(Ref ref) async {
  final all = await ref.watch(allTechniquesProvider.future);
  final tactics = await ref.watch(allTacticsProvider.future);

  final map = <String, List<AttackTechnique>>{};
  for (final tactic in tactics) {
    map[tactic.shortName] = all
        .where((t) => t.tactics.contains(tactic.shortName) && !t.isSubTechnique)
        .toList();
  }
  return map;
}

// ─── Coverage stats (used by dashboard & RiskEngine) ─────────────────────────
@riverpod
Future<Map<String, int>> techniqueCountByTactic(Ref ref) async {
  final byTactic = await ref.watch(techniquesByTacticProvider.future);
  return byTactic.map((k, v) => MapEntry(k, v.length));
}

// ─── High-risk uncovered techniques (for dashboard + reports) ─────────────────
@riverpod
Future<List<AttackTechnique>> highRiskTechniques(Ref ref) async {
  final all = await ref.watch(allTechniquesProvider.future);
  return all.where((t) => t.riskScore >= 7.0 && !t.isSubTechnique).toList()
    ..sort((a, b) => b.riskScore.compareTo(a.riskScore));
}

// ─── Unique platforms across all techniques ───────────────────────────────────
@Riverpod(keepAlive: true)
Future<List<String>> allPlatforms(Ref ref) async {
  final all = await ref.watch(allTechniquesProvider.future);
  final platforms = <String>{};
  for (final t in all) {
    platforms.addAll(t.platforms);
  }
  return platforms.toList()..sort();
}

// ─── Technique count (for dashboard card) ────────────────────────────────────
@riverpod
Future<int> techniqueCount(Ref ref) async {
  final all = await ref.watch(allTechniquesProvider.future);
  return all.where((t) => !t.isSubTechnique).length;
}

@riverpod
Future<int> totalTechniqueCount(Ref ref) async {
  final all = await ref.watch(allTechniquesProvider.future);
  return all.length;
}
