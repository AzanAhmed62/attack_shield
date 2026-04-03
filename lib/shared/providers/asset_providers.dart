import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'asset_providers.g.dart';

@Riverpod()
Future<List<SecurityAsset>> allAssets(AllAssetsRef ref) async {
  final repository = ref.watch(assetRepositoryProvider);
  return repository.getAllAssets();
}

@Riverpod()
String selectedAssetCriticality(SelectedAssetCriticalityRef ref) => '';

@Riverpod()
String selectedAssetPlatform(SelectedAssetPlatformRef ref) => '';

@Riverpod()
Future<List<SecurityAsset>> filteredAssets(FilteredAssetsRef ref) async {
  final allAssets = await ref.watch(allAssetsProvider.future);
  final criticalityFilter = ref.watch(selectedAssetCriticalityProvider);
  final platformFilter = ref.watch(selectedAssetPlatformProvider);

  var result = allAssets;

  if (criticalityFilter.isNotEmpty) {
    result = result.where((a) => a.type == criticalityFilter).toList();
  }

  if (platformFilter.isNotEmpty) {
    result = result.where((a) => a.platform == platformFilter).toList();
  }

  return result;
}

@Riverpod()
Future<int> totalAssets(TotalAssetsRef ref) async {
  final assets = await ref.watch(allAssetsProvider.future);
  return assets.length;
}

@Riverpod()
Future<int> criticalAssets(CriticalAssetsRef ref) async {
  final assets = await ref.watch(allAssetsProvider.future);
  return assets.where((a) => a.type == 'critical').length;
}

@Riverpod()
Future<int> highAssets(HighAssetsRef ref) async {
  final assets = await ref.watch(allAssetsProvider.future);
  return assets.where((a) => a.type == 'high').length;
}

@Riverpod()
Future<void> createAsset(CreateAssetRef ref, SecurityAsset asset) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.createAsset(asset);
  ref.invalidate(allAssetsProvider);
}

@Riverpod()
Future<void> updateAsset(UpdateAssetRef ref, SecurityAsset asset) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.updateAsset(asset);
  ref.invalidate(allAssetsProvider);
}

@Riverpod()
Future<void> deleteAsset(DeleteAssetRef ref, String id) async {
  final repository = ref.watch(assetRepositoryProvider);
  await repository.deleteAsset(id);
  ref.invalidate(allAssetsProvider);
}
