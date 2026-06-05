// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alertsHash() => r'9b83719955d89ce27e7e0e12138758f8c9345913';

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
String _$alertActionsHash() => r'a331351cc461929ac48bdd9540d2b4e563679442';

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
