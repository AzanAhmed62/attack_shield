import 'package:freezed_annotation/freezed_annotation.dart';

part 'attack_technique.freezed.dart';
part 'attack_technique.g.dart';

/// Represents a MITRE ATT&CK technique
@freezed
class AttackTechnique with _$AttackTechnique {
  const factory AttackTechnique({
    required String id,
    required String name,
    required String description,
    required List<String> tactics,
    @Default([]) List<String> platforms,
    @Default([]) List<String> detectionIds,
    @Default([]) List<String> mitigationIds,
    @Default([]) List<String> relatedTechniqueIds,
    @Default(5.0) double riskScore,
    String? source,
    DateTime? lastModified,
    String? externalUrl,
  }) = _AttackTechnique;

  factory AttackTechnique.fromJson(Map<String, dynamic> json) =>
      _$AttackTechniqueFromJson(json);
}
