/// String extensions for common operations
extension StringExtensions on String {
  /// Capitalize the first letter
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Convert to title case
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string to specified length
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return substring(0, length) + ellipsis;
  }
}

/// DateTime extensions
extension DateTimeExtensions on DateTime {
  /// Format to simple date string
  String get formattedDate {
    return '$day/${month.toString().padLeft(2, '0')}/$year';
  }

  /// Format to date and time
  String get formattedDateTime {
    return '$formattedDate ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

/// List extensions
extension ListExtensions<T> on List<T> {
  /// Get first or null
  T? getFirstOrNull() {
    return isEmpty ? null : first;
  }

  /// Remove duplicates
  List<T> get unique {
    return toSet().toList();
  }
}
