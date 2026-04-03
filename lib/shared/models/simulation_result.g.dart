// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationResultImpl _$$SimulationResultImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationResultImpl(
  id: json['id'] as String,
  scenarioId: json['scenarioId'] as String,
  result: $enumDecode(_$TestResultEnumMap, json['result']),
  observations: json['observations'] as String,
  recommendations: json['recommendations'] as String,
  testedAt: DateTime.parse(json['testedAt'] as String),
  testedBy: json['testedBy'] as String,
);

Map<String, dynamic> _$$SimulationResultImplToJson(
  _$SimulationResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'scenarioId': instance.scenarioId,
  'result': _$TestResultEnumMap[instance.result]!,
  'observations': instance.observations,
  'recommendations': instance.recommendations,
  'testedAt': instance.testedAt.toIso8601String(),
  'testedBy': instance.testedBy,
};

const _$TestResultEnumMap = {
  TestResult.notTested: 'notTested',
  TestResult.passed: 'passed',
  TestResult.failed: 'failed',
  TestResult.partiallyPassed: 'partiallyPassed',
};
