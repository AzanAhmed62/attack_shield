// lib/data/repositories/simulation_repository.dart
// NEW FILE — uses existing SimulationScenario + SimulationResult models.
// Also stores SimulationHistoryEntry for the history tab chart.

import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../shared/models/simulation_scenario.dart';
import '../../shared/models/simulation_result.dart';
import '../../features/simulations/presentation/models/simulation_history_entry.dart';
import '../services/local_storage_service.dart';

const _kResultsKey  = 'simulation_results_v1';
const _kHistoryKey  = 'simulation_history_v1';

abstract class SimulationRepository {
  Future<List<SimulationResult>>       getAllResults();
  Future<void>                         saveResult(SimulationResult result);
  Future<List<SimulationHistoryEntry>> getSimulationHistory();
  Future<void>                         saveSimulationResult(SimulationHistoryEntry entry);
  Future<void>                         clearHistory();
}

class SimulationRepositoryImpl implements SimulationRepository {
  final LocalStorageService storage;
  SimulationRepositoryImpl(this.storage);

  final _box = GetStorage();

  // ── SimulationResult ────────────────────────────────────────────────────────
  @override
  Future<List<SimulationResult>> getAllResults() async {
    try {
      final raw = _box.read<String>(_kResultsKey);
      if (raw == null) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(SimulationResult.fromJson).toList();
    } catch (_) { return []; }
  }

  @override
  Future<void> saveResult(SimulationResult result) async {
    final all = await getAllResults();
    all.insert(0, result);
    await _box.write(_kResultsKey,
        jsonEncode(all.take(50).map((r) => r.toJson()).toList()));
  }

  // ── SimulationHistoryEntry (for history chart) ──────────────────────────────
  @override
  Future<List<SimulationHistoryEntry>> getSimulationHistory() async {
    try {
      final raw = _box.read<String>(_kHistoryKey);
      if (raw == null || raw.isEmpty) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(_entryFromJson).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } catch (_) { return []; }
  }

  @override
  Future<void> saveSimulationResult(SimulationHistoryEntry entry) async {
    final existing = await getSimulationHistory();
    existing.insert(0, entry);
    await _box.write(_kHistoryKey,
        jsonEncode(existing.take(50).map(_entryToJson).toList()));
  }

  @override
  Future<void> clearHistory() async {
    await _box.remove(_kHistoryKey);
    await _box.remove(_kResultsKey);
  }

  Map<String, dynamic> _entryToJson(SimulationHistoryEntry e) => {
    'scenarioName':    e.scenarioName,
    'scenarioIcon':    e.scenarioIcon,
    'totalTechniques': e.totalTechniques,
    'readiness':       e.readiness,
    'timestamp':       e.timestamp.toIso8601String(),
  };

  SimulationHistoryEntry _entryFromJson(Map<String, dynamic> m) =>
    SimulationHistoryEntry(
      scenarioName:    m['scenarioName']    as String,
      scenarioIcon:    m['scenarioIcon']    as String,
      totalTechniques: m['totalTechniques'] as int,
      readiness:       (m['readiness']      as num).toDouble(),
      timestamp:       DateTime.parse(m['timestamp'] as String),
    );
}
