// lib/data/repositories/attack_technique_repository.dart
// FULL REPLACEMENT — parses enterprise-attack-14.5.json from assets,
// runs JSON decoding in a Dart isolate (compute()), caches to GetStorage.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';

import '../../shared/models/attack_technique.dart';

// ─── Storage keys ────────────────────────────────────────────────────────────
const _kTechniquesKey = 'stix_techniques_v14_5';
const _kTacticsKey = 'stix_tactics_v14_5';

// ─── Interface ───────────────────────────────────────────────────────────────
abstract class AttackTechniqueRepository {
  Future<List<AttackTechnique>> getAllTechniques();
  Future<AttackTechnique?> getTechniqueById(String id);
  Future<List<AttackTechnique>> getTechniquesByTactic(String tacticShortName);
  Future<List<AttackTechnique>> searchTechniques(String query);
  Future<List<AttackTechnique>> filterTechniques({
    List<String>? tactics,
    List<String>? platforms,
    double? minRiskScore,
    bool? subTechniquesOnly,
    bool? parentTechniquesOnly,
  });
  Future<List<AttackTactic>> getAllTactics();
  Future<void> clearCache();
}

// ─── Implementation ──────────────────────────────────────────────────────────
class AttackTechniqueRepositoryImpl implements AttackTechniqueRepository {
  // In-memory cache (session-level)
  List<AttackTechnique>? _techniques;
  List<AttackTactic>? _tactics;

  final _storage = GetStorage();

  // ── Public API ─────────────────────────────────────────────────────────────

  @override
  Future<List<AttackTechnique>> getAllTechniques() async {
    if (_techniques != null) return _techniques!;
    await _ensureLoaded();
    return _techniques!;
  }

  @override
  Future<List<AttackTactic>> getAllTactics() async {
    if (_tactics != null) return _tactics!;
    await _ensureLoaded();
    return _tactics!;
  }

  @override
  Future<AttackTechnique?> getTechniqueById(String id) async {
    final all = await getAllTechniques();
    try {
      return all.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByTactic(
    String tacticShortName,
  ) async {
    final all = await getAllTechniques();
    return all.where((t) => t.tactics.contains(tacticShortName)).toList();
  }

  @override
  Future<List<AttackTechnique>> searchTechniques(String query) async {
    if (query.trim().isEmpty) return getAllTechniques();
    final all = await getAllTechniques();
    final lower = query.toLowerCase();
    return all
        .where(
          (t) =>
              t.name.toLowerCase().contains(lower) ||
              t.id.toLowerCase().contains(lower) ||
              t.description.toLowerCase().contains(lower),
        )
        .toList();
  }

  @override
  Future<List<AttackTechnique>> filterTechniques({
    List<String>? tactics,
    List<String>? platforms,
    double? minRiskScore,
    bool? subTechniquesOnly,
    bool? parentTechniquesOnly,
  }) async {
    var result = await getAllTechniques();
    if (tactics != null && tactics.isNotEmpty) {
      result = result
          .where((t) => t.tactics.any((tac) => tactics.contains(tac)))
          .toList();
    }
    if (platforms != null && platforms.isNotEmpty) {
      result = result
          .where((t) => t.platforms.any((p) => platforms.contains(p)))
          .toList();
    }
    if (minRiskScore != null) {
      result = result.where((t) => t.riskScore >= minRiskScore).toList();
    }
    if (subTechniquesOnly == true) {
      result = result.where((t) => t.isSubTechnique).toList();
    }
    if (parentTechniquesOnly == true) {
      result = result.where((t) => !t.isSubTechnique).toList();
    }
    return result;
  }

  @override
  Future<void> clearCache() async {
    await _storage.remove(_kTechniquesKey);
    await _storage.remove(_kTacticsKey);
    _techniques = null;
    _tactics = null;
  }

  // ── Internal loading ───────────────────────────────────────────────────────

  Future<void> _ensureLoaded() async {
    // 1. Try GetStorage disk cache (instant)
    if (_tryLoadFromDiskCache()) return;

    // 2. Parse STIX bundle off main thread via compute()
    debugPrint('[STIX] Cache miss — parsing bundle in isolate...');
    final jsonString = await rootBundle.loadString(
      'assets/data/enterprise-attack-14.5.json',
    );
    final parsed = await compute(_parseStixBundle, jsonString);
    _techniques = parsed.techniques;
    _tactics = parsed.tactics;

    // 3. Persist to disk for next session
    await _saveToDiskCache();
    debugPrint(
      '[STIX] Loaded ${_techniques!.length} techniques, '
      '${_tactics!.length} tactics. Cached to storage.',
    );
  }

  bool _tryLoadFromDiskCache() {
    try {
      final techJson = _storage.read<String>(_kTechniquesKey);
      final tacticsJson = _storage.read<String>(_kTacticsKey);
      if (techJson == null || tacticsJson == null) return false;

      final techList = (jsonDecode(techJson) as List)
          .cast<Map<String, dynamic>>();
      final tacticList = (jsonDecode(tacticsJson) as List)
          .cast<Map<String, dynamic>>();
      _techniques = techList.map(AttackTechnique.fromJson).toList();
      _tactics = tacticList.map(AttackTactic.fromJson).toList();
      debugPrint(
        '[STIX] Loaded ${_techniques!.length} techniques from disk cache.',
      );
      return true;
    } catch (e) {
      debugPrint('[STIX] Cache read failed, re-parsing: $e');
      return false;
    }
  }

  Future<void> _saveToDiskCache() async {
    try {
      final techJson = jsonEncode(_techniques!.map((t) => t.toJson()).toList());
      final tacticsJson = jsonEncode(_tactics!.map((t) => t.toJson()).toList());
      await _storage.write(_kTechniquesKey, techJson);
      await _storage.write(_kTacticsKey, tacticsJson);
    } catch (e) {
      debugPrint('[STIX] Cache write failed: $e');
    }
  }
}

// ─── Isolate-safe parser (top-level function required by compute()) ──────────

class _ParsedBundle {
  final List<AttackTechnique> techniques;
  final List<AttackTactic> tactics;
  _ParsedBundle(this.techniques, this.tactics);
}

_ParsedBundle _parseStixBundle(String jsonString) {
  final bundle = jsonDecode(jsonString) as Map<String, dynamic>;
  final objects = (bundle['objects'] as List).cast<Map<String, dynamic>>();

  // ── 1. Index all objects by STIX ID ────────────────────────────────────────
  final objectIndex = <String, Map<String, dynamic>>{};
  for (final obj in objects) {
    final id = obj['id'] as String?;
    if (id != null) objectIndex[id] = obj;
  }

  // ── 2. Parse tactics (x-mitre-tactic) ─────────────────────────────────────
  final tacticObjects = objects
      .where((o) => o['type'] == 'x-mitre-tactic')
      .toList();
  final tacticByShortName = <String, AttackTactic>{};
  final tacticById = <String, AttackTactic>{};

  for (final obj in tacticObjects) {
    final extRefs =
        (obj['external_references'] as List?)?.cast<Map<String, dynamic>>() ??
        [];
    final mitreRef = extRefs.firstWhere(
      (r) => r['source_name'] == 'mitre-attack',
      orElse: () => {},
    );
    final tacticId = mitreRef['external_id'] as String? ?? '';
    final shortName = obj['x_mitre_shortname'] as String? ?? '';
    final tactic = AttackTactic(
      id: tacticId,
      name: obj['name'] as String? ?? '',
      shortName: shortName,
      description: obj['description'] as String? ?? '',
    );
    tacticByShortName[shortName] = tactic;
    if (tacticId.isNotEmpty) tacticById[tacticId] = tactic;
  }

  // ── 3. Parse relationships ─────────────────────────────────────────────────
  // subtechnique-of: source=sub, target=parent
  // mitigates:       source=course-of-action, target=attack-pattern
  // detects:         source=x-mitre-data-component, target=attack-pattern

  final subOf = <String, String>{}; // sub_stix_id → parent_stix_id
  final mitigations =
      <String, List<String>>{}; // technique_stix_id → [mitigation names]
  final detections =
      <String, List<String>>{}; // technique_stix_id → [detection names]
  final related =
      <String, Set<String>>{}; // technique_stix_id → {related stix ids}

  for (final obj in objects) {
    if (obj['type'] != 'relationship') continue;
    final relType = obj['relationship_type'] as String? ?? '';
    final sourceRef = obj['source_ref'] as String? ?? '';
    final targetRef = obj['target_ref'] as String? ?? '';

    switch (relType) {
      case 'subtechnique-of':
        subOf[sourceRef] = targetRef;
      case 'mitigates':
        // source = course-of-action, target = attack-pattern
        final mitObj = objectIndex[sourceRef];
        if (mitObj != null) {
          final name = mitObj['name'] as String? ?? 'Unknown';
          mitigations.putIfAbsent(targetRef, () => []).add(name);
        }
      case 'detects':
        final detObj = objectIndex[sourceRef];
        if (detObj != null) {
          final name = detObj['name'] as String? ?? 'Unknown';
          detections.putIfAbsent(targetRef, () => []).add(name);
        }
      case 'uses':
        // bidirectional: also build related techniques list
        related.putIfAbsent(sourceRef, () => {}).add(targetRef);
        related.putIfAbsent(targetRef, () => {}).add(sourceRef);
    }
  }

  // ── 4. Parse attack-pattern objects ────────────────────────────────────────
  final attackPatterns = objects.where((o) {
    if (o['type'] != 'attack-pattern') return false;
    // Skip revoked / deprecated
    if (o['revoked'] == true) return false;
    if (o['x_mitre_deprecated'] == true) return false;
    return true;
  }).toList();

  // First pass: build stixId → T-number map (needed to resolve relationships)
  final stixToTId = <String, String>{};
  for (final obj in attackPatterns) {
    final stixId = obj['id'] as String? ?? '';
    final extRefs =
        (obj['external_references'] as List?)?.cast<Map<String, dynamic>>() ??
        [];
    final mitreRef = extRefs.firstWhere(
      (r) => r['source_name'] == 'mitre-attack',
      orElse: () => {},
    );
    final tId = mitreRef['external_id'] as String? ?? '';
    if (stixId.isNotEmpty && tId.isNotEmpty) stixToTId[stixId] = tId;
  }

  // Second pass: build full AttackTechnique objects
  final techniqueMap = <String, AttackTechnique>{};
  for (final obj in attackPatterns) {
    final stixId = obj['id'] as String? ?? '';
    final extRefs =
        (obj['external_references'] as List?)?.cast<Map<String, dynamic>>() ??
        [];
    final mitreRef = extRefs.firstWhere(
      (r) => r['source_name'] == 'mitre-attack',
      orElse: () => {},
    );
    final tId = mitreRef['external_id'] as String? ?? '';
    final url = mitreRef['url'] as String?;
    if (tId.isEmpty) continue;

    // Tactics from kill_chain_phases
    final killChain =
        (obj['kill_chain_phases'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final tacticShortNames = killChain
        .where((kc) => kc['kill_chain_name'] == 'mitre-attack')
        .map((kc) => kc['phase_name'] as String)
        .toList();
    final tacticIds = tacticShortNames
        .map((sn) => tacticByShortName[sn]?.id ?? '')
        .where((id) => id.isNotEmpty)
        .toList();

    // Platforms
    final platforms = (obj['x_mitre_platforms'] as List?)?.cast<String>() ?? [];

    // Data sources
    final dataSources =
        (obj['x_mitre_data_sources'] as List?)?.cast<String>() ?? [];

    // Sub-technique
    final isSub = obj['x_mitre_is_subtechnique'] == true;
    final parentStixId = isSub ? subOf[stixId] : null;
    final parentTId = parentStixId != null ? stixToTId[parentStixId] : null;

    // Relationships
    final mitList = mitigations[stixId] ?? [];
    final detList = detections[stixId] ?? [];
    final relSet = related[stixId] ?? {};
    final relTIds = relSet
        .map((sid) => stixToTId[sid])
        .where((id) => id != null && id != tId)
        .cast<String>()
        .toSet()
        .toList();

    // Risk score: computed from tactic severity weights + platform breadth
    final riskScore = _computeRiskScore(
      tacticShortNames: tacticShortNames,
      platformCount: platforms.length,
      hasMitigations: mitList.isNotEmpty,
    );

    techniqueMap[stixId] = AttackTechnique(
      id: tId,
      stixId: stixId,
      name: obj['name'] as String? ?? '',
      description: obj['description'] as String? ?? '',
      tactics: tacticShortNames,
      tacticIds: tacticIds,
      platforms: platforms,
      dataSources: dataSources,
      mitigationIds: mitList,
      detectionIds: detList,
      relatedTechniqueIds: relTIds,
      isSubTechnique: isSub,
      parentTechniqueId: parentTId,
      riskScore: riskScore,
      url: url,
      created: obj['created'] as String?,
      modified: obj['modified'] as String?,
    );
  }

  // Third pass: build parent→children map
  final parentToChildren = <String, List<String>>{};
  for (final t in techniqueMap.values) {
    if (t.isSubTechnique && t.parentTechniqueId != null) {
      parentToChildren.putIfAbsent(t.parentTechniqueId!, () => []).add(t.id);
    }
  }

  // Assign subTechniqueIds to parents
  final withChildren = techniqueMap.values.map((t) {
    final children = parentToChildren[t.id];
    if (children == null || children.isEmpty) return t;
    return t.copyWith(subTechniqueIds: children);
  }).toList();

  // Sort: parents first (alphabetically), then sub-techniques under parent
  withChildren.sort((a, b) {
    final aBase = a.isSubTechnique ? a.parentTechniqueId! : a.id;
    final bBase = b.isSubTechnique ? b.parentTechniqueId! : b.id;
    if (aBase != bBase) return aBase.compareTo(bBase);
    return a.id.compareTo(b.id);
  });

  // Populate tactic techniqueIds
  final tacticWithTechniques = tacticByShortName.map((shortName, tactic) {
    final ids = withChildren
        .where((t) => t.tactics.contains(shortName))
        .map((t) => t.id)
        .toList();
    return MapEntry(shortName, tactic.copyWith(techniqueIds: ids));
  });

  return _ParsedBundle(
    withChildren,
    tacticWithTechniques.values.toList()..sort((a, b) => a.id.compareTo(b.id)),
  );
}

// ─── Risk score formula ───────────────────────────────────────────────────────
// Academic basis: tactic severity weight × platform breadth multiplier,
// penalised by presence of mitigations (defensible).
// Normalised to 0–10 range.

const _tacticWeights = <String, double>{
  'impact': 1.5,
  'exfiltration': 1.4,
  'command-and-control': 1.3,
  'lateral-movement': 1.3,
  'privilege-escalation': 1.2,
  'persistence': 1.2,
  'credential-access': 1.2,
  'execution': 1.1,
  'collection': 1.1,
  'defense-evasion': 1.0,
  'discovery': 0.9,
  'initial-access': 1.1,
  'reconnaissance': 0.8,
  'resource-development': 0.7,
};

double _computeRiskScore({
  required List<String> tacticShortNames,
  required int platformCount,
  required bool hasMitigations,
}) {
  if (tacticShortNames.isEmpty) return 5.0;

  // Max tactic weight
  double maxWeight = tacticShortNames
      .map((t) => _tacticWeights[t] ?? 1.0)
      .reduce((a, b) => a > b ? a : b);

  // Base score from tactic weight → 0-8
  double base = maxWeight * 5.5;

  // Platform breadth bonus: more platforms = more exposure (max +1.5)
  final breadth = (platformCount / 8.0).clamp(0.0, 1.0) * 1.5;

  // Mitigation penalty: if mitigations exist, slightly lower risk
  final mitigationPenalty = hasMitigations ? 0.5 : 0.0;

  final score = (base + breadth - mitigationPenalty).clamp(0.0, 10.0);
  // Round to 1 decimal
  return (score * 10).round() / 10;
}
