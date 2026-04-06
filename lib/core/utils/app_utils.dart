import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static const _uuid = Uuid();

  /// Generate a unique ID (UUID v4).
  static String generateId() => _uuid.v4();

  /// Format large numbers with commas. e.g. 1234567 → '1,234,567'
  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }

  /// Calculate a percentage. Returns 0 if total is 0.
  static double calculatePercentage(int current, int total) {
    if (total == 0) return 0;
    return (current / total) * 100.0;
  }

  /// Format a DateTime as a readable string. e.g. 'Apr 6, 2026'
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Format a DateTime with time. e.g. 'Apr 6, 2026 – 14:30'
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, yyyy – HH:mm').format(date);
  }

  /// Risk level text from a 0–10 score.
  static String getRiskLevelText(double riskScore) {
    if (riskScore >= 8.5) return 'Critical';
    if (riskScore >= 7.0) return 'High';
    if (riskScore >= 5.0) return 'Medium';
    if (riskScore >= 3.0) return 'Low';
    return 'Minimal';
  }

  /// Risk color from a 0–10 score.
  static Color getRiskColor(double riskScore) {
    if (riskScore >= 8.5) return const Color(0xFFFF3333); // danger
    if (riskScore >= 7.0) return const Color(0xFFFF3366); // accent
    if (riskScore >= 5.0) return const Color(0xFFFFCC00); // warning
    return const Color(0xFF00CC66);                         // success
  }

  /// Organization risk score label from a 0–100 score.
  static String getOrgRiskLabel(double score) {
    if (score >= 80) return 'Critical';
    if (score >= 60) return 'High';
    if (score >= 40) return 'Medium';
    if (score >= 20) return 'Low';
    return 'Minimal';
  }

  /// Coverage level label from a 0–100 percentage.
  static String getCoverageLabel(double percentage) {
    if (percentage >= 80) return 'Excellent';
    if (percentage >= 60) return 'Good';
    if (percentage >= 40) return 'Moderate';
    if (percentage >= 20) return 'Low';
    return 'Critical Gap';
  }

  /// Truncate a string to a max length with ellipsis.
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}…';
  }

  /// Capitalize the first letter of a string.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}