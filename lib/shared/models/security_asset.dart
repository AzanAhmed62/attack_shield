// lib/shared/models/security_asset.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'security_asset.freezed.dart';
part 'security_asset.g.dart';

enum AssetType {
  server,
  workstation,
  network,
  cloud,
  application,
  mobile,
  iot,
  other,
}

enum AssetCriticality { low, medium, high, critical }

@freezed
class SecurityAsset with _$SecurityAsset {
  const factory SecurityAsset({
    required String id,
    required String name,
    @Default(AssetType.server) AssetType type,
    @Default(AssetCriticality.medium) AssetCriticality criticality,
    @Default('') String description,
    @Default([]) List<String> relatedTechniqueIds,
    @Default([]) List<String> tags,
    @Default([]) List<String> platforms,
    required DateTime createdAt,
    DateTime? lastUpdated,
    DateTime? discoveredAt,
    DateTime? lastScanned,
    String? owner,
    String? ipAddress,
    String? operatingSystem,
  }) = _SecurityAsset;

  factory SecurityAsset.fromJson(Map<String, dynamic> json) =>
      _$SecurityAssetFromJson(json);
}
