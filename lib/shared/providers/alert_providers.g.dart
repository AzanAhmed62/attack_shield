// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alertsHash() => r'7428612054c1630776bfdc44ab2d35e3fda2d630';

/// See also [alerts].
@ProviderFor(alerts)
final alertsProvider = AutoDisposeFutureProvider<List<SecurityAlert>>.internal(
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
typedef AlertsRef = AutoDisposeFutureProviderRef<List<SecurityAlert>>;
String _$openAlertCountHash() => r'466fcf9e51cd6ddfc9671cd6be24732c0ecf351b';

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
    r'c67d01cadd762d0aa5de07e58d2d44f36c0eb101';

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
String _$alertActionsHash() => r'f50b9fa339d84ac9e961ed40ea2aa49bf1bc7343';

/// See also [AlertActions].
@ProviderFor(AlertActions)
final alertActionsProvider =
    AutoDisposeNotifierProvider<AlertActions, bool>.internal(
      AlertActions.new,
      name: r'alertActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$alertActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlertActions = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
