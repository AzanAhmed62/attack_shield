// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allSimulationScenariosHash() =>
    r'dce95be5df3cf8df2f21f8545d19f6963b924f83';

/// See also [allSimulationScenarios].
@ProviderFor(allSimulationScenarios)
final allSimulationScenariosProvider =
    AutoDisposeFutureProvider<List<SimulationScenario>>.internal(
      allSimulationScenarios,
      name: r'allSimulationScenariosProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allSimulationScenariosHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllSimulationScenariosRef =
    AutoDisposeFutureProviderRef<List<SimulationScenario>>;
String _$allSimulationResultsHash() =>
    r'91a854c9cfda41138ca94394796908e0e87d0688';

/// See also [allSimulationResults].
@ProviderFor(allSimulationResults)
final allSimulationResultsProvider =
    AutoDisposeFutureProvider<List<SimulationResult>>.internal(
      allSimulationResults,
      name: r'allSimulationResultsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allSimulationResultsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllSimulationResultsRef =
    AutoDisposeFutureProviderRef<List<SimulationResult>>;
String _$simulationReadinessHash() =>
    r'32a75ab1d5a547c520a1d0013472e53802ff079a';

/// See also [simulationReadiness].
@ProviderFor(simulationReadiness)
final simulationReadinessProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      simulationReadiness,
      name: r'simulationReadinessProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$simulationReadinessHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SimulationReadinessRef = AutoDisposeFutureProviderRef<Map<String, int>>;
String _$totalScenariosPassedHash() =>
    r'ab6e32177e1cbb2cc20cecd24f3e0ffce883073a';

/// See also [totalScenariosPassed].
@ProviderFor(totalScenariosPassed)
final totalScenariosPassedProvider = AutoDisposeFutureProvider<int>.internal(
  totalScenariosPassed,
  name: r'totalScenariosPassedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalScenariosPassedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalScenariosPassedRef = AutoDisposeFutureProviderRef<int>;
String _$totalScenariosFailedHash() =>
    r'd795986323f21a267df4bd942c52eb6b63a7038b';

/// See also [totalScenariosFailed].
@ProviderFor(totalScenariosFailed)
final totalScenariosFailedProvider = AutoDisposeFutureProvider<int>.internal(
  totalScenariosFailed,
  name: r'totalScenariosFailedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalScenariosFailedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalScenariosFailedRef = AutoDisposeFutureProviderRef<int>;
String _$totalScenariosPartiallyPassedHash() =>
    r'fcb7d161b12eccf4d48810da35105410768ae352';

/// See also [totalScenariosPartiallyPassed].
@ProviderFor(totalScenariosPartiallyPassed)
final totalScenariosPartiallyPassedProvider =
    AutoDisposeFutureProvider<int>.internal(
      totalScenariosPartiallyPassed,
      name: r'totalScenariosPartiallyPassedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totalScenariosPartiallyPassedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalScenariosPartiallyPassedRef = AutoDisposeFutureProviderRef<int>;
String _$readinessPercentageHash() =>
    r'01244a75266d204b5d306898f10ffe58fe75a219';

/// See also [readinessPercentage].
@ProviderFor(readinessPercentage)
final readinessPercentageProvider = AutoDisposeFutureProvider<double>.internal(
  readinessPercentage,
  name: r'readinessPercentageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$readinessPercentageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReadinessPercentageRef = AutoDisposeFutureProviderRef<double>;
String _$createSimulationScenarioHash() =>
    r'25dfda8a5f79629c64c4403c5854fc80aee6bd43';

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

/// See also [createSimulationScenario].
@ProviderFor(createSimulationScenario)
const createSimulationScenarioProvider = CreateSimulationScenarioFamily();

/// See also [createSimulationScenario].
class CreateSimulationScenarioFamily extends Family<AsyncValue<void>> {
  /// See also [createSimulationScenario].
  const CreateSimulationScenarioFamily();

  /// See also [createSimulationScenario].
  CreateSimulationScenarioProvider call(SimulationScenario scenario) {
    return CreateSimulationScenarioProvider(scenario);
  }

  @override
  CreateSimulationScenarioProvider getProviderOverride(
    covariant CreateSimulationScenarioProvider provider,
  ) {
    return call(provider.scenario);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createSimulationScenarioProvider';
}

/// See also [createSimulationScenario].
class CreateSimulationScenarioProvider extends AutoDisposeFutureProvider<void> {
  /// See also [createSimulationScenario].
  CreateSimulationScenarioProvider(SimulationScenario scenario)
    : this._internal(
        (ref) => createSimulationScenario(
          ref as CreateSimulationScenarioRef,
          scenario,
        ),
        from: createSimulationScenarioProvider,
        name: r'createSimulationScenarioProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createSimulationScenarioHash,
        dependencies: CreateSimulationScenarioFamily._dependencies,
        allTransitiveDependencies:
            CreateSimulationScenarioFamily._allTransitiveDependencies,
        scenario: scenario,
      );

  CreateSimulationScenarioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scenario,
  }) : super.internal();

  final SimulationScenario scenario;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateSimulationScenarioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateSimulationScenarioProvider._internal(
        (ref) => create(ref as CreateSimulationScenarioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scenario: scenario,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateSimulationScenarioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateSimulationScenarioProvider &&
        other.scenario == scenario;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scenario.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateSimulationScenarioRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `scenario` of this provider.
  SimulationScenario get scenario;
}

class _CreateSimulationScenarioProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CreateSimulationScenarioRef {
  _CreateSimulationScenarioProviderElement(super.provider);

  @override
  SimulationScenario get scenario =>
      (origin as CreateSimulationScenarioProvider).scenario;
}

String _$createSimulationResultHash() =>
    r'68fe179e21bf2d6cbadc75f95581693643f18bcf';

/// See also [createSimulationResult].
@ProviderFor(createSimulationResult)
const createSimulationResultProvider = CreateSimulationResultFamily();

/// See also [createSimulationResult].
class CreateSimulationResultFamily extends Family<AsyncValue<void>> {
  /// See also [createSimulationResult].
  const CreateSimulationResultFamily();

  /// See also [createSimulationResult].
  CreateSimulationResultProvider call(SimulationResult result) {
    return CreateSimulationResultProvider(result);
  }

  @override
  CreateSimulationResultProvider getProviderOverride(
    covariant CreateSimulationResultProvider provider,
  ) {
    return call(provider.result);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createSimulationResultProvider';
}

/// See also [createSimulationResult].
class CreateSimulationResultProvider extends AutoDisposeFutureProvider<void> {
  /// See also [createSimulationResult].
  CreateSimulationResultProvider(SimulationResult result)
    : this._internal(
        (ref) =>
            createSimulationResult(ref as CreateSimulationResultRef, result),
        from: createSimulationResultProvider,
        name: r'createSimulationResultProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createSimulationResultHash,
        dependencies: CreateSimulationResultFamily._dependencies,
        allTransitiveDependencies:
            CreateSimulationResultFamily._allTransitiveDependencies,
        result: result,
      );

  CreateSimulationResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.result,
  }) : super.internal();

  final SimulationResult result;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateSimulationResultRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateSimulationResultProvider._internal(
        (ref) => create(ref as CreateSimulationResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        result: result,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateSimulationResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateSimulationResultProvider && other.result == result;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, result.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateSimulationResultRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `result` of this provider.
  SimulationResult get result;
}

class _CreateSimulationResultProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CreateSimulationResultRef {
  _CreateSimulationResultProviderElement(super.provider);

  @override
  SimulationResult get result =>
      (origin as CreateSimulationResultProvider).result;
}

String _$deleteSimulationScenarioHash() =>
    r'214b4f7825dfd506e1016844f7402682c44c506a';

/// See also [deleteSimulationScenario].
@ProviderFor(deleteSimulationScenario)
const deleteSimulationScenarioProvider = DeleteSimulationScenarioFamily();

/// See also [deleteSimulationScenario].
class DeleteSimulationScenarioFamily extends Family<AsyncValue<void>> {
  /// See also [deleteSimulationScenario].
  const DeleteSimulationScenarioFamily();

  /// See also [deleteSimulationScenario].
  DeleteSimulationScenarioProvider call(String id) {
    return DeleteSimulationScenarioProvider(id);
  }

  @override
  DeleteSimulationScenarioProvider getProviderOverride(
    covariant DeleteSimulationScenarioProvider provider,
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
  String? get name => r'deleteSimulationScenarioProvider';
}

/// See also [deleteSimulationScenario].
class DeleteSimulationScenarioProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteSimulationScenario].
  DeleteSimulationScenarioProvider(String id)
    : this._internal(
        (ref) =>
            deleteSimulationScenario(ref as DeleteSimulationScenarioRef, id),
        from: deleteSimulationScenarioProvider,
        name: r'deleteSimulationScenarioProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteSimulationScenarioHash,
        dependencies: DeleteSimulationScenarioFamily._dependencies,
        allTransitiveDependencies:
            DeleteSimulationScenarioFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteSimulationScenarioProvider._internal(
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
    FutureOr<void> Function(DeleteSimulationScenarioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteSimulationScenarioProvider._internal(
        (ref) => create(ref as DeleteSimulationScenarioRef),
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
    return _DeleteSimulationScenarioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteSimulationScenarioProvider && other.id == id;
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
mixin DeleteSimulationScenarioRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeleteSimulationScenarioProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteSimulationScenarioRef {
  _DeleteSimulationScenarioProviderElement(super.provider);

  @override
  String get id => (origin as DeleteSimulationScenarioProvider).id;
}

String _$resultsByScenarioHash() => r'204c3d4067d53cc2ec1bfc90a5d9428f12b92c6d';

/// See also [resultsByScenario].
@ProviderFor(resultsByScenario)
const resultsByScenarioProvider = ResultsByScenarioFamily();

/// See also [resultsByScenario].
class ResultsByScenarioFamily
    extends Family<AsyncValue<List<SimulationResult>>> {
  /// See also [resultsByScenario].
  const ResultsByScenarioFamily();

  /// See also [resultsByScenario].
  ResultsByScenarioProvider call(String scenarioId) {
    return ResultsByScenarioProvider(scenarioId);
  }

  @override
  ResultsByScenarioProvider getProviderOverride(
    covariant ResultsByScenarioProvider provider,
  ) {
    return call(provider.scenarioId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'resultsByScenarioProvider';
}

/// See also [resultsByScenario].
class ResultsByScenarioProvider
    extends AutoDisposeFutureProvider<List<SimulationResult>> {
  /// See also [resultsByScenario].
  ResultsByScenarioProvider(String scenarioId)
    : this._internal(
        (ref) => resultsByScenario(ref as ResultsByScenarioRef, scenarioId),
        from: resultsByScenarioProvider,
        name: r'resultsByScenarioProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$resultsByScenarioHash,
        dependencies: ResultsByScenarioFamily._dependencies,
        allTransitiveDependencies:
            ResultsByScenarioFamily._allTransitiveDependencies,
        scenarioId: scenarioId,
      );

  ResultsByScenarioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scenarioId,
  }) : super.internal();

  final String scenarioId;

  @override
  Override overrideWith(
    FutureOr<List<SimulationResult>> Function(ResultsByScenarioRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResultsByScenarioProvider._internal(
        (ref) => create(ref as ResultsByScenarioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scenarioId: scenarioId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SimulationResult>> createElement() {
    return _ResultsByScenarioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResultsByScenarioProvider && other.scenarioId == scenarioId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scenarioId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ResultsByScenarioRef
    on AutoDisposeFutureProviderRef<List<SimulationResult>> {
  /// The parameter `scenarioId` of this provider.
  String get scenarioId;
}

class _ResultsByScenarioProviderElement
    extends AutoDisposeFutureProviderElement<List<SimulationResult>>
    with ResultsByScenarioRef {
  _ResultsByScenarioProviderElement(super.provider);

  @override
  String get scenarioId => (origin as ResultsByScenarioProvider).scenarioId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
