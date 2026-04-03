// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCoverageStatusesHash() =>
    r'92aebbbdeed320805f6758d12ab7a6c7da9531bf';

/// See also [allCoverageStatuses].
@ProviderFor(allCoverageStatuses)
final allCoverageStatusesProvider =
    AutoDisposeFutureProvider<List<CoverageStatus>>.internal(
      allCoverageStatuses,
      name: r'allCoverageStatusesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allCoverageStatusesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCoverageStatusesRef =
    AutoDisposeFutureProviderRef<List<CoverageStatus>>;
String _$coveragePercentageHash() =>
    r'70e2584b658ab4b62cce9fe1c8a0aa17635b711b';

/// See also [coveragePercentage].
@ProviderFor(coveragePercentage)
final coveragePercentageProvider = AutoDisposeFutureProvider<double>.internal(
  coveragePercentage,
  name: r'coveragePercentageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coveragePercentageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoveragePercentageRef = AutoDisposeFutureProviderRef<double>;
String _$coverageBreakdownHash() => r'e45a939dd35d3bd9295d7bf12a50b40b83a1054a';

/// See also [coverageBreakdown].
@ProviderFor(coverageBreakdown)
final coverageBreakdownProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      coverageBreakdown,
      name: r'coverageBreakdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coverageBreakdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoverageBreakdownRef = AutoDisposeFutureProviderRef<Map<String, int>>;
String _$techniqueCoverageStatusHash() =>
    r'e0635be2725b8f4d8bd0848568edb0178a243888';

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

/// See also [techniqueCoverageStatus].
@ProviderFor(techniqueCoverageStatus)
const techniqueCoverageStatusProvider = TechniqueCoverageStatusFamily();

/// See also [techniqueCoverageStatus].
class TechniqueCoverageStatusFamily
    extends Family<AsyncValue<CoverageStatus?>> {
  /// See also [techniqueCoverageStatus].
  const TechniqueCoverageStatusFamily();

  /// See also [techniqueCoverageStatus].
  TechniqueCoverageStatusProvider call(String techniqueId) {
    return TechniqueCoverageStatusProvider(techniqueId);
  }

  @override
  TechniqueCoverageStatusProvider getProviderOverride(
    covariant TechniqueCoverageStatusProvider provider,
  ) {
    return call(provider.techniqueId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'techniqueCoverageStatusProvider';
}

/// See also [techniqueCoverageStatus].
class TechniqueCoverageStatusProvider
    extends AutoDisposeFutureProvider<CoverageStatus?> {
  /// See also [techniqueCoverageStatus].
  TechniqueCoverageStatusProvider(String techniqueId)
    : this._internal(
        (ref) => techniqueCoverageStatus(
          ref as TechniqueCoverageStatusRef,
          techniqueId,
        ),
        from: techniqueCoverageStatusProvider,
        name: r'techniqueCoverageStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$techniqueCoverageStatusHash,
        dependencies: TechniqueCoverageStatusFamily._dependencies,
        allTransitiveDependencies:
            TechniqueCoverageStatusFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
      );

  TechniqueCoverageStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
  }) : super.internal();

  final String techniqueId;

  @override
  Override overrideWith(
    FutureOr<CoverageStatus?> Function(TechniqueCoverageStatusRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TechniqueCoverageStatusProvider._internal(
        (ref) => create(ref as TechniqueCoverageStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CoverageStatus?> createElement() {
    return _TechniqueCoverageStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TechniqueCoverageStatusProvider &&
        other.techniqueId == techniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TechniqueCoverageStatusRef
    on AutoDisposeFutureProviderRef<CoverageStatus?> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;
}

class _TechniqueCoverageStatusProviderElement
    extends AutoDisposeFutureProviderElement<CoverageStatus?>
    with TechniqueCoverageStatusRef {
  _TechniqueCoverageStatusProviderElement(super.provider);

  @override
  String get techniqueId =>
      (origin as TechniqueCoverageStatusProvider).techniqueId;
}

String _$updateCoverageStatusHash() =>
    r'882c0057e51918fd779814f67eb3993b3b8ae152';

/// See also [updateCoverageStatus].
@ProviderFor(updateCoverageStatus)
const updateCoverageStatusProvider = UpdateCoverageStatusFamily();

/// See also [updateCoverageStatus].
class UpdateCoverageStatusFamily extends Family<AsyncValue<void>> {
  /// See also [updateCoverageStatus].
  const UpdateCoverageStatusFamily();

  /// See also [updateCoverageStatus].
  UpdateCoverageStatusProvider call(CoverageStatus status) {
    return UpdateCoverageStatusProvider(status);
  }

  @override
  UpdateCoverageStatusProvider getProviderOverride(
    covariant UpdateCoverageStatusProvider provider,
  ) {
    return call(provider.status);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateCoverageStatusProvider';
}

/// See also [updateCoverageStatus].
class UpdateCoverageStatusProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateCoverageStatus].
  UpdateCoverageStatusProvider(CoverageStatus status)
    : this._internal(
        (ref) => updateCoverageStatus(ref as UpdateCoverageStatusRef, status),
        from: updateCoverageStatusProvider,
        name: r'updateCoverageStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateCoverageStatusHash,
        dependencies: UpdateCoverageStatusFamily._dependencies,
        allTransitiveDependencies:
            UpdateCoverageStatusFamily._allTransitiveDependencies,
        status: status,
      );

  UpdateCoverageStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final CoverageStatus status;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateCoverageStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateCoverageStatusProvider._internal(
        (ref) => create(ref as UpdateCoverageStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateCoverageStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateCoverageStatusProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateCoverageStatusRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `status` of this provider.
  CoverageStatus get status;
}

class _UpdateCoverageStatusProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateCoverageStatusRef {
  _UpdateCoverageStatusProviderElement(super.provider);

  @override
  CoverageStatus get status => (origin as UpdateCoverageStatusProvider).status;
}

String _$deleteCoverageStatusHash() =>
    r'3524ade43bf8cb9408c3f589b4d64e56b70d19dc';

/// See also [deleteCoverageStatus].
@ProviderFor(deleteCoverageStatus)
const deleteCoverageStatusProvider = DeleteCoverageStatusFamily();

/// See also [deleteCoverageStatus].
class DeleteCoverageStatusFamily extends Family<AsyncValue<void>> {
  /// See also [deleteCoverageStatus].
  const DeleteCoverageStatusFamily();

  /// See also [deleteCoverageStatus].
  DeleteCoverageStatusProvider call(String techniqueId) {
    return DeleteCoverageStatusProvider(techniqueId);
  }

  @override
  DeleteCoverageStatusProvider getProviderOverride(
    covariant DeleteCoverageStatusProvider provider,
  ) {
    return call(provider.techniqueId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteCoverageStatusProvider';
}

/// See also [deleteCoverageStatus].
class DeleteCoverageStatusProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteCoverageStatus].
  DeleteCoverageStatusProvider(String techniqueId)
    : this._internal(
        (ref) =>
            deleteCoverageStatus(ref as DeleteCoverageStatusRef, techniqueId),
        from: deleteCoverageStatusProvider,
        name: r'deleteCoverageStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteCoverageStatusHash,
        dependencies: DeleteCoverageStatusFamily._dependencies,
        allTransitiveDependencies:
            DeleteCoverageStatusFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
      );

  DeleteCoverageStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
  }) : super.internal();

  final String techniqueId;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteCoverageStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteCoverageStatusProvider._internal(
        (ref) => create(ref as DeleteCoverageStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteCoverageStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteCoverageStatusProvider &&
        other.techniqueId == techniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteCoverageStatusRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;
}

class _DeleteCoverageStatusProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteCoverageStatusRef {
  _DeleteCoverageStatusProviderElement(super.provider);

  @override
  String get techniqueId =>
      (origin as DeleteCoverageStatusProvider).techniqueId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
