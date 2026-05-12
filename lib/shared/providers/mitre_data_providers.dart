// lib/shared/providers/mitre_data_providers.dart
//
// USAGE:
//   Copy to lib/shared/providers/mitre_data_providers.dart
//   Providers lazy-initialize the MITRE service on first use.
//   Then watch any provider below from any widget.

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/services/mitre_stix_data_service.dart';
import 'package:attackshield/shared/models/plain_language_model.dart';

// ═══════════════════════════════════════════════════════════════
// SERVICE SINGLETON
// ═══════════════════════════════════════════════════════════════

/// Single shared instance of the MITRE service.
/// Initialized once in main(), reused everywhere.
final mitreServiceProvider = Provider<MitreStixDataService>(
  (ref) => MitreStixDataService(),
);

final mitreInitializationProvider = FutureProvider<void>((ref) async {
  await ref.watch(mitreServiceProvider).initialize();
});

Future<MitreStixDataService> _readyMitreService(Ref ref) async {
  final service = ref.watch(mitreServiceProvider);
  await ref.watch(mitreInitializationProvider.future);
  return service;
}

// ═══════════════════════════════════════════════════════════════
// TECHNIQUES
// ═══════════════════════════════════════════════════════════════

/// All main techniques (excludes sub-techniques).
/// Result: ~600 objects, cached after first load.
final allTechniquesProvider = FutureProvider<List<StixTechnique>>((ref) async {
  final svc = await _readyMitreService(ref);
  final all = svc.getAllTechniques();
  return all.where((t) => !t.isSubTechnique).toList();
});

/// All sub-techniques (T1xxx.00x).
final allSubTechniquesProvider = FutureProvider<List<StixTechnique>>((
  ref,
) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllTechniques().where((t) => t.isSubTechnique).toList();
});

/// Every technique + sub-technique combined.
final allTechniquesAndSubsProvider = FutureProvider<List<StixTechnique>>((
  ref,
) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllTechniques();
});

/// Single technique by ATT&CK external ID (e.g. "T1566").
final techniqueByAttackIdProvider =
    FutureProvider.family<StixTechnique?, String>((ref, attackId) async {
      final svc = await _readyMitreService(ref);
      return svc.getTechniqueByAttackId(attackId);
    });

/// All techniques belonging to a tactic (by tactic shortname).
/// e.g. 'initial-access', 'execution', 'persistence' …
final techniquesByTacticProvider =
    FutureProvider.family<List<StixTechnique>, String>((
      ref,
      tacticShortname,
    ) async {
      final svc = await _readyMitreService(ref);
      return svc.getTechniquesByTactic(tacticShortname);
    });

/// Sub-techniques for a parent (by parent ATT&CK ID, e.g. "T1566").
final subTechniquesForParentProvider =
    FutureProvider.family<List<StixTechnique>, String>((
      ref,
      parentAttackId,
    ) async {
      final svc = await _readyMitreService(ref);
      return svc.getSubTechniquesForParent(parentAttackId);
    });

// ═══════════════════════════════════════════════════════════════
// TACTICS
// ═══════════════════════════════════════════════════════════════

/// All 14 ATT&CK tactics, sorted by ATT&CK order.
final allTacticsProvider = FutureProvider<List<StixTactic>>((ref) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllTactics();
});

// ═══════════════════════════════════════════════════════════════
// THREAT GROUPS (APTs / Campaigns)
// ═══════════════════════════════════════════════════════════════

/// All threat groups (700+).
final allThreatGroupsProvider = FutureProvider<List<StixThreatGroup>>((
  ref,
) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllThreatGroups();
});

/// Threat groups that use a given technique (by ATT&CK ID).
final threatGroupsForTechniqueProvider =
    FutureProvider.family<List<StixThreatGroup>, String>((ref, attackId) async {
      final svc = await _readyMitreService(ref);
      return svc.getThreatGroupsForTechnique(attackId);
    });

/// Techniques used by a specific threat group (by group name or ID).
final techniquesForThreatGroupProvider =
    FutureProvider.family<List<StixTechnique>, String>((ref, groupId) async {
      final svc = await _readyMitreService(ref);
      return svc.getTechniquesForThreatGroup(groupId);
    });

// ═══════════════════════════════════════════════════════════════
// MITIGATIONS
// ═══════════════════════════════════════════════════════════════

/// All mitigations (150+).
final allMitigationsProvider = FutureProvider<List<StixMitigation>>((
  ref,
) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllMitigations();
});

/// Mitigations for a technique (by ATT&CK ID).
final mitigationsForTechniqueProvider =
    FutureProvider.family<List<StixMitigation>, String>((ref, attackId) async {
      final svc = await _readyMitreService(ref);
      return svc.getMitigationsForTechnique(attackId);
    });

// ═══════════════════════════════════════════════════════════════
// MALWARE & TOOLS
// ═══════════════════════════════════════════════════════════════

/// All malware families (500+).
final allMalwareProvider = FutureProvider<List<StixMalware>>((ref) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllMalware();
});

/// All tools (400+).
final allToolsProvider = FutureProvider<List<StixTool>>((ref) async {
  final svc = await _readyMitreService(ref);
  return svc.getAllTools();
});

/// Malware that uses a given technique.
final malwareForTechniqueProvider =
    FutureProvider.family<List<StixMalware>, String>((ref, attackId) async {
      final svc = await _readyMitreService(ref);
      return svc.getMalwareForTechnique(attackId);
    });

// ═══════════════════════════════════════════════════════════════
// RELATIONSHIPS / ATTACK CHAINS
// ═══════════════════════════════════════════════════════════════

/// Technique IDs that are related to the given technique.
final relatedTechniquesProvider = FutureProvider.family<List<String>, String>((
  ref,
  attackId,
) async {
  final svc = await _readyMitreService(ref);
  return svc.getRelatedTechniques(attackId);
});

// ═══════════════════════════════════════════════════════════════
// SEARCH
// ═══════════════════════════════════════════════════════════════

/// Live search across all techniques by name/description.
/// Debounce in the widget layer before watching this.
final searchTechniquesProvider =
    FutureProvider.family<List<StixTechnique>, String>((ref, query) async {
      if (query.trim().isEmpty) return [];
      final svc = await _readyMitreService(ref);
      return svc.searchTechniques(query.trim());
    });

// ═══════════════════════════════════════════════════════════════
// STATISTICS
// ═══════════════════════════════════════════════════════════════

/// High-level stats (counts only, no heavy data loaded).
final mitreStatisticsProvider = Provider<MitreStatistics?>((ref) {
  final svc = ref.watch(mitreServiceProvider);
  try {
    return svc.getStatistics();
  } catch (_) {
    return null;
  }
});

// ═══════════════════════════════════════════════════════════════
// ORG-AWARE THREAT PRIORITISATION
// Combines org profile + MITRE data → ranked threat list
// ═══════════════════════════════════════════════════════════════

/// Returns top-N techniques for the current org profile.
final prioritisedTechniquesProvider =
    FutureProvider.family<List<RankedTechnique>, OrganizationProfileV2>((
      ref,
      profile,
    ) async {
      final svc = await _readyMitreService(ref);
      return _rankTechniquesForOrg(svc, profile);
    });

/// A technique enriched with its priority score for a given org.
class RankedTechnique {
  final StixTechnique technique;
  final String attackId; // e.g. "T1566"
  final double score; // 0–100
  final String plainName;
  final String whyMatters;
  final List<String> threatGroupNames; // top-3 APTs using it
  final List<String> mitigationNames; // top-3 mitigations

  const RankedTechnique({
    required this.technique,
    required this.attackId,
    required this.score,
    required this.plainName,
    required this.whyMatters,
    required this.threatGroupNames,
    required this.mitigationNames,
  });
}

Future<List<RankedTechnique>> _rankTechniquesForOrg(
  MitreStixDataService svc,
  OrganizationProfileV2 profile,
) async {
  final techniques = svc
      .getAllTechniques()
      .where((t) => !t.isSubTechnique)
      .toList();
  final ranked = <RankedTechnique>[];

  for (final tech in techniques) {
    final attackId = tech.attackId ?? '';
    if (attackId.isEmpty) continue;

    // Base score: how many threat groups use this technique
    final groups = svc.getThreatGroupsForTechnique(attackId);
    double score = groups.length.toDouble().clamp(0, 50); // 0–50

    // Sector multiplier
    score *= _sectorMultiplier(profile.sector, attackId);

    // Size multiplier
    score *= _sizeMultiplier(profile.size);

    // Defense reduction
    score *= (1 - _defenseReduction(profile.currentDefenses, attackId));

    // Technology boost
    score += _technologyBoost(profile.technology, attackId);

    score = score.clamp(0, 100);

    final mitigations = svc.getMitigationsForTechnique(attackId);

    ranked.add(
      RankedTechnique(
        technique: tech,
        attackId: attackId,
        score: score,
        plainName: _plainName(attackId),
        whyMatters: _whyMatters(attackId, profile.sector.name),
        threatGroupNames: groups.take(3).map((g) => g.name).toList(),
        mitigationNames: mitigations.take(3).map((m) => m.name).toList(),
      ),
    );
  }

  ranked.sort((a, b) => b.score.compareTo(a.score));
  return ranked;
}

// ─── scoring helpers ─────────────────────────────────────────

double _sectorMultiplier(BusinessSector sector, String attackId) {
  const weights = <String, Map<String, double>>{
    'healthcare': {
      'T1486': 1.8,
      'T1566': 1.5,
      'T1078': 1.4,
      'T1005': 1.3,
      'T1110': 1.2,
    },
    'finance': {
      'T1110': 1.8,
      'T1098': 1.6,
      'T1005': 1.5,
      'T1040': 1.4,
      'T1486': 1.3,
    },
    'education': {'T1566': 1.6, 'T1486': 1.4, 'T1078': 1.3, 'T1195': 1.2},
    'retail': {'T1486': 1.6, 'T1110': 1.4, 'T1040': 1.3, 'T1566': 1.2},
    'manufacturing': {'T1005': 1.5, 'T1570': 1.4, 'T1486': 1.3, 'T1083': 1.2},
    'government': {'T1555': 1.6, 'T1003': 1.5, 'T1098': 1.4, 'T1134': 1.3},
    'technology': {'T1195': 1.7, 'T1566': 1.4, 'T1005': 1.4, 'T1078': 1.3},
    'nonprofit': {'T1566': 1.5, 'T1486': 1.3, 'T1078': 1.2},
    'hospitality': {'T1486': 1.5, 'T1110': 1.3, 'T1040': 1.2},
  };
  return weights[sector.name]?[attackId] ?? 1.0;
}

double _sizeMultiplier(OrganizationSize size) {
  switch (size) {
    case OrganizationSize.solo:
      return 0.6;
    case OrganizationSize.small:
      return 0.85;
    case OrganizationSize.medium:
      return 1.0;
    case OrganizationSize.largeSmall:
      return 1.2;
    case OrganizationSize.large:
      return 1.4;
  }
}

double _defenseReduction(List<ExistingDefenses> defenses, String attackId) {
  double r = 0;
  for (final d in defenses) {
    switch (d) {
      case ExistingDefenses.mfa:
        if (['T1110', 'T1078', 'T1098'].contains(attackId)) r += 0.55;
        break;
      case ExistingDefenses.edr:
        if (['T1059', 'T1486', 'T1570', 'T1003'].contains(attackId)) r += 0.45;
        break;
      case ExistingDefenses.siem:
        if (['T1482', 'T1083', 'T1040'].contains(attackId)) r += 0.35;
        break;
      case ExistingDefenses.avAndFirewall:
        r += 0.15;
        break;
      case ExistingDefenses.comprehensive:
        r += 0.60;
        break;
      default:
        break;
    }
  }
  return r.clamp(0.0, 0.80);
}

double _technologyBoost(PrimaryTechnology tech, String attackId) {
  switch (tech) {
    case PrimaryTechnology.windowsOnly:
      return ['T1059', 'T1566', 'T1003'].contains(attackId) ? 8 : 0;
    case PrimaryTechnology.cloudPrimary:
      return ['T1550', 'T1537', 'T1098'].contains(attackId) ? 10 : 0;
    case PrimaryTechnology.hybrid:
      return ['T1570', 'T1021'].contains(attackId) ? 6 : 0;
    default:
      return 0;
  }
}

String _plainName(String id) {
  const m = {
    'T1110': 'Someone Tries Many Passwords',
    'T1566': 'Fake Emails That Trick You',
    'T1486': 'Files Get Locked (Ransomware)',
    'T1078': 'Stolen or Default Passwords Used',
    'T1005': 'Your Data Gets Collected',
    'T1040': 'Network Traffic Is Listened To',
    'T1098': 'Account Permissions Changed',
    'T1059': 'Attacker Runs Commands on Your System',
    'T1570': 'Attacker Moves Across Your Network',
    'T1003': 'Passwords Stolen from Memory',
    'T1195': 'Trusted Software Update Is Compromised',
    'T1136': 'Fake User Accounts Created',
    'T1553': 'Security Warnings Bypassed',
    'T1055': 'Malicious Code Hidden in Legitimate App',
    'T1021': 'Attacker Logs In Remotely',
    'T1074': 'Your Files Are Being Gathered',
    'T1083': 'Attacker Browses Your Files',
    'T1082': 'Attacker Learns About Your System',
    'T1057': 'Attacker Looks at Running Programs',
    'T1016': 'Attacker Maps Your Network',
    'T1049': 'Attacker Lists Network Connections',
    'T1087': 'Attacker Finds Your User Accounts',
    'T1482': 'Attacker Maps Your Domain',
    'T1007': 'Attacker Lists Your Services',
    'T1047': 'Windows Management Is Abused',
    'T1053': 'Malware Runs on a Schedule',
    'T1543': 'Malware Starts Automatically',
    'T1547': 'Malware Runs When You Log In',
    'T1574': 'Software Libraries Are Hijacked',
    'T1218': 'Legitimate Windows Tools Abused',
    'T1550': 'Stolen Tokens or Hashes Used',
    'T1070': 'Attack Evidence Is Deleted',
    'T1562': 'Your Security Tools Are Disabled',
    'T1491': 'Your Website Is Defaced',
    'T1561': 'Your Drives Are Wiped',
    'T1531': 'Your Accounts Are Deleted',
    'T1490': 'Backups Are Deleted',
    'T1657': 'Attacker Asks for Money (Extortion)',
    'T1041': 'Data Sent Out Through Internet',
    'T1048': 'Data Leaked via Alternate Channel',
    'T1537': 'Data Copied to Cloud Storage',
    'T1530': 'Cloud Storage Data Accessed',
  };
  return m[id] ?? 'Unknown Technique ($id)';
}

String _whyMatters(String id, String sector) {
  const sectorMessages = {
    'healthcare': {
      'T1486':
          'Ransomware shuts down patient care systems — average cost \$1.27M in healthcare',
      'T1566':
          'Medical staff under pressure click malicious emails — most common initial access',
    },
    'finance': {
      'T1110': 'Password attacks target banking portals directly',
      'T1098': 'Attackers elevate privileges to move money',
    },
  };
  return sectorMessages[sector]?[id] ??
      'This technique is actively exploited against organizations like yours';
}
