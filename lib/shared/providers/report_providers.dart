import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'report_providers.g.dart';

@Riverpod()
Future<List<ReportSummary>> allReports(AllReportsRef ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getAllReports();
}

@Riverpod()
Future<ReportSummary?> latestReport(LatestReportRef ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getLatestReport();
}

@Riverpod()
Future<int> reportCount(ReportCountRef ref) async {
  final reports = await ref.watch(allReportsProvider.future);
  return reports.length;
}

@Riverpod()
Future<double> averageCoverage(AverageCoverageRef ref) async {
  final reports = await ref.watch(allReportsProvider.future);
  if (reports.isEmpty) return 0.0;

  final sum = reports.fold<double>(0, (acc, r) => acc + r.coveragePercentage);
  return sum / reports.length;
}

@Riverpod()
Future<void> generateReport(GenerateReportRef ref, ReportSummary report) async {
  final repository = ref.watch(reportRepositoryProvider);
  await repository.createReport(report);
  ref.invalidate(allReportsProvider);
  ref.invalidate(latestReportProvider);
}

@Riverpod()
Future<void> deleteReport(DeleteReportRef ref, String id) async {
  final repository = ref.watch(reportRepositoryProvider);
  await repository.deleteReport(id);
  ref.invalidate(allReportsProvider);
  ref.invalidate(latestReportProvider);
}
