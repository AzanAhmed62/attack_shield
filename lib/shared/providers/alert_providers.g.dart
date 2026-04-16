// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAlertsHash() => r'2852fa59f8d5387b30a583b549c7152007b3202d';

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
String _$filteredAlertsHash() => r'd2e367027a0a4995fa78dcf7c0e5cab7842f78e8';

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
String _$alertCountProviderHash() =>
    r'a708b469e9f1dfa8d6dfaf3befb99ce640d1a318';

/// See also [alertCountProvider].
@ProviderFor(alertCountProvider)
final alertCountProviderProvider = AutoDisposeFutureProvider<int>.internal(
  alertCountProvider,
  name: r'alertCountProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertCountProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertCountProviderRef = AutoDisposeFutureProviderRef<int>;
String _$openAlertCountHash() => r'0c388a7f5bd721994e96653a7bdf4055a05f228e';

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
String _$criticalAlertCountHash() =>
    r'e7ce79c52c6313b2b245eaf2ead31d3fb400c665';

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
String _$createAlertHash() => r'959ff0b2cbffe3b93b25af33ceb42e2c5fc0b959';

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

String _$updateAlertHash() => r'e4398bea65efaa43e2023b2925ba80c3d229bcc6';

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

String _$deleteAlertHash() => r'c610af8e829f970c1c359f0019e5353156d0e939';

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

String _$clearAllAlertsHash() => r'9befc6e2cf62cb3e214c27cd11c2c96ddad439c8';

/// See also [clearAllAlerts].
@ProviderFor(clearAllAlerts)
final clearAllAlertsProvider = AutoDisposeFutureProvider<void>.internal(
  clearAllAlerts,
  name: r'clearAllAlertsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearAllAlertsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearAllAlertsRef = AutoDisposeFutureProviderRef<void>;
String _$alertSearchQueryHash() => r'8833276897fb2da32e8c5a06f5f71467434c7b34';

/// Search query for the alerts screen.
///
/// Copied from [AlertSearchQuery].
@ProviderFor(AlertSearchQuery)
final alertSearchQueryProvider =
    AutoDisposeNotifierProvider<AlertSearchQuery, String>.internal(
      AlertSearchQuery.new,
      name: r'alertSearchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$alertSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlertSearchQuery = AutoDisposeNotifier<String>;
String _$selectedAlertStatusHash() =>
    r'898629df601c5700f03ee24df238795fe09fae1b';

/// Selected alert status filter (empty = all).
///
/// Copied from [SelectedAlertStatus].
@ProviderFor(SelectedAlertStatus)
final selectedAlertStatusProvider =
    AutoDisposeNotifierProvider<SelectedAlertStatus, String>.internal(
      SelectedAlertStatus.new,
      name: r'selectedAlertStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedAlertStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedAlertStatus = AutoDisposeNotifier<String>;
String _$selectedAlertPriorityHash() =>
    r'9d9c155b22ac327dfd39a6f527b5f84f443cb20f';

/// Selected alert priority filter (null = all).
///
/// Copied from [SelectedAlertPriority].
@ProviderFor(SelectedAlertPriority)
final selectedAlertPriorityProvider =
    AutoDisposeNotifierProvider<SelectedAlertPriority, AlertPriority?>.internal(
      SelectedAlertPriority.new,
      name: r'selectedAlertPriorityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedAlertPriorityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedAlertPriority = AutoDisposeNotifier<AlertPriority?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
