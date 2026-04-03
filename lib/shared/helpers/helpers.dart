/// Common helper functions
class Helpers {
  /// Delay for async operations
  static Future<void> delay({int milliseconds = 500}) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// Print with label if in debug mode
  static void printDebug(String label, dynamic value) {
    // ignore: avoid_print
    print('[$label] $value');
  }
}
