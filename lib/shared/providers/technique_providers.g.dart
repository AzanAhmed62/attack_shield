// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTechniquesHash() => r'f36bf752b80b512e6c13d4c7de53c534ca7cc471';

/// All techniques — cached in repository, won't refetch on every watch.
///
/// Copied from [allTechniques].
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
String _$allTacticsHash() => r'fef984abd5652143317e523171adf0e9ac0c90a5';

/// All tactics.
///
/// Copied from [allTactics].
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
    r'e933e85c9ee3c491670cdfd85fdcfb9fcbfda13b';

/// Techniques filtered by tactic, search query, platform, and risk score.
///
/// Copied from [filteredTechniques].
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
String _$techniqueByIdHash() => r'd0cbe66f0b26bf1b7a5f61b13fb02c5ce90fed8a';

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

/// Single technique by ID (includes sub-techniques).
///
/// Copied from [techniqueById].
@ProviderFor(techniqueById)
const techniqueByIdProvider = TechniqueByIdFamily();

/// Single technique by ID (includes sub-techniques).
///
/// Copied from [techniqueById].
class TechniqueByIdFamily extends Family<AsyncValue<AttackTechnique?>> {
  /// Single technique by ID (includes sub-techniques).
  ///
  /// Copied from [techniqueById].
  const TechniqueByIdFamily();

  /// Single technique by ID (includes sub-techniques).
  ///
  /// Copied from [techniqueById].
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

/// Single technique by ID (includes sub-techniques).
///
/// Copied from [techniqueById].
class TechniqueByIdProvider
    extends AutoDisposeFutureProvider<AttackTechnique?> {
  /// Single technique by ID (includes sub-techniques).
  ///
  /// Copied from [techniqueById].
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

String _$techniquesByTacticHash() =>
    r'01ea1bf6dbd54ce26e68aca65c0c723eabee755f';

/// Techniques belonging to a specific tactic.
///
/// Copied from [techniquesByTactic].
@ProviderFor(techniquesByTactic)
const techniquesByTacticProvider = TechniquesByTacticFamily();

/// Techniques belonging to a specific tactic.
///
/// Copied from [techniquesByTactic].
class TechniquesByTacticFamily
    extends Family<AsyncValue<List<AttackTechnique>>> {
  /// Techniques belonging to a specific tactic.
  ///
  /// Copied from [techniquesByTactic].
  const TechniquesByTacticFamily();

  /// Techniques belonging to a specific tactic.
  ///
  /// Copied from [techniquesByTactic].
  TechniquesByTacticProvider call(String tacticName) {
    return TechniquesByTacticProvider(tacticName);
  }

  @override
  TechniquesByTacticProvider getProviderOverride(
    covariant TechniquesByTacticProvider provider,
  ) {
    return call(provider.tacticName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'techniquesByTacticProvider';
}

/// Techniques belonging to a specific tactic.
///
/// Copied from [techniquesByTactic].
class TechniquesByTacticProvider
    extends AutoDisposeFutureProvider<List<AttackTechnique>> {
  /// Techniques belonging to a specific tactic.
  ///
  /// Copied from [techniquesByTactic].
  TechniquesByTacticProvider(String tacticName)
    : this._internal(
        (ref) => techniquesByTactic(ref as TechniquesByTacticRef, tacticName),
        from: techniquesByTacticProvider,
        name: r'techniquesByTacticProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$techniquesByTacticHash,
        dependencies: TechniquesByTacticFamily._dependencies,
        allTransitiveDependencies:
            TechniquesByTacticFamily._allTransitiveDependencies,
        tacticName: tacticName,
      );

  TechniquesByTacticProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tacticName,
  }) : super.internal();

  final String tacticName;

  @override
  Override overrideWith(
    FutureOr<List<AttackTechnique>> Function(TechniquesByTacticRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TechniquesByTacticProvider._internal(
        (ref) => create(ref as TechniquesByTacticRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tacticName: tacticName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttackTechnique>> createElement() {
    return _TechniquesByTacticProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TechniquesByTacticProvider &&
        other.tacticName == tacticName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tacticName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TechniquesByTacticRef
    on AutoDisposeFutureProviderRef<List<AttackTechnique>> {
  /// The parameter `tacticName` of this provider.
  String get tacticName;
}

class _TechniquesByTacticProviderElement
    extends AutoDisposeFutureProviderElement<List<AttackTechnique>>
    with TechniquesByTacticRef {
  _TechniquesByTacticProviderElement(super.provider);

  @override
  String get tacticName => (origin as TechniquesByTacticProvider).tacticName;
}

String _$topRiskTechniquesHash() => r'ba1a2edf355bada767c0997b409ac3b15b9bf1d2';

/// Top N highest-risk techniques (default 10). Used on dashboard and reports.
///
/// Copied from [topRiskTechniques].
@ProviderFor(topRiskTechniques)
const topRiskTechniquesProvider = TopRiskTechniquesFamily();

/// Top N highest-risk techniques (default 10). Used on dashboard and reports.
///
/// Copied from [topRiskTechniques].
class TopRiskTechniquesFamily
    extends Family<AsyncValue<List<AttackTechnique>>> {
  /// Top N highest-risk techniques (default 10). Used on dashboard and reports.
  ///
  /// Copied from [topRiskTechniques].
  const TopRiskTechniquesFamily();

  /// Top N highest-risk techniques (default 10). Used on dashboard and reports.
  ///
  /// Copied from [topRiskTechniques].
  TopRiskTechniquesProvider call({int limit = 10}) {
    return TopRiskTechniquesProvider(limit: limit);
  }

  @override
  TopRiskTechniquesProvider getProviderOverride(
    covariant TopRiskTechniquesProvider provider,
  ) {
    return call(limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'topRiskTechniquesProvider';
}

/// Top N highest-risk techniques (default 10). Used on dashboard and reports.
///
/// Copied from [topRiskTechniques].
class TopRiskTechniquesProvider
    extends AutoDisposeFutureProvider<List<AttackTechnique>> {
  /// Top N highest-risk techniques (default 10). Used on dashboard and reports.
  ///
  /// Copied from [topRiskTechniques].
  TopRiskTechniquesProvider({int limit = 10})
    : this._internal(
        (ref) => topRiskTechniques(ref as TopRiskTechniquesRef, limit: limit),
        from: topRiskTechniquesProvider,
        name: r'topRiskTechniquesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$topRiskTechniquesHash,
        dependencies: TopRiskTechniquesFamily._dependencies,
        allTransitiveDependencies:
            TopRiskTechniquesFamily._allTransitiveDependencies,
        limit: limit,
      );

  TopRiskTechniquesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<AttackTechnique>> Function(TopRiskTechniquesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopRiskTechniquesProvider._internal(
        (ref) => create(ref as TopRiskTechniquesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttackTechnique>> createElement() {
    return _TopRiskTechniquesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopRiskTechniquesProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TopRiskTechniquesRef
    on AutoDisposeFutureProviderRef<List<AttackTechnique>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _TopRiskTechniquesProviderElement
    extends AutoDisposeFutureProviderElement<List<AttackTechnique>>
    with TopRiskTechniquesRef {
  _TopRiskTechniquesProviderElement(super.provider);

  @override
  int get limit => (origin as TopRiskTechniquesProvider).limit;
}

String _$techniqueCountByTacticHash() =>
    r'cfb5df3c2d8b566eb549607d7b246d247d87c7a5';

/// Techniques count per tactic — used for coverage heatmap.
/// Returns a map of { tacticName: techniqueCount }
///
/// Copied from [techniqueCountByTactic].
@ProviderFor(techniqueCountByTactic)
final techniqueCountByTacticProvider =
    FutureProvider<Map<String, int>>.internal(
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
typedef TechniqueCountByTacticRef = FutureProviderRef<Map<String, int>>;
String _$allPlatformsHash() => r'c587c1d9cb62493601782ab90fefb1e58008f83d';

/// All unique platforms across all techniques.
///
/// Copied from [allPlatforms].
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
String _$totalSubTechniqueCountHash() =>
    r'a9e33f5ab1188aaa0ed92e64cc45160fd29b4a13';

/// Total sub-technique count across all techniques.
///
/// Copied from [totalSubTechniqueCount].
@ProviderFor(totalSubTechniqueCount)
final totalSubTechniqueCountProvider = FutureProvider<int>.internal(
  totalSubTechniqueCount,
  name: r'totalSubTechniqueCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalSubTechniqueCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalSubTechniqueCountRef = FutureProviderRef<int>;
String _$selectedTacticHash() => r'6e61c4a70b4f4a1ac643d4c86ae9d807f01586f9';

/// Currently selected tactic filter (empty string = all tactics).
///
/// Copied from [SelectedTactic].
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
String _$searchQueryHash() => r'09c59a4abc19083d67b5fdf35f633d569dc4a233';

/// Search query for the technique library.
///
/// Copied from [SearchQuery].
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
String _$selectedPlatformHash() => r'a8c4dc742265a69dbea109dfdb1461a332b12644';

/// Selected platform filter (empty = all platforms).
///
/// Copied from [SelectedPlatform].
@ProviderFor(SelectedPlatform)
final selectedPlatformProvider =
    AutoDisposeNotifierProvider<SelectedPlatform, String>.internal(
      SelectedPlatform.new,
      name: r'selectedPlatformProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedPlatformHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedPlatform = AutoDisposeNotifier<String>;
String _$minRiskFilterHash() => r'ce3ca1e8090c628c002125cdbb46d1b3263157d8';

/// Minimum risk score filter (0.0 = no filter).
///
/// Copied from [MinRiskFilter].
@ProviderFor(MinRiskFilter)
final minRiskFilterProvider =
    AutoDisposeNotifierProvider<MinRiskFilter, double>.internal(
      MinRiskFilter.new,
      name: r'minRiskFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$minRiskFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MinRiskFilter = AutoDisposeNotifier<double>;
String _$techniqueSortHash() => r'980dc5a7aca7568bccf76e842fcfe308757ca53f';

/// Sort mode for the library list.
///
/// Copied from [TechniqueSort].
@ProviderFor(TechniqueSort)
final techniqueSortProvider =
    AutoDisposeNotifierProvider<TechniqueSort, TechniqueSortOption>.internal(
      TechniqueSort.new,
      name: r'techniqueSortProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$techniqueSortHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TechniqueSort = AutoDisposeNotifier<TechniqueSortOption>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
