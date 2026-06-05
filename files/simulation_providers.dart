// lib/shared/providers/simulation_providers.dart
// NEW FILE — simulation providers extracted from simulations_screen.dart.
// @riverpod annotations cannot live inside a screen/widget file.

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/simulations/presentation/models/simulation_history_entry.dart';
import 'repository_providers.dart';

part 'simulation_providers.g.dart';

@riverpod
Future<List<SimulationHistoryEntry>> simulationHistory(Ref ref) async {
  final repo = ref.watch(simulationRepositoryProvider);
  return repo.getSimulationHistory();
}

@riverpod
Future<void> saveSimulationResult(
  Ref ref,
  SimulationHistoryEntry entry,
) async {
  await ref.read(simulationRepositoryProvider).saveSimulationResult(entry);
  ref.invalidate(simulationHistoryProvider);
}
