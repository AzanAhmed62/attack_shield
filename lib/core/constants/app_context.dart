/// Enum representing the deployment context of the application.
enum AppContext { personalLearning, lab, organizational }

/// Extension for AppContext conversion utilities.
extension AppContextX on AppContext {
  /// Convert enum value to display label.
  String get label {
    return switch (this) {
      AppContext.personalLearning => 'Personal Learning',
      AppContext.lab => 'Lab Environment',
      AppContext.organizational => 'Organization',
    };
  }

  /// Convert this enum to its string representation for storage.
  String get value {
    return switch (this) {
      AppContext.personalLearning => 'personal',
      AppContext.lab => 'lab',
      AppContext.organizational => 'organization',
    };
  }

  /// Parse a string value to AppContext enum.
  static AppContext fromString(String value) {
    return switch (value.toLowerCase()) {
      'personal' || 'personal_learning' => AppContext.personalLearning,
      'lab' => AppContext.lab,
      'organization' || 'organizational' => AppContext.organizational,
      _ => AppContext.personalLearning,
    };
  }

  /// Parse from label (e.g., 'Personal Learning').
  static AppContext fromLabel(String label) {
    return switch (label) {
      'Personal Learning' => AppContext.personalLearning,
      'Lab Environment' => AppContext.lab,
      'Organization' => AppContext.organizational,
      _ => AppContext.personalLearning,
    };
  }
}
