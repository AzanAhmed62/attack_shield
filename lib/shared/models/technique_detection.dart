import 'package:freezed_annotation/freezed_annotation.dart';

part 'technique_detection.freezed.dart';
part 'technique_detection.g.dart';

/// Detection/monitoring idea for a technique
@freezed
class TechniqueDetection with _$TechniqueDetection {
  const factory TechniqueDetection({
    required String id,
    required String techniqueId,
    required String description,
    String? source,
    String? datasource,
  }) = _TechniqueDetection;

  factory TechniqueDetection.fromJson(Map<String, dynamic> json) =>
      _$TechniqueDetectionFromJson(json);
}
