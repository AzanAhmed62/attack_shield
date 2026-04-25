import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/core/services/ai_service.dart';
import 'package:attackshield/core/services/risk_engine.dart';
import 'package:attackshield/shared/models/models.dart';

part 'ai_providers.g.dart';

// ── AI service singleton ──────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
AIService aiService(Ref ref) => AIService();

// ── API key state ─────────────────────────────────────────────────────────────

/// Whether a valid API key is configured.
@Riverpod(keepAlive: true)
class ApiKeyConfigured extends _$ApiKeyConfigured {
  @override
  bool build() => AIService().hasApiKey;

  void refresh() => state = AIService().hasApiKey;

  Future<void> saveKey(String key) async {
    await AIService().saveApiKey(key);
    state = AIService().hasApiKey;
  }

  Future<void> clearKey() async {
    await AIService().clearApiKey();
    state = false;
  }
}

// ── Feature 1: Technique Explainer ───────────────────────────────────────────

/// State for the AI technique explanation.
/// null = not yet requested, loading state handled by AsyncValue.
@Riverpod(keepAlive: false)
class TechniqueExplainerState extends _$TechniqueExplainerState {
  @override
  AsyncValue<TechniqueExplanation>? build() => null;

  Future<void> explain({
    required AttackTechnique technique,
    OrganizationProfile? orgProfile,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AIService().explainTechnique(
        technique: technique,
        orgProfile: orgProfile,
      ),
    );
  }

  void reset() => state = null;
}

// ── Feature 2: Threat Intel Mapper ───────────────────────────────────────────

@Riverpod(keepAlive: false)
class ThreatIntelMapperState extends _$ThreatIntelMapperState {
  @override
  AsyncValue<ThreatIntelResult>? build() => null;

  Future<void> analyse(String rawText) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AIService().mapThreatIntelligence(rawText),
    );
  }

  void reset() => state = null;
}

// ── Feature 3: Coverage Advisor ──────────────────────────────────────────────

@Riverpod(keepAlive: false)
class CoverageAdvisorState extends _$CoverageAdvisorState {
  @override
  AsyncValue<CoverageAdvice>? build() => null;

  Future<void> generateAdvice({
    required OrganizationProfile orgProfile,
    required List<RiskGap> topGaps,
    required double currentCoverage,
    required double riskScore,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Extract technique IDs from risk gaps
      // targetedIds = techniques that are identified as threats/gaps
      // coveredIds = techniques from topGaps that have coverage or low risk
      final targetedIds = <String>{};
      final coveredIds = <String>{};

      for (final gap in topGaps) {
        targetedIds.add(gap.technique.id);
        // Mark as covered if coverage exists or risk is low
        final hasCoverage = gap.coverageLevel != CoverageLevel.notCovered;
        final isLowRisk = gap.exposedRiskScore < 5.0;
        if (hasCoverage || isLowRisk) {
          coveredIds.add(gap.technique.id);
        }
      }

      return AIService().generateCoverageAdvice(
        orgProfile: orgProfile,
        coveredTechniqueIds: coveredIds.toList(),
        targetedTechniqueIds: targetedIds.toList(),
      );
    });
  }

  void reset() => state = null;
}

// ── Feature 4: Simulation Debrief ────────────────────────────────────────────

/// Keyed by simulation result ID so each result has independent state.
@Riverpod(keepAlive: false)
class SimulationDebriefState extends _$SimulationDebriefState {
  @override
  AsyncValue<SimulationDebrief>? build() => null;

  Future<void> generateDebrief({
    required SimulationScenario scenario,
    required SimulationResult result,
    OrganizationProfile? orgProfile,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AIService().debriefSimulation(
        simulationName: scenario.name,
        scenarioDescription: scenario.description,
        successDetected:
            result.result == TestResult.passed ||
            result.result == TestResult.partiallyPassed,
        timeToDetect: 'Not measured',
        detectionMethod: result.observations,
        mitigationSuccess: result.recommendations,
        improvements: result.observations,
      ),
    );
  }

  void reset() => state = null;
}

// ── Feature 5: Natural Language Search ───────────────────────────────────────

@Riverpod(keepAlive: false)
class NaturalLanguageSearchState extends _$NaturalLanguageSearchState {
  @override
  AsyncValue<List<String>>? build() => null;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = null;
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AIService().naturalLanguageSearch(query),
    );
  }

  void reset() => state = null;
}
