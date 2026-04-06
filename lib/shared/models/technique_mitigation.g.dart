// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique_mitigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TechniqueMitigationImpl _$$TechniqueMitigationImplFromJson(
  Map<String, dynamic> json,
) => _$TechniqueMitigationImpl(
  id: json['id'] as String,
  techniqueId: json['techniqueId'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  mitreId: json['mitreId'] as String?,
  controlFrameworks:
      (json['controlFrameworks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TechniqueMitigationImplToJson(
  _$TechniqueMitigationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'techniqueId': instance.techniqueId,
  'name': instance.name,
  'description': instance.description,
  'mitreId': instance.mitreId,
  'controlFrameworks': instance.controlFrameworks,
};
