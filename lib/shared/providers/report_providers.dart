import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'report_providers.g.dart';

// ── Data ──────────────────────────────────────────────────────────────────────

/// All saved reports, sorted newest first.
@Riverpod(keepAlive: false)
Future<List<ReportSummary>> allReports(Ref ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getAllReports();
}

/// The most recently generated report, or null if none exist.
@Riverpod(keepAlive: false)
Future<ReportSummary?> latestReport(Ref ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getLatestReport();
}

// ── Mutations ─────────────────────────────────────────────────────────────────

/// Generate (save) a new report and refresh the report list.
@Riverpod(keepAlive: false)
Future<void> generateReport(Ref ref, ReportSummary report) async {
  final repository = ref.watch(reportRepositoryProvider);
  await repository.saveReport(report);
  ref.invalidate(allReportsProvider);
  ref.invalidate(latestReportProvider);
}

/// Delete a specific report by ID.
@Riverpod(keepAlive: false)
Future<void> deleteReport(Ref ref, String id) async {
  final repository = ref.watch(reportRepositoryProvider);
  await repository.deleteReport(id);
  ref.invalidate(allReportsProvider);
  ref.invalidate(latestReportProvider);
}

/// Clear all reports.
@Riverpod(keepAlive: false)
Future<void> clearAllReports(Ref ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  await repository.clearAllReports();
  ref.invalidate(allReportsProvider);
  ref.invalidate(latestReportProvider);
}