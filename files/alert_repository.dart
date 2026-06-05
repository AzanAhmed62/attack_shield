// lib/data/repositories/alert_repository.dart
// NEW FILE — full CRUD using the existing AlertItem model.
// Persists to GetStorage under key 'alert_items_v2'.

import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../shared/models/alert_item.dart';

const _kKey = 'alert_items_v2';

abstract class AlertRepository {
  Future<List<AlertItem>> getAllAlerts();
  Future<AlertItem?> getAlertById(String id);
  Future<void> createAlert(AlertItem alert);
  Future<void> updateAlert(AlertItem alert);
  Future<void> deleteAlert(String id);
  Future<void> clearAll();
}

class AlertRepositoryImpl implements AlertRepository {
  final _box = GetStorage();

  @override
  Future<List<AlertItem>> getAllAlerts() async {
    try {
      final raw = _box.read<String>(_kKey);
      if (raw == null || raw.isEmpty) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(AlertItem.fromJson).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (_) {
      return [];
    }
  }

  @override
  Future<AlertItem?> getAlertById(String id) async {
    final all = await getAllAlerts();
    try { return all.firstWhere((a) => a.id == id); } catch (_) { return null; }
  }

  @override
  Future<void> createAlert(AlertItem alert) async {
    final all = await getAllAlerts();
    all.insert(0, alert);
    await _persist(all);
  }

  @override
  Future<void> updateAlert(AlertItem alert) async {
    final all = await getAllAlerts();
    final i   = all.indexWhere((a) => a.id == alert.id);
    if (i == -1) return;
    all[i] = alert;
    await _persist(all);
  }

  @override
  Future<void> deleteAlert(String id) async {
    final all = await getAllAlerts();
    all.removeWhere((a) => a.id == id);
    await _persist(all);
  }

  @override
  Future<void> clearAll() async => _box.remove(_kKey);

  Future<void> _persist(List<AlertItem> list) async {
    await _box.write(_kKey, jsonEncode(list.map((a) => a.toJson()).toList()));
  }
}
