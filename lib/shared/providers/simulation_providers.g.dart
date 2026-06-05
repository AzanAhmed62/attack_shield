// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simulationHistoryHash() => r'02cbe42cfdc4505077c815ea42db532e89d1dc84';

/// See also [simulationHistory].
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
    r'023e75c21d779e8e8e2a17c077e3dd175dc92bdb';

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

/// See also [saveSimulationResult].
@ProviderFor(saveSimulationResult)
const saveSimulationResultProvider = SaveSimulationResultFamily();

/// See also [saveSimulationResult].
class SaveSimulationResultFamily extends Family<AsyncValue<void>> {
  /// See also [saveSimulationResult].
  const SaveSimulationResultFamily();

  /// See also [saveSimulationResult].
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

/// See also [saveSimulationResult].
class SaveSimulationResultProvider extends AutoDisposeFutureProvider<void> {
  /// See also [saveSimulationResult].
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
