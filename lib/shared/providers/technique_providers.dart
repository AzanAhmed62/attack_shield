import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'technique_providers.g.dart';

// ─── Raw data providers ───────────────────────────────────────────────────────

/// All techniques — cached in repository, won't refetch on every watch.
@Riverpod(keepAlive: true)
Future<List<AttackTechnique>> allTechniques(Ref ref) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getAllTechniques();
}

/// All tactics.
@Riverpod(keepAlive: true)
Future<List<AttackTactic>> allTactics(Ref ref) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getAllTactics();
}

// ─── Filter state providers ───────────────────────────────────────────────────

/// Currently selected tactic filter (empty string = all tactics).
@Riverpod(keepAlive: false)
class SelectedTactic extends _$SelectedTactic {
  @override
  String build() => '';

  void select(String tactic) => state = tactic;
  void clear() => state = '';
}

/// Search query for the technique library.
@Riverpod(keepAlive: false)
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
  void clear() => state = '';
}

/// Selected platform filter (empty = all platforms).
@Riverpod(keepAlive: false)
class SelectedPlatform extends _$SelectedPlatform {
  @override
  String build() => '';

  void select(String platform) => state = platform;
  void clear() => state = '';
}

/// Minimum risk score filter (0.0 = no filter).
@Riverpod(keepAlive: false)
class MinRiskFilter extends _$MinRiskFilter {
  @override
  double build() => 0.0;

  void setMin(double value) => state = value;
  void clear() => state = 0.0;
}

// ─── Computed / filtered providers ───────────────────────────────────────────

/// Techniques filtered by tactic, search query, platform, and risk score.
@Riverpod()
Future<List<AttackTechnique>> filteredTechniques(Ref ref) async {
  final allTechs = await ref.watch(allTechniquesProvider.future);
  final selectedTactic = ref.watch(selectedTacticProvider);
  final query = ref.watch(searchQueryProvider);
  final selectedPlatform = ref.watch(selectedPlatformProvider);
  final minRisk = ref.watch(minRiskFilterProvider);

  var result = allTechs;

  if (selectedTactic.isNotEmpty) {
    result = result
        .where(
          (t) => t.tactics.any(
            (tac) => tac.toLowerCase() == selectedTactic.toLowerCase(),
          ),
        )
        .toList();
  }

  if (selectedPlatform.isNotEmpty) {
    result = result
        .where(
          (t) => t.platforms.any(
            (p) => p.toLowerCase() == selectedPlatform.toLowerCase(),
          ),
        )
        .toList();
  }

  if (minRisk > 0.0) {
    result = result.where((t) => t.riskScore >= minRisk).toList();
  }

  if (query.isNotEmpty) {
    final q = query.toLowerCase();
    result = result
        .where(
          (t) =>
              t.name.toLowerCase().contains(q) ||
              t.id.toLowerCase().contains(q) ||
              t.description.toLowerCase().contains(q) ||
              t.tactics.any((tac) => tac.toLowerCase().contains(q)),
        )
        .toList();
  }

  return result;
}

/// Single technique by ID (includes sub-techniques).
@Riverpod()
Future<AttackTechnique?> techniqueById(Ref ref, String id) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getTechniqueById(id);
}

/// Techniques belonging to a specific tactic.
@Riverpod()
Future<List<AttackTechnique>> techniquesByTactic(
  Ref ref,
  String tacticName,
) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getTechniquesByTactic(tacticName);
}

/// Top N highest-risk techniques (default 10). Used on dashboard and reports.
@Riverpod()
Future<List<AttackTechnique>> topRiskTechniques(
  Ref ref, {
  int limit = 10,
}) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getHighRiskTechniques(limit: limit);
}

/// Techniques count per tactic — used for coverage heatmap.
/// Returns a map of { tacticName: techniqueCount }
@Riverpod(keepAlive: true)
Future<Map<String, int>> techniqueCountByTactic(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final counts = <String, int>{};

  for (final t in techniques) {
    for (final tac in t.tactics) {
      counts[tac] = (counts[tac] ?? 0) + 1;
    }
  }

  return counts;
}

/// All unique platforms across all techniques.
@Riverpod(keepAlive: true)
Future<List<String>> allPlatforms(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final platforms = <String>{};
  for (final t in techniques) {
    platforms.addAll(t.platforms);
  }
  final sorted = platforms.toList()..sort();
  return sorted;
}

/// Total sub-technique count across all techniques.
@Riverpod(keepAlive: true)
Future<int> totalSubTechniqueCount(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  return techniques.fold<int>(0, (sum, t) => sum + t.subTechniques.length);
}
