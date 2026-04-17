// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threat_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threatProfileHash() => r'cdf98f5f9c339cebd79456853ccdeffc895fc3ce';

/// Computes the full ThreatProfile from the current OrganizationProfile.
/// Automatically recomputes when the org profile changes.
/// Returns null if no org profile is set yet.
///
/// Copied from [threatProfile].
@ProviderFor(threatProfile)
final threatProfileProvider =
    AutoDisposeFutureProvider<ThreatProfile?>.internal(
      threatProfile,
      name: r'threatProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$threatProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThreatProfileRef = AutoDisposeFutureProviderRef<ThreatProfile?>;
String _$orgPriorityTechniqueIdsHash() =>
    r'8c4988e76637fa8db510d862aa30308b09f34830';

/// Just the priority technique IDs for this org — used in library sorting.
///
/// Copied from [orgPriorityTechniqueIds].
@ProviderFor(orgPriorityTechniqueIds)
final orgPriorityTechniqueIdsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
      orgPriorityTechniqueIds,
      name: r'orgPriorityTechniqueIdsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orgPriorityTechniqueIdsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgPriorityTechniqueIdsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$orgTopThreatsHash() => r'b42667561541adb65a32cb390ee6e8192408594a';

/// Top named threats — used in dashboard and plain-language mode.
///
/// Copied from [orgTopThreats].
@ProviderFor(orgTopThreats)
final orgTopThreatsProvider =
    AutoDisposeFutureProvider<List<NamedThreat>>.internal(
      orgTopThreats,
      name: r'orgTopThreatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orgTopThreatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgTopThreatsRef = AutoDisposeFutureProviderRef<List<NamedThreat>>;
String _$orgCoverageSuggestionsHash() =>
    r'c6a330875c7f4fb2311f56bd62fe11d553d07d4e';

/// Coverage suggestions based on declared controls.
///
/// Copied from [orgCoverageSuggestions].
@ProviderFor(orgCoverageSuggestions)
final orgCoverageSuggestionsProvider =
    AutoDisposeFutureProvider<List<CoverageSuggestion>>.internal(
      orgCoverageSuggestions,
      name: r'orgCoverageSuggestionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orgCoverageSuggestionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgCoverageSuggestionsRef =
    AutoDisposeFutureProviderRef<List<CoverageSuggestion>>;
String _$orgBaselineRiskHash() => r'adcd996847fe792f70206f7f3e99615a2b005aab';

/// The baseline risk score (0–100) before any manual coverage is applied.
///
/// Copied from [orgBaselineRisk].
@ProviderFor(orgBaselineRisk)
final orgBaselineRiskProvider = AutoDisposeFutureProvider<double>.internal(
  orgBaselineRisk,
  name: r'orgBaselineRiskProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orgBaselineRiskHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrgBaselineRiskRef = AutoDisposeFutureProviderRef<double>;
String _$hasCompleteThreatProfileHash() =>
    r'76d1e2306cea6ef418048eab5a4809293211a4a2';

/// Whether the org profile has enough data to generate a threat profile.
///
/// Copied from [hasCompleteThreatProfile].
@ProviderFor(hasCompleteThreatProfile)
final hasCompleteThreatProfileProvider =
    AutoDisposeFutureProvider<bool>.internal(
      hasCompleteThreatProfile,
      name: r'hasCompleteThreatProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$hasCompleteThreatProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasCompleteThreatProfileRef = AutoDisposeFutureProviderRef<bool>;
String _$applyCoverageSuggestionsHash() =>
    r'df936afbef2f927e17c5a5fdc32d57bfd2768b69';

/// Auto-apply coverage suggestions from declared controls.
/// Call this after onboarding or when the user saves an updated org profile.
/// It creates CoverageStatus entries for all suggested techniques,
/// but only if no coverage has been manually set for that technique yet
/// (so it never overwrites the user's manual assessments).
///
/// Copied from [applyCoverageSuggestions].
@ProviderFor(applyCoverageSuggestions)
final applyCoverageSuggestionsProvider =
    AutoDisposeFutureProvider<int>.internal(
      applyCoverageSuggestions,
      name: r'applyCoverageSuggestionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$applyCoverageSuggestionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApplyCoverageSuggestionsRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
