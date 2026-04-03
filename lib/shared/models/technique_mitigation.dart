import 'package:freezed_annotation/freezed_annotation.dart';

part 'technique_mitigation.freezed.dart';
part 'technique_mitigation.g.dart';

/// Mitigation/defense for a technique
@freezed
class TechniqueMitigation with _$TechniqueMitigation {
  const factory TechniqueMitigation({
    required String id,
    required String techniqueId,
    required String mitigationId,
    required String description,
    String? type, // e.g., 'Technical', 'Procedural'
  }) = _TechniqueMitigation;

  factory TechniqueMitigation.fromJson(Map<String, dynamic> json) =>
      _$TechniqueMitigationFromJson(json);
}
