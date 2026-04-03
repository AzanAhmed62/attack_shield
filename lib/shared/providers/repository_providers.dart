import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/data/repositories/repositories.dart';
import 'package:attackshield/data/services/services.dart';

part 'repository_providers.g.dart';

// Repository Providers
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(LocalStorageServiceRef ref) {
  return LocalStorageService();
}

@Riverpod(keepAlive: true)
AttackTechniqueRepository attackTechniqueRepository(
  AttackTechniqueRepositoryRef ref,
) {
  return AttackTechniqueRepositoryImpl();
}

@Riverpod(keepAlive: true)
CoverageRepository coverageRepository(CoverageRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return CoverageRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return BookmarkRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
AlertRepository alertRepository(AlertRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return AlertRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
AssetRepository assetRepository(AssetRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return AssetRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
SimulationRepository simulationRepository(SimulationRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return SimulationRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
OrganizationRepository organizationRepository(OrganizationRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return OrganizationRepositoryImpl(storageService);
}

@Riverpod(keepAlive: true)
ReportRepository reportRepository(ReportRepositoryRef ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return ReportRepositoryImpl(storageService);
}
