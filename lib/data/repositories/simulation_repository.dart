// lib/data/repositories/simulation_repository.dart
// FIX: imports SimulationHistoryEntry from its extracted model file,
// not from simulations_screen.dart (which would be a circular import).

import 'dart:convert';
import 'package:attackshield/shared/models/simulation_history_entry.dart';
import 'package:get_storage/get_storage.dart';

import '../services/local_storage_service.dart';

const _kHistoryKey = 'simulation_history_v1';

abstract class SimulationRepository {
  Future<List<SimulationHistoryEntry>> getSimulationHistory();
  Future<void> saveSimulationResult(SimulationHistoryEntry entry);
  Future<void> clearHistory();
}

class SimulationRepositoryImpl implements SimulationRepository {
  // ignore: unused_field
  final LocalStorageService _storage;
  SimulationRepositoryImpl(this._storage);

  final _box = GetStorage();

  @override
  Future<List<SimulationHistoryEntry>> getSimulationHistory() async {
    try {
      final raw = _box.read<String>(_kHistoryKey);
      if (raw == null || raw.isEmpty) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(_fromJson).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveSimulationResult(SimulationHistoryEntry entry) async {
    final existing = await getSimulationHistory();
    existing.insert(0, entry);
    final trimmed = existing.take(50).toList(); // keep last 50
    await _box.write(_kHistoryKey, jsonEncode(trimmed.map(_toJson).toList()));
  }

  @override
  Future<void> clearHistory() async => _box.remove(_kHistoryKey);

  Map<String, dynamic> _toJson(SimulationHistoryEntry e) => {
    'scenarioName':     e.scenarioName,
    'scenarioIcon':     e.scenarioIcon,
    'totalTechniques':  e.totalTechniques,
    'readiness':        e.readiness,
    'timestamp':        e.timestamp.toIso8601String(),
  };

  SimulationHistoryEntry _fromJson(Map<String, dynamic> m) =>
    SimulationHistoryEntry(
      scenarioName:    m['scenarioName']    as String,
      scenarioIcon:    m['scenarioIcon']    as String,
      totalTechniques: m['totalTechniques'] as int,
      readiness:       (m['readiness']      as num).toDouble(),
      timestamp:       DateTime.parse(m['timestamp'] as String),
    );
}