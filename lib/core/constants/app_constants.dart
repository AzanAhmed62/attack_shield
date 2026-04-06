/// App-wide constants and configuration.
class AppConstants {
  AppConstants._();

  // ── App Info ────────────────────────────────────────────────────────────────
  static const String appName = 'ATT&CK Defender';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Defensive cybersecurity platform powered by MITRE ATT&CK Framework';

  // ── External URLs ────────────────────────────────────────────────────────────
  static const String mitrAttackUrl = 'https://attack.mitre.org/';
  static const String mitrAttackApiUrl =
      'https://raw.githubusercontent.com/mitre/cti/master/';

  // ── Storage Keys ─────────────────────────────────────────────────────────────
  static const String storageKeyOrgProfile = 'organization_profile';
  static const String storageKeyBookmarks = 'bookmarks';
  static const String storageKeyCoverage = 'coverage_statuses';
  static const String storageKeyAlerts = 'alerts';
  static const String storageKeyAssets = 'security_assets';
  static const String storageKeySimScenarios = 'simulation_scenarios';
  static const String storageKeySimResults = 'simulation_results';
  static const String storageKeyReports = 'reports';
  static const String storageKeyThemeMode = 'theme_mode';
  static const String storageKeyOnboardingComplete = 'onboarding_complete';

  // ── UI Constants ─────────────────────────────────────────────────────────────
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;

  // ── Pagination ───────────────────────────────────────────────────────────────
  static const int pageSize = 20;

  // ── Timeouts ─────────────────────────────────────────────────────────────────
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration cacheExpiry = Duration(hours: 24);
}

/// Risk score thresholds for UI coloring and labeling.
class RiskThresholds {
  RiskThresholds._();
  static const double low = 3.0;
  static const double medium = 5.0;
  static const double high = 7.0;
  static const double critical = 8.5;
}

/// Coverage level descriptions for UI tooltips.
class CoverageLevelDescriptions {
  CoverageLevelDescriptions._();
  static const Map<String, String> descriptions = {
    'notCovered': 'No controls cover this technique (exposure × 1.0)',
    'partiallyCovered': 'Partial controls in place (exposure × 0.5)',
    'covered': 'Fully covered by controls (exposure × 0.0)',
    'unknown': 'Coverage status not assessed (exposure × 0.7)',
  };
}