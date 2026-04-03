import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_item.freezed.dart';
part 'alert_item.g.dart';

enum AlertPriority { low, medium, high, critical }

enum AlertStatus { open, acknowledged, resolved }

/// Represents a security alert or intelligence note
@freezed
class AlertItem with _$AlertItem {
  const factory AlertItem({
    required String id,
    required String title,
    required String description,
    required AlertPriority priority,
    required AlertStatus status,
    required String source,
    String? relatedTechniqueId,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? notes,
  }) = _AlertItem;

  factory AlertItem.fromJson(Map<String, dynamic> json) =>
      _$AlertItemFromJson(json);
}
