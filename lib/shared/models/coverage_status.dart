import 'package:freezed_annotation/freezed_annotation.dart';

part 'coverage_status.freezed.dart';
part 'coverage_status.g.dart';

/// Coverage level enum — used internally for type-safe comparisons.
enum CoverageLevel { notCovered, partiallyCovered, covered, unknown }

/// Extension to convert between CoverageLevel and the string stored in DB.
extension CoverageLevelX on CoverageLevel {
  String get statusString {
    switch (this) {
      case CoverageLevel.covered:
        return 'covered';
      case CoverageLevel.partiallyCovered:
        return 'partiallyCovered';
      case CoverageLevel.unknown:
        return 'unknown';
      case CoverageLevel.notCovered:
        return 'notCovered';
    }
  }

  static CoverageLevel fromString(String s) {
    switch (s) {
      case 'covered':
        return CoverageLevel.covered;
      case 'partiallyCovered':
        return CoverageLevel.partiallyCovered;
      case 'unknown':
        return CoverageLevel.unknown;
      default:
        return CoverageLevel.notCovered;
    }
  }
}

@freezed
class CoverageStatus with _$CoverageStatus {
  const factory CoverageStatus({
    required String techniqueId,
    required CoverageLevel level,
    String? notes,
    @Default([]) List<String> relatedControls,
    DateTime? lastUpdated,
  }) = _CoverageStatus;

  factory CoverageStatus.fromJson(Map<String, dynamic> json) =>
      _$CoverageStatusFromJson(json);
}

/// Helper — get the string status from a nullable CoverageStatus.
/// This is what RiskEngine uses.
extension CoverageStatusX on CoverageStatus? {
  String get statusString =>
      this?.level.statusString ?? 'notCovered';
}