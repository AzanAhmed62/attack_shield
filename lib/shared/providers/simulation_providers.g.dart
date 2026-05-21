// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simulationHistoryHash() => r'962c5116630bac2c9d1e0d24fa6a4708372ae03c';

/// Get simulation history (past executed simulations)
///
/// Copied from [simulationHistory].
@ProviderFor(simulationHistory)
final simulationHistoryProvider =
    AutoDisposeFutureProvider<List<SimulationHistoryEntry>>.internal(
      simulationHistory,
      name: r'simulationHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$simulationHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SimulationHistoryRef =
    AutoDisposeFutureProviderRef<List<SimulationHistoryEntry>>;
String _$saveSimulationResultHash() =>
    r'2efe30c5292bd9ab4b229ec6aeb86cdac9c5a637';

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

/// Save a simulation result to history
///
/// Copied from [saveSimulationResult].
@ProviderFor(saveSimulationResult)
const saveSimulationResultProvider = SaveSimulationResultFamily();

/// Save a simulation result to history
///
/// Copied from [saveSimulationResult].
class SaveSimulationResultFamily extends Family<AsyncValue<void>> {
  /// Save a simulation result to history
  ///
  /// Copied from [saveSimulationResult].
  const SaveSimulationResultFamily();

  /// Save a simulation result to history
  ///
  /// Copied from [saveSimulationResult].
  SaveSimulationResultProvider call(SimulationHistoryEntry entry) {
    return SaveSimulationResultProvider(entry);
  }

  @override
  SaveSimulationResultProvider getProviderOverride(
    covariant SaveSimulationResultProvider provider,
  ) {
    return call(provider.entry);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saveSimulationResultProvider';
}

/// Save a simulation result to history
///
/// Copied from [saveSimulationResult].
class SaveSimulationResultProvider extends AutoDisposeFutureProvider<void> {
  /// Save a simulation result to history
  ///
  /// Copied from [saveSimulationResult].
  SaveSimulationResultProvider(SimulationHistoryEntry entry)
    : this._internal(
        (ref) => saveSimulationResult(ref as SaveSimulationResultRef, entry),
        from: saveSimulationResultProvider,
        name: r'saveSimulationResultProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$saveSimulationResultHash,
        dependencies: SaveSimulationResultFamily._dependencies,
        allTransitiveDependencies:
            SaveSimulationResultFamily._allTransitiveDependencies,
        entry: entry,
      );

  SaveSimulationResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.entry,
  }) : super.internal();

  final SimulationHistoryEntry entry;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveSimulationResultRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveSimulationResultProvider._internal(
        (ref) => create(ref as SaveSimulationResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        entry: entry,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveSimulationResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveSimulationResultProvider && other.entry == entry;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, entry.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaveSimulationResultRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `entry` of this provider.
  SimulationHistoryEntry get entry;
}

class _SaveSimulationResultProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SaveSimulationResultRef {
  _SaveSimulationResultProviderElement(super.provider);

  @override
  SimulationHistoryEntry get entry =>
      (origin as SaveSimulationResultProvider).entry;
}

String _$clearSimulationHistoryHash() =>
    r'537c7a9ab1cac88215510f0bb4162d3991a06007';

/// Clear all simulation history
///
/// Copied from [clearSimulationHistory].
@ProviderFor(clearSimulationHistory)
final clearSimulationHistoryProvider = AutoDisposeFutureProvider<void>.internal(
  clearSimulationHistory,
  name: r'clearSimulationHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearSimulationHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearSimulationHistoryRef = AutoDisposeFutureProviderRef<void>;
String _$totalSimulationsRunHash() =>
    r'44c0c8c8ace64df339498140a3cc3e849a761979';

/// Total number of past simulations
///
/// Copied from [totalSimulationsRun].
@ProviderFor(totalSimulationsRun)
final totalSimulationsRunProvider = AutoDisposeFutureProvider<int>.internal(
  totalSimulationsRun,
  name: r'totalSimulationsRunProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalSimulationsRunHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalSimulationsRunRef = AutoDisposeFutureProviderRef<int>;
String _$averageReadinessFromHistoryHash() =>
    r'05c2f93b431da0ccb9e33f26536816638e41c5b2';

/// Average readiness from all past simulations
///
/// Copied from [averageReadinessFromHistory].
@ProviderFor(averageReadinessFromHistory)
final averageReadinessFromHistoryProvider =
    AutoDisposeFutureProvider<double>.internal(
      averageReadinessFromHistory,
      name: r'averageReadinessFromHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$averageReadinessFromHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AverageReadinessFromHistoryRef = AutoDisposeFutureProviderRef<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
