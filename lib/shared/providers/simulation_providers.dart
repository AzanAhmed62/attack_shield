import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'simulation_providers.g.dart';

@Riverpod()
Future<List<SimulationScenario>> allSimulationScenarios(
  AllSimulationScenariosRef ref,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getAllScenarios();
}

@Riverpod()
Future<List<SimulationResult>> allSimulationResults(
  AllSimulationResultsRef ref,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getAllResults();
}

@Riverpod()
Future<Map<String, int>> simulationReadiness(SimulationReadinessRef ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.overallReadiness();
}

@Riverpod()
Future<int> totalScenariosPassed(TotalScenariosPassedRef ref) async {
  final readiness = await ref.watch(simulationReadinessProvider.future);
  return readiness['passed'] ?? 0;
}

@Riverpod()
Future<int> totalScenariosFailed(TotalScenariosFailedRef ref) async {
  final readiness = await ref.watch(simulationReadinessProvider.future);
  return readiness['failed'] ?? 0;
}

@Riverpod()
Future<int> totalScenariosPartiallyPassed(
  TotalScenariosPartiallyPassedRef ref,
) async {
  final readiness = await ref.watch(simulationReadinessProvider.future);
  return readiness['partiallyPassed'] ?? 0;
}

@Riverpod()
Future<double> readinessPercentage(ReadinessPercentageRef ref) async {
  final readiness = await ref.watch(simulationReadinessProvider.future);
  final total =
      (readiness['notTested'] ?? 0) +
      (readiness['passed'] ?? 0) +
      (readiness['failed'] ?? 0) +
      (readiness['partiallyPassed'] ?? 0);

  if (total == 0) return 0.0;

  final tested =
      (readiness['passed'] ?? 0) + (readiness['partiallyPassed'] ?? 0);
  return (tested / total) * 100;
}

@Riverpod()
Future<void> createSimulationScenario(
  CreateSimulationScenarioRef ref,
  SimulationScenario scenario,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.createScenario(scenario);
  ref.invalidate(allSimulationScenariosProvider);
}

@Riverpod()
Future<void> createSimulationResult(
  CreateSimulationResultRef ref,
  SimulationResult result,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.createResult(result);
  ref.invalidate(allSimulationResultsProvider);
  ref.invalidate(simulationReadinessProvider);
}

@Riverpod()
Future<void> deleteSimulationScenario(
  DeleteSimulationScenarioRef ref,
  String id,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.deleteScenario(id);
  ref.invalidate(allSimulationScenariosProvider);
}

@Riverpod()
Future<List<SimulationResult>> resultsByScenario(
  ResultsByScenarioRef ref,
  String scenarioId,
) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getResultsByScenario(scenarioId);
}
