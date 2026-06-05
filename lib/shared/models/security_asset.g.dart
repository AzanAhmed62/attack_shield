// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityAssetImpl _$$SecurityAssetImplFromJson(
  Map<String, dynamic> json,
) => _$SecurityAssetImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type:
      $enumDecodeNullable(_$AssetTypeEnumMap, json['type']) ?? AssetType.server,
  criticality:
      $enumDecodeNullable(_$AssetCriticalityEnumMap, json['criticality']) ??
      AssetCriticality.medium,
  description: json['description'] as String? ?? '',
  relatedTechniqueIds:
      (json['relatedTechniqueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  discoveredAt: json['discoveredAt'] == null
      ? null
      : DateTime.parse(json['discoveredAt'] as String),
  lastScanned: json['lastScanned'] == null
      ? null
      : DateTime.parse(json['lastScanned'] as String),
  owner: json['owner'] as String?,
  ipAddress: json['ipAddress'] as String?,
  operatingSystem: json['operatingSystem'] as String?,
);

Map<String, dynamic> _$$SecurityAssetImplToJson(_$SecurityAssetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AssetTypeEnumMap[instance.type]!,
      'criticality': _$AssetCriticalityEnumMap[instance.criticality]!,
      'description': instance.description,
      'relatedTechniqueIds': instance.relatedTechniqueIds,
      'tags': instance.tags,
      'platforms': instance.platforms,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'discoveredAt': instance.discoveredAt?.toIso8601String(),
      'lastScanned': instance.lastScanned?.toIso8601String(),
      'owner': instance.owner,
      'ipAddress': instance.ipAddress,
      'operatingSystem': instance.operatingSystem,
    };

const _$AssetTypeEnumMap = {
  AssetType.server: 'server',
  AssetType.workstation: 'workstation',
  AssetType.network: 'network',
  AssetType.cloud: 'cloud',
  AssetType.application: 'application',
  AssetType.mobile: 'mobile',
  AssetType.iot: 'iot',
  AssetType.other: 'other',
};

const _$AssetCriticalityEnumMap = {
  AssetCriticality.low: 'low',
  AssetCriticality.medium: 'medium',
  AssetCriticality.high: 'high',
  AssetCriticality.critical: 'critical',
};
