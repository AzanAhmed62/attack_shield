// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationProfileHash() =>
    r'71968d58097a2f2e8671973265d8c1c947b5adba';

/// Current organization profile. Returns null if not set (triggers onboarding).
///
/// Copied from [organizationProfile].
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
String _$updateOrganizationProfileHash() =>
    r'8af61d64f4687fa1048cd9bad5af35254762319d';

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

/// Save or update the organization profile.
///
/// Copied from [updateOrganizationProfile].
@ProviderFor(updateOrganizationProfile)
const updateOrganizationProfileProvider = UpdateOrganizationProfileFamily();

/// Save or update the organization profile.
///
/// Copied from [updateOrganizationProfile].
class UpdateOrganizationProfileFamily extends Family<AsyncValue<void>> {
  /// Save or update the organization profile.
  ///
  /// Copied from [updateOrganizationProfile].
  const UpdateOrganizationProfileFamily();

  /// Save or update the organization profile.
  ///
  /// Copied from [updateOrganizationProfile].
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

/// Save or update the organization profile.
///
/// Copied from [updateOrganizationProfile].
class UpdateOrganizationProfileProvider
    extends AutoDisposeFutureProvider<void> {
  /// Save or update the organization profile.
  ///
  /// Copied from [updateOrganizationProfile].
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

String _$deleteOrganizationProfileHash() =>
    r'4c691dc5543479fc197a63a0f3538097d1fbe9a3';

/// Delete the organization profile (forces onboarding on next cold start).
///
/// Copied from [deleteOrganizationProfile].
@ProviderFor(deleteOrganizationProfile)
final deleteOrganizationProfileProvider =
    AutoDisposeFutureProvider<void>.internal(
      deleteOrganizationProfile,
      name: r'deleteOrganizationProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deleteOrganizationProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteOrganizationProfileRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
