import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_result.freezed.dart';
part 'simulation_result.g.dart';

enum TestResult {
  notTested,
  passed,
  failed,
  partiallyPassed,
}

/// Represents the result of running a simulation scenario
@freezed
class SimulationResult with _$SimulationResult {
  const factory SimulationResult({
    required String id,
    required String scenarioId,
    required TestResult result,
    required String observations,
    required String recommendations,
    required DateTime testedAt,
    required String testedBy,
  }) = _SimulationResult;

  factory SimulationResult.fromJson(Map<String, dynamic> json) =>
      _$SimulationResultFromJson(json);
}
