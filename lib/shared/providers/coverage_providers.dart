import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'coverage_providers.g.dart';

// All Coverage Statuses
@Riverpod()
Future<List<CoverageStatus>> allCoverageStatuses(
  AllCoverageStatusesRef ref,
) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getAllCoverageStatuses();
}

// Coverage Percentage
@Riverpod()
Future<double> coveragePercentage(CoveragePercentageRef ref) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.calculateCoveragePercentage();
}

// Coverage Breakdown
@Riverpod()
Future<Map<String, int>> coverageBreakdown(CoverageBreakdownRef ref) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getCoverageBreakdown();
}

// Get Coverage Status for a Technique
@Riverpod()
Future<CoverageStatus?> techniqueCoverageStatus(
  TechniqueCoverageStatusRef ref,
  String techniqueId,
) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getCoverageStatus(techniqueId);
}

// Update Coverage Status
@Riverpod()
Future<void> updateCoverageStatus(
  UpdateCoverageStatusRef ref,
  CoverageStatus status,
) async {
  final repository = ref.watch(coverageRepositoryProvider);
  await repository.updateCoverageStatus(status);
  // Invalidate related providers to refresh UI
  ref.invalidate(allCoverageStatusesProvider);
  ref.invalidate(coveragePercentageProvider);
  ref.invalidate(coverageBreakdownProvider);
}

// Delete Coverage Status
@Riverpod()
Future<void> deleteCoverageStatus(
  DeleteCoverageStatusRef ref,
  String techniqueId,
) async {
  final repository = ref.watch(coverageRepositoryProvider);
  await repository.deleteCoverageStatus(techniqueId);
  // Invalidate related providers to refresh UI
  ref.invalidate(allCoverageStatusesProvider);
  ref.invalidate(coveragePercentageProvider);
  ref.invalidate(coverageBreakdownProvider);
}
