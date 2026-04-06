// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityAssetImpl _$$SecurityAssetImplFromJson(Map<String, dynamic> json) =>
    _$SecurityAssetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? '',
      criticality:
          $enumDecodeNullable(_$AssetCriticalityEnumMap, json['criticality']) ??
          AssetCriticality.medium,
      platforms:
          (json['platforms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      discoveredAt: DateTime.parse(json['discoveredAt'] as String),
      lastScanned: json['lastScanned'] == null
          ? null
          : DateTime.parse(json['lastScanned'] as String),
    );

Map<String, dynamic> _$$SecurityAssetImplToJson(_$SecurityAssetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'criticality': _$AssetCriticalityEnumMap[instance.criticality]!,
      'platforms': instance.platforms,
      'tags': instance.tags,
      'discoveredAt': instance.discoveredAt.toIso8601String(),
      'lastScanned': instance.lastScanned?.toIso8601String(),
    };

const _$AssetCriticalityEnumMap = {
  AssetCriticality.low: 'low',
  AssetCriticality.medium: 'medium',
  AssetCriticality.high: 'high',
  AssetCriticality.critical: 'critical',
};
