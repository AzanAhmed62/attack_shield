// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAssetsHash() => r'abff0da2f4afdede09c0baa8ae033aba2adfc018';

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
String _$selectedAssetCriticalityHash() =>
    r'664b602cfe88ecc23f44ced8cbb12a937f72aed0';

/// See also [selectedAssetCriticality].
@ProviderFor(selectedAssetCriticality)
final selectedAssetCriticalityProvider = AutoDisposeProvider<String>.internal(
  selectedAssetCriticality,
  name: r'selectedAssetCriticalityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAssetCriticalityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedAssetCriticalityRef = AutoDisposeProviderRef<String>;
String _$selectedAssetPlatformHash() =>
    r'5ff62e488781efc787bfc13d377336096d186064';

/// See also [selectedAssetPlatform].
@ProviderFor(selectedAssetPlatform)
final selectedAssetPlatformProvider = AutoDisposeProvider<String>.internal(
  selectedAssetPlatform,
  name: r'selectedAssetPlatformProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAssetPlatformHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedAssetPlatformRef = AutoDisposeProviderRef<String>;
String _$filteredAssetsHash() => r'9a273478ae3486291afacef5caafa242c4237e1c';

/// See also [filteredAssets].
@ProviderFor(filteredAssets)
final filteredAssetsProvider =
    AutoDisposeFutureProvider<List<SecurityAsset>>.internal(
      filteredAssets,
      name: r'filteredAssetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredAssetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredAssetsRef = AutoDisposeFutureProviderRef<List<SecurityAsset>>;
String _$totalAssetsHash() => r'4f750126d53e0c53b7546a379733d7451c4bfcba';

/// See also [totalAssets].
@ProviderFor(totalAssets)
final totalAssetsProvider = AutoDisposeFutureProvider<int>.internal(
  totalAssets,
  name: r'totalAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalAssetsRef = AutoDisposeFutureProviderRef<int>;
String _$criticalAssetsHash() => r'a472f5a4de49a65cb00afc73449933ecc2b85abc';

/// See also [criticalAssets].
@ProviderFor(criticalAssets)
final criticalAssetsProvider = AutoDisposeFutureProvider<int>.internal(
  criticalAssets,
  name: r'criticalAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$criticalAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CriticalAssetsRef = AutoDisposeFutureProviderRef<int>;
String _$highAssetsHash() => r'b6f45181cb0213b2a04668838ac04a28584f2dfa';

/// See also [highAssets].
@ProviderFor(highAssets)
final highAssetsProvider = AutoDisposeFutureProvider<int>.internal(
  highAssets,
  name: r'highAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$highAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HighAssetsRef = AutoDisposeFutureProviderRef<int>;
String _$createAssetHash() => r'990f0995c1b8b243043bf4fd09e778aef9a58e36';

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

String _$updateAssetHash() => r'debeb7b60ce5c7496926137c6a2ca83675bcadc7';

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

String _$deleteAssetHash() => r'5c8175adff15ec7cbfc6e3498183b94916b280d1';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
