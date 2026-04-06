// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationProfileImpl _$$OrganizationProfileImplFromJson(
  Map<String, dynamic> json,
) => _$OrganizationProfileImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  context:
      $enumDecodeNullable(_$AppContextEnumMap, json['context']) ??
      AppContext.personalLearning,
  description: json['description'] as String? ?? '',
  preferredSectors:
      (json['preferredSectors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  preferredPlatforms:
      (json['preferredPlatforms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastModified: DateTime.parse(json['lastModified'] as String),
);

Map<String, dynamic> _$$OrganizationProfileImplToJson(
  _$OrganizationProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'context': _$AppContextEnumMap[instance.context]!,
  'description': instance.description,
  'preferredSectors': instance.preferredSectors,
  'preferredPlatforms': instance.preferredPlatforms,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastModified': instance.lastModified.toIso8601String(),
};

const _$AppContextEnumMap = {
  AppContext.personalLearning: 'personalLearning',
  AppContext.lab: 'lab',
  AppContext.organizational: 'organizational',
};
