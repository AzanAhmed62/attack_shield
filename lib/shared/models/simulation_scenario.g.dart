// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationScenarioImpl _$$SimulationScenarioImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationScenarioImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  relatedTechniques: (json['relatedTechniques'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  objectives: json['objectives'] as String?,
  expectedOutcomes: json['expectedOutcomes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$SimulationScenarioImplToJson(
  _$SimulationScenarioImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'relatedTechniques': instance.relatedTechniques,
  'objectives': instance.objectives,
  'expectedOutcomes': instance.expectedOutcomes,
  'createdAt': instance.createdAt?.toIso8601String(),
};
