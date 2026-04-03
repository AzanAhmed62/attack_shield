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
  mitigationId: json['mitigationId'] as String,
  description: json['description'] as String,
  type: json['type'] as String?,
);

Map<String, dynamic> _$$TechniqueMitigationImplToJson(
  _$TechniqueMitigationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'techniqueId': instance.techniqueId,
  'mitigationId': instance.mitigationId,
  'description': instance.description,
  'type': instance.type,
};
