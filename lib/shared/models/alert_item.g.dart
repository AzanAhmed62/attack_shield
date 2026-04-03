// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertItemImpl _$$AlertItemImplFromJson(Map<String, dynamic> json) =>
    _$AlertItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$AlertPriorityEnumMap, json['priority']),
      status: $enumDecode(_$AlertStatusEnumMap, json['status']),
      source: json['source'] as String,
      relatedTechniqueId: json['relatedTechniqueId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$AlertItemImplToJson(_$AlertItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$AlertPriorityEnumMap[instance.priority]!,
      'status': _$AlertStatusEnumMap[instance.status]!,
      'source': instance.source,
      'relatedTechniqueId': instance.relatedTechniqueId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'notes': instance.notes,
    };

const _$AlertPriorityEnumMap = {
  AlertPriority.low: 'low',
  AlertPriority.medium: 'medium',
  AlertPriority.high: 'high',
  AlertPriority.critical: 'critical',
};

const _$AlertStatusEnumMap = {
  AlertStatus.open: 'open',
  AlertStatus.acknowledged: 'acknowledged',
  AlertStatus.resolved: 'resolved',
};
