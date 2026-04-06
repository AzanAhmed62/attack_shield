// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationRiskScoreHash() =>
    r'd5d74e9812d36848374fe60ed468d7964c3dea47';

/// Overall organization risk score — 0.0 to 100.0
///
/// Copied from [organizationRiskScore].
@ProviderFor(organizationRiskScore)
final organizationRiskScoreProvider =
    AutoDisposeFutureProvider<double>.internal(
      organizationRiskScore,
      name: r'organizationRiskScoreProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$organizationRiskScoreHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationRiskScoreRef = AutoDisposeFutureProviderRef<double>;
String _$organizationRiskLabelHash() =>
    r'68bccb4f8c7e7ccf6a063d5bb39796efbebba8ae';

/// Risk label for the organization score (Critical / High / Medium / Low / Minimal)
///
/// Copied from [organizationRiskLabel].
@ProviderFor(organizationRiskLabel)
final organizationRiskLabelProvider =
    AutoDisposeFutureProvider<String>.internal(
      organizationRiskLabel,
      name: r'organizationRiskLabelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$organizationRiskLabelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationRiskLabelRef = AutoDisposeFutureProviderRef<String>;
String _$riskEngineCoveragePercentageHash() =>
    r'2748e9a8e8e596743fc5a08f631ce616d74b99ba';

/// Coverage percentage driven by RiskEngine (0–100)
///
/// Copied from [riskEngineCoveragePercentage].
@ProviderFor(riskEngineCoveragePercentage)
final riskEngineCoveragePercentageProvider =
    AutoDisposeFutureProvider<double>.internal(
      riskEngineCoveragePercentage,
      name: r'riskEngineCoveragePercentageProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$riskEngineCoveragePercentageHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RiskEngineCoveragePercentageRef = AutoDisposeFutureProviderRef<double>;
String _$riskCoverageBreakdownHash() =>
    r'6c2189688922d47a5339a2f1c7f4913d1e6a8153';

/// Coverage breakdown map — { 'covered': N, 'partiallyCovered': N, 'notCovered': N, 'unknown': N }
///
/// Copied from [riskCoverageBreakdown].
@ProviderFor(riskCoverageBreakdown)
final riskCoverageBreakdownProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      riskCoverageBreakdown,
      name: r'riskCoverageBreakdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$riskCoverageBreakdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RiskCoverageBreakdownRef =
    AutoDisposeFutureProviderRef<Map<String, int>>;
String _$tacticRiskMapHash() => r'dc1d5fdc6d196af1963f3f77d1d17931b39031f0';

/// Tactic-level risk map — { tacticName: riskScore(0–10) }
/// Used for the coverage heatmap / matrix screen.
///
/// Copied from [tacticRiskMap].
@ProviderFor(tacticRiskMap)
final tacticRiskMapProvider =
    AutoDisposeFutureProvider<Map<String, double>>.internal(
      tacticRiskMap,
      name: r'tacticRiskMapProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tacticRiskMapHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TacticRiskMapRef = AutoDisposeFutureProviderRef<Map<String, double>>;
String _$topRiskGapsHash() => r'de56d53439ad66bcd4aa3584d1ce3c695d6eec27';

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

/// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
/// This is the primary output for reports and recommendations.
///
/// Copied from [topRiskGaps].
@ProviderFor(topRiskGaps)
const topRiskGapsProvider = TopRiskGapsFamily();

/// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
/// This is the primary output for reports and recommendations.
///
/// Copied from [topRiskGaps].
class TopRiskGapsFamily extends Family<AsyncValue<List<RiskGap>>> {
  /// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
  /// This is the primary output for reports and recommendations.
  ///
  /// Copied from [topRiskGaps].
  const TopRiskGapsFamily();

  /// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
  /// This is the primary output for reports and recommendations.
  ///
  /// Copied from [topRiskGaps].
  TopRiskGapsProvider call({int limit = 10}) {
    return TopRiskGapsProvider(limit: limit);
  }

  @override
  TopRiskGapsProvider getProviderOverride(
    covariant TopRiskGapsProvider provider,
  ) {
    return call(limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'topRiskGapsProvider';
}

/// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
/// This is the primary output for reports and recommendations.
///
/// Copied from [topRiskGaps].
class TopRiskGapsProvider extends AutoDisposeFutureProvider<List<RiskGap>> {
  /// Top 10 highest-exposure risk gaps — uncovered/partial techniques sorted by risk.
  /// This is the primary output for reports and recommendations.
  ///
  /// Copied from [topRiskGaps].
  TopRiskGapsProvider({int limit = 10})
    : this._internal(
        (ref) => topRiskGaps(ref as TopRiskGapsRef, limit: limit),
        from: topRiskGapsProvider,
        name: r'topRiskGapsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$topRiskGapsHash,
        dependencies: TopRiskGapsFamily._dependencies,
        allTransitiveDependencies: TopRiskGapsFamily._allTransitiveDependencies,
        limit: limit,
      );

  TopRiskGapsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<RiskGap>> Function(TopRiskGapsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopRiskGapsProvider._internal(
        (ref) => create(ref as TopRiskGapsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RiskGap>> createElement() {
    return _TopRiskGapsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopRiskGapsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TopRiskGapsRef on AutoDisposeFutureProviderRef<List<RiskGap>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _TopRiskGapsProviderElement
    extends AutoDisposeFutureProviderElement<List<RiskGap>>
    with TopRiskGapsRef {
  _TopRiskGapsProviderElement(super.provider);

  @override
  int get limit => (origin as TopRiskGapsProvider).limit;
}

String _$riskGapsBySeverityHash() =>
    r'05d1816aa883cb080a2f2a213600c92c5c223c8e';

/// Risk gaps count by severity
///
/// Copied from [riskGapsBySeverity].
@ProviderFor(riskGapsBySeverity)
final riskGapsBySeverityProvider =
    AutoDisposeFutureProvider<Map<String, int>>.internal(
      riskGapsBySeverity,
      name: r'riskGapsBySeverityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$riskGapsBySeverityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RiskGapsBySeverityRef = AutoDisposeFutureProviderRef<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
