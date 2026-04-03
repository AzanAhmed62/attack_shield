import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class OrganizationRepository {
  Future<OrganizationProfile?> getProfile();
  Future<void> createProfile(OrganizationProfile profile);
  Future<void> updateProfile(OrganizationProfile profile);
}

class OrganizationRepositoryImpl implements OrganizationRepository {
  final LocalStorageService _storageService;
  static const String _storageKey = 'organization_profile';

  OrganizationRepositoryImpl(this._storageService);

  @override
  Future<OrganizationProfile?> getProfile() async {
    try {
      final profileJson = _storageService.read<Map<String, dynamic>>(
        _storageKey,
      );
      if (profileJson == null) return null;
      return OrganizationProfile.fromJson(profileJson);
    } catch (e) {
      throw DataException(message: 'Failed to fetch profile: $e');
    }
  }

  @override
  Future<void> createProfile(OrganizationProfile profile) async {
    try {
      await _storageService.write(_storageKey, profile.toJson());
    } catch (e) {
      throw DataException(message: 'Failed to create profile: $e');
    }
  }

  @override
  Future<void> updateProfile(OrganizationProfile profile) async {
    try {
      await _storageService.write(_storageKey, profile.toJson());
    } catch (e) {
      throw DataException(message: 'Failed to update profile: $e');
    }
  }
}
