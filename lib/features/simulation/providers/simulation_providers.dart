// lib/features/simulation/providers/simulation_providers.dart
//
// Simulation state management using Riverpod

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:attackshield/shared/models/simulation_scenario.dart';
import 'package:attackshield/shared/models/simulation_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

/// Pre-built scenarios for testing and learning
final preBuiltScenariosProvider = FutureProvider<List<SimulationScenario>>((
  ref,
) async {
  try {
    return _getDefaultScenarios();
  } catch (e) {
    if (kDebugMode) print('Error loading scenarios: $e');
    return [];
  }
});

List<SimulationScenario> _getDefaultScenarios() {
  return [
    SimulationScenario(
      id: 'phishing_001',
      name: 'Phishing Attack Detection',
      description: 'Identify and respond to a phishing email campaign.',
      relatedTechniques: ['T1566.001', 'T1566.002'],
      objectives: 'Detect phishing emails before users click malicious links',
      expectedOutcomes: 'Understand email gateway detection and user training',
      createdAt: DateTime.now(),
    ),
    SimulationScenario(
      id: 'ransomware_001',
      name: 'Ransomware Encryption Response',
      description:
          'Detect and contain a ransomware attack spreading across your network.',
      relatedTechniques: ['T1566.001', 'T1204.002', 'T1486', 'T1570'],
      objectives: 'Respond quickly to ransomware detection',
      expectedOutcomes:
          'Understand backup strategies and network containment procedures',
      createdAt: DateTime.now(),
    ),
    SimulationScenario(
      id: 'lateral_movement_001',
      name: 'Lateral Movement Detection',
      description: 'Identify an attacker moving across your network.',
      relatedTechniques: ['T1078', 'T1570', 'T1021.002'],
      objectives: 'Detect lateral movement activity',
      expectedOutcomes: 'Understand EDR and network monitoring capabilities',
      createdAt: DateTime.now(),
    ),
  ];
}

/// Current simulation session
final currentSimulationSessionProvider =
    StateNotifierProvider<SessionNotifier, AsyncValue<SimulationSession?>>((
      ref,
    ) {
      return SessionNotifier();
    });

class SessionNotifier extends StateNotifier<AsyncValue<SimulationSession?>> {
  SessionNotifier() : super(const AsyncValue.data(null));

  Future<void> startSimulation(String scenarioId, String orgId) async {
    try {
      state = const AsyncValue.loading();
      final session = SimulationSession(
        id: const Uuid().v4(),
        scenarioId: scenarioId,
        organizationId: orgId,
        startedAt: DateTime.now(),
        status: 'in_progress',
      );
      state = AsyncValue.data(session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> completeSimulation(String sessionId) async {
    try {
      final current = state.maybeWhen(
        data: (session) => session,
        orElse: () => null,
      );
      if (current != null) {
        final completed = current.copyWith(
          completedAt: DateTime.now(),
          status: 'completed',
        );
        state = AsyncValue.data(completed);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Simulation history
final simulationHistoryProvider =
    FutureProvider.family<List<SimulationResult>, String>((ref, orgId) async {
      try {
        final box = GetStorage();
        final results = <SimulationResult>[];
        final keys = box.getKeys();

        for (final key in keys) {
          if (key.toString().startsWith('result_')) {
            final json = box.read(key);
            if (json != null) {
              final result = SimulationResult.fromJson(
                json as Map<String, dynamic>,
              );
              results.add(result);
            }
          }
        }

        results.sort((a, b) => b.testedAt.compareTo(a.testedAt));
        return results;
      } catch (e) {
        return [];
      }
    });

/// Simple session model
class SimulationSession {
  final String id;
  final String scenarioId;
  final String organizationId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;

  SimulationSession({
    required this.id,
    required this.scenarioId,
    required this.organizationId,
    required this.startedAt,
    this.completedAt,
    required this.status,
  });

  SimulationSession copyWith({
    String? id,
    String? scenarioId,
    String? organizationId,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
  }) {
    return SimulationSession(
      id: id ?? this.id,
      scenarioId: scenarioId ?? this.scenarioId,
      organizationId: organizationId ?? this.organizationId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'scenarioId': scenarioId,
    'organizationId': organizationId,
    'startedAt': startedAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'status': status,
  };

  factory SimulationSession.fromJson(Map<String, dynamic> json) =>
      SimulationSession(
        id: json['id'] as String? ?? '',
        scenarioId: json['scenarioId'] as String? ?? '',
        organizationId: json['organizationId'] as String? ?? '',
        startedAt:
            DateTime.tryParse(json['startedAt'] as String? ?? '') ??
            DateTime.now(),
        completedAt: json['completedAt'] != null
            ? DateTime.tryParse(json['completedAt'] as String)
            : null,
        status: json['status'] as String? ?? 'in_progress',
      );
}
