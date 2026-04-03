import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class ReportRepository {
  Future<List<ReportSummary>> getAllReports();
  Future<ReportSummary?> getReportById(String id);
  Future<void> createReport(ReportSummary report);
  Future<void> deleteReport(String id);
  Future<ReportSummary?> getLatestReport();
}

class ReportRepositoryImpl implements ReportRepository {
  final LocalStorageService _storageService;
  static const String _storageKey = 'reports';

  ReportRepositoryImpl(this._storageService);

  @override
  Future<List<ReportSummary>> getAllReports() async {
    try {
      final reportsJson = _storageService.read<List>(_storageKey) ?? [];
      return reportsJson
          .map((e) => ReportSummary.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch reports: $e');
    }
  }

  @override
  Future<ReportSummary?> getReportById(String id) async {
    try {
      final reports = await getAllReports();
      try {
        return reports.firstWhere((r) => r.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw DataException(message: 'Failed to fetch report: $e');
    }
  }

  @override
  Future<void> createReport(ReportSummary report) async {
    try {
      final reports = await getAllReports();
      reports.add(report);
      final sorted = reports
        ..sort(
          (a, b) => (b.generatedAt ?? DateTime.now()).compareTo(
            a.generatedAt ?? DateTime.now(),
          ),
        );
      await _storageService.write(
        _storageKey,
        sorted.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to create report: $e');
    }
  }

  @override
  Future<void> deleteReport(String id) async {
    try {
      final reports = await getAllReports();
      reports.removeWhere((r) => r.id == id);
      await _storageService.write(
        _storageKey,
        reports.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete report: $e');
    }
  }

  @override
  Future<ReportSummary?> getLatestReport() async {
    try {
      final reports = await getAllReports();
      if (reports.isEmpty) return null;
      reports.sort(
        (a, b) => (b.generatedAt ?? DateTime.now()).compareTo(
          a.generatedAt ?? DateTime.now(),
        ),
      );
      return reports.first;
    } catch (e) {
      throw DataException(message: 'Failed to fetch latest report: $e');
    }
  }
}
