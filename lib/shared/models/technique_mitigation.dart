import 'package:freezed_annotation/freezed_annotation.dart';

part 'technique_mitigation.freezed.dart';
part 'technique_mitigation.g.dart';

@freezed
class TechniqueMitigation with _$TechniqueMitigation {
  const factory TechniqueMitigation({
    required String id,
    required String techniqueId,
    required String name,
    @Default('') String description,
    String? mitreId,                // e.g. 'M1017'
    @Default([]) List<String> controlFrameworks, // e.g. ['NIST', 'ISO27001']
  }) = _TechniqueMitigation;

  factory TechniqueMitigation.fromJson(Map<String, dynamic> json) =>
      _$TechniqueMitigationFromJson(json);
}