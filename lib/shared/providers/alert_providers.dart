import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'alert_providers.g.dart';

// ─── Raw data ─────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<List<AlertItem>> allAlerts(Ref ref) async {
  final repository = ref.watch(alertRepositoryProvider);
  return repository.getAllAlerts();
}

// ─── Filter state ─────────────────────────────────────────────────────────────

/// Search query for the alerts screen.
@Riverpod(keepAlive: false)
class AlertSearchQuery extends _$AlertSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
  void clear() => state = '';
}

/// Selected alert status filter (empty = all).
@Riverpod(keepAlive: false)
class SelectedAlertStatus extends _$SelectedAlertStatus {
  @override
  String build() => '';

  void select(String statusName) => state = statusName;
  void clear() => state = '';
}

/// Selected alert priority filter (null = all).
@Riverpod(keepAlive: false)
class SelectedAlertPriority extends _$SelectedAlertPriority {
  @override
  AlertPriority? build() => null;

  void select(AlertPriority priority) => state = priority;
  void clear() => state = null;
}

// ─── Computed ─────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<List<AlertItem>> filteredAlerts(Ref ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  final query = ref.watch(alertSearchQueryProvider);
  final status = ref.watch(selectedAlertStatusProvider);
  final priority = ref.watch(selectedAlertPriorityProvider);

  var result = alerts;

  if (status.isNotEmpty) {
    result = result
        .where((a) => a.status.name == status)
        .toList();
  }

  if (priority != null) {
    result = result.where((a) => a.priority == priority).toList();
  }

  if (query.isNotEmpty) {
    final q = query.toLowerCase();
    result = result
        .where(
          (a) =>
              a.title.toLowerCase().contains(q) ||
              a.description.toLowerCase().contains(q) ||
              a.source.toLowerCase().contains(q) ||
              (a.relatedTechniqueId?.toLowerCase().contains(q) ?? false),
        )
        .toList();
  }

  // Sort: critical first, then by date
  result.sort((a, b) {
    final pc = b.priority.index.compareTo(a.priority.index);
    if (pc != 0) return pc;
    return b.createdAt.compareTo(a.createdAt);
  });

  return result;
}

@Riverpod(keepAlive: false)
Future<int> alertCountProvider(Ref ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts.length;
}

@Riverpod(keepAlive: false)
Future<int> openAlertCount(Ref ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts.where((a) => a.status == AlertStatus.open).length;
}

@Riverpod(keepAlive: false)
Future<int> criticalAlertCount(Ref ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts
      .where((a) =>
          a.priority == AlertPriority.critical &&
          a.status == AlertStatus.open)
      .length;
}

// ─── Mutations ────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<void> createAlert(Ref ref, AlertItem alert) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.createAlert(alert);
  ref.invalidate(allAlertsProvider);
  ref.invalidate(filteredAlertsProvider);
  ref.invalidate(openAlertCountProvider);
  ref.invalidate(criticalAlertCountProvider);
}

@Riverpod(keepAlive: false)
Future<void> updateAlert(Ref ref, AlertItem alert) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.updateAlert(alert);
  ref.invalidate(allAlertsProvider);
  ref.invalidate(filteredAlertsProvider);
  ref.invalidate(openAlertCountProvider);
  ref.invalidate(criticalAlertCountProvider);
}

@Riverpod(keepAlive: false)
Future<void> deleteAlert(Ref ref, String id) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.deleteAlert(id);
  ref.invalidate(allAlertsProvider);
  ref.invalidate(filteredAlertsProvider);
  ref.invalidate(openAlertCountProvider);
  ref.invalidate(criticalAlertCountProvider);
}