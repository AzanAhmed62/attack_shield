import 'package:freezed_annotation/freezed_annotation.dart';

part 'attack_technique.freezed.dart';
part 'attack_technique.g.dart';

/// Represents a MITRE ATT&CK sub-technique (e.g. T1566.001)
@freezed
class AttackSubTechnique with _$AttackSubTechnique {
  const factory AttackSubTechnique({
    required String id, // e.g. "T1566.001"
    required String name, // e.g. "Spearphishing Attachment"
    required String description,
    @Default([]) List<String> platforms,
    @Default([]) List<String> detectionIds,
    @Default([]) List<String> mitigationIds,
    @Default(5.0) double riskScore,
  }) = _AttackSubTechnique;

  factory AttackSubTechnique.fromJson(Map<String, dynamic> json) =>
      _$AttackSubTechniqueFromJson(json);
}

/// Represents a MITRE ATT&CK technique (parent, e.g. T1566)
@freezed
class AttackTechnique with _$AttackTechnique {
  const factory AttackTechnique({
    required String id, // e.g. "T1566"
    required String name, // e.g. "Phishing"
    required String description,
    required List<String> tactics, // tactic names this belongs to
    @Default([]) List<String> platforms,
    @Default([]) List<String> detectionIds,
    @Default([]) List<String> mitigationIds,
    @Default([]) List<String> relatedTechniqueIds,
    @Default([]) List<AttackSubTechnique> subTechniques,
    @Default(5.0) double riskScore, // 0.0 – 10.0
    String? source,
    DateTime? lastModified,
    String? externalUrl,
    // Defensive enrichment fields
    @Default([]) List<String> detectionNotes, // free-text detection hints
    @Default([]) List<String> mitigationNotes, // free-text mitigation hints
    String? dataSource, // e.g. "Process monitoring"
  }) = _AttackTechnique;

  factory AttackTechnique.fromJson(Map<String, dynamic> json) =>
      _$AttackTechniqueFromJson(json);
}
