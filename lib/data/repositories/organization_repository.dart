// lib/data/repositories/organization_repository.dart
// NEW FILE — organisation profile persistence.

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../shared/models/organization_profile.dart';
import '../services/local_storage_service.dart';

const _kOrgKey = 'organization_profile_v1';

abstract class OrganizationRepository {
  Future<OrganizationProfile?> getProfile();
  Future<void> saveProfile(OrganizationProfile profile);
  Future<void> clearProfile();
}

class OrganizationRepositoryImpl implements OrganizationRepository {
  final LocalStorageService storage;
  OrganizationRepositoryImpl(this.storage);

  final _box = GetStorage();

  @override
  Future<OrganizationProfile?> getProfile() async {
    try {
      final raw = _box.read<String>(_kOrgKey);
      if (raw == null) return null;
      return OrganizationProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) { return null; }
  }

  @override
  Future<void> saveProfile(OrganizationProfile profile) async {
    await _box.write(_kOrgKey, jsonEncode(profile.toJson()));
  }

  @override
  Future<void> clearProfile() async => _box.remove(_kOrgKey);
}
