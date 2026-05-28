import 'package:attackshield/core/constants/constants.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/data/repositories/repositories.dart';
import 'package:attackshield/data/services/services.dart';
import 'package:attackshield/shared/models/security_alert.dart';

/// Seeds realistic sample data after onboarding completes.
/// Only runs once — subsequent launches skip it.
class SeedDataService {
  static const String _seedKey = 'seed_data_v1_done';

  final LocalStorageService _storage;
  final AlertRepository _alertRepo;
  final AssetRepository _assetRepo;

  SeedDataService({
    required LocalStorageService storage,
    required AlertRepository alertRepo,
    required AssetRepository assetRepo,
  }) : _storage = storage,
       _alertRepo = alertRepo,
       _assetRepo = assetRepo;

  Future<void> seedIfNeeded() async {
    final alreadySeeded = _storage.read<bool>(_seedKey) ?? false;
    final onboardingComplete =
        _storage.read<bool>(AppConstants.storageKeyOnboardingComplete) ?? false;
    if (alreadySeeded || !onboardingComplete) return;

    await _seedAlerts();
    // Simulations are created from the UI directly — no seeding needed
    await _seedAssets();

    await _storage.write(_seedKey, true);
  }

  Future<void> _seedAlerts() async {
    final alerts = [
      AlertItem(
        id: 'seed-alert-001',
        title: 'Suspicious PowerShell Execution Detected',
        description:
            'EDR flagged base64-encoded PowerShell invocation on workstation WS-042. '
            'Process tree shows wscript.exe → powershell.exe. Potential T1059.001 activity.',
        priority: AlertPriority.critical,
        status: AlertStatus.open,
        source: 'EDR / CrowdStrike',
        relatedTechniqueId: 'T1059.001',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        notes: 'Awaiting forensic analysis of the PowerShell script block.',
      ),
      AlertItem(
        id: 'seed-alert-002',
        title: 'Failed Login Attempts — Multiple Accounts',
        description:
            'SIEM detected 47 failed login attempts across 12 accounts in 10 minutes. '
            'Source IP: 185.220.101.42 (Tor exit node). Possible credential stuffing attack.',
        priority: AlertPriority.high,
        status: AlertStatus.acknowledged,
        source: 'SIEM / Splunk',
        relatedTechniqueId: 'T1110.004',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
        notes:
            'Account lockout policy triggered. Monitoring for further attempts.',
      ),
      AlertItem(
        id: 'seed-alert-003',
        title: 'Unusual Outbound DNS Traffic',
        description:
            'DNS monitoring identified high-frequency queries to randomised subdomains '
            'of domain iodine-test.example.com. Pattern consistent with DNS tunneling (T1071.004).',
        priority: AlertPriority.medium,
        status: AlertStatus.open,
        source: 'DNS Monitor',
        relatedTechniqueId: 'T1071.004',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    for (final alert in alerts) {
      final securityAlert = SecurityAlert(
        id: alert.id,
        title: alert.title,
        description: alert.description,
        severity: _priorityToSeverity(alert.priority),
        status: _statusToString(alert.status),
        source: alert.source,
        linkedTechniqueId: alert.relatedTechniqueId,
        createdAt: alert.createdAt,
        isRead: false,
        notes: alert.notes,
      );
      await _alertRepo.createAlert(securityAlert);
    }
  }

  String _priorityToSeverity(AlertPriority priority) {
    return switch (priority) {
      AlertPriority.critical => 'critical',
      AlertPriority.high => 'high',
      AlertPriority.medium => 'medium',
      AlertPriority.low => 'low',
    };
  }

  String _statusToString(AlertStatus status) {
    return switch (status) {
      AlertStatus.open => 'open',
      AlertStatus.acknowledged => 'open',
      AlertStatus.resolved => 'resolved',
    };
  }

  Future<void> _seedAssets() async {
    // The AssetRepository already seeds default assets in _defaultAssets().
    // This just ensures the storage is populated if it was previously empty.
    final existing = await _assetRepo.getAllAssets();
    if (existing.isEmpty) {
      // Default assets are returned automatically by the repo,
      // so no action needed — they'll appear on next read.
    }
  }
}
