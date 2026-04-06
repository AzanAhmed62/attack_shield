import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/core/services/risk_engine.dart';
import 'technique_providers.dart';
import 'coverage_providers.dart';

part 'risk_providers.g.dart';

/// Overall organization risk score — 0.0 to 100.0
@Riverpod(keepAlive: false)
Future<double> organizationRiskScore(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final coverageStatuses = await ref.watch(allCoverageStatusesProvider.future);
  return RiskEngine.organizationRiskScore(techniques, coverageStatuses);
}

/// Risk label for the organization score (Critical / High / Medium / Low / Minimal)
@Riverpod(keepAlive: false)
Future<String> organizationRiskLabel(Ref ref) async {
  final score = await ref.watch(organizationRiskScoreProvider.future);
  return RiskEngine.riskLabel(score);
}

/// Coverage percentage driven by RiskEngine (0–100)
@Riverpod(keepAlive: false)
Future<double> riskEngineCoveragePercentage(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final coverageStatuses = await ref.watch(allCoverageStatusesProvider.future);
  return RiskEngine.coveragePercentage(techniques, coverageStatuses);
}

/// Coverage breakdown map — { 'covered': N, 'partiallyCovered': N, 'notCovered': N, 'unknown': N }
@Riverpod(keepAlive: false)
Future<Map<String, int>> riskCoverageBreakdown(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final coverageStatuses = await ref.watch(allCoverageStatusesProvider.future);
  return RiskEngine.coverageBreakdown(techniques, coverageStatuses);
}

/// Tactic-level risk map — { tacticName: riskScore(0–10) }
/// Used for the coverage heatmap / matrix screen.
@Riverpod(keepAlive: false)
Future<Map<String, double>> tacticRiskMap(Ref ref) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final coverageStatuses = await ref.watch(allCoverageStatusesProvider.future);
  return RiskEngine.tacticRiskMap(techniques, coverageStatuses);
}

/// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
/// This is the primary output for reports and recommendations.
@Riverpod(keepAlive: false)
Future<List<RiskGap>> topRiskGaps(Ref ref, {int limit = 10}) async {
  final techniques = await ref.watch(allTechniquesProvider.future);
  final coverageStatuses = await ref.watch(allCoverageStatusesProvider.future);
  return RiskEngine.topRiskGaps(techniques, coverageStatuses, limit: limit);
}

/// Risk gaps count by severity
@Riverpod(keepAlive: false)
Future<Map<String, int>> riskGapsBySeverity(Ref ref) async {
  final gaps = await ref.watch(topRiskGapsProvider(limit: 999).future);
  final counts = {'Critical': 0, 'High': 0, 'Medium': 0, 'Low': 0};
  for (final gap in gaps) {
    counts[gap.riskLabel] = (counts[gap.riskLabel] ?? 0) + 1;
  }
  return counts;
}
