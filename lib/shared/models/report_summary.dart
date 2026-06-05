
// lib/shared/models/report_summary.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'report_summary.freezed.dart';
part 'report_summary.g.dart';

@freezed
class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    required String   id,
    required String   title,
    required DateTime generatedAt,
    required double   orgRiskScore,
    required double   coveragePercent,
    required int      totalTechniques,
    required int      coveredCount,
    required int      gapCount,
    @Default('') String aiNarrative,
    String?           pdfPath,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}