// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAlertsHash() => r'70e7e827703574ee284b31bbff88fb3c362ca419';

/// See also [allAlerts].
@ProviderFor(allAlerts)
final allAlertsProvider = AutoDisposeFutureProvider<List<AlertItem>>.internal(
  allAlerts,
  name: r'allAlertsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allAlertsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllAlertsRef = AutoDisposeFutureProviderRef<List<AlertItem>>;
String _$selectedAlertStatusHash() =>
    r'8492c30a49382ead8ce087d21820432b4f7cb1d8';

/// See also [selectedAlertStatus].
@ProviderFor(selectedAlertStatus)
final selectedAlertStatusProvider = AutoDisposeProvider<String>.internal(
  selectedAlertStatus,
  name: r'selectedAlertStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAlertStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedAlertStatusRef = AutoDisposeProviderRef<String>;
String _$alertSearchQueryHash() => r'8d5d3874ac059019ba6cfc4a1324d4d3ac0f3ed6';

/// See also [alertSearchQuery].
@ProviderFor(alertSearchQuery)
final alertSearchQueryProvider = AutoDisposeProvider<String>.internal(
  alertSearchQuery,
  name: r'alertSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertSearchQueryRef = AutoDisposeProviderRef<String>;
String _$filteredAlertsHash() => r'7154a9fb49616656d1a0925a2ad741d797c29058';

/// See also [filteredAlerts].
@ProviderFor(filteredAlerts)
final filteredAlertsProvider =
    AutoDisposeFutureProvider<List<AlertItem>>.internal(
      filteredAlerts,
      name: r'filteredAlertsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredAlertsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredAlertsRef = AutoDisposeFutureProviderRef<List<AlertItem>>;
String _$alertCountHash() => r'490ee36f8bf6a7ef62a35ea1f0f29d4da0ef95e4';

/// See also [alertCount].
@ProviderFor(alertCount)
final alertCountProvider = AutoDisposeFutureProvider<int>.internal(
  alertCount,
  name: r'alertCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertCountRef = AutoDisposeFutureProviderRef<int>;
String _$criticalAlertCountHash() =>
    r'01b2df8cee8a246fc5ab42e88bfd92891f062034';

/// See also [criticalAlertCount].
@ProviderFor(criticalAlertCount)
final criticalAlertCountProvider = AutoDisposeFutureProvider<int>.internal(
  criticalAlertCount,
  name: r'criticalAlertCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$criticalAlertCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CriticalAlertCountRef = AutoDisposeFutureProviderRef<int>;
String _$openAlertCountHash() => r'7dcbd9a792438cebdb8be6cc888681316f4852b4';

/// See also [openAlertCount].
@ProviderFor(openAlertCount)
final openAlertCountProvider = AutoDisposeFutureProvider<int>.internal(
  openAlertCount,
  name: r'openAlertCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openAlertCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OpenAlertCountRef = AutoDisposeFutureProviderRef<int>;
String _$createAlertHash() => r'5e39eea243e592bf056a033f2f30ee5cd8fe8ff0';

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

/// See also [createAlert].
@ProviderFor(createAlert)
const createAlertProvider = CreateAlertFamily();

/// See also [createAlert].
class CreateAlertFamily extends Family<AsyncValue<void>> {
  /// See also [createAlert].
  const CreateAlertFamily();

  /// See also [createAlert].
  CreateAlertProvider call(AlertItem alert) {
    return CreateAlertProvider(alert);
  }

  @override
  CreateAlertProvider getProviderOverride(
    covariant CreateAlertProvider provider,
  ) {
    return call(provider.alert);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createAlertProvider';
}

/// See also [createAlert].
class CreateAlertProvider extends AutoDisposeFutureProvider<void> {
  /// See also [createAlert].
  CreateAlertProvider(AlertItem alert)
    : this._internal(
        (ref) => createAlert(ref as CreateAlertRef, alert),
        from: createAlertProvider,
        name: r'createAlertProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createAlertHash,
        dependencies: CreateAlertFamily._dependencies,
        allTransitiveDependencies: CreateAlertFamily._allTransitiveDependencies,
        alert: alert,
      );

  CreateAlertProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alert,
  }) : super.internal();

  final AlertItem alert;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateAlertRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateAlertProvider._internal(
        (ref) => create(ref as CreateAlertRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        alert: alert,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateAlertProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAlertProvider && other.alert == alert;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alert.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateAlertRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `alert` of this provider.
  AlertItem get alert;
}

class _CreateAlertProviderElement extends AutoDisposeFutureProviderElement<void>
    with CreateAlertRef {
  _CreateAlertProviderElement(super.provider);

  @override
  AlertItem get alert => (origin as CreateAlertProvider).alert;
}

String _$updateAlertHash() => r'2812abcfc0a4c9a54bbba7142153645feb4ab7e7';

/// See also [updateAlert].
@ProviderFor(updateAlert)
const updateAlertProvider = UpdateAlertFamily();

/// See also [updateAlert].
class UpdateAlertFamily extends Family<AsyncValue<void>> {
  /// See also [updateAlert].
  const UpdateAlertFamily();

  /// See also [updateAlert].
  UpdateAlertProvider call(AlertItem alert) {
    return UpdateAlertProvider(alert);
  }

  @override
  UpdateAlertProvider getProviderOverride(
    covariant UpdateAlertProvider provider,
  ) {
    return call(provider.alert);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateAlertProvider';
}

/// See also [updateAlert].
class UpdateAlertProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateAlert].
  UpdateAlertProvider(AlertItem alert)
    : this._internal(
        (ref) => updateAlert(ref as UpdateAlertRef, alert),
        from: updateAlertProvider,
        name: r'updateAlertProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateAlertHash,
        dependencies: UpdateAlertFamily._dependencies,
        allTransitiveDependencies: UpdateAlertFamily._allTransitiveDependencies,
        alert: alert,
      );

  UpdateAlertProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alert,
  }) : super.internal();

  final AlertItem alert;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateAlertRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateAlertProvider._internal(
        (ref) => create(ref as UpdateAlertRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        alert: alert,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateAlertProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAlertProvider && other.alert == alert;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alert.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateAlertRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `alert` of this provider.
  AlertItem get alert;
}

class _UpdateAlertProviderElement extends AutoDisposeFutureProviderElement<void>
    with UpdateAlertRef {
  _UpdateAlertProviderElement(super.provider);

  @override
  AlertItem get alert => (origin as UpdateAlertProvider).alert;
}

String _$deleteAlertHash() => r'4f450930c780d033eb31ce7d01c48564e3997bbd';

/// See also [deleteAlert].
@ProviderFor(deleteAlert)
const deleteAlertProvider = DeleteAlertFamily();

/// See also [deleteAlert].
class DeleteAlertFamily extends Family<AsyncValue<void>> {
  /// See also [deleteAlert].
  const DeleteAlertFamily();

  /// See also [deleteAlert].
  DeleteAlertProvider call(String id) {
    return DeleteAlertProvider(id);
  }

  @override
  DeleteAlertProvider getProviderOverride(
    covariant DeleteAlertProvider provider,
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
  String? get name => r'deleteAlertProvider';
}

/// See also [deleteAlert].
class DeleteAlertProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteAlert].
  DeleteAlertProvider(String id)
    : this._internal(
        (ref) => deleteAlert(ref as DeleteAlertRef, id),
        from: deleteAlertProvider,
        name: r'deleteAlertProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteAlertHash,
        dependencies: DeleteAlertFamily._dependencies,
        allTransitiveDependencies: DeleteAlertFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteAlertProvider._internal(
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
    FutureOr<void> Function(DeleteAlertRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteAlertProvider._internal(
        (ref) => create(ref as DeleteAlertRef),
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
    return _DeleteAlertProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteAlertProvider && other.id == id;
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
mixin DeleteAlertRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeleteAlertProviderElement extends AutoDisposeFutureProviderElement<void>
    with DeleteAlertRef {
  _DeleteAlertProviderElement(super.provider);

  @override
  String get id => (origin as DeleteAlertProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
