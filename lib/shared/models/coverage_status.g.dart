// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoverageStatusImpl _$$CoverageStatusImplFromJson(Map<String, dynamic> json) =>
    _$CoverageStatusImpl(
      id: json['id'] as String?,
      techniqueId: json['techniqueId'] as String,
      level: $enumDecode(_$CoverageLevelEnumMap, json['level']),
      notes: json['notes'] as String?,
      relatedControls:
          (json['relatedControls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$CoverageStatusImplToJson(
  _$CoverageStatusImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'techniqueId': instance.techniqueId,
  'level': _$CoverageLevelEnumMap[instance.level]!,
  'notes': instance.notes,
  'relatedControls': instance.relatedControls,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};

const _$CoverageLevelEnumMap = {
  CoverageLevel.notCovered: 'notCovered',
  CoverageLevel.partiallyCovered: 'partiallyCovered',
  CoverageLevel.covered: 'covered',
  CoverageLevel.unknown: 'unknown',
};
