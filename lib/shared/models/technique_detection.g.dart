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
  description: json['description'] as String,
  source: json['source'] as String?,
  datasource: json['datasource'] as String?,
);

Map<String, dynamic> _$$TechniqueDetectionImplToJson(
  _$TechniqueDetectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'techniqueId': instance.techniqueId,
  'description': instance.description,
  'source': instance.source,
  'datasource': instance.datasource,
};
