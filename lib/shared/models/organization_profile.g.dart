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
  context: $enumDecode(_$AppContextEnumMap, json['context']),
  preferredSectors: (json['preferredSectors'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  preferredPlatforms: (json['preferredPlatforms'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastModified: json['lastModified'] == null
      ? null
      : DateTime.parse(json['lastModified'] as String),
);

Map<String, dynamic> _$$OrganizationProfileImplToJson(
  _$OrganizationProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'context': _$AppContextEnumMap[instance.context]!,
  'preferredSectors': instance.preferredSectors,
  'preferredPlatforms': instance.preferredPlatforms,
  'description': instance.description,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastModified': instance.lastModified?.toIso8601String(),
};

const _$AppContextEnumMap = {
  AppContext.personalLearning: 'personalLearning',
  AppContext.lab: 'lab',
  AppContext.organizational: 'organizational',
};
