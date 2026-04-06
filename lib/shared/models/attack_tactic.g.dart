// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_tactic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
