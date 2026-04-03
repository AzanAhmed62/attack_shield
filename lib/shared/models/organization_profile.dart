import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_profile.freezed.dart';
part 'organization_profile.g.dart';

enum AppContext { personalLearning, lab, organizational }

@freezed
class OrganizationProfile with _$OrganizationProfile {
  const factory OrganizationProfile({
    required String id,
    required String name,
    required AppContext context,
    List<String>? preferredSectors,
    List<String>? preferredPlatforms,
    String? description,
    DateTime? createdAt,
    DateTime? lastModified,
  }) = _OrganizationProfile;

  factory OrganizationProfile.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProfileFromJson(json);
}
