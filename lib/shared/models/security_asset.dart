import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_asset.freezed.dart';
part 'security_asset.g.dart';

/// Criticality levels for security assets
enum AssetCriticality { low, medium, high, critical }

@freezed
class SecurityAsset with _$SecurityAsset {
  const factory SecurityAsset({
    required String id,
    required String name,
    @Default('') String description,
    @Default('') String type,            // 'Network' | 'Server' | 'Workstation' | 'Application' | 'Cloud'
    @Default(AssetCriticality.medium) AssetCriticality criticality,
    @Default([]) List<String> platforms, // OS/platforms this asset runs
    @Default([]) List<String> tags,
    required DateTime discoveredAt,
    DateTime? lastScanned,
  }) = _SecurityAsset;

  factory SecurityAsset.fromJson(Map<String, dynamic> json) =>
      _$SecurityAssetFromJson(json);
}