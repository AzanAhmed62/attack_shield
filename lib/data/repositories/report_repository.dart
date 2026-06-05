
// lib/data/repositories/report_repository.dart
// NEW FILE — report summary persistence.

// ignore_for_file: file_names

import 'dart:convert';

import 'package:attackshield/data/services/local_storage_service.dart';
import 'package:get_storage/get_storage.dart';

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