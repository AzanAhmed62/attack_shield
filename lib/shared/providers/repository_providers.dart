// lib/shared/providers/repository_providers.dart
// FULL REPLACEMENT — wires all repositories + GeminiService into Riverpod.

import 'package:hooks_riverpod/hooks_riverpod.dart';
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

part 'repository_providers.g.dart';

// ─── Storage service (singleton) ─────────────────────────────────────────────
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) => LocalStorageService();

// ─── Gemini AI service (singleton) ───────────────────────────────────────────
@Riverpod(keepAlive: true)
GeminiService geminiService(Ref ref) => GeminiService();

// ─── Repositories ─────────────────────────────────────────────────────────────

// Attack techniques — uses its own internal GetStorage, no LocalStorageService dep
@Riverpod(keepAlive: true)
AttackTechniqueRepository attackTechniqueRepository(Ref ref) =>
    AttackTechniqueRepositoryImpl();

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
BookmarkRepository bookmarkRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return BookmarkRepositoryImpl(storage);
}

@Riverpod(keepAlive: true)
CoverageRepository coverageRepository(Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return CoverageRepositoryImpl(storage);
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