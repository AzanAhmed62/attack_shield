import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'asset_providers.g.dart';

// ── Data ──────────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<List<SecurityAsset>> allAssets(Ref ref) async {
  final repository = ref.watch(assetRepositoryProvider);
  return repository.getAllAssets();
}

@Riverpod(keepAlive: false)
Future<SecurityAsset?> assetById(Ref ref, String id) async {
  final repository = ref.watch(assetRepositoryProvider);
  return repository.getAssetById(id);
}

/// Assets grouped by type — used for the coverage matrix asset distribution view.
@Riverpod(keepAlive: false)
Future<Map<String, int>> assetCountByType(Ref ref) async {
  final assets = await ref.watch(allAssetsProvider.future);
  final counts = <String, int>{};
  for (final a in assets) {
    counts[a.type] = (counts[a.type] ?? 0) + 1;
  }
  return counts;
}

/// Count of critical assets only.
@Riverpod(keepAlive: false)
Future<int> criticalAssetCount(Ref ref) async {
  final assets = await ref.watch(allAssetsProvider.future);
  return assets
      .where((a) => a.criticality == AssetCriticality.critical)
      .length;
}

// ── Mutations ─────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<void> createAsset(Ref ref, SecurityAsset asset) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.createAsset(asset);
  ref.invalidate(allAssetsProvider);
  ref.invalidate(assetCountByTypeProvider);
  ref.invalidate(criticalAssetCountProvider);
}

@Riverpod(keepAlive: false)
Future<void> updateAsset(Ref ref, SecurityAsset asset) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.updateAsset(asset);
  ref.invalidate(allAssetsProvider);
  ref.invalidate(assetCountByTypeProvider);
}

@Riverpod(keepAlive: false)
Future<void> deleteAsset(Ref ref, String id) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.deleteAsset(id);
  ref.invalidate(allAssetsProvider);
  ref.invalidate(assetCountByTypeProvider);
  ref.invalidate(criticalAssetCountProvider);
}