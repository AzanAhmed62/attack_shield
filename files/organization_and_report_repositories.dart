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

// ─────────────────────────────────────────────────────────────────────────────

// lib/data/repositories/report_repository.dart
// NEW FILE — report summary persistence.

// ignore_for_file: file_names

import '../../shared/models/report_summary.dart';

abstract class ReportRepository {
  Future<List<ReportSummary>> getAllReports();
  Future<void> saveReport(ReportSummary report);
  Future<void> deleteReport(String id);
}

class ReportRepositoryImpl implements ReportRepository {
  final LocalStorageService storage;
  ReportRepositoryImpl(this.storage);

  final _box2 = GetStorage();
  static const _kReportsKey = 'report_summaries_v1';

  @override
  Future<List<ReportSummary>> getAllReports() async {
    try {
      final raw = _box2.read<String>(_kReportsKey);
      if (raw == null) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(ReportSummary.fromJson).toList();
    } catch (_) { return []; }
  }

  @override
  Future<void> saveReport(ReportSummary report) async {
    final all = await getAllReports();
    all.insert(0, report);
    await _box2.write(_kReportsKey, jsonEncode(all.map((r) => r.toJson()).toList()));
  }

  @override
  Future<void> deleteReport(String id) async {
    final all = await getAllReports();
    all.removeWhere((r) => r.id == id);
    await _box2.write(_kReportsKey, jsonEncode(all.map((r) => r.toJson()).toList()));
  }
}
