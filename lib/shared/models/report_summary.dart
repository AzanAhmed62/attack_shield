import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_summary.freezed.dart';
part 'report_summary.g.dart';

@freezed
class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    required String id,
    required String title,
    @Default(0) int totalTechniquesReviewed,
    @Default(0.0) double coveragePercentage,
    @Default([]) List<String> topRiskyTechniques,
    @Default([]) List<String> unresolvedGaps,
    @Default([]) List<String> recommendedActions,
    DateTime? generatedAt,
    String? notes,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}