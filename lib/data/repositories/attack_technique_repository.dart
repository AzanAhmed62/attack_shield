import 'package:attackshield/core/services/mitre_stix_data_service.dart';
import 'package:attackshield/shared/models/models.dart';

import '../../core/errors/errors.dart';

/// Abstract contract for the technique data layer.
/// Swap [AttackTechniqueRepositoryImpl] with an API-backed version in Phase 2.
abstract class AttackTechniqueRepository {
  Future<List<AttackTechnique>> getAllTechniques();
  Future<AttackTechnique?> getTechniqueById(String id);
  Future<List<AttackTechnique>> getTechniquesByTactic(String tacticName);
  Future<List<AttackTechnique>> searchTechniques(String query);
  Future<List<AttackTechnique>> filterTechniques({
    List<String>? tactics,
    List<String>? platforms,
    double? minRiskScore,
    double? maxRiskScore,
  });
  Future<List<AttackTactic>> getAllTactics();
  Future<AttackTactic?> getTacticById(String id);
  Future<List<AttackTechnique>> getHighRiskTechniques({int limit = 10});
  Future<List<AttackTechnique>> getTechniquesByPlatform(String platform);
}

class AttackTechniqueRepositoryImpl implements AttackTechniqueRepository {
  AttackTechniqueRepositoryImpl({MitreStixDataService? mitreService})
    : _mitreService = mitreService ?? MitreStixDataService();

  final MitreStixDataService _mitreService;

  List<AttackTechnique>? _cachedTechniques;
  List<AttackTactic>? _cachedTactics;

  @override
  Future<List<AttackTechnique>> getAllTechniques() async {
    try {
      if (_cachedTechniques != null) {
        return _cachedTechniques!;
      }

      await _mitreService.initialize();

      final techniques =
          _mitreService.getTopLevelTechniques().map(_mapTechnique).toList()
            ..sort((a, b) => a.id.compareTo(b.id));

      _cachedTechniques = List.unmodifiable(techniques);
      return _cachedTechniques!;
    } catch (e) {
      throw DataException(message: 'Failed to fetch techniques: $e');
    }
  }

  @override
  Future<AttackTechnique?> getTechniqueById(String id) async {
    try {
      final techniques = await getAllTechniques();
      final normalizedId = id.trim().toUpperCase();

      for (final technique in techniques) {
        if (technique.id.toUpperCase() == normalizedId) {
          return technique;
        }

        for (final subTechnique in technique.subTechniques) {
          if (subTechnique.id.toUpperCase() == normalizedId) {
            return technique;
          }
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByTactic(String tacticName) async {
    try {
      final techniques = await getAllTechniques();
      final normalizedTactic = _normalizeTactic(tacticName);

      return techniques
          .where(
            (technique) => technique.tactics.any(
              (tactic) => _normalizeTactic(tactic) == normalizedTactic,
            ),
          )
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch by tactic: $e');
    }
  }

  @override
  Future<List<AttackTechnique>> searchTechniques(String query) async {
    try {
      final techniques = await getAllTechniques();
      final normalizedQuery = query.trim().toLowerCase();

      if (normalizedQuery.isEmpty) {
        return techniques;
      }

      return techniques
          .where(
            (technique) =>
                technique.name.toLowerCase().contains(normalizedQuery) ||
                technique.id.toLowerCase().contains(normalizedQuery) ||
                technique.description.toLowerCase().contains(normalizedQuery) ||
                technique.tactics.any(
                  (tactic) => tactic.toLowerCase().contains(normalizedQuery),
                ),
          )
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to search techniques: $e');
    }
  }

  @override
  Future<List<AttackTechnique>> filterTechniques({
    List<String>? tactics,
    List<String>? platforms,
    double? minRiskScore,
    double? maxRiskScore,
  }) async {
    try {
      var result = await getAllTechniques();

      if (tactics != null && tactics.isNotEmpty) {
        final tacticFilters = tactics.map(_normalizeTactic).toSet();
        result = result
            .where(
              (technique) => technique.tactics.any(
                (tactic) => tacticFilters.contains(_normalizeTactic(tactic)),
              ),
            )
            .toList();
      }

      if (platforms != null && platforms.isNotEmpty) {
        final platformFilters = platforms
            .map((platform) => platform.toLowerCase())
            .toSet();
        result = result
            .where(
              (technique) => technique.platforms.any(
                (platform) => platformFilters.contains(platform.toLowerCase()),
              ),
            )
            .toList();
      }

      if (minRiskScore != null) {
        result = result
            .where((technique) => technique.riskScore >= minRiskScore)
            .toList();
      }

      if (maxRiskScore != null) {
        result = result
            .where((technique) => technique.riskScore <= maxRiskScore)
            .toList();
      }

      return result;
    } catch (e) {
      throw DataException(message: 'Failed to filter techniques: $e');
    }
  }

  @override
  Future<List<AttackTactic>> getAllTactics() async {
    try {
      if (_cachedTactics != null) {
        return _cachedTactics!;
      }

      await _mitreService.initialize();

      final tactics = _mitreService
          .getAllTactics()
          .map(
            (tactic) => AttackTactic(
              id: tactic.id,
              name: tactic.name,
              description: tactic.description ?? '',
              shortName: tactic.shortname,
              techniqueIds:
                  _mitreService
                      .getTechniquesByTactic(tactic.shortname)
                      .where((technique) => !technique.isSubTechnique)
                      .map((technique) => technique.attackId ?? technique.id)
                      .toList()
                    ..sort(),
            ),
          )
          .toList();

      _cachedTactics = List.unmodifiable(tactics);
      return _cachedTactics!;
    } catch (e) {
      throw DataException(message: 'Failed to fetch tactics: $e');
    }
  }

  @override
  Future<AttackTactic?> getTacticById(String id) async {
    try {
      final tactics = await getAllTactics();
      final normalizedId = id.trim().toLowerCase();

      for (final tactic in tactics) {
        if (tactic.id.toLowerCase() == normalizedId ||
            tactic.name.toLowerCase() == normalizedId ||
            tactic.shortName?.toLowerCase() == normalizedId) {
          return tactic;
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getHighRiskTechniques({int limit = 10}) async {
    final techniques = await getAllTechniques();
    final sorted = [...techniques]
      ..sort((a, b) => b.riskScore.compareTo(a.riskScore));
    return sorted.take(limit).toList();
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByPlatform(String platform) async {
    try {
      final techniques = await getAllTechniques();
      final normalizedPlatform = platform.toLowerCase();

      return techniques
          .where(
            (technique) => technique.platforms.any(
              (item) => item.toLowerCase() == normalizedPlatform,
            ),
          )
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to filter by platform: $e');
    }
  }

  AttackTechnique _mapTechnique(StixTechnique technique) {
    final attackId = technique.attackId ?? technique.id;
    final subTechniques =
        _mitreService
            .getSubTechniquesForParent(attackId)
            .map(_mapSubTechnique)
            .toList()
          ..sort((a, b) => a.id.compareTo(b.id));
    final threatGroups = _mitreService.getThreatGroupsForTechnique(attackId);
    final mitigations = _mitreService.getMitigationsForTechnique(attackId);
    final relatedTechniqueIds =
        _mitreService.getRelatedTechniques(attackId).map((relatedId) {
          final relatedTechnique = _mitreService.getTechniqueById(relatedId);
          return relatedTechnique?.attackId ??
              relatedTechnique?.id ??
              relatedId;
        }).toList()..sort();

    return AttackTechnique(
      id: attackId,
      name: technique.name,
      description: technique.description ?? 'No description available.',
      tactics: _formattedTactics(technique.tacticShortnames),
      platforms: _sortedDistinctStrings(technique.platforms),
      detectionIds: const [],
      mitigationIds: mitigations.map((mitigation) => mitigation.id).toList(),
      relatedTechniqueIds: relatedTechniqueIds,
      subTechniques: subTechniques,
      riskScore: _estimateRiskScore(
        tacticCount: technique.tacticShortnames.length,
        groupCount: threatGroups.length,
        subTechniqueCount: subTechniques.length,
        platformCount: technique.platforms.length,
        hasDetectionGuidance: (technique.detection ?? '').trim().isNotEmpty,
      ),
      source: 'MITRE ATT&CK Enterprise v14.5',
      externalUrl: _externalUrlForAttackId(attackId),
      detectionNotes: _paragraphsFromText(technique.detection),
      mitigationNotes: mitigations
          .map((mitigation) => mitigation.description?.trim())
          .whereType<String>()
          .where((description) => description.isNotEmpty)
          .toList(),
      dataSource: technique.platforms.isEmpty
          ? null
          : 'Platforms: ${_sortedDistinctStrings(technique.platforms).join(', ')}',
    );
  }

  AttackSubTechnique _mapSubTechnique(StixTechnique technique) {
    final attackId = technique.attackId ?? technique.id;
    final mitigations = _mitreService.getMitigationsForTechnique(attackId);
    final threatGroups = _mitreService.getThreatGroupsForTechnique(attackId);

    return AttackSubTechnique(
      id: attackId,
      name: technique.name,
      description: technique.description ?? 'No description available.',
      platforms: _sortedDistinctStrings(technique.platforms),
      detectionIds: const [],
      mitigationIds: mitigations.map((mitigation) => mitigation.id).toList(),
      riskScore: _estimateRiskScore(
        tacticCount: technique.tacticShortnames.length,
        groupCount: threatGroups.length,
        subTechniqueCount: 0,
        platformCount: technique.platforms.length,
        hasDetectionGuidance: (technique.detection ?? '').trim().isNotEmpty,
        isSubTechnique: true,
      ),
    );
  }

  List<String> _formattedTactics(List<String> tacticShortnames) {
    return tacticShortnames.map(_formatTacticName).toList();
  }

  List<String> _paragraphsFromText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return const [];
    }

    return value
        .split(RegExp(r'\n\s*\n'))
        .map((part) => part.trim().replaceAll(RegExp(r'\s+'), ' '))
        .where((part) => part.isNotEmpty)
        .toList();
  }

  List<String> _sortedDistinctStrings(List<String> values) {
    final items =
        values
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
    return items;
  }

  String _formatTacticName(String shortname) {
    return shortname
        .split('-')
        .where((segment) => segment.isNotEmpty)
        .map(
          (segment) =>
              '${segment[0].toUpperCase()}${segment.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  String _normalizeTactic(String tactic) {
    return tactic.trim().toLowerCase().replaceAll('-', ' ');
  }

  String? _externalUrlForAttackId(String attackId) {
    if (attackId.trim().isEmpty) {
      return null;
    }

    return 'https://attack.mitre.org/techniques/${attackId.replaceAll('.', '/')}/';
  }

  double _estimateRiskScore({
    required int tacticCount,
    required int groupCount,
    required int subTechniqueCount,
    required int platformCount,
    required bool hasDetectionGuidance,
    bool isSubTechnique = false,
  }) {
    var score = 4.0;
    score += tacticCount * 0.35;
    score += platformCount * 0.1;
    score += subTechniqueCount * 0.12;
    score += groupCount.clamp(0, 32) / 8.0;

    if (hasDetectionGuidance) {
      score += 0.2;
    }

    if (isSubTechnique) {
      score -= 0.25;
    }

    return score.clamp(3.0, 9.8);
  }
}
