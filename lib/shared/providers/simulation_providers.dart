import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/features/simulations/presentation/screens/simulations_screen.dart';
import 'repository_providers.dart';

part 'simulation_providers.g.dart';

/// Get simulation history (past executed simulations)
@Riverpod(keepAlive: false)
Future<List<SimulationHistoryEntry>> simulationHistory(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  return repository.getSimulationHistory();
}

/// Save a simulation result to history
@Riverpod(keepAlive: false)
Future<void> saveSimulationResult(Ref ref, SimulationHistoryEntry entry) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.saveSimulationResult(entry);
  ref.invalidate(simulationHistoryProvider);
}

/// Clear all simulation history
@Riverpod(keepAlive: false)
Future<void> clearSimulationHistory(Ref ref) async {
  final repository = ref.watch(simulationRepositoryProvider);
  await repository.clearHistory();
  ref.invalidate(simulationHistoryProvider);
}

/// Total number of past simulations
@Riverpod(keepAlive: false)
Future<int> totalSimulationsRun(Ref ref) async {
  final history = await ref.watch(simulationHistoryProvider.future);
  return history.length;
}

/// Average readiness from all past simulations
@Riverpod(keepAlive: false)
Future<double> averageReadinessFromHistory(Ref ref) async {
  final history = await ref.watch(simulationHistoryProvider.future);
  if (history.isEmpty) return 0.0;
  final sum = history.fold<double>(0, (acc, e) => acc + e.readiness);
  return sum / history.length;
}
