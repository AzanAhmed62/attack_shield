// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportSummaryImpl _$$ReportSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReportSummaryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      totalTechniquesReviewed: (json['totalTechniquesReviewed'] as num).toInt(),
      coveragePercentage: (json['coveragePercentage'] as num).toDouble(),
      topRiskyTechniques: (json['topRiskyTechniques'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      unresolvedGaps: (json['unresolvedGaps'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendedActions: (json['recommendedActions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      generatedAt: json['generatedAt'] == null
          ? null
          : DateTime.parse(json['generatedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ReportSummaryImplToJson(_$ReportSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'totalTechniquesReviewed': instance.totalTechniquesReviewed,
      'coveragePercentage': instance.coveragePercentage,
      'topRiskyTechniques': instance.topRiskyTechniques,
      'unresolvedGaps': instance.unresolvedGaps,
      'recommendedActions': instance.recommendedActions,
      'generatedAt': instance.generatedAt?.toIso8601String(),
      'notes': instance.notes,
    };
