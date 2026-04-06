// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_technique.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttackSubTechniqueImpl _$$AttackSubTechniqueImplFromJson(
  Map<String, dynamic> json,
) => _$AttackSubTechniqueImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
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
  riskScore: (json['riskScore'] as num?)?.toDouble() ?? 5.0,
);

Map<String, dynamic> _$$AttackSubTechniqueImplToJson(
  _$AttackSubTechniqueImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'platforms': instance.platforms,
  'detectionIds': instance.detectionIds,
  'mitigationIds': instance.mitigationIds,
  'riskScore': instance.riskScore,
};

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
  subTechniques:
      (json['subTechniques'] as List<dynamic>?)
          ?.map((e) => AttackSubTechnique.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  riskScore: (json['riskScore'] as num?)?.toDouble() ?? 5.0,
  source: json['source'] as String?,
  lastModified: json['lastModified'] == null
      ? null
      : DateTime.parse(json['lastModified'] as String),
  externalUrl: json['externalUrl'] as String?,
  detectionNotes:
      (json['detectionNotes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mitigationNotes:
      (json['mitigationNotes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  dataSource: json['dataSource'] as String?,
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
  'subTechniques': instance.subTechniques,
  'riskScore': instance.riskScore,
  'source': instance.source,
  'lastModified': instance.lastModified?.toIso8601String(),
  'externalUrl': instance.externalUrl,
  'detectionNotes': instance.detectionNotes,
  'mitigationNotes': instance.mitigationNotes,
  'dataSource': instance.dataSource,
};

_$AttackTacticImpl _$$AttackTacticImplFromJson(Map<String, dynamic> json) =>
    _$AttackTacticImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      techniqueIds:
          (json['techniqueIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shortName: json['shortName'] as String?,
    );

Map<String, dynamic> _$$AttackTacticImplToJson(_$AttackTacticImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'techniqueIds': instance.techniqueIds,
      'shortName': instance.shortName,
    };
