import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ── String extensions ─────────────────────────────────────────────────────────

extension StringX on String {
  bool get isValidEmail => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(this);

  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ').map((w) => w.capitalized).join(' ');

  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';

  bool get isAttackTechniqueId => RegExp(r'^T\d{4}(\.\d{3})?$').hasMatch(this);
}

// ── DateTime extensions ───────────────────────────────────────────────────────

extension DateTimeX on DateTime {
  String get toReadableDate => DateFormat('MMM d, yyyy').format(this);
  String get toReadableDateTime =>
      DateFormat('MMM d, yyyy – HH:mm').format(this);
  String get toShortDate => DateFormat('MMM d').format(this);
  String get toIsoDate => DateFormat('yyyy-MM-dd').format(this);

  bool get isToday => DateUtils.isSameDay(this, DateTime.now());
  bool get isThisWeek => difference(DateTime.now()).inDays.abs() <= 7;

  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return toReadableDate;
  }
}

// ── List extensions ───────────────────────────────────────────────────────────

extension ListX<T> on List<T> {
  List<T> get unique => toSet().toList();

  List<T> sortedBy<C extends Comparable>(C Function(T) key) {
    final copy = [...this];
    copy.sort((a, b) => key(a).compareTo(key(b)));
    return copy;
  }

  List<T> sortedByDescending<C extends Comparable>(C Function(T) key) {
    final copy = [...this];
    copy.sort((a, b) => key(b).compareTo(key(a)));
    return copy;
  }

  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
}

// ── double extensions ─────────────────────────────────────────────────────────

extension DoubleX on double {
  /// Format as percentage string: 65.5 → '65.5%'
  String get asPercent => '${toStringAsFixed(1)}%';

  /// Format as risk score: 8.5 → '8.5/10'
  String get asRiskScore => '${toStringAsFixed(1)}/10';

  /// Clamp to 0–100 range.
  double get clampPercent => clamp(0.0, 100.0).toDouble();

  /// Clamp to 0–10 range.
  double get clampRisk => clamp(0.0, 10.0).toDouble();
}

// ── int extensions ────────────────────────────────────────────────────────────

extension IntX on int {
  /// Format with commas: 1234567 → '1,234,567'
  String get formatted =>
      toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}
