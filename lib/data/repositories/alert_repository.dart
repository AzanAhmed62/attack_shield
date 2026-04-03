import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class AlertRepository {
  Future<List<AlertItem>> getAllAlerts();
  Future<AlertItem?> getAlertById(String id);
  Future<void> createAlert(AlertItem alert);
  Future<void> updateAlert(AlertItem alert);
  Future<void> deleteAlert(String id);
  Future<List<AlertItem>> getAlertsByStatus(AlertStatus status);
  Future<List<AlertItem>> getAlertsByPriority(AlertPriority priority);
  Future<List<AlertItem>> getAlertsByTechnique(String techniqueId);
  Future<void> clearAllAlerts();
}

class AlertRepositoryImpl implements AlertRepository {
  final LocalStorageService _storageService;
  static const String _storageKey = 'alerts';

  AlertRepositoryImpl(this._storageService);

  @override
  Future<List<AlertItem>> getAllAlerts() async {
    try {
      final alertsJson = _storageService.read<List>(_storageKey) ?? [];
      return alertsJson
          .map((e) => AlertItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch alerts: $e');
    }
  }

  @override
  Future<AlertItem?> getAlertById(String id) async {
    try {
      final alerts = await getAllAlerts();
      try {
        return alerts.firstWhere((a) => a.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw DataException(message: 'Failed to fetch alert: $e');
    }
  }

  @override
  Future<void> createAlert(AlertItem alert) async {
    try {
      final alerts = await getAllAlerts();
      alerts.add(alert);
      await _storageService.write(
        _storageKey,
        alerts.map((a) => a.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to create alert: $e');
    }
  }

  @override
  Future<void> updateAlert(AlertItem alert) async {
    try {
      final alerts = await getAllAlerts();
      final index = alerts.indexWhere((a) => a.id == alert.id);
      if (index != -1) {
        alerts[index] = alert;
        await _storageService.write(
          _storageKey,
          alerts.map((a) => a.toJson()).toList(),
        );
      }
    } catch (e) {
      throw DataException(message: 'Failed to update alert: $e');
    }
  }

  @override
  Future<void> deleteAlert(String id) async {
    try {
      final alerts = await getAllAlerts();
      alerts.removeWhere((a) => a.id == id);
      await _storageService.write(
        _storageKey,
        alerts.map((a) => a.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete alert: $e');
    }
  }

  @override
  Future<List<AlertItem>> getAlertsByStatus(AlertStatus status) async {
    try {
      final alerts = await getAllAlerts();
      return alerts.where((a) => a.status == status).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch alerts by status: $e');
    }
  }

  @override
  Future<List<AlertItem>> getAlertsByPriority(AlertPriority priority) async {
    try {
      final alerts = await getAllAlerts();
      return alerts.where((a) => a.priority == priority).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch alerts by priority: $e');
    }
  }

  @override
  Future<List<AlertItem>> getAlertsByTechnique(String techniqueId) async {
    try {
      final alerts = await getAllAlerts();
      return alerts.where((a) => a.relatedTechniqueId == techniqueId).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch alerts by technique: $e');
    }
  }

  @override
  Future<void> clearAllAlerts() async {
    try {
      await _storageService.remove(_storageKey);
    } catch (e) {
      throw DataException(message: 'Failed to clear alerts: $e');
    }
  }
}
