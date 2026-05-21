// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alertsHash() => r'e0711c7999eed772334ac15e2e584b20e2ddf75a';

/// See also [alerts].
@ProviderFor(alerts)
final alertsProvider = AutoDisposeFutureProvider<List<AlertItem>>.internal(
  alerts,
  name: r'alertsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertsRef = AutoDisposeFutureProviderRef<List<AlertItem>>;
String _$createAlertHash() => r'dc097459198965433724ba71be3bf7fe4879908f';

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

String _$updateAlertStatusHash() => r'08106b5911ef027820a69d50909746b7b96b86bc';

/// See also [updateAlertStatus].
@ProviderFor(updateAlertStatus)
const updateAlertStatusProvider = UpdateAlertStatusFamily();

/// See also [updateAlertStatus].
class UpdateAlertStatusFamily extends Family<AsyncValue<void>> {
  /// See also [updateAlertStatus].
  const UpdateAlertStatusFamily();

  /// See also [updateAlertStatus].
  UpdateAlertStatusProvider call(String id, AlertStatus status) {
    return UpdateAlertStatusProvider(id, status);
  }

  @override
  UpdateAlertStatusProvider getProviderOverride(
    covariant UpdateAlertStatusProvider provider,
  ) {
    return call(provider.id, provider.status);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateAlertStatusProvider';
}

/// See also [updateAlertStatus].
class UpdateAlertStatusProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateAlertStatus].
  UpdateAlertStatusProvider(String id, AlertStatus status)
    : this._internal(
        (ref) => updateAlertStatus(ref as UpdateAlertStatusRef, id, status),
        from: updateAlertStatusProvider,
        name: r'updateAlertStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateAlertStatusHash,
        dependencies: UpdateAlertStatusFamily._dependencies,
        allTransitiveDependencies:
            UpdateAlertStatusFamily._allTransitiveDependencies,
        id: id,
        status: status,
      );

  UpdateAlertStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.status,
  }) : super.internal();

  final String id;
  final AlertStatus status;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateAlertStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateAlertStatusProvider._internal(
        (ref) => create(ref as UpdateAlertStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateAlertStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAlertStatusProvider &&
        other.id == id &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateAlertStatusRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `status` of this provider.
  AlertStatus get status;
}

class _UpdateAlertStatusProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateAlertStatusRef {
  _UpdateAlertStatusProviderElement(super.provider);

  @override
  String get id => (origin as UpdateAlertStatusProvider).id;
  @override
  AlertStatus get status => (origin as UpdateAlertStatusProvider).status;
}

String _$resolveAlertHash() => r'0918c780dfc813c36af4b8ef33a4a198a412059e';

/// See also [resolveAlert].
@ProviderFor(resolveAlert)
const resolveAlertProvider = ResolveAlertFamily();

/// See also [resolveAlert].
class ResolveAlertFamily extends Family<AsyncValue<void>> {
  /// See also [resolveAlert].
  const ResolveAlertFamily();

  /// See also [resolveAlert].
  ResolveAlertProvider call(String id) {
    return ResolveAlertProvider(id);
  }

  @override
  ResolveAlertProvider getProviderOverride(
    covariant ResolveAlertProvider provider,
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
  String? get name => r'resolveAlertProvider';
}

/// See also [resolveAlert].
class ResolveAlertProvider extends AutoDisposeFutureProvider<void> {
  /// See also [resolveAlert].
  ResolveAlertProvider(String id)
    : this._internal(
        (ref) => resolveAlert(ref as ResolveAlertRef, id),
        from: resolveAlertProvider,
        name: r'resolveAlertProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$resolveAlertHash,
        dependencies: ResolveAlertFamily._dependencies,
        allTransitiveDependencies:
            ResolveAlertFamily._allTransitiveDependencies,
        id: id,
      );

  ResolveAlertProvider._internal(
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
    FutureOr<void> Function(ResolveAlertRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResolveAlertProvider._internal(
        (ref) => create(ref as ResolveAlertRef),
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
    return _ResolveAlertProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolveAlertProvider && other.id == id;
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
mixin ResolveAlertRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ResolveAlertProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with ResolveAlertRef {
  _ResolveAlertProviderElement(super.provider);

  @override
  String get id => (origin as ResolveAlertProvider).id;
}

String _$acknowledgeAlertHash() => r'8b0733334cb68e7ef53531a8c72409ba5c5531f4';

/// See also [acknowledgeAlert].
@ProviderFor(acknowledgeAlert)
const acknowledgeAlertProvider = AcknowledgeAlertFamily();

/// See also [acknowledgeAlert].
class AcknowledgeAlertFamily extends Family<AsyncValue<void>> {
  /// See also [acknowledgeAlert].
  const AcknowledgeAlertFamily();

  /// See also [acknowledgeAlert].
  AcknowledgeAlertProvider call(String id) {
    return AcknowledgeAlertProvider(id);
  }

  @override
  AcknowledgeAlertProvider getProviderOverride(
    covariant AcknowledgeAlertProvider provider,
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
  String? get name => r'acknowledgeAlertProvider';
}

/// See also [acknowledgeAlert].
class AcknowledgeAlertProvider extends AutoDisposeFutureProvider<void> {
  /// See also [acknowledgeAlert].
  AcknowledgeAlertProvider(String id)
    : this._internal(
        (ref) => acknowledgeAlert(ref as AcknowledgeAlertRef, id),
        from: acknowledgeAlertProvider,
        name: r'acknowledgeAlertProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$acknowledgeAlertHash,
        dependencies: AcknowledgeAlertFamily._dependencies,
        allTransitiveDependencies:
            AcknowledgeAlertFamily._allTransitiveDependencies,
        id: id,
      );

  AcknowledgeAlertProvider._internal(
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
    FutureOr<void> Function(AcknowledgeAlertRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AcknowledgeAlertProvider._internal(
        (ref) => create(ref as AcknowledgeAlertRef),
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
    return _AcknowledgeAlertProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AcknowledgeAlertProvider && other.id == id;
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
mixin AcknowledgeAlertRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AcknowledgeAlertProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with AcknowledgeAlertRef {
  _AcknowledgeAlertProviderElement(super.provider);

  @override
  String get id => (origin as AcknowledgeAlertProvider).id;
}

String _$deleteAlertHash() => r'5a6278249e6998205ec638da478a7d5747f76041';

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

String _$alertsByStatusHash() => r'5d00e87d57d8923d8cda0e1919ac765488e01f93';

/// See also [alertsByStatus].
@ProviderFor(alertsByStatus)
const alertsByStatusProvider = AlertsByStatusFamily();

/// See also [alertsByStatus].
class AlertsByStatusFamily extends Family<AsyncValue<List<AlertItem>>> {
  /// See also [alertsByStatus].
  const AlertsByStatusFamily();

  /// See also [alertsByStatus].
  AlertsByStatusProvider call(AlertStatus status) {
    return AlertsByStatusProvider(status);
  }

  @override
  AlertsByStatusProvider getProviderOverride(
    covariant AlertsByStatusProvider provider,
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
  String? get name => r'alertsByStatusProvider';
}

/// See also [alertsByStatus].
class AlertsByStatusProvider
    extends AutoDisposeFutureProvider<List<AlertItem>> {
  /// See also [alertsByStatus].
  AlertsByStatusProvider(AlertStatus status)
    : this._internal(
        (ref) => alertsByStatus(ref as AlertsByStatusRef, status),
        from: alertsByStatusProvider,
        name: r'alertsByStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$alertsByStatusHash,
        dependencies: AlertsByStatusFamily._dependencies,
        allTransitiveDependencies:
            AlertsByStatusFamily._allTransitiveDependencies,
        status: status,
      );

  AlertsByStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final AlertStatus status;

  @override
  Override overrideWith(
    FutureOr<List<AlertItem>> Function(AlertsByStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AlertsByStatusProvider._internal(
        (ref) => create(ref as AlertsByStatusRef),
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
  AutoDisposeFutureProviderElement<List<AlertItem>> createElement() {
    return _AlertsByStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlertsByStatusProvider && other.status == status;
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
mixin AlertsByStatusRef on AutoDisposeFutureProviderRef<List<AlertItem>> {
  /// The parameter `status` of this provider.
  AlertStatus get status;
}

class _AlertsByStatusProviderElement
    extends AutoDisposeFutureProviderElement<List<AlertItem>>
    with AlertsByStatusRef {
  _AlertsByStatusProviderElement(super.provider);

  @override
  AlertStatus get status => (origin as AlertsByStatusProvider).status;
}

String _$alertsByPriorityHash() => r'0a53c1a7b8a4a9d575e3a9db86af0572e2df32a2';

/// See also [alertsByPriority].
@ProviderFor(alertsByPriority)
const alertsByPriorityProvider = AlertsByPriorityFamily();

/// See also [alertsByPriority].
class AlertsByPriorityFamily extends Family<AsyncValue<List<AlertItem>>> {
  /// See also [alertsByPriority].
  const AlertsByPriorityFamily();

  /// See also [alertsByPriority].
  AlertsByPriorityProvider call(AlertPriority priority) {
    return AlertsByPriorityProvider(priority);
  }

  @override
  AlertsByPriorityProvider getProviderOverride(
    covariant AlertsByPriorityProvider provider,
  ) {
    return call(provider.priority);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'alertsByPriorityProvider';
}

/// See also [alertsByPriority].
class AlertsByPriorityProvider
    extends AutoDisposeFutureProvider<List<AlertItem>> {
  /// See also [alertsByPriority].
  AlertsByPriorityProvider(AlertPriority priority)
    : this._internal(
        (ref) => alertsByPriority(ref as AlertsByPriorityRef, priority),
        from: alertsByPriorityProvider,
        name: r'alertsByPriorityProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$alertsByPriorityHash,
        dependencies: AlertsByPriorityFamily._dependencies,
        allTransitiveDependencies:
            AlertsByPriorityFamily._allTransitiveDependencies,
        priority: priority,
      );

  AlertsByPriorityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.priority,
  }) : super.internal();

  final AlertPriority priority;

  @override
  Override overrideWith(
    FutureOr<List<AlertItem>> Function(AlertsByPriorityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AlertsByPriorityProvider._internal(
        (ref) => create(ref as AlertsByPriorityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        priority: priority,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AlertItem>> createElement() {
    return _AlertsByPriorityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlertsByPriorityProvider && other.priority == priority;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, priority.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AlertsByPriorityRef on AutoDisposeFutureProviderRef<List<AlertItem>> {
  /// The parameter `priority` of this provider.
  AlertPriority get priority;
}

class _AlertsByPriorityProviderElement
    extends AutoDisposeFutureProviderElement<List<AlertItem>>
    with AlertsByPriorityRef {
  _AlertsByPriorityProviderElement(super.provider);

  @override
  AlertPriority get priority => (origin as AlertsByPriorityProvider).priority;
}

String _$alertsByTechniqueHash() => r'd12b4106aa79f36e34d6089c8f38295a623ec485';

/// See also [alertsByTechnique].
@ProviderFor(alertsByTechnique)
const alertsByTechniqueProvider = AlertsByTechniqueFamily();

/// See also [alertsByTechnique].
class AlertsByTechniqueFamily extends Family<AsyncValue<List<AlertItem>>> {
  /// See also [alertsByTechnique].
  const AlertsByTechniqueFamily();

  /// See also [alertsByTechnique].
  AlertsByTechniqueProvider call(String techniqueId) {
    return AlertsByTechniqueProvider(techniqueId);
  }

  @override
  AlertsByTechniqueProvider getProviderOverride(
    covariant AlertsByTechniqueProvider provider,
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
  String? get name => r'alertsByTechniqueProvider';
}

/// See also [alertsByTechnique].
class AlertsByTechniqueProvider
    extends AutoDisposeFutureProvider<List<AlertItem>> {
  /// See also [alertsByTechnique].
  AlertsByTechniqueProvider(String techniqueId)
    : this._internal(
        (ref) => alertsByTechnique(ref as AlertsByTechniqueRef, techniqueId),
        from: alertsByTechniqueProvider,
        name: r'alertsByTechniqueProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$alertsByTechniqueHash,
        dependencies: AlertsByTechniqueFamily._dependencies,
        allTransitiveDependencies:
            AlertsByTechniqueFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
      );

  AlertsByTechniqueProvider._internal(
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
    FutureOr<List<AlertItem>> Function(AlertsByTechniqueRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AlertsByTechniqueProvider._internal(
        (ref) => create(ref as AlertsByTechniqueRef),
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
  AutoDisposeFutureProviderElement<List<AlertItem>> createElement() {
    return _AlertsByTechniqueProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlertsByTechniqueProvider &&
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
mixin AlertsByTechniqueRef on AutoDisposeFutureProviderRef<List<AlertItem>> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;
}

class _AlertsByTechniqueProviderElement
    extends AutoDisposeFutureProviderElement<List<AlertItem>>
    with AlertsByTechniqueRef {
  _AlertsByTechniqueProviderElement(super.provider);

  @override
  String get techniqueId => (origin as AlertsByTechniqueProvider).techniqueId;
}

String _$openAlertCountHash() => r'28071dc57bae1c5da75df028c6f097dd8072c84c';

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
    r'4958f18e334c7e5a4ec9d74abbdd74400975b98f';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
