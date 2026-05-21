// lib/shared/providers/alert_providers.dart
// Real CRUD providers for AlertItem with proper enums and types.

import 'package:attackshield/shared/models/alert_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'repository_providers.dart';

part 'alert_providers.g.dart';

// ─── All alerts (live list) ───────────────────────────────────────────────────
@Riverpod(keepAlive: false)
Future<List<AlertItem>> alerts(Ref ref) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAllAlerts();
}

// ─── Create ───────────────────────────────────────────────────────────────────
@riverpod
Future<void> createAlert(Ref ref, AlertItem alert) async {
  final repo = ref.read(alertRepositoryProvider);
  await repo.createAlert(alert);
  ref.invalidate(alertsProvider);
}

// ─── Update status ────────────────────────────────────────────────────────────
@riverpod
Future<void> updateAlertStatus(Ref ref, String id, AlertStatus status) async {
  final repo = ref.read(alertRepositoryProvider);
  final alerts = await repo.getAllAlerts();
  final alert = alerts.firstWhere((a) => a.id == id);
  await repo.updateAlert(alert.copyWith(status: status));
  ref.invalidate(alertsProvider);
}

// ─── Resolve alert ────────────────────────────────────────────────────────────
@riverpod
Future<void> resolveAlert(Ref ref, String id) async {
  final repo = ref.read(alertRepositoryProvider);
  final alerts = await repo.getAllAlerts();
  final alert = alerts.firstWhere((a) => a.id == id);
  await repo.updateAlert(alert.copyWith(status: AlertStatus.resolved));
  ref.invalidate(alertsProvider);
}

// ─── Acknowledge alert ────────────────────────────────────────────────────────
@riverpod
Future<void> acknowledgeAlert(Ref ref, String id) async {
  final repo = ref.read(alertRepositoryProvider);
  final alerts = await repo.getAllAlerts();
  final alert = alerts.firstWhere((a) => a.id == id);
  await repo.updateAlert(alert.copyWith(status: AlertStatus.acknowledged));
  ref.invalidate(alertsProvider);
}

// ─── Delete ───────────────────────────────────────────────────────────────────
@riverpod
Future<void> deleteAlert(Ref ref, String id) async {
  final repo = ref.read(alertRepositoryProvider);
  await repo.deleteAlert(id);
  ref.invalidate(alertsProvider);
}

// ─── Get by status ────────────────────────────────────────────────────────────
@riverpod
Future<List<AlertItem>> alertsByStatus(Ref ref, AlertStatus status) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAlertsByStatus(status);
}

// ─── Get by priority ──────────────────────────────────────────────────────────
@riverpod
Future<List<AlertItem>> alertsByPriority(
  Ref ref,
  AlertPriority priority,
) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAlertsByPriority(priority);
}

// ─── Get by technique ─────────────────────────────────────────────────────────
@riverpod
Future<List<AlertItem>> alertsByTechnique(Ref ref, String techniqueId) async {
  final repo = ref.watch(alertRepositoryProvider);
  return repo.getAlertsByTechnique(techniqueId);
}

// ─── Alert count (for dashboard badge) ───────────────────────────────────────
@riverpod
Future<int> openAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all.where((a) => a.status == AlertStatus.open).length;
}

@riverpod
Future<int> criticalAlertCount(Ref ref) async {
  final all = await ref.watch(alertsProvider.future);
  return all
      .where(
        (a) =>
            a.priority == AlertPriority.critical &&
            a.status == AlertStatus.open,
      )
      .length;
}
