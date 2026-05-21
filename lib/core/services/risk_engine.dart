import 'package:attackshield/shared/models/attack_technique.dart';
import 'package:attackshield/shared/models/models.dart';

/// ────────────────────────────────────────────────────────────────────────────
/// RiskEngine — core academic contribution of the AttackShield thesis project.
///
/// Calculates organizational security risk based on:
///   1. Coverage gaps (uncovered / partially covered ATT&CK techniques)
///   2. Technique risk scores from MITRE ATT&CK (0–10 scale)
///   3. Tactic-level exposure weighted by kill-chain phase criticality
///
/// Scoring Formula (for thesis defense):
///
///   ExposedRisk(technique) = riskScore × coverageMultiplier
///     coverageMultiplier:
///       CoverageLevel.covered          → 0.0  (no exposure)
///       CoverageLevel.partiallyCovered → 0.5  (50% exposure)
///       CoverageLevel.unknown          → 0.7  (assumed partial gap)
///       CoverageLevel.notCovered       → 1.0  (full exposure)
///
///   TacticExposure = mean(ExposedRisk) for techniques in that tactic
///
///   OrganizationRisk = Σ(TacticExposure × tacticWeight) / Σ(tacticWeight)
///   NormalizedScore  = (OrganizationRisk / 10.0) × 100  →  0–100
///
/// Reference: MITRE ATT&CK v14 Enterprise framework.
/// ────────────────────────────────────────────────────────────────────────────
class RiskEngine {
  static const double _mCovered = 0.0;
  static const double _mPartial = 0.5;
  static const double _mUnknown = 0.7;
  static const double _mNotCovered = 1.0;

  /// Tactic severity weights — higher = more critical kill-chain phase.
  static const Map<String, double> tacticWeights = {
    'Impact': 1.5,
    'Exfiltration': 1.4,
    'Command and Control': 1.3,
    'Execution': 1.3,
    'Credential Access': 1.2,
    'Privilege Escalation': 1.2,
    'Lateral Movement': 1.2,
    'Persistence': 1.1,
    'Defense Evasion': 1.1,
    'Collection': 1.0,
    'Initial Access': 1.0,
    'Discovery': 0.9,
    'Reconnaissance': 0.8,
    'Resource Development': 0.7,
  };

  // ── Public API ────────────────────────────────────────────────────────────

  /// Exposed risk for one technique given its coverage. Returns 0–10.
  static double techniqueRisk(
    AttackTechnique technique,
    CoverageStatus? coverage,
  ) =>
      technique.riskScore * _multiplier(coverage?.level);

  /// Risk per tactic — { tacticName → exposedRisk 0–10 }.
  static Map<String, double> tacticRiskMap(
    List<AttackTechnique> techniques,
    List<CoverageStatus> coverageStatuses,
  ) {
    final cm = _coverageMap(coverageStatuses);
    final acc = <String, List<double>>{};

    for (final t in techniques) {
      final risk = techniqueRisk(t, cm[t.id]);
      for (final tac in t.tactics) {
        acc.putIfAbsent(tac, () => []).add(risk);
      }
    }

    return {for (final e in acc.entries) e.key: _mean(e.value)};
  }

  /// Weighted org risk normalized to 0–100.
  static double organizationRiskScore(
    List<AttackTechnique> techniques,
    List<CoverageStatus> coverageStatuses,
  ) {
    final tr = tacticRiskMap(techniques, coverageStatuses);
    if (tr.isEmpty) return 0.0;

    double wSum = 0, wTotal = 0;
    for (final e in tr.entries) {
      final w = tacticWeights[e.key] ?? 1.0;
      wSum += e.value * w;
      wTotal += w;
    }

    return ((wSum / wTotal / 10.0) * 100.0).clamp(0.0, 100.0);
  }

  /// Coverage % (0–100). Fully covered = 2 pts, partial = 1 pt.
  static double coveragePercentage(
    List<AttackTechnique> techniques,
    List<CoverageStatus> coverageStatuses,
  ) {
    if (techniques.isEmpty) return 0.0;
    final cm = _coverageMap(coverageStatuses);
    int score = 0;

    for (final t in techniques) {
      final lvl = cm[t.id]?.level ?? CoverageLevel.notCovered;
      if (lvl == CoverageLevel.covered) score += 2;
      if (lvl == CoverageLevel.partiallyCovered) score += 1;
    }

    return (score / (techniques.length * 2)) * 100.0;
  }

  /// Top N uncovered techniques sorted by exposure.
  static List<RiskGap> topRiskGaps(
    List<AttackTechnique> techniques,
    List<CoverageStatus> coverageStatuses, {
    int limit = 10,
  }) {
    final cm = _coverageMap(coverageStatuses);
    final gaps = <RiskGap>[];

    for (final t in techniques) {
      final cov = cm[t.id];
      final lvl = cov?.level ?? CoverageLevel.notCovered;
      if (lvl == CoverageLevel.covered) continue;
      gaps.add(RiskGap(
        technique: t,
        coverageLevel: lvl,
        exposedRiskScore: techniqueRisk(t, cov),
      ));
    }

    return (gaps..sort((a, b) => b.exposedRiskScore.compareTo(a.exposedRiskScore)))
        .take(limit)
        .toList();
  }

  /// Coverage count breakdown.
  static Map<String, int> coverageBreakdown(
    List<AttackTechnique> techniques,
    List<CoverageStatus> coverageStatuses,
  ) {
    final cm = _coverageMap(coverageStatuses);
    int cov = 0, par = 0, nc = 0, unk = 0;

    for (final t in techniques) {
      switch (cm[t.id]?.level ?? CoverageLevel.notCovered) {
        case CoverageLevel.covered:
          cov++;
        case CoverageLevel.partiallyCovered:
          par++;
        case CoverageLevel.unknown:
          unk++;
        case CoverageLevel.notCovered:
          nc++;
      }
    }

    return {
      'covered': cov,
      'partiallyCovered': par,
      'notCovered': nc,
      'unknown': unk,
    };
  }

  /// Human-readable label for a 0–100 score.
  static String riskLabel(double score) {
    if (score >= 80) return 'Critical';
    if (score >= 60) return 'High';
    if (score >= 40) return 'Medium';
    if (score >= 20) return 'Low';
    return 'Minimal';
  }

  // ── Private ───────────────────────────────────────────────────────────────

  static Map<String, CoverageStatus> _coverageMap(
          List<CoverageStatus> s) =>
      {for (final c in s) c.techniqueId: c};

  static double _multiplier(CoverageLevel? lvl) => switch (lvl) {
        CoverageLevel.covered => _mCovered,
        CoverageLevel.partiallyCovered => _mPartial,
        CoverageLevel.unknown => _mUnknown,
        _ => _mNotCovered,
      };

  static double _mean(List<double> v) =>
      v.isEmpty ? 0.0 : v.reduce((a, b) => a + b) / v.length;
}

// ─────────────────────────────────────────────────────────────────────────────

/// A single coverage gap entry — used in reports and Risk Gaps tab.
class RiskGap {
  final AttackTechnique technique;
  final CoverageLevel coverageLevel;
  final double exposedRiskScore; // 0–10

  const RiskGap({
    required this.technique,
    required this.coverageLevel,
    required this.exposedRiskScore,
  });

  String get riskLabel {
    if (exposedRiskScore >= 8.5) return 'Critical';
    if (exposedRiskScore >= 7.0) return 'High';
    if (exposedRiskScore >= 5.0) return 'Medium';
    return 'Low';
  }

  String get coverageLabel {
    switch (coverageLevel) {
      case CoverageLevel.partiallyCovered:
        return 'Partial';
      case CoverageLevel.unknown:
        return 'Unknown';
      default:
        return 'Not Covered';
    }
  }
}