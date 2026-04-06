import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:attackshield/core/constants/app_context.dart';

part 'organization_profile.freezed.dart';
part 'organization_profile.g.dart';

@freezed
class OrganizationProfile with _$OrganizationProfile {
  const factory OrganizationProfile({
    required String id,
    required String name,
    @Default(AppContext.personalLearning) AppContext context,
    @Default('') String description,
    @Default([]) List<String> preferredSectors,
    @Default([]) List<String> preferredPlatforms,
    required DateTime createdAt,
    required DateTime lastModified,
  }) = _OrganizationProfile;

  factory OrganizationProfile.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProfileFromJson(json);
}
