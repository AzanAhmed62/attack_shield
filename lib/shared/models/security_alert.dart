// lib/shared/models/security_alert.dart
// NEW FILE — SecurityAlert model used by alerts_screen, create_alert_screen,
// alert_providers. Uses Freezed for immutability + JSON serialization.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_alert.freezed.dart';
part 'security_alert.g.dart';

@freezed
class SecurityAlert with _$SecurityAlert {
  const factory SecurityAlert({
    required String id,
    required String title,
    @Default('') String description,
    @Default('medium') String severity,   // 'critical' | 'high' | 'medium' | 'low'
    @Default('Manual') String source,
    String? linkedTechniqueId,
    required DateTime createdAt,
    @Default(false) bool isRead,
    @Default('open') String status,       // 'open' | 'resolved'
    String? notes,
  }) = _SecurityAlert;

  factory SecurityAlert.fromJson(Map<String, dynamic> json) =>
      _$SecurityAlertFromJson(json);
}
