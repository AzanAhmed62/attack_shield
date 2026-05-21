// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTechniquesHash() => r'221e63d5bb1361b7f023399367c9ffc69a0a9f8c';

/// See also [allTechniques].
@ProviderFor(allTechniques)
final allTechniquesProvider = FutureProvider<List<AttackTechnique>>.internal(
  allTechniques,
  name: r'allTechniquesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allTechniquesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTechniquesRef = FutureProviderRef<List<AttackTechnique>>;
String _$allTacticsHash() => r'494a73e26c1b2538b1da5b132d30df35885b204a';

/// See also [allTactics].
@ProviderFor(allTactics)
final allTacticsProvider = FutureProvider<List<AttackTactic>>.internal(
  allTactics,
  name: r'allTacticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allTacticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTacticsRef = FutureProviderRef<List<AttackTactic>>;
String _$filteredTechniquesHash() =>
    r'2e0bd95291ef92cc38e0277cac062e503efd1019';

/// See also [filteredTechniques].
@ProviderFor(filteredTechniques)
final filteredTechniquesProvider =
    AutoDisposeFutureProvider<List<AttackTechnique>>.internal(
      filteredTechniques,
      name: r'filteredTechniquesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredTechniquesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredTechniquesRef =
    AutoDisposeFutureProviderRef<List<AttackTechnique>>;
String _$techniqueByIdHash() => r'0d43a0a911620ce5423f421fe03e54dccfc9de63';

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

/// See also [techniqueById].
@ProviderFor(techniqueById)
const techniqueByIdProvider = TechniqueByIdFamily();

/// See also [techniqueById].
class TechniqueByIdFamily extends Family<AsyncValue<AttackTechnique?>> {
  /// See also [techniqueById].
  const TechniqueByIdFamily();

  /// See also [techniqueById].
  TechniqueByIdProvider call(String id) {
    return TechniqueByIdProvider(id);
  }

  @override
  TechniqueByIdProvider getProviderOverride(
    covariant TechniqueByIdProvider provider,
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
  String? get name => r'techniqueByIdProvider';
}

/// See also [techniqueById].
class TechniqueByIdProvider
    extends AutoDisposeFutureProvider<AttackTechnique?> {
  /// See also [techniqueById].
  TechniqueByIdProvider(String id)
    : this._internal(
        (ref) => techniqueById(ref as TechniqueByIdRef, id),
        from: techniqueByIdProvider,
        name: r'techniqueByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$techniqueByIdHash,
        dependencies: TechniqueByIdFamily._dependencies,
        allTransitiveDependencies:
            TechniqueByIdFamily._allTransitiveDependencies,
        id: id,
      );

  TechniqueByIdProvider._internal(
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
    FutureOr<AttackTechnique?> Function(TechniqueByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TechniqueByIdProvider._internal(
        (ref) => create(ref as TechniqueByIdRef),
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
  AutoDisposeFutureProviderElement<AttackTechnique?> createElement() {
    return _TechniqueByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TechniqueByIdProvider && other.id == id;
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
mixin TechniqueByIdRef on AutoDisposeFutureProviderRef<AttackTechnique?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TechniqueByIdProviderElement
    extends AutoDisposeFutureProviderElement<AttackTechnique?>
    with TechniqueByIdRef {
  _TechniqueByIdProviderElement(super.provider);

  @override
  String get id => (origin as TechniqueByIdProvider).id;
}

String _$subTechniquesHash() => r'9ec3d65c684b7a77caa10e27374f572f5ac564a5';

/// See also [subTechniques].
@ProviderFor(subTechniques)
const subTechniquesProvider = SubTechniquesFamily();

/// See also [subTechniques].
class SubTechniquesFamily extends Family<AsyncValue<List<AttackTechnique>>> {
  /// See also [subTechniques].
  const SubTechniquesFamily();

  /// See also [subTechniques].
  SubTechniquesProvider call(String parentId) {
    return SubTechniquesProvider(parentId);
  }

  @override
  SubTechniquesProvider getProviderOverride(
    covariant SubTechniquesProvider provider,
  ) {
    return call(provider.parentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subTechniquesProvider';
}

/// See also [subTechniques].
class SubTechniquesProvider
    extends AutoDisposeFutureProvider<List<AttackTechnique>> {
  /// See also [subTechniques].
  SubTechniquesProvider(String parentId)
    : this._internal(
        (ref) => subTechniques(ref as SubTechniquesRef, parentId),
        from: subTechniquesProvider,
        name: r'subTechniquesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$subTechniquesHash,
        dependencies: SubTechniquesFamily._dependencies,
        allTransitiveDependencies:
            SubTechniquesFamily._allTransitiveDependencies,
        parentId: parentId,
      );

  SubTechniquesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
  }) : super.internal();

  final String parentId;

  @override
  Override overrideWith(
    FutureOr<List<AttackTechnique>> Function(SubTechniquesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubTechniquesProvider._internal(
        (ref) => create(ref as SubTechniquesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttackTechnique>> createElement() {
    return _SubTechniquesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubTechniquesProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubTechniquesRef on AutoDisposeFutureProviderRef<List<AttackTechnique>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _SubTechniquesProviderElement
    extends AutoDisposeFutureProviderElement<List<AttackTechnique>>
    with SubTechniquesRef {
  _SubTechniquesProviderElement(super.provider);

  @override
  String get parentId => (origin as SubTechniquesProvider).parentId;
}

String _$techniquesByTacticHash() =>
    r'bbbe0c1a3c93666fd6c022b2a7525bf27a3d48b9';

/// See also [techniquesByTactic].
@ProviderFor(techniquesByTactic)
final techniquesByTacticProvider =
    FutureProvider<Map<String, List<AttackTechnique>>>.internal(
      techniquesByTactic,
      name: r'techniquesByTacticProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$techniquesByTacticHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TechniquesByTacticRef =
    FutureProviderRef<Map<String, List<AttackTechnique>>>;
String _$techniqueCountByTacticHash() =>
    r'2cf20b4101ec52093b3426b97aa596a72dd26a4d';

/// See also [techniqueCountByTactic].
@ProviderFor(techniqueCountByTactic)
final techniqueCountByTacticProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      techniqueCountByTactic,
      name: r'techniqueCountByTacticProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$techniqueCountByTacticHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TechniqueCountByTacticRef =
    AutoDisposeFutureProviderRef<Map<String, int>>;
String _$highRiskTechniquesHash() =>
    r'fc994b3f9446708375ac4935f25749da4b7e0188';

/// See also [highRiskTechniques].
@ProviderFor(highRiskTechniques)
final highRiskTechniquesProvider =
    AutoDisposeFutureProvider<List<AttackTechnique>>.internal(
      highRiskTechniques,
      name: r'highRiskTechniquesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$highRiskTechniquesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HighRiskTechniquesRef =
    AutoDisposeFutureProviderRef<List<AttackTechnique>>;
String _$allPlatformsHash() => r'743ec633f1fccad511eb0bc587c49262aaf6869e';

/// See also [allPlatforms].
@ProviderFor(allPlatforms)
final allPlatformsProvider = FutureProvider<List<String>>.internal(
  allPlatforms,
  name: r'allPlatformsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allPlatformsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllPlatformsRef = FutureProviderRef<List<String>>;
String _$techniqueCountHash() => r'26d117043911f0f4752e2f88268c7b00c96c54d1';

/// See also [techniqueCount].
@ProviderFor(techniqueCount)
final techniqueCountProvider = AutoDisposeFutureProvider<int>.internal(
  techniqueCount,
  name: r'techniqueCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$techniqueCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TechniqueCountRef = AutoDisposeFutureProviderRef<int>;
String _$totalTechniqueCountHash() =>
    r'68532a5cf86e431ab5c1032001303e6765ca4f44';

/// See also [totalTechniqueCount].
@ProviderFor(totalTechniqueCount)
final totalTechniqueCountProvider = AutoDisposeFutureProvider<int>.internal(
  totalTechniqueCount,
  name: r'totalTechniqueCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalTechniqueCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalTechniqueCountRef = AutoDisposeFutureProviderRef<int>;
String _$searchQueryHash() => r'09c59a4abc19083d67b5fdf35f633d569dc4a233';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
      SearchQuery.new,
      name: r'searchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$selectedTacticHash() => r'39ee9353f16a5cbeb9ed997a7a14b1827b1e2ef7';

/// See also [SelectedTactic].
@ProviderFor(SelectedTactic)
final selectedTacticProvider =
    AutoDisposeNotifierProvider<SelectedTactic, String>.internal(
      SelectedTactic.new,
      name: r'selectedTacticProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedTacticHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedTactic = AutoDisposeNotifier<String>;
String _$selectedPlatformsHash() => r'c2c6118b7bd4c1f7e533309fb1caa94f74ff404c';

/// See also [SelectedPlatforms].
@ProviderFor(SelectedPlatforms)
final selectedPlatformsProvider =
    AutoDisposeNotifierProvider<SelectedPlatforms, List<String>>.internal(
      SelectedPlatforms.new,
      name: r'selectedPlatformsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedPlatformsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedPlatforms = AutoDisposeNotifier<List<String>>;
String _$showSubTechniquesHash() => r'92b760c4159b9ba34e46aa75ac61ae146f94d07f';

/// See also [ShowSubTechniques].
@ProviderFor(ShowSubTechniques)
final showSubTechniquesProvider =
    AutoDisposeNotifierProvider<ShowSubTechniques, bool>.internal(
      ShowSubTechniques.new,
      name: r'showSubTechniquesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$showSubTechniquesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ShowSubTechniques = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
