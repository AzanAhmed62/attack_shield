import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'technique_providers.g.dart';

// Techniques List
@Riverpod(keepAlive: true)
Future<List<AttackTechnique>> allTechniques(AllTechniquesRef ref) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getAllTechniques();
}

// Tactics List
@Riverpod(keepAlive: true)
Future<List<AttackTactic>> allTactics(AllTacticsRef ref) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getAllTactics();
}

// Selected Tactic Filter
@Riverpod(keepAlive: false)
class SelectedTactic extends _$SelectedTactic {
  @override
  String build() => '';
}

// Search Query
@Riverpod(keepAlive: false)
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';
}

// Selected Severity Filter
@Riverpod()
int selectedSeverity(SelectedSeverityRef ref) => 0;

// Filtered Techniques based on search and filters
@Riverpod()
Future<List<AttackTechnique>> filteredTechniques(
  FilteredTechniquesRef ref,
) async {
  final allTechs = await ref.watch(allTechniquesProvider.future);
  final selectedTactic = ref.watch(selectedTacticProvider);
  final query = ref.watch(searchQueryProvider);

  var result = allTechs;

  // Filter by tactic
  if (selectedTactic.isNotEmpty) {
    result = result.where((t) => t.tactics.contains(selectedTactic)).toList();
  }

  // Search by query
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    result = result
        .where(
          (t) =>
              t.name.toLowerCase().contains(lowerQuery) ||
              t.id.toLowerCase().contains(lowerQuery) ||
              t.description.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  return result;
}

// Get single technique
@Riverpod()
Future<AttackTechnique?> techniqueById(TechniqueByIdRef ref, String id) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getTechniqueById(id);
}

// Get techniques by tactic
@Riverpod()
Future<List<AttackTechnique>> techniquesByTactic(
  TechniquesByTacticRef ref,
  String tacticId,
) async {
  final repository = ref.watch(attackTechniqueRepositoryProvider);
  return repository.getTechniquesByTactic(tacticId);
}
