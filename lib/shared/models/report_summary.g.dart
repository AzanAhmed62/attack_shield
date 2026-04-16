// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportSummaryImpl _$$ReportSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReportSummaryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      totalTechniquesReviewed:
          (json['totalTechniquesReviewed'] as num?)?.toInt() ?? 0,
      riskScore: (json['riskScore'] as num?)?.toDouble() ?? 0.0,
      coveragePercentage:
          (json['coveragePercentage'] as num?)?.toDouble() ?? 0.0,
      topRiskyTechniques:
          (json['topRiskyTechniques'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      unresolvedGaps:
          (json['unresolvedGaps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recommendedActions:
          (json['recommendedActions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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
      'riskScore': instance.riskScore,
      'coveragePercentage': instance.coveragePercentage,
      'topRiskyTechniques': instance.topRiskyTechniques,
      'unresolvedGaps': instance.unresolvedGaps,
      'recommendedActions': instance.recommendedActions,
      'generatedAt': instance.generatedAt?.toIso8601String(),
      'notes': instance.notes,
    };
