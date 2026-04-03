import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class AssetRepository {
  Future<List<SecurityAsset>> getAllAssets();
  Future<SecurityAsset?> getAssetById(String id);
  Future<void> createAsset(SecurityAsset asset);
  Future<void> updateAsset(SecurityAsset asset);
  Future<void> deleteAsset(String id);
  Future<List<SecurityAsset>> getAssetsByCriticality(String criticality);
  Future<List<SecurityAsset>> getAssetsByPlatform(String platform);
}

class AssetRepositoryImpl implements AssetRepository {
  final LocalStorageService _storageService;
  static const String _storageKey = 'security_assets';

  AssetRepositoryImpl(this._storageService);

  @override
  Future<List<SecurityAsset>> getAllAssets() async {
    try {
      final assetsJson = _storageService.read<List>(_storageKey) ?? [];
      return assetsJson
          .map((e) => SecurityAsset.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch assets: $e');
    }
  }

  @override
  Future<SecurityAsset?> getAssetById(String id) async {
    try {
      final assets = await getAllAssets();
      try {
        return assets.firstWhere((a) => a.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw DataException(message: 'Failed to fetch asset: $e');
    }
  }

  @override
  Future<void> createAsset(SecurityAsset asset) async {
    try {
      final assets = await getAllAssets();
      assets.add(asset);
      await _storageService.write(
        _storageKey,
        assets.map((a) => a.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to create asset: $e');
    }
  }

  @override
  Future<void> updateAsset(SecurityAsset asset) async {
    try {
      final assets = await getAllAssets();
      final index = assets.indexWhere((a) => a.id == asset.id);
      if (index != -1) {
        assets[index] = asset;
        await _storageService.write(
          _storageKey,
          assets.map((a) => a.toJson()).toList(),
        );
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
      await _storageService.write(
        _storageKey,
        assets.map((a) => a.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete asset: $e');
    }
  }

  @override
  Future<List<SecurityAsset>> getAssetsByCriticality(String criticality) async {
    try {
      final assets = await getAllAssets();
      return assets.where((a) => a.type == criticality).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch assets by criticality: $e');
    }
  }

  @override
  Future<List<SecurityAsset>> getAssetsByPlatform(String platform) async {
    try {
      final assets = await getAllAssets();
      return assets.where((a) => a.platform == platform).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch assets by platform: $e');
    }
  }
}
