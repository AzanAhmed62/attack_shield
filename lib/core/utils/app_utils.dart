/// Create utility functions for common operations
import 'package:uuid/uuid.dart';
import 'dart:convert';

class AppUtils {
  static const _uuid = Uuid();

  /// Generate a unique ID
  static String generateId() => _uuid.v4();

  /// Format large numbers with commas
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }

  /// Calculate percentage
  static double calculatePercentage(int current, int total) {
    if (total == 0) return 0;
    return (current / total) * 100;
  }

  /// Convert to JSON safe format
  static String toJsonString(dynamic obj) {
    if (obj == null) return '';
    try {
      return jsonEncode(obj);
    } catch (e) {
      return obj.toString();
    }
  }

  /// Get severity level text from int
  static String severityLevelText(int severity) {
    switch (severity) {
      case 1:
      case 2:
        return 'Low';
      case 3:
      case 4:
        return 'Medium';
      case 5:
      case 6:
        return 'High';
      case 7:
      case 8:
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  /// Get risk color from risk score
  static String getRiskLevelText(double riskScore) {
    if (riskScore < 2.0) return 'Low';
    if (riskScore < 4.0) return 'Medium';
    if (riskScore < 6.0) return 'High';
    return 'Critical';
  }
}
