// lib/shared/providers/alert_providers.dart
// FULL REPLACEMENT — uses AlertItem model (existing), correct Notifier pattern.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/alert_item.dart';
import 'repository_providers.dart';

part 'alert_providers.g.dart';

// ─── All alerts ───────────────────────────────────────────────────────────────
@riverpod
Future<List<AlertItem>> alerts(Ref ref) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAllAlerts();
}

// ─── Alert mutations via Notifier ─────────────────────────────────────────────
@riverpod
class AlertActions extends _$AlertActions {
  @override
  bool build() => false;

  Future<void> create(AlertItem alert) async {
    await ref.read(alertRepositoryProvider).createAlert(alert);
    ref.invalidate(alertsProvider);
  }

  Future<void> resolve(String id) async {
    final repo   = ref.read(alertRepositoryProvider);
    final all    = await repo.getAllAlerts();
    try {
      final alert = all.firstWhere((a) => a.id == id);
      await repo.updateAlert(alert.copyWith(status: AlertStatus.resolved));
      ref.invalidate(alertsProvider);
    } catch (_) {}
  }

  Future<void> acknowledge(String id) async {
    final repo = ref.read(alertRepositoryProvider);
    final all  = await repo.getAllAlerts();
    try {
      final alert = all.firstWhere((a) => a.id == id);
      await repo.updateAlert(alert.copyWith(status: AlertStatus.acknowledged));
      ref.invalidate(alertsProvider);
    } catch (_) {}
  }

  Future<void> markRead(String id) async {
    final repo = ref.read(alertRepositoryProvider);
    final all  = await repo.getAllAlerts();
    try {
      final alert = all.firstWhere((a) => a.id == id);
      if (!alert.isRead) {
        await repo.updateAlert(alert.copyWith(isRead: true));
        ref.invalidate(alertsProvider);
      }
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    await ref.read(alertRepositoryProvider).deleteAlert(id);
    ref.invalidate(alertsProvider);
  }
}

// ─── Counts for dashboard ─────────────────────────────────────────────────────
@riverpod
Future<int> openAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all.where((a) => a.status == AlertStatus.open).length;
}

@riverpod
Future<int> criticalAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all
      .where((a) => a.priority == AlertPriority.critical &&
                    a.status   == AlertStatus.open)
      .length;
}
