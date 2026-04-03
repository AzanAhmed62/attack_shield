// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkItemImpl _$$BookmarkItemImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkItemImpl(
      id: json['id'] as String,
      techniqueId: json['techniqueId'] as String,
      techniqueName: json['techniqueName'] as String,
      notes: json['notes'] as String?,
      bookmarkedAt: json['bookmarkedAt'] == null
          ? null
          : DateTime.parse(json['bookmarkedAt'] as String),
    );

Map<String, dynamic> _$$BookmarkItemImplToJson(_$BookmarkItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'techniqueId': instance.techniqueId,
      'techniqueName': instance.techniqueName,
      'notes': instance.notes,
      'bookmarkedAt': instance.bookmarkedAt?.toIso8601String(),
    };
