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
  description: json['description'] as String? ?? '',
  context: json['context'] as String? ?? 'Organization',
  sector:
      $enumDecodeNullable(_$OrgSectorEnumMap, json['sector']) ?? OrgSector.sme,
  orgSize:
      $enumDecodeNullable(_$OrgSizeEnumMap, json['orgSize']) ?? OrgSize.small,
  techStack:
      (json['techStack'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  currentControls:
      (json['currentControls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
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
  'description': instance.description,
  'context': instance.context,
  'sector': _$OrgSectorEnumMap[instance.sector]!,
  'orgSize': _$OrgSizeEnumMap[instance.orgSize]!,
  'techStack': instance.techStack,
  'currentControls': instance.currentControls,
  'preferredSectors': instance.preferredSectors,
  'preferredPlatforms': instance.preferredPlatforms,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastModified': instance.lastModified.toIso8601String(),
};

const _$OrgSectorEnumMap = {
  OrgSector.healthcare: 'healthcare',
  OrgSector.finance: 'finance',
  OrgSector.education: 'education',
  OrgSector.retail: 'retail',
  OrgSector.government: 'government',
  OrgSector.technology: 'technology',
  OrgSector.manufacturing: 'manufacturing',
  OrgSector.energy: 'energy',
  OrgSector.sme: 'sme',
  OrgSector.personal: 'personal',
  OrgSector.other: 'other',
};

const _$OrgSizeEnumMap = {
  OrgSize.micro: 'micro',
  OrgSize.small: 'small',
  OrgSize.medium: 'medium',
  OrgSize.large: 'large',
  OrgSize.enterprise: 'enterprise',
};
