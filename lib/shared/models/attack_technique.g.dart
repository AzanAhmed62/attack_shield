// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_technique.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttackTechniqueImpl _$$AttackTechniqueImplFromJson(
  Map<String, dynamic> json,
) => _$AttackTechniqueImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  tactics: (json['tactics'] as List<dynamic>).map((e) => e as String).toList(),
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  detectionIds:
      (json['detectionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mitigationIds:
      (json['mitigationIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  relatedTechniqueIds:
      (json['relatedTechniqueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  riskScore: (json['riskScore'] as num?)?.toDouble() ?? 5.0,
  source: json['source'] as String?,
  lastModified: json['lastModified'] == null
      ? null
      : DateTime.parse(json['lastModified'] as String),
  externalUrl: json['externalUrl'] as String?,
);

Map<String, dynamic> _$$AttackTechniqueImplToJson(
  _$AttackTechniqueImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'tactics': instance.tactics,
  'platforms': instance.platforms,
  'detectionIds': instance.detectionIds,
  'mitigationIds': instance.mitigationIds,
  'relatedTechniqueIds': instance.relatedTechniqueIds,
  'riskScore': instance.riskScore,
  'source': instance.source,
  'lastModified': instance.lastModified?.toIso8601String(),
  'externalUrl': instance.externalUrl,
};
