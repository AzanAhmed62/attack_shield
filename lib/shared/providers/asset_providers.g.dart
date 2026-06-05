// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAssetsHash() => r'0b0ff1947c5c246dabceb3caffe59ceefbea1797';

/// See also [allAssets].
@ProviderFor(allAssets)
final allAssetsProvider =
    AutoDisposeFutureProvider<List<SecurityAsset>>.internal(
      allAssets,
      name: r'allAssetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allAssetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllAssetsRef = AutoDisposeFutureProviderRef<List<SecurityAsset>>;
String _$assetByIdHash() => r'9c3849afb9ec8c4ea3eca9d80f649faefec2b65b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [assetById].
@ProviderFor(assetById)
const assetByIdProvider = AssetByIdFamily();

/// See also [assetById].
class AssetByIdFamily extends Family<AsyncValue<SecurityAsset?>> {
  /// See also [assetById].
  const AssetByIdFamily();

  /// See also [assetById].
  AssetByIdProvider call(String id) {
    return AssetByIdProvider(id);
  }

  @override
  AssetByIdProvider getProviderOverride(covariant AssetByIdProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assetByIdProvider';
}

/// See also [assetById].
class AssetByIdProvider extends AutoDisposeFutureProvider<SecurityAsset?> {
  /// See also [assetById].
  AssetByIdProvider(String id)
    : this._internal(
        (ref) => assetById(ref as AssetByIdRef, id),
        from: assetByIdProvider,
        name: r'assetByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assetByIdHash,
        dependencies: AssetByIdFamily._dependencies,
        allTransitiveDependencies: AssetByIdFamily._allTransitiveDependencies,
        id: id,
      );

  AssetByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<SecurityAsset?> Function(AssetByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssetByIdProvider._internal(
        (ref) => create(ref as AssetByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SecurityAsset?> createElement() {
    return _AssetByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssetByIdRef on AutoDisposeFutureProviderRef<SecurityAsset?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AssetByIdProviderElement
    extends AutoDisposeFutureProviderElement<SecurityAsset?>
    with AssetByIdRef {
  _AssetByIdProviderElement(super.provider);

  @override
  String get id => (origin as AssetByIdProvider).id;
}

String _$assetCountByTypeHash() => r'241d95aba104d17702ede9ef92586b0479613480';

/// Assets grouped by type — used for the coverage matrix asset distribution view.
///
/// Copied from [assetCountByType].
@ProviderFor(assetCountByType)
final assetCountByTypeProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      assetCountByType,
      name: r'assetCountByTypeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$assetCountByTypeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssetCountByTypeRef = AutoDisposeFutureProviderRef<Map<String, int>>;
String _$criticalAssetCountHash() =>
    r'ebd7b4f35ddf72e3e644491b4363156873dcc7d6';

/// Count of critical assets only.
///
/// Copied from [criticalAssetCount].
@ProviderFor(criticalAssetCount)
final criticalAssetCountProvider = AutoDisposeFutureProvider<int>.internal(
  criticalAssetCount,
  name: r'criticalAssetCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$criticalAssetCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CriticalAssetCountRef = AutoDisposeFutureProviderRef<int>;
String _$createAssetHash() => r'e3d1edbde40a4a06c52085ec41f9cdd898a766ad';

/// See also [createAsset].
@ProviderFor(createAsset)
const createAssetProvider = CreateAssetFamily();

/// See also [createAsset].
class CreateAssetFamily extends Family<AsyncValue<void>> {
  /// See also [createAsset].
  const CreateAssetFamily();

  /// See also [createAsset].
  CreateAssetProvider call(SecurityAsset asset) {
    return CreateAssetProvider(asset);
  }

  @override
  CreateAssetProvider getProviderOverride(
    covariant CreateAssetProvider provider,
  ) {
    return call(provider.asset);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createAssetProvider';
}

/// See also [createAsset].
class CreateAssetProvider extends AutoDisposeFutureProvider<void> {
  /// See also [createAsset].
  CreateAssetProvider(SecurityAsset asset)
    : this._internal(
        (ref) => createAsset(ref as CreateAssetRef, asset),
        from: createAssetProvider,
        name: r'createAssetProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createAssetHash,
        dependencies: CreateAssetFamily._dependencies,
        allTransitiveDependencies: CreateAssetFamily._allTransitiveDependencies,
        asset: asset,
      );

  CreateAssetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.asset,
  }) : super.internal();

  final SecurityAsset asset;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateAssetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateAssetProvider._internal(
        (ref) => create(ref as CreateAssetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        asset: asset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateAssetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAssetProvider && other.asset == asset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateAssetRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `asset` of this provider.
  SecurityAsset get asset;
}

class _CreateAssetProviderElement extends AutoDisposeFutureProviderElement<void>
    with CreateAssetRef {
  _CreateAssetProviderElement(super.provider);

  @override
  SecurityAsset get asset => (origin as CreateAssetProvider).asset;
}

String _$updateAssetHash() => r'd7586343768ef08ce68649e165c3f686c26fe9a1';

/// See also [updateAsset].
@ProviderFor(updateAsset)
const updateAssetProvider = UpdateAssetFamily();

/// See also [updateAsset].
class UpdateAssetFamily extends Family<AsyncValue<void>> {
  /// See also [updateAsset].
  const UpdateAssetFamily();

  /// See also [updateAsset].
  UpdateAssetProvider call(SecurityAsset asset) {
    return UpdateAssetProvider(asset);
  }

  @override
  UpdateAssetProvider getProviderOverride(
    covariant UpdateAssetProvider provider,
  ) {
    return call(provider.asset);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateAssetProvider';
}

/// See also [updateAsset].
class UpdateAssetProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateAsset].
  UpdateAssetProvider(SecurityAsset asset)
    : this._internal(
        (ref) => updateAsset(ref as UpdateAssetRef, asset),
        from: updateAssetProvider,
        name: r'updateAssetProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateAssetHash,
        dependencies: UpdateAssetFamily._dependencies,
        allTransitiveDependencies: UpdateAssetFamily._allTransitiveDependencies,
        asset: asset,
      );

  UpdateAssetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.asset,
  }) : super.internal();

  final SecurityAsset asset;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateAssetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateAssetProvider._internal(
        (ref) => create(ref as UpdateAssetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        asset: asset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateAssetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAssetProvider && other.asset == asset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateAssetRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `asset` of this provider.
  SecurityAsset get asset;
}

class _UpdateAssetProviderElement extends AutoDisposeFutureProviderElement<void>
    with UpdateAssetRef {
  _UpdateAssetProviderElement(super.provider);

  @override
  SecurityAsset get asset => (origin as UpdateAssetProvider).asset;
}

String _$deleteAssetHash() => r'3df3ea9c9541e2125a8b40e59657d7e6ed5fda2d';

/// See also [deleteAsset].
@ProviderFor(deleteAsset)
const deleteAssetProvider = DeleteAssetFamily();

/// See also [deleteAsset].
class DeleteAssetFamily extends Family<AsyncValue<void>> {
  /// See also [deleteAsset].
  const DeleteAssetFamily();

  /// See also [deleteAsset].
  DeleteAssetProvider call(String id) {
    return DeleteAssetProvider(id);
  }

  @override
  DeleteAssetProvider getProviderOverride(
    covariant DeleteAssetProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteAssetProvider';
}

/// See also [deleteAsset].
class DeleteAssetProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteAsset].
  DeleteAssetProvider(String id)
    : this._internal(
        (ref) => deleteAsset(ref as DeleteAssetRef, id),
        from: deleteAssetProvider,
        name: r'deleteAssetProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteAssetHash,
        dependencies: DeleteAssetFamily._dependencies,
        allTransitiveDependencies: DeleteAssetFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteAssetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteAssetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteAssetProvider._internal(
        (ref) => create(ref as DeleteAssetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteAssetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteAssetProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteAssetRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeleteAssetProviderElement extends AutoDisposeFutureProviderElement<void>
    with DeleteAssetRef {
  _DeleteAssetProviderElement(super.provider);

  @override
  String get id => (origin as DeleteAssetProvider).id;
}

String _$clearAllAssetsHash() => r'b68bd2bc90739774a68c3f9b82232720c4794eb7';

/// See also [clearAllAssets].
@ProviderFor(clearAllAssets)
final clearAllAssetsProvider = AutoDisposeFutureProvider<void>.internal(
  clearAllAssets,
  name: r'clearAllAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearAllAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearAllAssetsRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
