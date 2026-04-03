// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationProfileHash() =>
    r'340546b7433bb4fd27aa69247814aabb5098be61';

/// See also [organizationProfile].
@ProviderFor(organizationProfile)
final organizationProfileProvider =
    AutoDisposeFutureProvider<OrganizationProfile?>.internal(
      organizationProfile,
      name: r'organizationProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$organizationProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationProfileRef =
    AutoDisposeFutureProviderRef<OrganizationProfile?>;
String _$organizationNameHash() => r'd5269a43d74014926bf03a781ba057f0c67be904';

/// See also [organizationName].
@ProviderFor(organizationName)
final organizationNameProvider = AutoDisposeFutureProvider<String>.internal(
  organizationName,
  name: r'organizationNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationNameRef = AutoDisposeFutureProviderRef<String>;
String _$organizationContextHash() =>
    r'319999d7c494f4079a3847dee0dd9b7ae0d7fcd3';

/// See also [organizationContext].
@ProviderFor(organizationContext)
final organizationContextProvider = AutoDisposeFutureProvider<String>.internal(
  organizationContext,
  name: r'organizationContextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationContextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationContextRef = AutoDisposeFutureProviderRef<String>;
String _$createOrganizationProfileHash() =>
    r'd385b5b2fcf7299f4982f493f048f542eaf07927';

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

/// See also [createOrganizationProfile].
@ProviderFor(createOrganizationProfile)
const createOrganizationProfileProvider = CreateOrganizationProfileFamily();

/// See also [createOrganizationProfile].
class CreateOrganizationProfileFamily extends Family<AsyncValue<void>> {
  /// See also [createOrganizationProfile].
  const CreateOrganizationProfileFamily();

  /// See also [createOrganizationProfile].
  CreateOrganizationProfileProvider call(OrganizationProfile profile) {
    return CreateOrganizationProfileProvider(profile);
  }

  @override
  CreateOrganizationProfileProvider getProviderOverride(
    covariant CreateOrganizationProfileProvider provider,
  ) {
    return call(provider.profile);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createOrganizationProfileProvider';
}

/// See also [createOrganizationProfile].
class CreateOrganizationProfileProvider
    extends AutoDisposeFutureProvider<void> {
  /// See also [createOrganizationProfile].
  CreateOrganizationProfileProvider(OrganizationProfile profile)
    : this._internal(
        (ref) => createOrganizationProfile(
          ref as CreateOrganizationProfileRef,
          profile,
        ),
        from: createOrganizationProfileProvider,
        name: r'createOrganizationProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createOrganizationProfileHash,
        dependencies: CreateOrganizationProfileFamily._dependencies,
        allTransitiveDependencies:
            CreateOrganizationProfileFamily._allTransitiveDependencies,
        profile: profile,
      );

  CreateOrganizationProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profile,
  }) : super.internal();

  final OrganizationProfile profile;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateOrganizationProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateOrganizationProfileProvider._internal(
        (ref) => create(ref as CreateOrganizationProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profile: profile,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateOrganizationProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateOrganizationProfileProvider &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profile.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateOrganizationProfileRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `profile` of this provider.
  OrganizationProfile get profile;
}

class _CreateOrganizationProfileProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CreateOrganizationProfileRef {
  _CreateOrganizationProfileProviderElement(super.provider);

  @override
  OrganizationProfile get profile =>
      (origin as CreateOrganizationProfileProvider).profile;
}

String _$updateOrganizationProfileHash() =>
    r'028af5f1b17273a6245d9baa4c2153e2fbc2a75b';

/// See also [updateOrganizationProfile].
@ProviderFor(updateOrganizationProfile)
const updateOrganizationProfileProvider = UpdateOrganizationProfileFamily();

/// See also [updateOrganizationProfile].
class UpdateOrganizationProfileFamily extends Family<AsyncValue<void>> {
  /// See also [updateOrganizationProfile].
  const UpdateOrganizationProfileFamily();

  /// See also [updateOrganizationProfile].
  UpdateOrganizationProfileProvider call(OrganizationProfile profile) {
    return UpdateOrganizationProfileProvider(profile);
  }

  @override
  UpdateOrganizationProfileProvider getProviderOverride(
    covariant UpdateOrganizationProfileProvider provider,
  ) {
    return call(provider.profile);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateOrganizationProfileProvider';
}

/// See also [updateOrganizationProfile].
class UpdateOrganizationProfileProvider
    extends AutoDisposeFutureProvider<void> {
  /// See also [updateOrganizationProfile].
  UpdateOrganizationProfileProvider(OrganizationProfile profile)
    : this._internal(
        (ref) => updateOrganizationProfile(
          ref as UpdateOrganizationProfileRef,
          profile,
        ),
        from: updateOrganizationProfileProvider,
        name: r'updateOrganizationProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateOrganizationProfileHash,
        dependencies: UpdateOrganizationProfileFamily._dependencies,
        allTransitiveDependencies:
            UpdateOrganizationProfileFamily._allTransitiveDependencies,
        profile: profile,
      );

  UpdateOrganizationProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profile,
  }) : super.internal();

  final OrganizationProfile profile;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateOrganizationProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateOrganizationProfileProvider._internal(
        (ref) => create(ref as UpdateOrganizationProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profile: profile,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateOrganizationProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateOrganizationProfileProvider &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profile.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateOrganizationProfileRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `profile` of this provider.
  OrganizationProfile get profile;
}

class _UpdateOrganizationProfileProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateOrganizationProfileRef {
  _UpdateOrganizationProfileProviderElement(super.provider);

  @override
  OrganizationProfile get profile =>
      (origin as UpdateOrganizationProfileProvider).profile;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
