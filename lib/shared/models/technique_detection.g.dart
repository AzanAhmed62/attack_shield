// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique_detection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TechniqueDetectionImpl _$$TechniqueDetectionImplFromJson(
  Map<String, dynamic> json,
) => _$TechniqueDetectionImpl(
  id: json['id'] as String,
  techniqueId: json['techniqueId'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  dataSourcesRequired:
      (json['dataSourcesRequired'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  toolsRecommended:
      (json['toolsRecommended'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TechniqueDetectionImplToJson(
  _$TechniqueDetectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'techniqueId': instance.techniqueId,
  'name': instance.name,
  'description': instance.description,
  'dataSourcesRequired': instance.dataSourcesRequired,
  'toolsRecommended': instance.toolsRecommended,
};
