import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_summary.freezed.dart';
part 'report_summary.g.dart';

@freezed
class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    required String id,
    required String title,
    required int totalTechniquesReviewed,
    required double coveragePercentage,
    required List<String> topRiskyTechniques,
    required List<String> unresolvedGaps,
    required List<String> recommendedActions,
    DateTime? generatedAt,
    String? notes,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}
