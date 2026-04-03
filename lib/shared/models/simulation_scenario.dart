import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_scenario.freezed.dart';
part 'simulation_scenario.g.dart';

@freezed
class SimulationScenario with _$SimulationScenario {
  const factory SimulationScenario({
    required String id,
    required String name,
    required String description,
    List<String>? relatedTechniques,
    String? objectives,
    String? expectedOutcomes,
    DateTime? createdAt,
  }) = _SimulationScenario;

  factory SimulationScenario.fromJson(Map<String, dynamic> json) =>
      _$SimulationScenarioFromJson(json);
}
