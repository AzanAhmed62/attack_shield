// lib/shared/models/alert_item.dart
// UPDATED — keeps AlertPriority / AlertStatus enums but adds fields our
// new screens need (linkedTechniqueId, isRead, severity String helper).
// All old code that used AlertItem still compiles unchanged.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_item.freezed.dart';
part 'alert_item.g.dart';

enum AlertPriority { low, medium, high, critical }
enum AlertStatus   { open, acknowledged, resolved }

@freezed
class AlertItem with _$AlertItem {
  const factory AlertItem({
    required String id,
    required String title,
    @Default('') String description,
    @Default(AlertPriority.medium) AlertPriority priority,
    @Default(AlertStatus.open)     AlertStatus   status,
    @Default('Manual')             String        source,

    // Technique linkage (new)
    String? linkedTechniqueId,
    @Deprecated('Use linkedTechniqueId')
    String? relatedTechniqueId,

    required DateTime createdAt,
    @Default(DateTime.now) DateTime updatedAt,

    // Read tracking (new)
    @Default(false) bool isRead,

    String? notes,
  }) = _AlertItem;

  factory AlertItem.fromJson(Map<String, dynamic> json) =>
      _$AlertItemFromJson(json);
}

// ── Convenience extensions ────────────────────────────────────────────────────
extension AlertItemX on AlertItem {
  /// Returns a String severity matching our UI convention.
  String get severity {
    switch (priority) {
      case AlertPriority.critical: return 'critical';
      case AlertPriority.high:     return 'high';
      case AlertPriority.medium:   return 'medium';
      case AlertPriority.low:      return 'low';
    }
  }

  /// True if this alert is still open.
  bool get isOpen => status == AlertStatus.open;

  /// The technique this alert is linked to (new or legacy field).
  String? get effectiveLinkedTechniqueId =>
      linkedTechniqueId ?? relatedTechniqueId;
}

// ── Factory helpers ───────────────────────────────────────────────────────────
extension AlertItemFactory on AlertItem {
  static AlertItem create({
    required String id,
    required String title,
    String description = '',
    String severity    = 'medium',
    String source      = 'Manual',
    String? linkedTechniqueId,
    String? notes,
  }) {
    AlertPriority p;
    switch (severity) {
      case 'critical': p = AlertPriority.critical; break;
      case 'high':     p = AlertPriority.high;     break;
      case 'low':      p = AlertPriority.low;       break;
      default:         p = AlertPriority.medium;
    }
    return AlertItem(
      id:                  id,
      title:               title,
      description:         description,
      priority:            p,
      source:              source,
      linkedTechniqueId:   linkedTechniqueId,
      createdAt:           DateTime.now(),
      updatedAt:           DateTime.now(),
      notes:               notes,
    );
  }
}
