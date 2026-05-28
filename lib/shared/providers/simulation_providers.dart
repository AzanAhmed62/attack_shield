// lib/shared/providers/simulation_providers.dart
// NEW FILE — simulation history provider moved OUT of simulations_screen.dart
// (codegen can't live in a screen file). Also exposes saveSimulationResult.

import 'package:attackshield/shared/models/simulation_history_entry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'repository_providers.dart';

part 'simulation_providers.g.dart';

// ─── History list ─────────────────────────────────────────────────────────────
@riverpod
Future<List<SimulationHistoryEntry>> simulationHistory(Ref ref) async {
  final repo = ref.watch(simulationRepositoryProvider);
  return repo.getSimulationHistory();
}

// ─── Save a result and refresh ────────────────────────────────────────────────
@riverpod
Future<void> saveSimulationResult(
  Ref ref,
  SimulationHistoryEntry entry,
) async {
  final repo = ref.read(simulationRepositoryProvider);
  await repo.saveSimulationResult(entry);
  ref.invalidate(simulationHistoryProvider);
}