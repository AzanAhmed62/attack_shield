import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'coverage_providers.g.dart';

/// All saved coverage statuses from local storage.
@Riverpod(keepAlive: false)
Future<List<CoverageStatus>> allCoverageStatuses(Ref ref) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getAllCoverageStatuses();
}

/// Coverage percentage (0–100) calculated by repository.
/// Note: RiskEngine also provides a richer version via riskEngineCoveragePercentageProvider.
@Riverpod(keepAlive: false)
Future<double> coveragePercentage(Ref ref) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.calculateCoveragePercentage();
}

/// Coverage breakdown by level.
@Riverpod(keepAlive: false)
Future<Map<String, int>> coverageBreakdown(Ref ref) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getCoverageBreakdown();
}

/// Coverage status for a single technique.
@Riverpod(keepAlive: false)
Future<CoverageStatus?> techniqueCoverageStatus(
  Ref ref,
  String techniqueId,
) async {
  final repository = ref.watch(coverageRepositoryProvider);
  return repository.getCoverageStatus(techniqueId);
}

/// Update coverage status and refresh all related providers.
@Riverpod(keepAlive: false)
Future<void> updateCoverageStatus(Ref ref, CoverageStatus status) async {
  final repository = ref.watch(coverageRepositoryProvider);
  await repository.updateCoverageStatus(status);
  ref.invalidate(allCoverageStatusesProvider);
  ref.invalidate(coveragePercentageProvider);
  ref.invalidate(coverageBreakdownProvider);
  // Also invalidate risk engine providers so they recompute
  ref.invalidate(techniqueCoverageStatusProvider(status.techniqueId));
}

/// Delete coverage status for a technique.
@Riverpod(keepAlive: false)
Future<void> deleteCoverageStatus(Ref ref, String techniqueId) async {
  final repository = ref.watch(coverageRepositoryProvider);
  await repository.deleteCoverageStatus(techniqueId);
  ref.invalidate(allCoverageStatusesProvider);
  ref.invalidate(coveragePercentageProvider);
  ref.invalidate(coverageBreakdownProvider);
}