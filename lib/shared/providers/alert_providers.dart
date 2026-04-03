import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'alert_providers.g.dart';

@Riverpod()
Future<List<AlertItem>> allAlerts(AllAlertsRef ref) async {
  final repository = ref.watch(alertRepositoryProvider);
  return repository.getAllAlerts();
}

@Riverpod()
String selectedAlertStatus(SelectedAlertStatusRef ref) => '';

@Riverpod()
String alertSearchQuery(AlertSearchQueryRef ref) => '';

@Riverpod()
Future<List<AlertItem>> filteredAlerts(FilteredAlertsRef ref) async {
  final allAlerts = await ref.watch(allAlertsProvider.future);
  final statusFilter = ref.watch(selectedAlertStatusProvider);
  final query = ref.watch(alertSearchQueryProvider);

  var result = allAlerts;

  // Filter by status
  if (statusFilter.isNotEmpty) {
    final status = AlertStatus.values.firstWhere(
      (s) => s.toString().split('.').last == statusFilter,
      orElse: () => AlertStatus.open,
    );
    result = result.where((a) => a.status == status).toList();
  }

  // Search by query
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    result = result
        .where(
          (a) =>
              a.title.toLowerCase().contains(lowerQuery) ||
              a.description.toLowerCase().contains(lowerQuery) ||
              a.source.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  // Sort by date (newest first) and priority
  result.sort((a, b) {
    final dateCompare = b.createdAt.compareTo(a.createdAt);
    if (dateCompare != 0) return dateCompare;
    return b.priority.index.compareTo(a.priority.index);
  });

  return result;
}

@Riverpod()
Future<int> alertCount(AlertCountRef ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts.length;
}

@Riverpod()
Future<int> criticalAlertCount(CriticalAlertCountRef ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts.where((a) => a.priority == AlertPriority.critical).length;
}

@Riverpod()
Future<int> openAlertCount(OpenAlertCountRef ref) async {
  final alerts = await ref.watch(allAlertsProvider.future);
  return alerts.where((a) => a.status == AlertStatus.open).length;
}

@Riverpod()
Future<void> createAlert(CreateAlertRef ref, AlertItem alert) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.createAlert(alert);
  ref.invalidate(allAlertsProvider);
}

@Riverpod()
Future<void> updateAlert(UpdateAlertRef ref, AlertItem alert) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.updateAlert(alert);
  ref.invalidate(allAlertsProvider);
}

@Riverpod()
Future<void> deleteAlert(DeleteAlertRef ref, String id) async {
  final repository = ref.watch(alertRepositoryProvider);
  await repository.deleteAlert(id);
  ref.invalidate(allAlertsProvider);
}
