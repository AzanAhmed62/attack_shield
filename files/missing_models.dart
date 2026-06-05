// lib/shared/models/security_asset.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'security_asset.freezed.dart';
part 'security_asset.g.dart';

enum AssetType    { server, workstation, network, cloud, application, mobile, iot, other }
enum AssetCriticality { low, medium, high, critical }

@freezed
class SecurityAsset with _$SecurityAsset {
  const factory SecurityAsset({
    required String           id,
    required String           name,
    @Default(AssetType.server)       AssetType        type,
    @Default(AssetCriticality.medium) AssetCriticality criticality,
    @Default('')  String description,
    @Default([])  List<String> relatedTechniqueIds,
    @Default([])  List<String> tags,
    required DateTime         createdAt,
    DateTime?                 lastUpdated,
    String?                   owner,
    String?                   ipAddress,
    String?                   operatingSystem,
  }) = _SecurityAsset;

  factory SecurityAsset.fromJson(Map<String, dynamic> json) =>
      _$SecurityAssetFromJson(json);
}

// ─────────────────────────────────────────────────────────────────────────────

// lib/shared/models/organization_profile.dart
// ignore_for_file: prefer_relative_imports
import 'package:freezed_annotation/freezed_annotation.dart';
part 'organization_profile.freezed.dart';
part 'organization_profile.g.dart';

@freezed
class OrganizationProfile with _$OrganizationProfile {
  const factory OrganizationProfile({
    required String        name,
    @Default('') String    sector,
    @Default('') String    size,            // 'small' | 'medium' | 'large' | 'enterprise'
    @Default([]) List<String> platforms,    // e.g. ['Windows', 'Cloud']
    @Default([]) List<String> frameworks,   // e.g. ['ISO27001', 'NIST']
    @Default('') String    country,
    @Default(false) bool   hasCompletedSetup,
    DateTime?              setupDate,
  }) = _OrganizationProfile;

  factory OrganizationProfile.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProfileFromJson(json);
}

// ─────────────────────────────────────────────────────────────────────────────

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
