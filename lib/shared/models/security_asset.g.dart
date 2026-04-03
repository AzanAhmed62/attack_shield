// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityAssetImpl _$$SecurityAssetImplFromJson(Map<String, dynamic> json) =>
    _$SecurityAssetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      platform: json['platform'] as String?,
      relatedTechniques:
          (json['relatedTechniques'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SecurityAssetImplToJson(_$SecurityAssetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'location': instance.location,
      'platform': instance.platform,
      'relatedTechniques': instance.relatedTechniques,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
