/// App-wide constants and configuration
class AppConstants {
  // App Info
  static const String appName = 'ATT&CK Defender';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Defensive cybersecurity app using MITRE ATT&CK framework';

  // URLs
  static const String mitrAttackUrl = 'https://attack.mitre.org/';
  static const String mitrAttackApiUrl =
      'https://raw.githubusercontent.com/mitre/cti/master/';

  // Storage Keys
  static const String storageKeyOrgProfile = 'organization_profile';
  static const String storageKeyBookmarks = 'bookmarks';
  static const String storageKeyCoverage = 'coverage_statuses';
  static const String storageKeyAlerts = 'alerts';
  static const String storageKeySimResults = 'simulation_results';
  static const String storageKeyAssets = 'security_assets';
  static const String storageKeyThemeMode = 'theme_mode';
  static const String storageKeyOnboardingComplete = 'onboarding_complete';

  // Pagination
  static const int pageSize = 20;

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration cacheExpiry = Duration(hours: 24);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;
}

class TechniqueSeverity {
  static const int low = 1;
  static const int medium = 5;
  static const int high = 7;
  static const int critical = 9;
}

class CoverageLevelDescriptions {
  static const Map<String, String> descriptions = {
    'notCovered': 'This technique is not covered by any controls',
    'partiallyCovered':
        'This technique is partially covered by existing controls',
    'covered': 'This technique is fully covered by existing controls',
    'unknown': 'Coverage status is unknown',
  };
}
