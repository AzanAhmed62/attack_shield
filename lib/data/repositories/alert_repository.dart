// lib/data/repositories/alert_repository.dart
// FULL REPLACEMENT — full CRUD that matches alert_providers.dart.
// Persists SecurityAlert objects to GetStorage.

import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../shared/models/security_alert.dart';

const _kAlertsKey = 'security_alerts_v1';

abstract class AlertRepository {
  Future<List<SecurityAlert>> getAllAlerts();
  Future<SecurityAlert?> getAlertById(String id);
  Future<void> createAlert(SecurityAlert alert);
  Future<void> updateAlert(SecurityAlert alert);
  Future<void> deleteAlert(String id);
  Future<void> clearAllAlerts();
}

class AlertRepositoryImpl implements AlertRepository {
  final _box = GetStorage();


  @override
  Future<List<SecurityAlert>> getAllAlerts() async {
    try {
      final raw = _box.read<String>(_kAlertsKey);
      if (raw == null || raw.isEmpty) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      final alerts = list.map(SecurityAlert.fromJson).toList();
      // Sort: newest first, then by severity
      alerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return alerts;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<SecurityAlert?> getAlertById(String id) async {
    final all = await getAllAlerts();
    try {
      return all.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createAlert(SecurityAlert alert) async {
    final all = await getAllAlerts();
    all.insert(0, alert); // newest first
    await _persist(all);
  }

  @override
  Future<void> updateAlert(SecurityAlert alert) async {
    final all = await getAllAlerts();
    final idx = all.indexWhere((a) => a.id == alert.id);
    if (idx == -1) return;
    all[idx] = alert;
    await _persist(all);
  }

  @override
  Future<void> deleteAlert(String id) async {
    final all = await getAllAlerts();
    all.removeWhere((a) => a.id == id);
    await _persist(all);
  }

  @override
  Future<void> clearAllAlerts() async {
    await _box.remove(_kAlertsKey);
  }

  Future<void> _persist(List<SecurityAlert> alerts) async {
    final json = jsonEncode(alerts.map((a) => a.toJson()).toList());
    await _box.write(_kAlertsKey, json);
  }
}