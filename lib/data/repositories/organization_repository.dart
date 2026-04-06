import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../../core/constants/constants.dart';
import '../services/services.dart';

abstract class OrganizationRepository {
  Future<OrganizationProfile?> getOrganizationProfile();
  Future<void> saveOrganizationProfile(OrganizationProfile profile);
  Future<void> deleteOrganizationProfile();
}

class OrganizationRepositoryImpl implements OrganizationRepository {
  final LocalStorageService _storageService;

  OrganizationRepositoryImpl(this._storageService);

  @override
  Future<OrganizationProfile?> getOrganizationProfile() async {
    try {
      final data = _storageService.read<Map>(AppConstants.storageKeyOrgProfile);
      if (data == null) return null;
      return OrganizationProfile.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw DataException(message: 'Failed to fetch organization profile: $e');
    }
  }

  @override
  Future<void> saveOrganizationProfile(OrganizationProfile profile) async {
    try {
      await _storageService.write(
        AppConstants.storageKeyOrgProfile,
        profile.toJson(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to save organization profile: $e');
    }
  }

  @override
  Future<void> deleteOrganizationProfile() async {
    try {
      await _storageService.remove(AppConstants.storageKeyOrgProfile);
    } catch (e) {
      throw DataException(message: 'Failed to delete organization profile: $e');
    }
  }
}