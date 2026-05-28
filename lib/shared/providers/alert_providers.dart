// lib/shared/providers/alert_providers.dart
// FULL REPLACEMENT — correct Riverpod codegen syntax. Family providers only
// take primitive types as params (String, int, bool). Complex object mutations
// use a Notifier pattern instead.

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/security_alert.dart';
import 'repository_providers.dart';

part 'alert_providers.g.dart';

// ─── All alerts (live, re-fetched whenever invalidated) ───────────────────────
@riverpod
Future<List<SecurityAlert>> alerts(Ref ref) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAllAlerts();
}

// ─── Alert mutations via a Notifier (avoids complex family params) ────────────
@riverpod
class AlertActions extends _$AlertActions {
  @override
  bool build() => false; // dummy state — we just use the actions

  Future<void> create(SecurityAlert alert) async {
    final repo = ref.read(alertRepositoryProvider);
    await repo.createAlert(alert);
    ref.invalidate(alertsProvider);
  }

  Future<void> resolve(String id) async {
    final repo   = ref.read(alertRepositoryProvider);
    final alerts = await repo.getAllAlerts();
    try {
      final alert = alerts.firstWhere((a) => a.id == id);
      await repo.updateAlert(alert.copyWith(status: 'resolved'));
      ref.invalidate(alertsProvider);
    } catch (_) {}
  }

  Future<void> markRead(String id) async {
    final repo   = ref.read(alertRepositoryProvider);
    final alerts = await repo.getAllAlerts();
    try {
      final alert = alerts.firstWhere((a) => a.id == id);
      if (!alert.isRead) {
        await repo.updateAlert(alert.copyWith(isRead: true));
        ref.invalidate(alertsProvider);
      }
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    final repo = ref.read(alertRepositoryProvider);
    await repo.deleteAlert(id);
    ref.invalidate(alertsProvider);
  }
}

// ─── Counts (for dashboard) ───────────────────────────────────────────────────
@riverpod
Future<int> openAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all.where((a) => a.status == 'open').length;
}

@riverpod
Future<int> criticalAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all
      .where((a) => a.severity == 'critical' && a.status == 'open')
      .length;
}