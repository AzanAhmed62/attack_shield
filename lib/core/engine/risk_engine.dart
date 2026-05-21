// lib/core/engine/risk_engine.dart
// NEW FILE — the academic core of the thesis.
// Formula: ExposedRisk = riskScore × coverageMultiplier
// Tactic-level weighted aggregation → normalized 0–100 org risk score.

import '../../shared/models/attack_technique.dart';
import '../../shared/models/coverage_status.dart';

// ─── Tactic weights (documented in thesis §3.2) ────────────────────────────
const _tacticImpactWeights = <String, double>{
  'impact':              1.5,
  'exfiltration':        1.4,
  'command-and-control': 1.3,
  'lateral-movement':    1.3,
  'privilege-escalation':1.2,
  'persistence':         1.2,
  'credential-access':   1.2,
  'execution':           1.1,
  'collection':          1.1,
  'initial-access':      1.1,
  'defense-evasion':     1.0,
  'discovery':           0.9,
  'reconnaissance':      0.8,
  'resource-development':0.7,
};

// Coverage multiplier: how much of the risk is "exposed" given coverage level.
const _coverageMultiplier = <CoverageLevel, double>{
  CoverageLevel.covered:           0.0,   // Fully mitigated — no exposure
  CoverageLevel.partiallyCovered:  0.5,   // Half exposure
  CoverageLevel.notCovered:        1.0,   // Full exposure
  CoverageLevel.unknown:           0.8,   // Assume mostly exposed
};

class RiskEngine {
  /// Compute the organisation risk score (0–100).
  ///
  /// [techniques]    — full list of ATT&CK techniques (parsed from STIX)
  /// [coverageMap]   — map of techniqueId → CoverageLevel
  ///
  /// Returns a [RiskReport] with overall score + per-tactic breakdown.
  static RiskReport calculate({
    required List<AttackTechnique>    techniques,
    required Map<String, CoverageLevel> coverageMap,
  }) {
    // Only assess parent techniques (sub-techniques inherit parent coverage)
    final parents = techniques.where((t) => !t.isSubTechnique).toList();
    if (parents.isEmpty) return RiskReport.zero();

    // ── Per-tactic aggregation ──────────────────────────────────────────────
    final tacticScores = <String, _TacticScore>{};

    for (final technique in parents) {
      final coverage = coverageMap[technique.id] ?? CoverageLevel.unknown;
      final multiplier = _coverageMultiplier[coverage]!;
      final exposedRisk = technique.riskScore * multiplier; // 0–10

      for (final tactic in technique.tactics) {
        tacticScores.putIfAbsent(tactic, () => _TacticScore(tactic));
        tacticScores[tactic]!.addTechnique(
          techniqueId:  technique.id,
          exposedRisk:  exposedRisk,
          rawRisk:      technique.riskScore,
          coverage:     coverage,
        );
      }
    }

    // ── Weighted aggregate ──────────────────────────────────────────────────
    double weightedSum   = 0.0;
    double totalWeight   = 0.0;
    final tacticBreakdown = <TacticRiskEntry>[];

    for (final entry in tacticScores.values) {
      if (entry.techniqueCount == 0) continue;
      final weight      = _tacticImpactWeights[entry.tacticShortName] ?? 1.0;
      final avgExposed  = entry.totalExposedRisk / entry.techniqueCount;
      // Scale to 0–100 (raw score is 0–10)
      final tacticScore = (avgExposed / 10.0) * 100.0;

      weightedSum  += tacticScore * weight;
      totalWeight  += weight;

      tacticBreakdown.add(TacticRiskEntry(
        tacticShortName: entry.tacticShortName,
        score:           double.parse(tacticScore.toStringAsFixed(1)),
        weight:          weight,
        techniqueCount:  entry.techniqueCount,
        coveredCount:    entry.coveredCount,
        uncoveredCount:  entry.uncoveredCount,
      ));
    }

    final orgScore = totalWeight > 0
        ? (weightedSum / totalWeight).clamp(0.0, 100.0)
        : 0.0;

    // ── Coverage summary ────────────────────────────────────────────────────
    final covered        = parents.where((t) =>
        (coverageMap[t.id] ?? CoverageLevel.unknown) == CoverageLevel.covered).length;
    final partial        = parents.where((t) =>
        (coverageMap[t.id] ?? CoverageLevel.unknown) == CoverageLevel.partiallyCovered).length;
    final uncovered      = parents.where((t) =>
        (coverageMap[t.id] ?? CoverageLevel.unknown) == CoverageLevel.notCovered).length;
    final unknown        = parents.length - covered - partial - uncovered;
    final coveragePct    = parents.isEmpty ? 0.0
        : ((covered + partial * 0.5) / parents.length) * 100.0;

    // ── Top uncovered high-risk techniques ─────────────────────────────────
    final topGaps = parents
        .where((t) =>
            (coverageMap[t.id] ?? CoverageLevel.unknown) != CoverageLevel.covered)
        .toList()
      ..sort((a, b) => b.riskScore.compareTo(a.riskScore));

    return RiskReport(
      orgRiskScore:     double.parse(orgScore.toStringAsFixed(1)),
      coveragePercent:  double.parse(coveragePct.toStringAsFixed(1)),
      totalTechniques:  parents.length,
      coveredCount:     covered,
      partialCount:     partial,
      uncoveredCount:   uncovered,
      unknownCount:     unknown,
      tacticBreakdown:  tacticBreakdown..sort((a, b) => b.score.compareTo(a.score)),
      topGaps:          topGaps.take(10).map((t) => t.id).toList(),
    );
  }
}

// ─── Internal accumulator ─────────────────────────────────────────────────────
class _TacticScore {
  final String tacticShortName;
  double totalExposedRisk = 0.0;
  int    techniqueCount   = 0;
  int    coveredCount     = 0;
  int    uncoveredCount   = 0;

  _TacticScore(this.tacticShortName);

  void addTechnique({
    required String        techniqueId,
    required double        exposedRisk,
    required double        rawRisk,
    required CoverageLevel coverage,
  }) {
    totalExposedRisk += exposedRisk;
    techniqueCount++;
    if (coverage == CoverageLevel.covered) coveredCount++;
    if (coverage == CoverageLevel.notCovered) uncoveredCount++;
  }
}

// ─── Output models ────────────────────────────────────────────────────────────
class RiskReport {
  final double orgRiskScore;      // 0–100
  final double coveragePercent;   // 0–100
  final int    totalTechniques;
  final int    coveredCount;
  final int    partialCount;
  final int    uncoveredCount;
  final int    unknownCount;
  final List<TacticRiskEntry> tacticBreakdown;
  final List<String>          topGaps;         // top-10 uncovered T-IDs by risk

  const RiskReport({
    required this.orgRiskScore,
    required this.coveragePercent,
    required this.totalTechniques,
    required this.coveredCount,
    required this.partialCount,
    required this.uncoveredCount,
    required this.unknownCount,
    required this.tacticBreakdown,
    required this.topGaps,
  });

  factory RiskReport.zero() => const RiskReport(
    orgRiskScore:    0,
    coveragePercent: 0,
    totalTechniques: 0,
    coveredCount:    0,
    partialCount:    0,
    uncoveredCount:  0,
    unknownCount:    0,
    tacticBreakdown: [],
    topGaps:         [],
  );

  String get riskLabel {
    if (orgRiskScore >= 75) return 'Critical';
    if (orgRiskScore >= 50) return 'High';
    if (orgRiskScore >= 25) return 'Medium';
    return 'Low';
  }
}

class TacticRiskEntry {
  final String tacticShortName;
  final double score;          // 0–100
  final double weight;
  final int    techniqueCount;
  final int    coveredCount;
  final int    uncoveredCount;

  const TacticRiskEntry({
    required this.tacticShortName,
    required this.score,
    required this.weight,
    required this.techniqueCount,
    required this.coveredCount,
    required this.uncoveredCount,
  });
}