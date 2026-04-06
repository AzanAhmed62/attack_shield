import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class ReportRepository {
  Future<List<ReportSummary>> getAllReports();
  Future<ReportSummary?> getLatestReport();
  Future<void> saveReport(ReportSummary report);
  Future<void> deleteReport(String id);
  Future<void> clearAllReports();
}

class ReportRepositoryImpl implements ReportRepository {
  final LocalStorageService _storageService;
  static const String _key = 'reports';

  ReportRepositoryImpl(this._storageService);

  @override
  Future<List<ReportSummary>> getAllReports() async {
    try {
      final data = _storageService.read<List>(_key);
      if (data == null) return [];
      final reports = data
          .map((e) => ReportSummary.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      // Sort newest first
      reports.sort((a, b) {
        final aDate = a.generatedAt ?? DateTime(2000);
        final bDate = b.generatedAt ?? DateTime(2000);
        return bDate.compareTo(aDate);
      });
      return reports;
    } catch (e) {
      throw DataException(message: 'Failed to fetch reports: $e');
    }
  }

  @override
  Future<ReportSummary?> getLatestReport() async {
    final reports = await getAllReports();
    return reports.isEmpty ? null : reports.first;
  }

  @override
  Future<void> saveReport(ReportSummary report) async {
    try {
      final reports = await getAllReports();
      reports.insert(0, report); // newest first
      await _storageService.write(
        _key,
        reports.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to save report: $e');
    }
  }

  @override
  Future<void> deleteReport(String id) async {
    try {
      final reports = await getAllReports();
      reports.removeWhere((r) => r.id == id);
      await _storageService.write(
        _key,
        reports.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete report: $e');
    }
  }

  @override
  Future<void> clearAllReports() async {
    try {
      await _storageService.remove(_key);
    } catch (e) {
      throw DataException(message: 'Failed to clear reports: $e');
    }
  }
}