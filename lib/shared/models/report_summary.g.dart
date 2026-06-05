// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportSummaryImpl _$$ReportSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReportSummaryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      orgRiskScore: (json['orgRiskScore'] as num).toDouble(),
      coveragePercent: (json['coveragePercent'] as num).toDouble(),
      totalTechniques: (json['totalTechniques'] as num).toInt(),
      coveredCount: (json['coveredCount'] as num).toInt(),
      gapCount: (json['gapCount'] as num).toInt(),
      aiNarrative: json['aiNarrative'] as String? ?? '',
      pdfPath: json['pdfPath'] as String?,
    );

Map<String, dynamic> _$$ReportSummaryImplToJson(_$ReportSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'orgRiskScore': instance.orgRiskScore,
      'coveragePercent': instance.coveragePercent,
      'totalTechniques': instance.totalTechniques,
      'coveredCount': instance.coveredCount,
      'gapCount': instance.gapCount,
      'aiNarrative': instance.aiNarrative,
      'pdfPath': instance.pdfPath,
    };
