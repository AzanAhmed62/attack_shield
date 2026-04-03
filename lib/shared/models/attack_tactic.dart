import 'package:freezed_annotation/freezed_annotation.dart';

part 'attack_tactic.freezed.dart';
part 'attack_tactic.g.dart';

/// Represents a MITRE ATT&CK tactic (phase of an attack)
@freezed
class AttackTactic with _$AttackTactic {
  const factory AttackTactic({
    required String id,
    required String name,
    required String description,
    @Default([]) List<String> techniqueIds,
  }) = _AttackTactic;

  factory AttackTactic.fromJson(Map<String, dynamic> json) =>
      _$AttackTacticFromJson(json);
}
