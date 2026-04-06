import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class AssetRepository {
  Future<List<SecurityAsset>> getAllAssets();
  Future<SecurityAsset?> getAssetById(String id);
  Future<void> createAsset(SecurityAsset asset);
  Future<void> updateAsset(SecurityAsset asset);
  Future<void> deleteAsset(String id);
  Future<List<SecurityAsset>> getAssetsByType(String type);
  Future<List<SecurityAsset>> getAssetsByCriticality(AssetCriticality criticality);
}

class AssetRepositoryImpl implements AssetRepository {
  final LocalStorageService _storageService;
  static const String _key = 'security_assets';

  AssetRepositoryImpl(this._storageService);

  @override
  Future<List<SecurityAsset>> getAllAssets() async {
    try {
      final data = _storageService.read<List>(_key);
      if (data == null) return _defaultAssets();
      final stored = data
          .map((e) => SecurityAsset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      return stored.isEmpty ? _defaultAssets() : stored;
    } catch (e) {
      throw DataException(message: 'Failed to fetch assets: $e');
    }
  }

  @override
  Future<SecurityAsset?> getAssetById(String id) async {
    final assets = await getAllAssets();
    try {
      return assets.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createAsset(SecurityAsset asset) async {
    try {
      final assets = await getAllAssets();
      assets.add(asset);
      await _save(assets);
    } catch (e) {
      throw DataException(message: 'Failed to create asset: $e');
    }
  }

  @override
  Future<void> updateAsset(SecurityAsset asset) async {
    try {
      final assets = await getAllAssets();
      final index = assets.indexWhere((a) => a.id == asset.id);
      if (index >= 0) {
        assets[index] = asset;
        await _save(assets);
      }
    } catch (e) {
      throw DataException(message: 'Failed to update asset: $e');
    }
  }

  @override
  Future<void> deleteAsset(String id) async {
    try {
      final assets = await getAllAssets();
      assets.removeWhere((a) => a.id == id);
      await _save(assets);
    } catch (e) {
      throw DataException(message: 'Failed to delete asset: $e');
    }
  }

  @override
  Future<List<SecurityAsset>> getAssetsByType(String type) async {
    final assets = await getAllAssets();
    return assets.where((a) => a.type.toLowerCase() == type.toLowerCase()).toList();
  }

  @override
  Future<List<SecurityAsset>> getAssetsByCriticality(
      AssetCriticality criticality) async {
    final assets = await getAllAssets();
    return assets.where((a) => a.criticality == criticality).toList();
  }

  Future<void> _save(List<SecurityAsset> assets) async {
    await _storageService.write(_key, assets.map((a) => a.toJson()).toList());
  }

  /// Seed assets so the dashboard never shows 0 on first launch.
  List<SecurityAsset> _defaultAssets() {
    return [
      SecurityAsset(
        id: 'asset-001',
        name: 'Corporate Firewall',
        description: 'Perimeter network firewall',
        type: 'Network',
        criticality: AssetCriticality.critical,
        platforms: ['Network'],
        discoveredAt: DateTime(2024, 1, 1),
      ),
      SecurityAsset(
        id: 'asset-002',
        name: 'Primary Domain Controller',
        description: 'Active Directory domain controller',
        type: 'Server',
        criticality: AssetCriticality.critical,
        platforms: ['Windows'],
        discoveredAt: DateTime(2024, 1, 1),
      ),
      SecurityAsset(
        id: 'asset-003',
        name: 'Developer Workstations',
        description: 'Engineering team endpoints',
        type: 'Workstation',
        criticality: AssetCriticality.high,
        platforms: ['Windows', 'macOS', 'Linux'],
        discoveredAt: DateTime(2024, 1, 1),
      ),
      SecurityAsset(
        id: 'asset-004',
        name: 'Customer Web Portal',
        description: 'Public-facing web application',
        type: 'Application',
        criticality: AssetCriticality.high,
        platforms: ['Linux'],
        discoveredAt: DateTime(2024, 1, 1),
      ),
      SecurityAsset(
        id: 'asset-005',
        name: 'Cloud Storage Bucket',
        description: 'Backup and document storage',
        type: 'Cloud',
        criticality: AssetCriticality.medium,
        platforms: ['IaaS'],
        discoveredAt: DateTime(2024, 1, 1),
      ),
    ];
  }
}