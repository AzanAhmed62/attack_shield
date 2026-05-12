// lib/core/services/mitre_stix_data_service.dart
//
// DROP-IN replacement. Fully parses enterprise-attack-14.5.json.
// Every query is O(1) via pre-built in-memory indexes.
//
// SETUP (one-time, 5 min):
//   1. Download enterprise-attack-14.5.json from:
//      https://github.com/mitre-attack/attack-stix-data/releases
//   2. Place at: YOUR_PROJECT/assets/data/enterprise-attack-14.5.json
//   3. pubspec.yaml:
//        flutter:
//          assets:
//            - assets/data/enterprise-attack-14.5.json
//   4. main():
//        await GetStorage.init();
//        await MitreStixDataService().initialize();
//        runApp(const ProviderScope(child: MyApp()));

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

Map<String, dynamic> _decodeMitreBundle(String rawJson) {
  return Map<String, dynamic>.from(jsonDecode(rawJson) as Map);
}

// ═══════════════════════════════════════════════════════════════
// STIX DOMAIN MODELS
// ═══════════════════════════════════════════════════════════════

class StixTechnique {
  final String id; // STIX UUID e.g. "attack-pattern--..."
  final String name;
  final String? description;
  final String? detection; // x_mitre_detection field
  final bool isSubTechnique;
  final String? parentId; // STIX UUID of parent technique
  final String? attackId; // "T1566" or "T1566.001"
  final List<String> tacticShortnames; // ["initial-access", ...]
  final List<String> platforms; // ["Windows", "Linux", ...]
  final String? version;

  const StixTechnique({
    required this.id,
    required this.name,
    this.description,
    this.detection,
    required this.isSubTechnique,
    this.parentId,
    this.attackId,
    required this.tacticShortnames,
    required this.platforms,
    this.version,
  });

  factory StixTechnique.empty() => const StixTechnique(
    id: '',
    name: '',
    isSubTechnique: false,
    tacticShortnames: [],
    platforms: [],
  );

  bool get isEmpty => id.isEmpty;

  factory StixTechnique.fromJson(Map<String, dynamic> j) {
    // Extract ATT&CK ID (e.g. "T1566") from external_references
    final refs = (j['external_references'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    final attackId =
        refs.firstWhere(
              (r) => r['source_name'] == 'mitre-attack',
              orElse: () => <String, dynamic>{},
            )['external_id']
            as String?;

    // Extract tactic shortnames from kill_chain_phases
    final phases = (j['kill_chain_phases'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    final tactics = phases
        .where((p) => p['kill_chain_name'] == 'mitre-attack')
        .map((p) => p['phase_name'] as String)
        .toList();

    return StixTechnique(
      id: j['id'] as String? ?? '',
      name: j['name'] as String? ?? '',
      description: j['description'] as String?,
      detection: j['x_mitre_detection'] as String?,
      isSubTechnique: j['x_mitre_is_subtechnique'] as bool? ?? false,
      attackId: attackId,
      tacticShortnames: tactics,
      platforms: (j['x_mitre_platforms'] as List? ?? []).cast<String>(),
      version: j['x_mitre_version'] as String?,
    );
  }

  // Returns a copy with parentId set (resolved during second parse pass)
  StixTechnique withParent(String pid) => StixTechnique(
    id: id,
    name: name,
    description: description,
    detection: detection,
    isSubTechnique: isSubTechnique,
    parentId: pid,
    attackId: attackId,
    tacticShortnames: tacticShortnames,
    platforms: platforms,
    version: version,
  );
}

// ──────────────────────────────────────────────────────────────

class StixTactic {
  final String id;
  final String name;
  final String shortname; // "initial-access"
  final String? description;

  const StixTactic({
    required this.id,
    required this.name,
    required this.shortname,
    this.description,
  });

  factory StixTactic.fromJson(Map<String, dynamic> j) => StixTactic(
    id: j['id'] as String? ?? '',
    name: j['name'] as String? ?? '',
    shortname: j['x_mitre_shortname'] as String? ?? '',
    description: j['description'] as String?,
  );
}

// ──────────────────────────────────────────────────────────────

class StixThreatGroup {
  final String id;
  final String name;
  final String? description;
  final List<String> aliases;

  const StixThreatGroup({
    required this.id,
    required this.name,
    this.description,
    required this.aliases,
  });

  factory StixThreatGroup.fromJson(Map<String, dynamic> j) => StixThreatGroup(
    id: j['id'] as String? ?? '',
    name: j['name'] as String? ?? '',
    description: j['description'] as String?,
    aliases: (j['aliases'] as List? ?? []).cast<String>(),
  );
}

// ──────────────────────────────────────────────────────────────

class StixMitigation {
  final String id;
  final String name;
  final String? description;

  const StixMitigation({
    required this.id,
    required this.name,
    this.description,
  });

  factory StixMitigation.fromJson(Map<String, dynamic> j) => StixMitigation(
    id: j['id'] as String? ?? '',
    name: j['name'] as String? ?? '',
    description: j['description'] as String?,
  );
}

// ──────────────────────────────────────────────────────────────

class StixMalware {
  final String id;
  final String name;
  final String? description;
  final List<String> labels; // ["ransomware", "trojan", ...]

  const StixMalware({
    required this.id,
    required this.name,
    this.description,
    required this.labels,
  });

  factory StixMalware.fromJson(Map<String, dynamic> j) => StixMalware(
    id: j['id'] as String? ?? '',
    name: j['name'] as String? ?? '',
    description: j['description'] as String?,
    labels: (j['labels'] as List? ?? []).cast<String>(),
  );
}

// ──────────────────────────────────────────────────────────────

class StixTool {
  final String id;
  final String name;
  final String? description;

  const StixTool({required this.id, required this.name, this.description});

  factory StixTool.fromJson(Map<String, dynamic> j) => StixTool(
    id: j['id'] as String? ?? '',
    name: j['name'] as String? ?? '',
    description: j['description'] as String?,
  );
}

// ──────────────────────────────────────────────────────────────

class StixRelationship {
  final String id;
  final String relationshipType; // 'uses' | 'mitigates' | 'subtechnique-of'
  final String sourceRef;
  final String targetRef;

  const StixRelationship({
    required this.id,
    required this.relationshipType,
    required this.sourceRef,
    required this.targetRef,
  });

  factory StixRelationship.fromJson(Map<String, dynamic> j) => StixRelationship(
    id: j['id'] as String? ?? '',
    relationshipType: j['relationship_type'] as String? ?? '',
    sourceRef: j['source_ref'] as String? ?? '',
    targetRef: j['target_ref'] as String? ?? '',
  );
}

// ──────────────────────────────────────────────────────────────

class MitreStatistics {
  final int techniques;
  final int subTechniques;
  final int tactics;
  final int threatGroups;
  final int malware;
  final int tools;
  final int mitigations;
  final int relationships;

  const MitreStatistics({
    required this.techniques,
    required this.subTechniques,
    required this.tactics,
    required this.threatGroups,
    required this.malware,
    required this.tools,
    required this.mitigations,
    required this.relationships,
  });

  @override
  String toString() =>
      '─── MITRE ATT&CK Enterprise v14 ───\n'
      '  Techniques      : $techniques\n'
      '  Sub-Techniques  : $subTechniques\n'
      '  Tactics         : $tactics\n'
      '  Threat Groups   : $threatGroups\n'
      '  Malware         : $malware\n'
      '  Tools           : $tools\n'
      '  Mitigations     : $mitigations\n'
      '  Relationships   : $relationships\n'
      '────────────────────────────────────';
}

// ═══════════════════════════════════════════════════════════════
// SERVICE
// ═══════════════════════════════════════════════════════════════

class MitreStixDataService {
  // ─── singleton ─────────────────────────────────────────────
  static final MitreStixDataService _instance =
      MitreStixDataService._internal();
  factory MitreStixDataService() => _instance;
  MitreStixDataService._internal();

  // ─── constants ─────────────────────────────────────────────
  static const _assetPath = 'assets/data/enterprise-attack-14.5.json';
  static const _cacheKey = 'mitre_stix_bundle_v145';
  static const _versionKey = 'mitre_stix_version';
  static const _version = '14.5';

  // ─── primary indexes (O(1) lookups) ────────────────────────
  final Map<String, StixTechnique> _byId = {};
  final Map<String, StixTechnique> _byAttackId = {};
  final Map<String, StixTactic> _tactics = {};
  final Map<String, StixThreatGroup> _groups = {};
  final Map<String, StixMitigation> _mits = {};
  final Map<String, StixMalware> _malware = {};
  final Map<String, StixTool> _tools = {};
  final List<StixRelationship> _rels = [];

  // ─── secondary indexes ─────────────────────────────────────
  /// technique STIX id → set of group STIX ids that 'use' it
  final Map<String, Set<String>> _groupsByTech = {};

  /// technique STIX id → set of mitigation STIX ids
  final Map<String, Set<String>> _mitsByTech = {};

  /// technique STIX id → set of malware/tool STIX ids that 'use' it
  final Map<String, Set<String>> _malwareByTech = {};

  /// parent technique STIX id → set of sub-technique STIX ids
  final Map<String, Set<String>> _subsByParent = {};

  /// tactic shortname → set of technique STIX ids
  final Map<String, Set<String>> _techsByTactic = {};

  bool _initialized = false;
  Future<void>? _initializationFuture;

  // ═══════════════════════════════════════════════════════════
  // INITIALIZATION
  // ═══════════════════════════════════════════════════════════

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    _initializationFuture ??= _initializeInternal();
    return _initializationFuture!;
  }

  Future<void> _initializeInternal() async {
    if (_initialized) {
      return;
    }

    try {
      final box = GetStorage();

      // Try cache first — avoids 5-10s parse on every cold start
      if (box.read<String>(_versionKey) == _version) {
        final raw = box.read<String>(_cacheKey);
        if (raw != null) {
          _parseBundle(await compute(_decodeMitreBundle, raw));
          _initialized = true;
          if (kDebugMode) {
            print('✅ MITRE data loaded from cache\n${getStatistics()}');
          }
          return;
        }
      }

      if (kDebugMode) print('⏳ First-time MITRE data load from asset…');
      final jsonStr = await rootBundle.loadString(_assetPath);
      final decoded = await compute(_decodeMitreBundle, jsonStr);
      _parseBundle(decoded);

      // Cache for subsequent launches
      await box.write(_cacheKey, jsonStr);
      await box.write(_versionKey, _version);

      _initialized = true;
      if (kDebugMode) print('✅ MITRE data loaded & cached\n${getStatistics()}');
    } catch (e) {
      _initializationFuture = null;
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // PARSE + INDEX
  // ═══════════════════════════════════════════════════════════

  void _parseBundle(Map<String, dynamic> bundle) {
    _byId.clear();
    _byAttackId.clear();
    _tactics.clear();
    _groups.clear();
    _mits.clear();
    _malware.clear();
    _tools.clear();
    _rels.clear();
    _groupsByTech.clear();
    _mitsByTech.clear();
    _malwareByTech.clear();
    _subsByParent.clear();
    _techsByTactic.clear();

    final objects = bundle['objects'] as List;

    // ── Pass 1: parse all objects ──────────────────────────
    for (final raw in objects) {
      final j = raw as Map<String, dynamic>;
      final type = j['type'] as String? ?? '';

      switch (type) {
        case 'attack-pattern':
          final t = StixTechnique.fromJson(j);
          if (t.id.isEmpty) break;
          _byId[t.id] = t;
          if (t.attackId != null) _byAttackId[t.attackId!] = t;
          for (final tac in t.tacticShortnames) {
            (_techsByTactic[tac] ??= {}).add(t.id);
          }
          break;

        case 'x-mitre-tactic':
          final tac = StixTactic.fromJson(j);
          if (tac.id.isNotEmpty) _tactics[tac.id] = tac;
          break;

        case 'intrusion-set':
          final g = StixThreatGroup.fromJson(j);
          if (g.id.isNotEmpty) _groups[g.id] = g;
          break;

        case 'course-of-action':
          final m = StixMitigation.fromJson(j);
          if (m.id.isNotEmpty) _mits[m.id] = m;
          break;

        case 'malware':
          final mw = StixMalware.fromJson(j);
          if (mw.id.isNotEmpty) _malware[mw.id] = mw;
          break;

        case 'tool':
          final tool = StixTool.fromJson(j);
          if (tool.id.isNotEmpty) _tools[tool.id] = tool;
          break;

        case 'relationship':
          final rel = StixRelationship.fromJson(j);
          if (rel.id.isNotEmpty) _rels.add(rel);
          break;
      }
    }

    // ── Pass 2: resolve relationships into secondary indexes ─
    for (final rel in _rels) {
      switch (rel.relationshipType) {
        case 'uses':
          // Group → Technique
          if (_groups.containsKey(rel.sourceRef) &&
              _byId.containsKey(rel.targetRef)) {
            (_groupsByTech[rel.targetRef] ??= {}).add(rel.sourceRef);
          }
          // Malware or Tool → Technique
          if ((_malware.containsKey(rel.sourceRef) ||
                  _tools.containsKey(rel.sourceRef)) &&
              _byId.containsKey(rel.targetRef)) {
            (_malwareByTech[rel.targetRef] ??= {}).add(rel.sourceRef);
          }
          break;

        case 'mitigates':
          if (_mits.containsKey(rel.sourceRef) &&
              _byId.containsKey(rel.targetRef)) {
            (_mitsByTech[rel.targetRef] ??= {}).add(rel.sourceRef);
          }
          break;

        case 'subtechnique-of':
          if (_byId.containsKey(rel.sourceRef) &&
              _byId.containsKey(rel.targetRef)) {
            (_subsByParent[rel.targetRef] ??= {}).add(rel.sourceRef);
            // Patch parentId into the sub-technique object
            final sub = _byId[rel.sourceRef]!;
            final patched = sub.withParent(rel.targetRef);
            _byId[rel.sourceRef] = patched;
            if (sub.attackId != null) _byAttackId[sub.attackId!] = patched;
          }
          break;
      }
    }
  }

  // ═══════════════════════════════════════════════════════════
  // PUBLIC QUERY API
  // ═══════════════════════════════════════════════════════════

  void _assert() {
    assert(
      _initialized,
      'MitreStixDataService.initialize() must be called in main() before use.',
    );
  }

  // ── techniques ────────────────────────────────────────────

  /// Every technique + sub-technique in the dataset.
  List<StixTechnique> getAllTechniques() {
    _assert();
    return _byId.values.toList();
  }

  /// Only top-level techniques (not sub-techniques).
  List<StixTechnique> getTopLevelTechniques() {
    _assert();
    return _byId.values.where((t) => !t.isSubTechnique).toList();
  }

  /// Lookup by ATT&CK ID, e.g. "T1566" or "T1566.001".
  StixTechnique? getTechniqueByAttackId(String attackId) {
    _assert();
    return _byAttackId[attackId];
  }

  /// Lookup by STIX UUID.
  StixTechnique? getTechniqueById(String stixId) {
    _assert();
    return _byId[stixId];
  }

  /// All techniques in a tactic (by shortname, e.g. "initial-access").
  List<StixTechnique> getTechniquesByTactic(String tacticShortname) {
    _assert();
    return (_techsByTactic[tacticShortname] ?? {})
        .map((id) => _byId[id])
        .whereType<StixTechnique>()
        .toList();
  }

  /// Sub-techniques for a parent (by ATT&CK ID, e.g. "T1566").
  List<StixTechnique> getSubTechniquesForParent(String parentAttackId) {
    _assert();
    final parent = _byAttackId[parentAttackId];
    if (parent == null) return [];
    return (_subsByParent[parent.id] ?? {})
        .map((id) => _byId[id])
        .whereType<StixTechnique>()
        .toList();
  }

  /// STIX IDs of sub-techniques for a parent (for relationship display).
  List<String> getRelatedTechniques(String attackId) {
    _assert();
    final tech = _byAttackId[attackId];
    if (tech == null) return [];
    return (_subsByParent[tech.id] ?? {}).toList();
  }

  /// Full-text search across name, description, and ATT&CK ID.
  List<StixTechnique> searchTechniques(String query) {
    _assert();
    final q = query.toLowerCase();
    return _byId.values
        .where(
          (t) =>
              t.name.toLowerCase().contains(q) ||
              (t.description?.toLowerCase().contains(q) ?? false) ||
              (t.attackId?.toLowerCase().contains(q) ?? false),
        )
        .toList();
  }

  // ── tactics ───────────────────────────────────────────────

  /// All 14 tactics sorted in canonical ATT&CK order.
  List<StixTactic> getAllTactics() {
    _assert();
    const order = [
      'reconnaissance',
      'resource-development',
      'initial-access',
      'execution',
      'persistence',
      'privilege-escalation',
      'defense-evasion',
      'credential-access',
      'discovery',
      'lateral-movement',
      'collection',
      'command-and-control',
      'exfiltration',
      'impact',
    ];
    final list = _tactics.values.toList();
    list.sort((a, b) {
      final ai = order.indexOf(a.shortname);
      final bi = order.indexOf(b.shortname);
      if (ai < 0 && bi < 0) return a.name.compareTo(b.name);
      if (ai < 0) return 1;
      if (bi < 0) return -1;
      return ai.compareTo(bi);
    });
    return list;
  }

  // ── threat groups ─────────────────────────────────────────

  List<StixThreatGroup> getAllThreatGroups() {
    _assert();
    return _groups.values.toList();
  }

  /// Groups that use a technique (by ATT&CK ID).
  List<StixThreatGroup> getThreatGroupsForTechnique(String attackId) {
    _assert();
    final tech = _byAttackId[attackId];
    if (tech == null) return [];
    return (_groupsByTech[tech.id] ?? {})
        .map((id) => _groups[id])
        .whereType<StixThreatGroup>()
        .toList();
  }

  /// Techniques used by a group (by STIX UUID or name).
  List<StixTechnique> getTechniquesForThreatGroup(String groupIdOrName) {
    _assert();
    final group =
        _groups[groupIdOrName] ??
        _groups.values.firstWhere(
          (g) => g.name == groupIdOrName,
          orElse: () => const StixThreatGroup(id: '', name: '', aliases: []),
        );
    if (group.id.isEmpty) return [];

    return _groupsByTech.entries
        .where((e) => e.value.contains(group.id))
        .map((e) => _byId[e.key])
        .whereType<StixTechnique>()
        .toList();
  }

  // ── mitigations ───────────────────────────────────────────

  List<StixMitigation> getAllMitigations() {
    _assert();
    return _mits.values.toList();
  }

  List<StixMitigation> getMitigationsForTechnique(String attackId) {
    _assert();
    final tech = _byAttackId[attackId];
    if (tech == null) return [];
    return (_mitsByTech[tech.id] ?? {})
        .map((id) => _mits[id])
        .whereType<StixMitigation>()
        .toList();
  }

  // ── malware & tools ───────────────────────────────────────

  List<StixMalware> getAllMalware() {
    _assert();
    return _malware.values.toList();
  }

  List<StixTool> getAllTools() {
    _assert();
    return _tools.values.toList();
  }

  List<StixMalware> getMalwareForTechnique(String attackId) {
    _assert();
    final tech = _byAttackId[attackId];
    if (tech == null) return [];
    return (_malwareByTech[tech.id] ?? {})
        .map((id) => _malware[id])
        .whereType<StixMalware>()
        .toList();
  }

  // ── statistics ────────────────────────────────────────────

  MitreStatistics getStatistics() {
    _assert();
    return MitreStatistics(
      techniques: _byId.values.where((t) => !t.isSubTechnique).length,
      subTechniques: _byId.values.where((t) => t.isSubTechnique).length,
      tactics: _tactics.length,
      threatGroups: _groups.length,
      malware: _malware.length,
      tools: _tools.length,
      mitigations: _mits.length,
      relationships: _rels.length,
    );
  }
}
