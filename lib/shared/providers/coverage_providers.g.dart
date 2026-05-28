// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCoverageStatusesHash() =>
    r'59559be361b31dfa83cdc93fd9a0b97913842fab';

/// See also [allCoverageStatuses].
@ProviderFor(allCoverageStatuses)
final allCoverageStatusesProvider =
    FutureProvider<List<CoverageStatus>>.internal(
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
typedef AllCoverageStatusesRef = FutureProviderRef<List<CoverageStatus>>;
String _$coverageMapHash() => r'77e53d448d871396e5032b41fdc4d1e3ee75d42e';

/// See also [coverageMap].
@ProviderFor(coverageMap)
final coverageMapProvider =
    AutoDisposeFutureProvider<Map<String, CoverageLevel>>.internal(
      coverageMap,
      name: r'coverageMapProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coverageMapHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoverageMapRef =
    AutoDisposeFutureProviderRef<Map<String, CoverageLevel>>;
String _$riskReportHash() => r'3a64a998fa677a4736dfe771ef4cbcb54813813f';

/// See also [riskReport].
@ProviderFor(riskReport)
final riskReportProvider = AutoDisposeFutureProvider<RiskReport>.internal(
  riskReport,
  name: r'riskReportProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$riskReportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RiskReportRef = AutoDisposeFutureProviderRef<RiskReport>;
String _$orgRiskScoreHash() => r'191319eb7f8052ea957197af0802fb76d720dc45';

/// See also [orgRiskScore].
@ProviderFor(orgRiskScore)
final orgRiskScoreProvider = AutoDisposeFutureProvider<double>.internal(
  orgRiskScore,
  name: r'orgRiskScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orgRiskScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgRiskScoreRef = AutoDisposeFutureProviderRef<double>;
String _$coveragePercentageHash() =>
    r'27b24eb68420e65fcb046a9672195aadccae1635';

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
String _$coverageBreakdownHash() => r'b05ba748bc0c3a76673d410c963df37d32520700';

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
String _$topCoverageGapsHash() => r'4768281d15829dcbb2c267a83ab68f3974b2ba9e';

/// See also [topCoverageGaps].
@ProviderFor(topCoverageGaps)
final topCoverageGapsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
      topCoverageGaps,
      name: r'topCoverageGapsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$topCoverageGapsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TopCoverageGapsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$techniqueCoverageStatusHash() =>
    r'601a77f2f322176c431fede5a614c32db99a7668';

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

String _$tacticRiskBreakdownHash() =>
    r'f3ebdd89584102342094276bf715ef6455c893f8';

/// See also [tacticRiskBreakdown].
@ProviderFor(tacticRiskBreakdown)
final tacticRiskBreakdownProvider =
    AutoDisposeFutureProvider<List<TacticRiskEntry>>.internal(
      tacticRiskBreakdown,
      name: r'tacticRiskBreakdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tacticRiskBreakdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TacticRiskBreakdownRef =
    AutoDisposeFutureProviderRef<List<TacticRiskEntry>>;
String _$tacticCoverageStatsHash() =>
    r'2337ada1c48a796872c13bfd0db39b992e4b3f26';

/// See also [tacticCoverageStats].
@ProviderFor(tacticCoverageStats)
const tacticCoverageStatsProvider = TacticCoverageStatsFamily();

/// See also [tacticCoverageStats].
class TacticCoverageStatsFamily
    extends Family<AsyncValue<({int covered, int total, double coveragePct})>> {
  /// See also [tacticCoverageStats].
  const TacticCoverageStatsFamily();

  /// See also [tacticCoverageStats].
  TacticCoverageStatsProvider call(String tacticShortName) {
    return TacticCoverageStatsProvider(tacticShortName);
  }

  @override
  TacticCoverageStatsProvider getProviderOverride(
    covariant TacticCoverageStatsProvider provider,
  ) {
    return call(provider.tacticShortName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tacticCoverageStatsProvider';
}

/// See also [tacticCoverageStats].
class TacticCoverageStatsProvider
    extends
        AutoDisposeFutureProvider<
          ({int covered, int total, double coveragePct})
        > {
  /// See also [tacticCoverageStats].
  TacticCoverageStatsProvider(String tacticShortName)
    : this._internal(
        (ref) =>
            tacticCoverageStats(ref as TacticCoverageStatsRef, tacticShortName),
        from: tacticCoverageStatsProvider,
        name: r'tacticCoverageStatsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tacticCoverageStatsHash,
        dependencies: TacticCoverageStatsFamily._dependencies,
        allTransitiveDependencies:
            TacticCoverageStatsFamily._allTransitiveDependencies,
        tacticShortName: tacticShortName,
      );

  TacticCoverageStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tacticShortName,
  }) : super.internal();

  final String tacticShortName;

  @override
  Override overrideWith(
    FutureOr<({int covered, int total, double coveragePct})> Function(
      TacticCoverageStatsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TacticCoverageStatsProvider._internal(
        (ref) => create(ref as TacticCoverageStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tacticShortName: tacticShortName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<
    ({int covered, int total, double coveragePct})
  >
  createElement() {
    return _TacticCoverageStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TacticCoverageStatsProvider &&
        other.tacticShortName == tacticShortName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tacticShortName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TacticCoverageStatsRef
    on
        AutoDisposeFutureProviderRef<
          ({int covered, int total, double coveragePct})
        > {
  /// The parameter `tacticShortName` of this provider.
  String get tacticShortName;
}

class _TacticCoverageStatsProviderElement
    extends
        AutoDisposeFutureProviderElement<
          ({int covered, int total, double coveragePct})
        >
    with TacticCoverageStatsRef {
  _TacticCoverageStatsProviderElement(super.provider);

  @override
  String get tacticShortName =>
      (origin as TacticCoverageStatsProvider).tacticShortName;
}

String _$coverageActionsHash() => r'fa30c4d96cf3a0a3d258dbc76a047314eed0c6fa';

/// See also [CoverageActions].
@ProviderFor(CoverageActions)
final coverageActionsProvider =
    AutoDisposeNotifierProvider<CoverageActions, bool>.internal(
      CoverageActions.new,
      name: r'coverageActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coverageActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CoverageActions = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
