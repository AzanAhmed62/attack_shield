import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class SimulationRepository {
  Future<List<SimulationScenario>> getAllScenarios();
  Future<SimulationScenario?> getScenarioById(String id);
  Future<void> createScenario(SimulationScenario scenario);
  Future<void> updateScenario(SimulationScenario scenario);
  Future<void> deleteScenario(String id);
  Future<void> clearAllScenarios();

  Future<List<SimulationResult>> getAllResults();
  Future<SimulationResult?> getResultById(String id);
  Future<void> createResult(SimulationResult result);
  Future<void> updateResult(SimulationResult result);
  Future<void> clearAllResults();
  Future<List<SimulationResult>> getResultsByScenario(String scenarioId);
  Future<List<SimulationResult>> getResultsByTechnique(String techniqueId);

  Future<int> scenarioPassRate(String scenarioId);
  Future<Map<String, int>> overallReadiness();
}

class SimulationRepositoryImpl implements SimulationRepository {
  final LocalStorageService _storageService;
  static const String _scenariosKey = 'simulation_scenarios';
  static const String _resultsKey = 'simulation_results';

  SimulationRepositoryImpl(this._storageService);

  @override
  Future<List<SimulationScenario>> getAllScenarios() async {
    try {
      final scenariosJson = _storageService.read<List>(_scenariosKey) ?? [];
      return scenariosJson
          .map((e) => SimulationScenario.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch scenarios: $e');
    }
  }

  @override
  Future<SimulationScenario?> getScenarioById(String id) async {
    try {
      final scenarios = await getAllScenarios();
      try {
        return scenarios.firstWhere((s) => s.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw DataException(message: 'Failed to fetch scenario: $e');
    }
  }

  @override
  Future<void> createScenario(SimulationScenario scenario) async {
    try {
      final scenarios = await getAllScenarios();
      scenarios.add(scenario);
      await _storageService.write(
        _scenariosKey,
        scenarios.map((s) => s.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to create scenario: $e');
    }
  }

  @override
  Future<void> updateScenario(SimulationScenario scenario) async {
    try {
      final scenarios = await getAllScenarios();
      final index = scenarios.indexWhere((s) => s.id == scenario.id);
      if (index != -1) {
        scenarios[index] = scenario;
        await _storageService.write(
          _scenariosKey,
          scenarios.map((s) => s.toJson()).toList(),
        );
      }
    } catch (e) {
      throw DataException(message: 'Failed to update scenario: $e');
    }
  }

  @override
  Future<void> deleteScenario(String id) async {
    try {
      final scenarios = await getAllScenarios();
      scenarios.removeWhere((s) => s.id == id);
      await _storageService.write(
        _scenariosKey,
        scenarios.map((s) => s.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete scenario: $e');
    }
  }

  @override
  Future<void> clearAllScenarios() async {
    try {
      await _storageService.remove(_scenariosKey);
    } catch (e) {
      throw DataException(message: 'Failed to clear scenarios: $e');
    }
  }

  @override
  Future<List<SimulationResult>> getAllResults() async {
    try {
      final resultsJson = _storageService.read<List>(_resultsKey) ?? [];
      return resultsJson
          .map((e) => SimulationResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch results: $e');
    }
  }

  @override
  Future<SimulationResult?> getResultById(String id) async {
    try {
      final results = await getAllResults();
      try {
        return results.firstWhere((r) => r.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw DataException(message: 'Failed to fetch result: $e');
    }
  }

  @override
  Future<void> createResult(SimulationResult result) async {
    try {
      final results = await getAllResults();
      results.add(result);
      await _storageService.write(
        _resultsKey,
        results.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to create result: $e');
    }
  }

  @override
  Future<void> updateResult(SimulationResult result) async {
    try {
      final results = await getAllResults();
      final index = results.indexWhere((r) => r.id == result.id);
      if (index != -1) {
        results[index] = result;
        await _storageService.write(
          _resultsKey,
          results.map((r) => r.toJson()).toList(),
        );
      }
    } catch (e) {
      throw DataException(message: 'Failed to update result: $e');
    }
  }

  @override
  Future<void> clearAllResults() async {
    try {
      await _storageService.remove(_resultsKey);
    } catch (e) {
      throw DataException(message: 'Failed to clear simulation results: $e');
    }
  }

  @override
  Future<List<SimulationResult>> getResultsByScenario(String scenarioId) async {
    try {
      final results = await getAllResults();
      return results.where((r) => r.scenarioId == scenarioId).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch results for scenario: $e');
    }
  }

  @override
  Future<List<SimulationResult>> getResultsByTechnique(
    String techniqueId,
  ) async {
    try {
      final results = await getAllResults();
      return results.toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch results for technique: $e');
    }
  }

  @override
  Future<int> scenarioPassRate(String scenarioId) async {
    try {
      final results = await getResultsByScenario(scenarioId);
      if (results.isEmpty) return 0;
      final passed = results.where((r) => r.result == TestResult.passed).length;
      return ((passed / results.length) * 100).toInt();
    } catch (e) {
      throw DataException(message: 'Failed to calculate pass rate: $e');
    }
  }

  @override
  Future<Map<String, int>> overallReadiness() async {
    try {
      final results = await getAllResults();
      if (results.isEmpty) {
        return {'notTested': 0, 'passed': 0, 'failed': 0, 'partiallyPassed': 0};
      }

      return {
        'notTested': results
            .where((r) => r.result == TestResult.notTested)
            .length,
        'passed': results.where((r) => r.result == TestResult.passed).length,
        'failed': results.where((r) => r.result == TestResult.failed).length,
        'partiallyPassed': results
            .where((r) => r.result == TestResult.partiallyPassed)
            .length,
      };
    } catch (e) {
      throw DataException(message: 'Failed to calculate readiness: $e');
    }
  }
}
