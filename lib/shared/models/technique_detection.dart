import 'package:freezed_annotation/freezed_annotation.dart';

part 'technique_detection.freezed.dart';
part 'technique_detection.g.dart';

@freezed
class TechniqueDetection with _$TechniqueDetection {
  const factory TechniqueDetection({
    required String id,
    required String techniqueId,
    required String name,
    @Default('') String description,
    @Default([]) List<String> dataSourcesRequired,
    @Default([]) List<String> toolsRecommended,
  }) = _TechniqueDetection;

  factory TechniqueDetection.fromJson(Map<String, dynamic> json) =>
      _$TechniqueDetectionFromJson(json);
}