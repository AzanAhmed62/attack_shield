// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityAlertImpl _$$SecurityAlertImplFromJson(Map<String, dynamic> json) =>
    _$SecurityAlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      severity: json['severity'] as String? ?? 'medium',
      source: json['source'] as String? ?? 'Manual',
      linkedTechniqueId: json['linkedTechniqueId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      status: json['status'] as String? ?? 'open',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$SecurityAlertImplToJson(_$SecurityAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'severity': instance.severity,
      'source': instance.source,
      'linkedTechniqueId': instance.linkedTechniqueId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'status': instance.status,
      'notes': instance.notes,
    };
