import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/data/repositories/repositories.dart';
import 'package:attackshield/data/services/services.dart';

part 'repository_providers.g.dart';

// ── Storage service (singleton) ───────────────────────────────────────────────

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return LocalStorageService();
}

// ── Repository providers (singletons) ────────────────────────────────────────

@Riverpod(keepAlive: true)
AttackTechniqueRepository attackTechniqueRepository(Ref ref) {
  return AttackTechniqueRepositoryImpl();
}

@Riverpod(keepAlive: true)
CoverageRepository coverageRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return CoverageRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
BookmarkRepository bookmarkRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return BookmarkRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
AlertRepository alertRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return AlertRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
AssetRepository assetRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return AssetRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
OrganizationRepository organizationRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return OrganizationRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
ReportRepository reportRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return ReportRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
SimulationRepository simulationRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return SimulationRepositoryImpl(storage);
}