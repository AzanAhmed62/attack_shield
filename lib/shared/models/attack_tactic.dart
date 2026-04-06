import 'package:freezed_annotation/freezed_annotation.dart';

part 'attack_tactic.freezed.dart';
part 'attack_tactic.g.dart';

@freezed
class AttackTactic with _$AttackTactic {
  const factory AttackTactic({
    required String id,          // e.g. 'TA0001'
    required String name,        // e.g. 'Initial Access'
    required String description,
    @Default([]) List<String> techniqueIds,
    String? shortName,           // e.g. 'initial-access'
  }) = _AttackTactic;

  factory AttackTactic.fromJson(Map<String, dynamic> json) =>
      _$AttackTacticFromJson(json);
}