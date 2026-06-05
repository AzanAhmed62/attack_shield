// lib/shared/providers/repository_providers.dart
// FULL REPLACEMENT — all repositories registered, OsintService added.

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/attack_technique_repository.dart';
import '../../data/repositories/alert_repository.dart';
import '../../data/repositories/asset_repository.dart';
import '../../data/repositories/bookmark_repository.dart';
import '../../data/repositories/coverage_repository.dart';
import '../../data/repositories/organization_repository.dart';
import '../../data/repositories/report_repository.dart';
import '../../data/repositories/simulation_repository.dart';
import '../../data/services/local_storage_service.dart';
import '../../data/services/gemini_service.dart';
import '../../data/services/osint_service.dart';

part 'repository_providers.g.dart';

// ─── Services ─────────────────────────────────────────────────────────────────
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) => LocalStorageService();

@Riverpod(keepAlive: true)
GeminiService geminiService(Ref ref) => GeminiService();

@Riverpod(keepAlive: true)
OsintService osintService(Ref ref) => OsintService();

// ─── Repositories ─────────────────────────────────────────────────────────────
@Riverpod(keepAlive: true)
AttackTechniqueRepository attackTechniqueRepository(Ref ref) =>
    AttackTechniqueRepositoryImpl();

@Riverpod(keepAlive: true)
AlertRepository alertRepository(Ref ref) => AlertRepositoryImpl();

@Riverpod(keepAlive: true)
AssetRepository assetRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return AssetRepositoryImpl(s);
}

@Riverpod(keepAlive: true)
BookmarkRepository bookmarkRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return BookmarkRepositoryImpl(s);
}

@Riverpod(keepAlive: true)
CoverageRepository coverageRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return CoverageRepositoryImpl(s);
}

@Riverpod(keepAlive: true)
OrganizationRepository organizationRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return OrganizationRepositoryImpl(s);
}

@Riverpod(keepAlive: true)
ReportRepository reportRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return ReportRepositoryImpl(s);
}

@Riverpod(keepAlive: true)
SimulationRepository simulationRepository(Ref ref) {
  final s = ref.watch(localStorageServiceProvider);
  return SimulationRepositoryImpl(s);
}
