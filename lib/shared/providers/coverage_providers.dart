// lib/shared/providers/coverage_providers.dart
// FULL REPLACEMENT — coverage providers now feed real STIX data through
// RiskEngine and produce live, accurate scores.

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/coverage_status.dart';
import '../../core/engine/risk_engine.dart';
import 'repository_providers.dart';
import 'technique_providers.dart';

part 'coverage_providers.g.dart';

// ─── All coverage statuses (persisted in GetStorage) ─────────────────────────
@Riverpod(keepAlive: true)
Future<List<CoverageStatus>> allCoverageStatuses(Ref ref) async {
  final repo = ref.watch(coverageRepositoryProvider);
  return repo.getAllCoverageStatuses();
}

// ─── Coverage map: techniqueId → CoverageLevel ───────────────────────────────
@riverpod
Future<Map<String, CoverageLevel>> coverageMap(Ref ref) async {
  final statuses = await ref.watch(allCoverageStatusesProvider.future);
  return { for (final s in statuses) s.techniqueId : s.level };
}

// ─── Full RiskReport (recomputed whenever coverage or techniques change) ──────
@riverpod
Future<RiskReport> riskReport(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final covMap     = await ref.watch(coverageMapProvider.future);
  return RiskEngine.calculate(techniques: techniques, coverageMap: covMap);
}

// ─── Convenience accessors (used in UI) ──────────────────────────────────────
@riverpod
Future<double> orgRiskScore(Ref ref) async {
  final report = await ref.watch(riskReportProvider.future);
  return report.orgRiskScore;
}

@riverpod
Future<double> coveragePercentage(Ref ref) async {
  final report = await ref.watch(riskReportProvider.future);
  return report.coveragePercent;
}

@riverpod
Future<Map<String, int>> coverageBreakdown(Ref ref) async {
  final report = await ref.watch(riskReportProvider.future);
  return {
    'covered':   report.coveredCount,
    'partial':   report.partialCount,
    'uncovered': report.uncoveredCount,
    'unknown':   report.unknownCount,
  };
}

@riverpod
Future<List<String>> topCoverageGaps(Ref ref) async {
  final report = await ref.watch(riskReportProvider.future);
  return report.topGaps;
}

// ─── Per-technique coverage status ───────────────────────────────────────────
@riverpod
Future<CoverageStatus?> techniqueCoverageStatus(Ref ref, String techniqueId) async {
  final repo = ref.watch(coverageRepositoryProvider);
  return repo.getCoverageStatus(techniqueId);
}

// ─── Mutation: set coverage level for a technique ────────────────────────────
@riverpod
Future<void> setCoverageLevel(
  Ref ref,
  String techniqueId,
  CoverageLevel level, {
  String? notes,
  List<String>? controls,
}) async {
  final repo = ref.watch(coverageRepositoryProvider);
  final existing = await repo.getCoverageStatus(techniqueId);

  final updated = CoverageStatus(
    id:              existing?.id ?? techniqueId,
    techniqueId:     techniqueId,
    level:           level,
    notes:           notes ?? existing?.notes,
    relatedControls: controls ?? existing?.relatedControls ?? [],
    lastUpdated:     DateTime.now(),
  );

  await repo.updateCoverageStatus(updated);

  // Invalidate all derived providers so UI refreshes
  ref.invalidate(allCoverageStatusesProvider);
  ref.invalidate(coverageMapProvider);
  ref.invalidate(riskReportProvider);
  ref.invalidate(orgRiskScoreProvider);
  ref.invalidate(coveragePercentageProvider);
  ref.invalidate(coverageBreakdownProvider);
  ref.invalidate(topCoverageGapsProvider);
}

// ─── Tactic-level coverage (for matrix heatmap) ──────────────────────────────
@riverpod
Future<List<TacticRiskEntry>> tacticRiskBreakdown(Ref ref) async {
  final report = await ref.watch(riskReportProvider.future);
  return report.tacticBreakdown;
}

// ─── Coverage stats for a specific tactic ────────────────────────────────────
@riverpod
Future<({int covered, int total, double coveragePct})> tacticCoverageStats(
  Ref ref,
  String tacticShortName,
) async {
  final byTactic = await ref.watch(techniquesByTacticProvider.future);
  final covMap   = await ref.watch(coverageMapProvider.future);
  final techs    = byTactic[tacticShortName] ?? [];
  if (techs.isEmpty) return (covered: 0, total: 0, coveragePct: 0.0);

  final covered = techs.where((t) =>
    covMap[t.id] == CoverageLevel.covered
  ).length;

  return (
    covered:     covered,
    total:       techs.length,
    coveragePct: (covered / techs.length) * 100.0,
  );
}