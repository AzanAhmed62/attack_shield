import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'simulation_providers.g.dart';

@Riverpod(keepAlive: false)
Future<List<SimulationScenario>> allSimulationScenarios(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getAllScenarios();
}

@Riverpod(keepAlive: false)
Future<List<SimulationResult>> allSimulationResults(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getAllResults();
}

@Riverpod(keepAlive: false)
Future<Map<String, int>> simulationReadiness(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.overallReadiness();
}

@Riverpod(keepAlive: false)
Future<double> readinessPercentage(Ref ref) async {
  final readiness = await ref.watch(simulationReadinessProvider.future);
  final total = (readiness['notTested'] ?? 0) +
      (readiness['passed'] ?? 0) +
      (readiness['failed'] ?? 0) +
      (readiness['partiallyPassed'] ?? 0);
  if (total == 0) return 0.0;
  final score =
      ((readiness['passed'] ?? 0) * 2) + (readiness['partiallyPassed'] ?? 0);
  return (score / (total * 2)) * 100.0;
}

@Riverpod(keepAlive: false)
Future<List<SimulationResult>> resultsByScenario(
    Ref ref, String scenarioId) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getResultsByScenario(scenarioId);
}

@Riverpod(keepAlive: false)
Future<void> createSimulationScenario(
    Ref ref, SimulationScenario scenario) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.createScenario(scenario);
  ref.invalidate(allSimulationScenariosProvider);
}

@Riverpod(keepAlive: false)
Future<void> createSimulationResult(
    Ref ref, SimulationResult result) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.createResult(result);
  ref.invalidate(allSimulationResultsProvider);
  ref.invalidate(simulationReadinessProvider);
  ref.invalidate(readinessPercentageProvider);
  ref.invalidate(resultsByScenarioProvider(result.scenarioId));
}

@Riverpod(keepAlive: false)
Future<void> deleteSimulationScenario(Ref ref, String id) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.deleteScenario(id);
  ref.invalidate(allSimulationScenariosProvider);
}

@Riverpod(keepAlive: false)
Future<void> clearAllSimulationData(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.clearAllScenarios();
  await repository.clearAllResults();
  ref.invalidate(allSimulationScenariosProvider);
  ref.invalidate(allSimulationResultsProvider);
  ref.invalidate(simulationReadinessProvider);
  ref.invalidate(readinessPercentageProvider);
}
