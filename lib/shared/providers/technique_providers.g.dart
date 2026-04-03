// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTechniquesHash() => r'f445a0c034c522d16ea556db473ab0cc9858ad8e';

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
String _$allTacticsHash() => r'e750a6e272a85d4f3db295a76804a3830aa24e23';

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
String _$selectedSeverityHash() => r'301fa72d00b3153be842691315d03cffdad4ff89';

/// See also [selectedSeverity].
@ProviderFor(selectedSeverity)
final selectedSeverityProvider = AutoDisposeProvider<int>.internal(
  selectedSeverity,
  name: r'selectedSeverityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSeverityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedSeverityRef = AutoDisposeProviderRef<int>;
String _$filteredTechniquesHash() =>
    r'da5f55ff4a35eb2579a23d48c0340be504eb54c7';

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
String _$techniqueByIdHash() => r'851f06c2134881804d7e9a69e532d21a2064ffbd';

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

String _$techniquesByTacticHash() =>
    r'7f4fd37ee48a969dae6a0d884703391e53ed4b1b';

/// See also [techniquesByTactic].
@ProviderFor(techniquesByTactic)
const techniquesByTacticProvider = TechniquesByTacticFamily();

/// See also [techniquesByTactic].
class TechniquesByTacticFamily
    extends Family<AsyncValue<List<AttackTechnique>>> {
  /// See also [techniquesByTactic].
  const TechniquesByTacticFamily();

  /// See also [techniquesByTactic].
  TechniquesByTacticProvider call(String tacticId) {
    return TechniquesByTacticProvider(tacticId);
  }

  @override
  TechniquesByTacticProvider getProviderOverride(
    covariant TechniquesByTacticProvider provider,
  ) {
    return call(provider.tacticId);
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

/// See also [techniquesByTactic].
class TechniquesByTacticProvider
    extends AutoDisposeFutureProvider<List<AttackTechnique>> {
  /// See also [techniquesByTactic].
  TechniquesByTacticProvider(String tacticId)
    : this._internal(
        (ref) => techniquesByTactic(ref as TechniquesByTacticRef, tacticId),
        from: techniquesByTacticProvider,
        name: r'techniquesByTacticProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$techniquesByTacticHash,
        dependencies: TechniquesByTacticFamily._dependencies,
        allTransitiveDependencies:
            TechniquesByTacticFamily._allTransitiveDependencies,
        tacticId: tacticId,
      );

  TechniquesByTacticProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tacticId,
  }) : super.internal();

  final String tacticId;

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
        tacticId: tacticId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AttackTechnique>> createElement() {
    return _TechniquesByTacticProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TechniquesByTacticProvider && other.tacticId == tacticId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tacticId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TechniquesByTacticRef
    on AutoDisposeFutureProviderRef<List<AttackTechnique>> {
  /// The parameter `tacticId` of this provider.
  String get tacticId;
}

class _TechniquesByTacticProviderElement
    extends AutoDisposeFutureProviderElement<List<AttackTechnique>>
    with TechniquesByTacticRef {
  _TechniquesByTacticProviderElement(super.provider);

  @override
  String get tacticId => (origin as TechniquesByTacticProvider).tacticId;
}

String _$selectedTacticHash() => r'715568e5db97dc1578f36d1ecfc02409986b3aed';

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
String _$searchQueryHash() => r'b86b8da90be76f01a6b100d272f027dc16b56d3c';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
