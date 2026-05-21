// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_technique.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttackTacticImpl _$$AttackTacticImplFromJson(Map<String, dynamic> json) =>
    _$AttackTacticImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      description: json['description'] as String,
      techniqueIds:
          (json['techniqueIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AttackTacticImplToJson(_$AttackTacticImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'description': instance.description,
      'techniqueIds': instance.techniqueIds,
    };

_$AttackTechniqueImpl _$$AttackTechniqueImplFromJson(
  Map<String, dynamic> json,
) => _$AttackTechniqueImpl(
  id: json['id'] as String,
  stixId: json['stixId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  tactics:
      (json['tactics'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tacticIds:
      (json['tacticIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dataSources:
      (json['dataSources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mitigationIds:
      (json['mitigationIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  detectionIds:
      (json['detectionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  relatedTechniqueIds:
      (json['relatedTechniqueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isSubTechnique: json['isSubTechnique'] as bool? ?? false,
  parentTechniqueId: json['parentTechniqueId'] as String?,
  subTechniqueIds:
      (json['subTechniqueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  riskScore: (json['riskScore'] as num?)?.toDouble() ?? 5.0,
  url: json['url'] as String?,
  created: json['created'] as String?,
  modified: json['modified'] as String?,
  plainTitle: json['plainTitle'] as String?,
  plainSummary: json['plainSummary'] as String?,
  businessRisk: json['businessRisk'] as String?,
  remediationSteps:
      (json['remediationSteps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AttackTechniqueImplToJson(
  _$AttackTechniqueImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'stixId': instance.stixId,
  'name': instance.name,
  'description': instance.description,
  'tactics': instance.tactics,
  'tacticIds': instance.tacticIds,
  'platforms': instance.platforms,
  'dataSources': instance.dataSources,
  'mitigationIds': instance.mitigationIds,
  'detectionIds': instance.detectionIds,
  'relatedTechniqueIds': instance.relatedTechniqueIds,
  'isSubTechnique': instance.isSubTechnique,
  'parentTechniqueId': instance.parentTechniqueId,
  'subTechniqueIds': instance.subTechniqueIds,
  'riskScore': instance.riskScore,
  'url': instance.url,
  'created': instance.created,
  'modified': instance.modified,
  'plainTitle': instance.plainTitle,
  'plainSummary': instance.plainSummary,
  'businessRisk': instance.businessRisk,
  'remediationSteps': instance.remediationSteps,
};
