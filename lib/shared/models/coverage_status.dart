import 'package:freezed_annotation/freezed_annotation.dart';

part 'coverage_status.freezed.dart';
part 'coverage_status.g.dart';

enum CoverageLevel { notCovered, partiallyCovered, covered, unknown }

@freezed
class CoverageStatus with _$CoverageStatus {
  const factory CoverageStatus({
    required String techniqueId,
    required CoverageLevel level,
    String? notes,
    List<String>? relatedControls,
    DateTime? lastUpdated,
  }) = _CoverageStatus;

  factory CoverageStatus.fromJson(Map<String, dynamic> json) =>
      _$CoverageStatusFromJson(json);
}
