// lib/shared/providers/plain_language_providers.dart

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:attackshield/shared/models/plain_language_model.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

// ════════════════════════════════════════════════════════════════════════════════
// APP MODE STATE
// ════════════════════════════════════════════════════════════════════════════════

enum AppMode { expertMode, plainLanguageMode }

/// Current app mode (Expert vs Plain Language)
final appModeProvider = StateProvider<AppMode>((ref) {
  final orgProfile = ref.watch(organizationProfileV2Provider);
  return orgProfile.maybeWhen(
    data: (profile) => profile != null && profile.appMode == 'PlainLanguageMode'
        ? AppMode.plainLanguageMode
        : AppMode.expertMode,
    orElse: () => AppMode.expertMode,
  );
});

// ════════════════════════════════════════════════════════════════════════════════
// PLAIN LANGUAGE MAPPINGS
// ════════════════════════════════════════════════════════════════════════════════

/// Load all plain language mappings from JSON asset
final plainLanguageMappingsProvider =
    FutureProvider<Map<String, PlainLanguageMapping>>((ref) async {
      try {
        final jsonString = await rootBundle.loadString(
          'assets/data/plain_language_mappings.json',
        );
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final mappings = <String, PlainLanguageMapping>{};

        for (final item in jsonList) {
          final mapping = PlainLanguageMapping.fromJson(
            item as Map<String, dynamic>,
          );
          mappings[mapping.techniqueId] = mapping;
        }

        return mappings;
      } catch (e) {
        // Silent fail - return empty map
        return {};
      }
    });

/// Get plain language mapping for a specific technique
final plainLanguageTechniqueProvider =
    FutureProvider.family<PlainLanguageMapping, String>((
      ref,
      techniqueId,
    ) async {
      final mappings = await ref.watch(plainLanguageMappingsProvider.future);
      return mappings[techniqueId] ??
          PlainLanguageMapping(
            techniqueId: techniqueId,
            plainName: 'Unknown Technique',
            realWorldScenario:
                'This is a security technique we do not have information for.',
            dangerLevel: 'Unknown',
            targetedTypes: 'Various organizations',
            howYouWouldKnow: 'Contact your security team for information',
            singleActionToTake:
                'Ask your IT team about this security technique',
            icon: '🔒',
            color: '#808080',
          );
    });

// ════════════════════════════════════════════════════════════════════════════════
// COVERAGE STATUS TRANSLATION
// ════════════════════════════════════════════════════════════════════════════════

/// Convert technical coverage level to plain language
final plainCoverageStatusProvider = FutureProvider.family<PlainCoverageStatus, String>((
  ref,
  techLevel,
) async {
  switch (techLevel) {
    case 'NotCovered':
      return const PlainCoverageStatus(
        technicalStatus: 'NotCovered',
        plainStatus: '❌ Not Protected',
        statusEmoji: '❌',
        plainMeaning:
            'You have no defense against this attack type. Attackers can attempt this without being blocked.',
        suggestion:
            '1. Add security tools to defend against this\n2. Train employees about this threat\n3. Review and update your security policies',
        urgencyScore: 90,
      );

    case 'PartiallyCovered':
      return const PlainCoverageStatus(
        technicalStatus: 'PartiallyCovered',
        plainStatus: '⚠️ Some Protection',
        statusEmoji: '⚠️',
        plainMeaning:
            'You have some defense against this attack, but it is not complete. Skilled attackers might still get through.',
        suggestion:
            '1. Improve your existing defenses\n2. Add additional security layers\n3. Test your current protections',
        urgencyScore: 60,
      );

    case 'Covered':
      return const PlainCoverageStatus(
        technicalStatus: 'Covered',
        plainStatus: '✅ Well Protected',
        statusEmoji: '✅',
        plainMeaning:
            'You have good defense against this attack type. You should be protected against most standard attacks.',
        suggestion:
            '1. Keep this defense updated\n2. Monitor that it is working correctly\n3. Test it regularly',
        urgencyScore: 20,
      );

    default:
      return const PlainCoverageStatus(
        technicalStatus: 'Unknown',
        plainStatus: '❓ Unknown',
        statusEmoji: '❓',
        plainMeaning:
            'Status unknown. Please update your coverage information.',
        suggestion: 'Review your coverage settings',
        urgencyScore: 50,
      );
  }
});

// ════════════════════════════════════════════════════════════════════════════════
// ORGANIZATION PROFILE V2
// ════════════════════════════════════════════════════════════════════════════════

/// Manage organization profile (with persistence)
final organizationProfileV2Provider =
    StateNotifierProvider<
      OrganizationProfileNotifier,
      AsyncValue<OrganizationProfileV2?>
    >((ref) {
      return OrganizationProfileNotifier(ref);
    });

class OrganizationProfileNotifier
    extends StateNotifier<AsyncValue<OrganizationProfileV2?>> {
  final Ref ref;

  OrganizationProfileNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      // Load from GetStorage
      final box = GetStorage();
      final profileJson = box.read<Map<String, dynamic>>('org_profile_v2');

      if (profileJson != null) {
        final profile = OrganizationProfileV2.fromJson(profileJson);
        state = AsyncValue.data(profile);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createOrUpdateProfile(OrganizationProfileV2 profile) async {
    try {
      state = const AsyncValue.loading();
      // Save to GetStorage
      final box = GetStorage();
      await box.write('org_profile_v2', profile.toJson());
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProfile() async {
    try {
      final box = GetStorage();
      await box.remove('org_profile_v2');
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleAppMode() async {
    final current = state.maybeWhen(
      data: (profile) => profile,
      orElse: () => null,
    );

    if (current == null) return;

    final newMode = current.appMode == 'PlainLanguageMode'
        ? 'ExpertMode'
        : 'PlainLanguageMode';

    final updated = current.copyWith(
      appMode: newMode,
      updatedAt: DateTime.now(),
    );

    await createOrUpdateProfile(updated);
  }
}

// ════════════════════════════════════════════════════════════════════════════════
// THREAT PROFILE GENERATION
// ════════════════════════════════════════════════════════════════════════════════

/// Generate threat profile based on organization profile
final generatedThreatProfileProvider =
    FutureProvider.family<GeneratedThreatProfile, OrganizationProfileV2>((
      ref,
      orgProfile,
    ) async {
      final generator = ThreatProfileGenerator();
      return generator.generateProfile(orgProfile);
    });

/// Business logic for generating threat profiles
class ThreatProfileGenerator {
  /// Sector-specific risk multipliers
  static const Map<String, Map<String, double>> sectorRiskMultipliers = {
    'healthcare': {
      'T1486': 1.5, // Ransomware
      'T1566': 1.4, // Phishing
      'T1530': 1.3, // Data from cloud
      'T1078': 1.3, // Valid accounts
      'T1005': 1.2, // Data collection
    },
    'finance': {
      'T1110': 1.5, // Brute force
      'T1098': 1.4, // Account manipulation
      'T1005': 1.3, // Data collection
      'T1040': 1.3, // Network sniffing
      'T1021': 1.2, // Lateral movement
    },
    'education': {
      'T1566': 1.4, // Phishing
      'T1195': 1.3, // Supply chain
      'T1078': 1.2, // Account compromise
      'T1486': 1.2, // Ransomware
      'T1005': 1.1, // Data collection
    },
    'retail': {
      'T1486': 1.4, // Ransomware
      'T1110': 1.3, // Brute force
      'T1040': 1.2, // Network sniffing
      'T1566': 1.2, // Phishing
      'T1005': 1.2, // Data collection
    },
    'manufacturing': {
      'T1570': 1.3, // Lateral movement
      'T1005': 1.3, // Data collection
      'T1518': 1.2, // Software discovery
      'T1083': 1.2, // File/folder enumeration
      'T1486': 1.1, // Ransomware
    },
    'government': {
      'T1555': 1.4, // Credential dumping
      'T1187': 1.3, // Man-in-the-browser
      'T1134': 1.2, // Token manipulation
      'T1098': 1.2, // Account manipulation
      'T1005': 1.2, // Data collection
    },
  };

  /// Size-based risk multipliers
  static const Map<String, double> sizeMultipliers = {
    'solo': 0.8,
    'small': 1.0,
    'medium': 1.1,
    'largesmall': 1.2,
    'large': 1.3,
  };

  /// Technology risk adjustments
  static const Map<String, Map<String, double>> technologyAdjustments = {
    'windows_only': {'T1566': 0.10, 'T1059': 0.15},
    'mac_only': {'T1566': 0.05, 'T1036': 0.10},
    'cloud_primary': {'T1550': 0.20, 'T1537': 0.15},
    'hybrid': {'T1570': 0.10, 'T1021': 0.10},
  };

  /// Defense reduction multipliers
  static const Map<String, Map<String, double>> defenseReductions = {
    'basic_av': {'T1566': 0.20, 'T1486': 0.20},
    'av_firewall': {'T1566': 0.30, 'T1040': 0.40},
    'mfa': {'T1110': 0.60, 'T1078': 0.40},
    'edr': {'T1059': 0.50, 'T1105': 0.45},
    'siem': {'T1482': 0.30, 'T1083': 0.30},
  };

  Future<GeneratedThreatProfile> generateProfile(
    OrganizationProfileV2 profile,
  ) async {
    // 1. Generate threat summary
    final threatSummary = _generateThreatSummary(profile);
    final sectorDesc = _generateSectorDescription(profile);

    // 2. Prioritize techniques based on sector, size, technology
    final allTechniques = _getAllTechniqueIds();
    final prioritized = _prioritizeTechniques(
      allTechniques,
      profile.sector.name,
      profile.size.name,
      profile.technology.name,
      profile.currentDefenses.map((d) => d.name).toList(),
    );

    // 3. Get top threats
    final topThreats = prioritized.take(15).toList();

    // 4. Get typical threat actors for sector
    final threatActors = _getThreatActorsForSector(profile.sector.name);

    // 5. Get common attack chains
    final chains = _getAttackChainsForSector(profile.sector.name);

    // 6. Generate initial recommendations
    final recommendations = _generateRecommendations(
      profile.sector.name,
      profile.size.name,
      profile.currentDefenses.map((d) => d.name).toList(),
    );

    return GeneratedThreatProfile(
      threatSummary: threatSummary,
      sectorDescription: sectorDesc,
      topThreats: topThreats,
      typicalThreatActors: threatActors,
      commonAttackChains: chains,
      initialRecommendations: recommendations,
      generatedAt: DateTime.now(),
    );
  }

  String _generateThreatSummary(OrganizationProfileV2 profile) {
    final sectorName = profile.sector.name;
    final sectorLabel = _getSectorLabel(sectorName);

    final topTech = sectorRiskMultipliers[sectorName]?.entries
        .toList()
        .asMap()
        .entries
        .take(3)
        .map((e) => e.value.key)
        .join(', ');

    return '$sectorLabel organizations are most commonly targeted by attackers using: $topTech. '
        'Based on your organization size and technology, you face elevated risk from these techniques. '
        'Regular security awareness training and proper defenses can significantly reduce your risk.';
  }

  String _generateSectorDescription(OrganizationProfileV2 profile) {
    final sectorLabels = {
      'healthcare': 'Healthcare - a high-value target for ransomware attacks',
      'finance': 'Finance - frequently targeted for credential theft',
      'education': 'Education - common target for phishing attacks',
      'retail': 'Retail - vulnerable to ransomware and payment fraud',
      'manufacturing': 'Manufacturing - target for espionage and disruption',
      'government':
          'Government - high-priority target for sophisticated attacks',
      'nonprofit': 'Nonprofit - often has limited security resources',
      'technology': 'Technology - target for supply chain attacks',
      'hospitality': 'Hospitality - vulnerable to data theft',
      'other': 'Your organization - needs customized security approach',
    };

    return sectorLabels[profile.sector.name] ?? 'Your organization type';
  }

  String _getSectorLabel(String sector) {
    return {
          'healthcare': 'Healthcare',
          'finance': 'Financial',
          'education': 'Educational',
          'retail': 'Retail',
          'manufacturing': 'Manufacturing',
          'government': 'Government',
          'nonprofit': 'Nonprofit',
          'technology': 'Technology',
          'hospitality': 'Hospitality',
          'other': 'Organizations in your sector',
        }[sector] ??
        'Organizations';
  }

  List<String> _getAllTechniqueIds() {
    // In production, get from your technique database
    return [
      'T1110',
      'T1566',
      'T1486',
      'T1078',
      'T1005',
      'T1040',
      'T1098',
      'T1087',
      'T1136',
      'T1543',
      'T1059',
      'T1574',
      'T1074',
      'T1003',
      'T1482',
      'T1007',
      'T1083',
    ];
  }

  List<PrioritizedTechnique> _prioritizeTechniques(
    List<String> techniques,
    String sector,
    String size,
    String technology,
    List<String> defenses,
  ) {
    final baseMultiplier = sizeMultipliers[size] ?? 1.0;
    final sectorMultipliers = sectorRiskMultipliers[sector] ?? {};

    final prioritized = techniques.map((techId) {
      var score = 50.0; // Base score

      // Apply sector multiplier
      if (sectorMultipliers.containsKey(techId)) {
        score *= sectorMultipliers[techId]!;
      }

      // Apply size multiplier
      score *= baseMultiplier;

      // Apply technology adjustments
      technologyAdjustments.forEach((tech, adjustments) {
        if (technology.contains(tech) && adjustments.containsKey(techId)) {
          score += adjustments[techId]! * 10;
        }
      });

      // Apply defense reductions
      for (final defense in defenses) {
        if (defenseReductions.containsKey(defense) &&
            defenseReductions[defense]!.containsKey(techId)) {
          score *= (1 - defenseReductions[defense]![techId]!);
        }
      }

      final suggestedCoverage = score > 70
          ? 'Covered'
          : score > 40
          ? 'PartiallyCovered'
          : 'NotCovered';

      return PrioritizedTechnique(
        techniqueId: techId,
        techniqueName: _getTechniqueName(techId),
        plainLanguageName: _getPlainLanguageName(techId),
        priorityScore: score.clamp(0, 100),
        whyMatters: _getWhyMatters(techId, sector),
        suggestedCoverage: suggestedCoverage,
      );
    }).toList();

    // Sort by priority score descending
    prioritized.sort((a, b) => b.priorityScore.compareTo(a.priorityScore));
    return prioritized;
  }

  String _getTechniqueName(String techId) {
    const names = {
      'T1110': 'Brute Force',
      'T1566': 'Phishing',
      'T1486': 'Ransomware',
      'T1078': 'Valid Accounts',
      'T1005': 'Data Collection',
      'T1040': 'Network Sniffing',
      'T1098': 'Account Manipulation',
      'T1087': 'Account Discovery',
      'T1136': 'Create Account',
      'T1543': 'Create or Modify Boot Process',
      'T1059': 'Command and Scripting Interpreter',
      'T1574': 'Hijack Execution Flow',
      'T1074': 'Data Staged',
      'T1003': 'Credential Dumping',
      'T1482': 'Domain Trust Discovery',
      'T1007': 'System Information Discovery',
      'T1083': 'File and Directory Discovery',
    };
    return names[techId] ?? 'Unknown Technique';
  }

  String _getPlainLanguageName(String techId) {
    const names = {
      'T1110': 'Someone Tries Many Passwords',
      'T1566': 'Fake Emails That Trick You',
      'T1486': 'Malware That Locks Files',
      'T1078': 'Stolen or Default Passwords',
      'T1005': 'Data Gets Stolen',
      'T1040': 'Someone Listens to Network',
      'T1098': 'Attacker Adds Account Access',
      'T1087': 'Attacker Searches For Your Info',
      'T1136': 'Fake User Accounts Created',
      'T1543': 'Malware Starts Automatically',
      'T1059': 'Attacker Runs Commands',
      'T1574': 'Software Libraries Hijacked',
      'T1074': 'Files Gathered For Stealing',
      'T1003': 'Passwords Stolen From Memory',
      'T1482': 'Network Structure Discovered',
      'T1007': 'System Info Gathered',
      'T1083': 'Files And Folders Explored',
    };
    return names[techId] ?? 'Unknown Threat';
  }

  String _getWhyMatters(String techId, String sector) {
    // Return why this technique matters for this sector
    if (sector == 'healthcare' && techId == 'T1486') {
      return 'Ransomware is the #1 threat to healthcare organizations, costing average \$500K+ per attack';
    }
    if (sector == 'finance' && techId == 'T1110') {
      return 'Credential theft is critical in finance - attackers want access to money';
    }
    return 'This technique is a significant threat to your organization type';
  }

  List<String> _getThreatActorsForSector(String sector) {
    const actors = {
      'healthcare': [
        'Alphv/BlackCat',
        'PLAY (previously Alphv)',
        'Change Titan',
      ],
      'finance': ['FIN7', 'APT28', 'Carbanak'],
      'education': ['LockBit', 'Black Basta', 'Royal'],
      'retail': ['Scattered Spider', 'Alphv', 'LockBit'],
      'manufacturing': ['APT41', 'Wizard Spider', 'Conti'],
      'government': ['APT29', 'APT28', 'Wizard Spider'],
      'nonprofit': ['LockBit', 'PLAY', 'Black Basta'],
      'technology': ['APT41', 'ALPHV', 'Carbanak'],
      'hospitality': ['LockBit', 'Black Basta', 'PLAY'],
      'other': ['Various criminal groups'],
    };

    return actors[sector] ?? ['Various threat actors'];
  }

  List<AttackChain> _getAttackChainsForSector(String sector) {
    // Return typical attack chains for sector
    if (sector == 'healthcare') {
      return [
        const AttackChain(
          name: 'Ransomware Attack Chain',
          techniques: ['T1566', 'T1204', 'T1059', 'T1486'],
          description:
              'Attacker sends phishing email → User clicks link → Malware downloads → Files encrypted',
          realWorldExample:
              'This is how the Change Titan healthcare ransomware attack works',
          typicalTimeline: '24-48 hours to encryption',
          typicalCost: '\$250,000+',
        ),
      ];
    }

    return [
      const AttackChain(
        name: 'Typical Attack Progression',
        techniques: ['T1566', 'T1110', 'T1005', 'T1486'],
        description:
            'Attacker gains initial access → Steals credentials → Moves laterally → Deploys malware',
        realWorldExample:
            'Common attack pattern seen across multiple organizations',
        typicalTimeline: '1-7 days',
        typicalCost: '\$200,000+',
      ),
    ];
  }

  List<String> _generateRecommendations(
    String sector,
    String size,
    List<String> currentDefenses,
  ) {
    final recommendations = <String>[];

    // Universal recommendations
    if (!currentDefenses.contains('mfa')) {
      recommendations.add(
        'Enable Multi-Factor Authentication (MFA) on all accounts immediately',
      );
    }
    if (!currentDefenses.contains('edr')) {
      recommendations.add(
        'Deploy Endpoint Detection & Response (EDR) software',
      );
    }

    // Sector-specific
    if (sector == 'healthcare') {
      recommendations.add(
        'Implement healthcare-specific security controls per HIPAA',
      );
      recommendations.add('Regular backups for patient data (offline backups)');
    }
    if (sector == 'finance') {
      recommendations.add('Implement PCI DSS compliance for payment data');
      recommendations.add(
        'Restrict financial system access to administrative tiers',
      );
    }

    // Size-based
    if (size == 'solo' || size == 'small') {
      recommendations.add(
        'Use managed security services (MSS) for 24/7 monitoring',
      );
      recommendations.add(
        'Implement cloud-based backup solutions - you may not have IT staff',
      );
    }

    recommendations.add(
      'Conduct security awareness training for all employees monthly',
    );
    recommendations.add('Review and test incident response plan quarterly');

    return recommendations.take(5).toList();
  }
}
