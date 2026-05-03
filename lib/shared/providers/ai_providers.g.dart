// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiServiceHash() => r'330ee79d96dbdc5b27db9a0732ddf2ee3097510e';

/// See also [aiService].
@ProviderFor(aiService)
final aiServiceProvider = Provider<AIService>.internal(
  aiService,
  name: r'aiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiServiceRef = ProviderRef<AIService>;
String _$apiKeyConfiguredHash() => r'51384842390f0bcda3fd6b5915c84523fddfc6d4';

/// Whether a valid API key is configured.
///
/// Copied from [ApiKeyConfigured].
@ProviderFor(ApiKeyConfigured)
final apiKeyConfiguredProvider =
    NotifierProvider<ApiKeyConfigured, bool>.internal(
      ApiKeyConfigured.new,
      name: r'apiKeyConfiguredProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$apiKeyConfiguredHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ApiKeyConfigured = Notifier<bool>;
String _$techniqueExplainerStateHash() =>
    r'0a70e7347285b21c5648a97b9880ff8c3e77e6d5';

/// State for the AI technique explanation.
/// null = not yet requested, loading state handled by AsyncValue.
///
/// Copied from [TechniqueExplainerState].
@ProviderFor(TechniqueExplainerState)
final techniqueExplainerStateProvider =
    AutoDisposeNotifierProvider<
      TechniqueExplainerState,
      AsyncValue<TechniqueExplanation>?
    >.internal(
      TechniqueExplainerState.new,
      name: r'techniqueExplainerStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$techniqueExplainerStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TechniqueExplainerState =
    AutoDisposeNotifier<AsyncValue<TechniqueExplanation>?>;
String _$threatIntelMapperStateHash() =>
    r'cc16c632c84e05fa4c244779caa6a8e5442a7e7d';

/// See also [ThreatIntelMapperState].
@ProviderFor(ThreatIntelMapperState)
final threatIntelMapperStateProvider =
    AutoDisposeNotifierProvider<
      ThreatIntelMapperState,
      AsyncValue<ThreatIntelResult>?
    >.internal(
      ThreatIntelMapperState.new,
      name: r'threatIntelMapperStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$threatIntelMapperStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThreatIntelMapperState =
    AutoDisposeNotifier<AsyncValue<ThreatIntelResult>?>;
String _$coverageAdvisorStateHash() =>
    r'2e7fc6dfbc5713f1dfe13cbbd3bad5cacd628ef7';

/// See also [CoverageAdvisorState].
@ProviderFor(CoverageAdvisorState)
final coverageAdvisorStateProvider =
    AutoDisposeNotifierProvider<
      CoverageAdvisorState,
      AsyncValue<CoverageAdvice>?
    >.internal(
      CoverageAdvisorState.new,
      name: r'coverageAdvisorStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coverageAdvisorStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CoverageAdvisorState =
    AutoDisposeNotifier<AsyncValue<CoverageAdvice>?>;
String _$simulationDebriefStateHash() =>
    r'a4cea87b6601feb09078f70bde656d0dda9f4273';

/// Keyed by simulation result ID so each result has independent state.
///
/// Copied from [SimulationDebriefState].
@ProviderFor(SimulationDebriefState)
final simulationDebriefStateProvider =
    AutoDisposeNotifierProvider<
      SimulationDebriefState,
      AsyncValue<SimulationDebrief>?
    >.internal(
      SimulationDebriefState.new,
      name: r'simulationDebriefStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$simulationDebriefStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SimulationDebriefState =
    AutoDisposeNotifier<AsyncValue<SimulationDebrief>?>;
String _$naturalLanguageSearchStateHash() =>
    r'1caa1917d43d74063ede4237ec4ce3b543a0c8c7';

/// See also [NaturalLanguageSearchState].
@ProviderFor(NaturalLanguageSearchState)
final naturalLanguageSearchStateProvider =
    AutoDisposeNotifierProvider<
      NaturalLanguageSearchState,
      AsyncValue<List<String>>?
    >.internal(
      NaturalLanguageSearchState.new,
      name: r'naturalLanguageSearchStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$naturalLanguageSearchStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NaturalLanguageSearchState =
    AutoDisposeNotifier<AsyncValue<List<String>>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
