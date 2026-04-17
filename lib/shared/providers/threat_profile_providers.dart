import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/core/services/threat_profile_service.dart';
import 'organization_providers.dart';
import 'coverage_providers.dart';
import 'repository_providers.dart';

part 'threat_profile_providers.g.dart';

/// Computes the full ThreatProfile from the current OrganizationProfile.
/// Automatically recomputes when the org profile changes.
/// Returns null if no org profile is set yet.
@Riverpod(keepAlive: false)
Future<ThreatProfile?> threatProfile(Ref ref) async {
  final org = await ref.watch(organizationProfileProvider.future);
  if (org == null) return null;
  // Run on isolate-friendly pure function
  return ThreatProfileService.generate(org);
}

/// Just the priority technique IDs for this org — used in library sorting.
@Riverpod(keepAlive: false)
Future<List<String>> orgPriorityTechniqueIds(Ref ref) async {
  final profile = await ref.watch(threatProfileProvider.future);
  return profile?.priorityTechniqueIds ?? [];
}

/// Top named threats — used in dashboard and plain-language mode.
@Riverpod(keepAlive: false)
Future<List<NamedThreat>> orgTopThreats(Ref ref) async {
  final profile = await ref.watch(threatProfileProvider.future);
  return profile?.topThreats ?? [];
}

/// Coverage suggestions based on declared controls.
@Riverpod(keepAlive: false)
Future<List<CoverageSuggestion>> orgCoverageSuggestions(Ref ref) async {
  final profile = await ref.watch(threatProfileProvider.future);
  return profile?.coverageSuggestions ?? [];
}

/// The baseline risk score (0–100) before any manual coverage is applied.
@Riverpod(keepAlive: false)
Future<double> orgBaselineRisk(Ref ref) async {
  final profile = await ref.watch(threatProfileProvider.future);
  return profile?.baselineRiskScore ?? 50.0;
}

/// Whether the org profile has enough data to generate a threat profile.
@Riverpod(keepAlive: false)
Future<bool> hasCompleteThreatProfile(Ref ref) async {
  final org = await ref.watch(organizationProfileProvider.future);
  return org != null && org.isProfileComplete;
}

/// Auto-apply coverage suggestions from declared controls.
/// Call this after onboarding or when the user saves an updated org profile.
/// It creates CoverageStatus entries for all suggested techniques,
/// but only if no coverage has been manually set for that technique yet
/// (so it never overwrites the user's manual assessments).
@Riverpod(keepAlive: false)
Future<int> applyCoverageSuggestions(Ref ref) async {
  final suggestions = await ref.read(orgCoverageSuggestionsProvider.future);
  if (suggestions.isEmpty) return 0;

  final coverageRepo = ref.read(coverageRepositoryProvider);
  final existing = await coverageRepo.getAllCoverageStatuses();
  final existingIds = existing.map((c) => c.techniqueId).toSet();

  int applied = 0;

  for (final suggestion in suggestions) {
    // Never overwrite manual coverage — only fill gaps
    if (existingIds.contains(suggestion.techniqueId)) continue;

    final level = _levelFromString(suggestion.suggestedLevel);
    await coverageRepo.updateCoverageStatus(
      CoverageStatus(
        techniqueId: suggestion.techniqueId,
        level: level,
        notes: 'Auto-suggested: ${suggestion.reason}',
        relatedControls: [suggestion.controlSource],
        lastUpdated: DateTime.now(),
      ),
    );
    applied++;
  }

  if (applied > 0) {
    // Refresh all coverage-dependent providers
    ref.invalidate(allCoverageStatusesProvider);
    ref.invalidate(coveragePercentageProvider);
    ref.invalidate(coverageBreakdownProvider);
  }

  return applied;
}

CoverageLevel _levelFromString(String s) {
  switch (s) {
    case 'covered':
      return CoverageLevel.covered;
    case 'partiallyCovered':
      return CoverageLevel.partiallyCovered;
    case 'unknown':
      return CoverageLevel.unknown;
    default:
      return CoverageLevel.notCovered;
  }
}
