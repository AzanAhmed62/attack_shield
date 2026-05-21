// lib/shared/models/attack_technique.dart
// FULL REPLACEMENT — adds complete STIX fields, sub-technique support,
// and data sources. Run build_runner after replacing this file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attack_technique.freezed.dart';
part 'attack_technique.g.dart';

// ─── Tactic ─────────────────────────────────────────────────────────────────

@freezed
class AttackTactic with _$AttackTactic {
  const factory AttackTactic({
    required String id,          // "TA0001"
    required String name,        // "Initial Access"
    required String shortName,   // "initial-access" (from STIX kill_chain)
    required String description,
    @Default([]) List<String> techniqueIds,
  }) = _AttackTactic;

  factory AttackTactic.fromJson(Map<String, dynamic> json) =>
      _$AttackTacticFromJson(json);
}

// ─── Technique ──────────────────────────────────────────────────────────────

@freezed
class AttackTechnique with _$AttackTechnique {
  const factory AttackTechnique({
    // Core identifiers
    required String id,           // "T1566"
    required String stixId,       // "attack-pattern--xxx" (internal STIX UUID)
    required String name,         // "Phishing"
    required String description,  // Full STIX description

    // Classification
    @Default([]) List<String> tactics,      // tactic shortNames e.g. ["initial-access"]
    @Default([]) List<String> tacticIds,    // TA numbers e.g. ["TA0001"]
    @Default([]) List<String> platforms,    // ["Windows", "macOS", ...]
    @Default([]) List<String> dataSources,  // from x_mitre_data_sources

    // References to related objects (resolved by repo)
    @Default([]) List<String> mitigationIds,       // T-IDs or names of mitigations
    @Default([]) List<String> detectionIds,
    @Default([]) List<String> relatedTechniqueIds,

    // Sub-technique support
    @Default(false) bool isSubTechnique,
    String? parentTechniqueId,             // "T1566" if this is T1566.001
    @Default([]) List<String> subTechniqueIds, // IDs of children

    // Risk
    @Default(5.0) double riskScore,        // 0–10, computed from STIX metadata

    // Metadata
    String? url,                           // MITRE ATT&CK URL
    String? created,
    String? modified,

    // Plain-language enrichment (populated by PlainLanguageService)
    String? plainTitle,
    String? plainSummary,
    String? businessRisk,
    @Default([]) List<String> remediationSteps,
  }) = _AttackTechnique;

  factory AttackTechnique.fromJson(Map<String, dynamic> json) =>
      _$AttackTechniqueFromJson(json);
}