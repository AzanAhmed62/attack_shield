import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_asset.freezed.dart';
part 'security_asset.g.dart';

/// Represents a security asset or system in the organization
@freezed
class SecurityAsset with _$SecurityAsset {
  const factory SecurityAsset({
    required String id,
    required String name,
    required String type, // e.g., 'Server', 'Workstation', 'Network', 'Application'
    String? description,
    String? location,
    String? platform,
    @Default([]) List<String> relatedTechniques,
    DateTime? createdAt,
  }) = _SecurityAsset;

  factory SecurityAsset.fromJson(Map<String, dynamic> json) =>
      _$SecurityAssetFromJson(json);
}
