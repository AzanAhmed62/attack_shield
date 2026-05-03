// lib/shared/models/plain_language_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'plain_language_model.freezed.dart';
part 'plain_language_model.g.dart';

/// ════════════════════════════════════════════════════════════════════════════════
/// PLAIN LANGUAGE MAPPINGS
/// Maps professional security terms to real-world, non-technical language
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class PlainLanguageMapping with _$PlainLanguageMapping {
  const factory PlainLanguageMapping({
    /// Professional ATT&CK technique ID (e.g., "T1110", "T1566.001")
    required String techniqueId,

    /// Simple, non-technical name for the attack
    /// Examples:
    /// - "Someone Tries Many Passwords to Get In" (T1110)
    /// - "Fake Emails That Trick You Into Clicking" (T1566)
    /// - "Malware That Locks Your Files For Ransom" (T1486)
    required String plainName,

    /// Real-world scenario non-technical user can relate to
    /// Should be 1-2 sentences describing how this attack happens to regular people
    /// Example for T1110:
    /// "An attacker uses a list of stolen passwords or automatically tries millions
    /// of password combinations until they guess yours."
    required String realWorldScenario,

    /// How easy is this for attackers to do?
    /// Values: "Easy to Do", "Moderate", "Difficult", "Highly Difficult"
    required String dangerLevel,

    /// Who is typically targeted by this attack?
    /// Example: "All businesses, but especially banks and email users"
    required String targetedTypes,

    /// What signs would you notice if this happened to you?
    /// Should be 2-3 observable signs, in plain language
    /// Example for T1110: "Strange logins from new devices, account locked, emails sent from your account"
    required String howYouWouldKnow,

    /// The single most important action to take RIGHT NOW
    /// Should be actionable and understandable by non-technical person
    /// Example: "Turn on two-factor authentication (2FA) for your important accounts"
    required String singleActionToTake,

    /// Icon/emoji for visual recognition in plain language mode
    /// Examples: 🔒, 🔑, ⚠️, 🚨, 💻, 📧, 🔓, 🛡️
    required String icon,

    /// Hex color for this technique in plain language mode
    /// Examples: "#FF6B6B" (red/danger), "#FFA500" (orange/warning), "#4CAF50" (green/safe)
    required String color,

    /// Industry-specific notes (if this threat is particularly relevant to certain sectors)
    /// Example for T1486 in Healthcare: "Ransomware is the #1 threat to hospitals"
    @Default('') String industryNotes,
  }) = _PlainLanguageMapping;

  factory PlainLanguageMapping.fromJson(Map<String, dynamic> json) =>
      _$PlainLanguageMappingFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// PLAIN COVERAGE STATUS
/// Translates technical CoverageLevel to plain language
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class PlainCoverageStatus with _$PlainCoverageStatus {
  const factory PlainCoverageStatus({
    /// Original technical coverage level
    /// Values: "NotCovered", "PartiallyCovered", "Covered"
    required String technicalStatus,

    /// Plain English translation
    /// Examples: "Not Protected", "Some Protection", "Well Protected"
    required String plainStatus,

    /// Status emoji for quick visual understanding
    /// ❌ = Not Protected, ⚠️ = Some Protection, ✅ = Well Protected
    required String statusEmoji,

    /// What this coverage status means in plain English (1-2 sentences)
    /// Example for NotCovered: "You have no defense against this attack type. Attackers can attempt this without being stopped."
    required String plainMeaning,

    /// What to do about it (2-3 actionable steps)
    /// Example: "1. Install antivirus software 2. Enable firewall 3. Update your systems"
    required String suggestion,

    /// Severity if NOT protected (0-100)
    /// Used to highlight which gaps matter most
    required int urgencyScore,
  }) = _PlainCoverageStatus;

  factory PlainCoverageStatus.fromJson(Map<String, dynamic> json) =>
      _$PlainCoverageStatusFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// ORGANIZATION PROFILE V2 (Enhanced)
/// Complete picture of organization for threat profiling
/// ════════════════════════════════════════════════════════════════════════════════

enum OrganizationSize {
  @JsonValue('solo')
  solo, // 1 person (home, freelancer)
  @JsonValue('small')
  small, // 2-10 (small office, startup)
  @JsonValue('medium')
  medium, // 11-50 (growing business)
  @JsonValue('largesmall')
  largeSmall, // 51-200 (established company)
  @JsonValue('large')
  large, // 200+ (enterprise)
}

enum BusinessSector {
  @JsonValue('healthcare')
  healthcare,
  @JsonValue('finance')
  finance,
  @JsonValue('education')
  education,
  @JsonValue('retail')
  retail,
  @JsonValue('manufacturing')
  manufacturing,
  @JsonValue('government')
  government,
  @JsonValue('nonprofit')
  nonprofit,
  @JsonValue('technology')
  technology,
  @JsonValue('hospitality')
  hospitality,
  @JsonValue('other')
  other,
}

enum PrimaryTechnology {
  @JsonValue('windows_only')
  windowsOnly,
  @JsonValue('mac_only')
  macOnly,
  @JsonValue('linux_only')
  linuxOnly,
  @JsonValue('mixed_onprem')
  mixedOnPrem,
  @JsonValue('cloud_primary')
  cloudPrimary,
  @JsonValue('hybrid')
  hybrid,
}

enum ExistingDefenses {
  @JsonValue('nothing')
  nothing,
  @JsonValue('basic_av')
  basicAv,
  @JsonValue('av_firewall')
  avAndFirewall,
  @JsonValue('mfa')
  mfa,
  @JsonValue('edr')
  edr,
  @JsonValue('siem')
  siem,
  @JsonValue('comprehensive')
  comprehensive,
}

enum UserTechLevel {
  @JsonValue('not_technical')
  notTechnical,
  @JsonValue('some_technical')
  someTechnical,
  @JsonValue('very_technical')
  veryTechnical,
}

@freezed
class OrganizationProfileV2 with _$OrganizationProfileV2 {
  const factory OrganizationProfileV2({
    /// Unique identifier for organization
    required String id,

    /// Organization name (e.g., "Acme Healthcare Corp")
    required String name,

    /// What type of business/organization
    required BusinessSector sector,

    /// How many people in organization
    required OrganizationSize size,

    /// Primary technology stack
    required PrimaryTechnology technology,

    /// What security controls already exist
    required List<ExistingDefenses> currentDefenses,

    /// User's technical knowledge level
    /// Used to determine when to show advanced explanations
    required UserTechLevel userTechLevel,

    /// Which UI mode: 'ExpertMode' or 'PlainLanguageMode'
    required String appMode,

    /// Calculated baseline risk (0-100) BEFORE considering coverage
    /// Based on sector, size, and technology stack
    /// Higher = more attacked by default
    required double baselineRiskScore,

    /// List of top 15 technique IDs most relevant to this organization
    /// Ranked by priority (relevance to this org type)
    /// Used for "My Threats" view and prioritization
    required List<String> prioritizedTechniqueIds,

    /// Pre-calculated coverage suggestions
    /// Map of techniqueId → suggested coverage level
    /// Used to populate pre-filled checkboxes in setup
    /// Example: {'T1110': 'PartiallyCovered', 'T1566': 'Covered'}
    required Map<String, String> suggestedCoverageLevels,

    /// Short description of this organization (user's own notes)
    /// Example: "Small family-owned dental clinic in California"
    @Default('') String description,

    /// When profile was created
    required DateTime createdAt,

    /// When last updated
    required DateTime updatedAt,
  }) = _OrganizationProfileV2;

  factory OrganizationProfileV2.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProfileV2FromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// GENERATED THREAT PROFILE
/// Result of analyzing organization profile to generate threat prioritization
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class GeneratedThreatProfile with _$GeneratedThreatProfile {
  const factory GeneratedThreatProfile({
    /// Plain-English summary of threats specific to this organization
    /// Example: "Healthcare organizations like yours are most targeted by phishing (fake emails)
    /// and ransomware (malware that locks your files). In the last year, 2 out of 3 healthcare
    /// organizations were hit by ransomware."
    required String threatSummary,

    /// Sector description (for context)
    /// Example: "You work in Healthcare - a high-value target for cybercriminals"
    required String sectorDescription,

    /// List of top threats prioritized for this org
    /// Ranked by: (a) how common in sector, (b) how damaging, (c) current coverage
    required List<PrioritizedTechnique> topThreats,

    /// Common threat actors/groups that target this sector
    /// Example: ["Alphv Blackcat", "Change Titan", "Scattered Spider"]
    required List<String> typicalThreatActors,

    /// Common attack patterns in this industry (attack chains)
    /// Example: "Phishing → Credential theft → Malware installation → Ransomware"
    required List<AttackChain> commonAttackChains,

    /// Recommended initial actions (top 5)
    /// Example: ["Enable MFA on all accounts", "Deploy antivirus", "Backup critical data daily"]
    required List<String> initialRecommendations,

    /// Industry-specific compliance notes
    /// Example for Healthcare: "HIPAA requires you to protect patient data"
    @Default('') String complianceNotes,

    /// When profile was generated
    required DateTime generatedAt,
  }) = _GeneratedThreatProfile;

  factory GeneratedThreatProfile.fromJson(Map<String, dynamic> json) =>
      _$GeneratedThreatProfileFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// PRIORITIZED TECHNIQUE
/// Single technique with priority context for this organization
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class PrioritizedTechnique with _$PrioritizedTechnique {
  const factory PrioritizedTechnique({
    /// Technique ID (e.g., "T1110")
    required String techniqueId,

    /// Professional technique name (e.g., "Brute Force")
    required String techniqueName,

    /// Plain language name (e.g., "Someone Tries Many Passwords to Get In")
    required String plainLanguageName,

    /// Priority score for this organization (0-100)
    /// Higher = more relevant to this organization type
    /// Calculated based on: sector frequency + severity + current coverage gap
    required double priorityScore,

    /// Why this technique is high priority for this org
    /// Example: "Ransomware is the #1 attack against healthcare organizations"
    required String whyMatters,

    /// Suggested coverage level for this organization
    /// Values: "NotCovered", "PartiallyCovered", "Covered"
    required String suggestedCoverage,

    /// How many organizations in this sector have been hit by this
    /// Example: "2 out of 3 healthcare organizations"
    @Default('') String prevalenceInSector,

    /// Average financial impact if compromised
    /// Example: "$200,000+ average cost"
    @Default('') String averageImpact,
  }) = _PrioritizedTechnique;

  factory PrioritizedTechnique.fromJson(Map<String, dynamic> json) =>
      _$PrioritizedTechniqueFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// ATTACK CHAIN
/// Sequence of techniques showing how real attacks typically progress
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class AttackChain with _$AttackChain {
  const factory AttackChain({
    /// Human-readable name (e.g., "Typical Ransomware Attack")
    required String name,

    /// Sequence of technique IDs in order (e.g., ['T1566', 'T1204', '1059', 'T1486'])
    required List<String> techniques,

    /// Plain-English description of the flow
    /// Example: "Attacker sends phishing email → User clicks link → Malware downloads
    /// → Attacker runs commands → Files encrypted and locked"
    required String description,

    /// Real-world example of this attack chain
    /// Example: "This is how the JBS ransomware attack happened in 2021"
    required String realWorldExample,

    /// Time it typically takes from first access to impact
    /// Example: "24 hours to encryption"
    @Default('') String typicalTimeline,

    /// Average damage/cost from this chain
    /// Example: "$250,000"
    @Default('') String typicalCost,
  }) = _AttackChain;

  factory AttackChain.fromJson(Map<String, dynamic> json) =>
      _$AttackChainFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SECTOR PROFILE (Internal reference data)
/// Static data about threat landscape per sector
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class SectorProfile with _$SectorProfile {
  const factory SectorProfile({
    /// Business sector
    required BusinessSector sector,

    /// Human-readable description
    /// Example: "Healthcare organizations including hospitals, clinics, and practices"
    required String description,

    /// Icon/emoji representing sector
    required String icon,

    /// Top 5 threats in this sector (technique IDs)
    /// Ranked by frequency
    required List<String> topThreats,

    /// Common threat actors targeting this sector
    required List<String> commonThreatActors,

    /// Risk multipliers for techniques (applied during prioritization)
    /// Map of techniqueId → multiplier (e.g., {"T1486": 1.5, "T1566": 1.4})
    required Map<String, double> techniqueRiskMultipliers,

    /// Typical compliance requirements
    /// Example for Healthcare: ["HIPAA", "HITECH"]
    required List<String> complianceRequirements,

    /// Average estimated annual cost of breach
    /// Example: "$500,000"
    required String averageBreachCost,
  }) = _SectorProfile;

  factory SectorProfile.fromJson(Map<String, dynamic> json) =>
      _$SectorProfileFromJson(json);
}
