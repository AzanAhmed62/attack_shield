// lib/data/repositories/asset_repository.dart
// NEW FILE — security asset management with GetStorage persistence.

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../shared/models/security_asset.dart';
import '../services/local_storage_service.dart';

const _kAssetsKey = 'security_assets_v1';

abstract class AssetRepository {
  Future<List<SecurityAsset>> getAllAssets();
  Future<SecurityAsset?> getAssetById(String id);
  Future<void> saveAsset(SecurityAsset asset);
  Future<void> deleteAsset(String id);
  Future<void> clearAll();
}

class AssetRepositoryImpl implements AssetRepository {
  final LocalStorageService storage;
  AssetRepositoryImpl(this.storage);

  final _box = GetStorage();

  @override
  Future<List<SecurityAsset>> getAllAssets() async {
    try {
      final raw = _box.read<String>(_kAssetsKey);
      if (raw == null || raw.isEmpty) return [];
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return list.map(SecurityAsset.fromJson).toList();
    } catch (_) { return []; }
  }

  @override
  Future<SecurityAsset?> getAssetById(String id) async {
    final all = await getAllAssets();
    try { return all.firstWhere((a) => a.id == id); } catch (_) { return null; }
  }

  @override
  Future<void> saveAsset(SecurityAsset asset) async {
    final all = await getAllAssets();
    final i   = all.indexWhere((a) => a.id == asset.id);
    if (i == -1) { all.add(asset); } else { all[i] = asset; }
    await _box.write(_kAssetsKey, jsonEncode(all.map((a) => a.toJson()).toList()));
  }

  @override
  Future<void> deleteAsset(String id) async {
    final all = await getAllAssets();
    all.removeWhere((a) => a.id == id);
    await _box.write(_kAssetsKey, jsonEncode(all.map((a) => a.toJson()).toList()));
  }

  @override
  Future<void> clearAll() async => _box.remove(_kAssetsKey);
}
