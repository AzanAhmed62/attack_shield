import 'package:attackshield/shared/models/attack_technique.dart';
import 'package:attackshield/shared/models/models.dart';

class AssetTechniqueMapper {
  AssetTechniqueMapper._();

  static const Map<String, List<String>> _assetTypeTactics = {
    'Network': [
      'Initial Access',
      'Command and Control',
      'Exfiltration',
      'Lateral Movement',
    ],
    'Server': [
      'Execution',
      'Persistence',
      'Privilege Escalation',
      'Credential Access',
    ],
    'Workstation': [
      'Initial Access',
      'Execution',
      'Credential Access',
      'Defense Evasion',
    ],
    'Application': [
      'Initial Access',
      'Execution',
      'Persistence',
      'Exfiltration',
    ],
    'Cloud': ['Credential Access', 'Persistence', 'Collection', 'Exfiltration'],
  };

  static List<String> recommendedTactics(SecurityAsset asset) {
    return _assetTypeTactics[asset.type] ?? const <String>[];
  }

  static List<AttackTechnique> relatedTechniques(
    SecurityAsset asset,
    List<AttackTechnique> techniques, {
    int limit = 8,
  }) {
    final preferredTactics = recommendedTactics(asset);
    final normalizedPlatforms = asset.platforms.map(_normalize).toSet();

    final scored =
        techniques
            .map(
              (technique) => (
                technique: technique,
                score: _relevanceScore(
                  technique,
                  normalizedPlatforms,
                  preferredTactics,
                ),
              ),
            )
            .where((entry) => entry.score > 0)
            .toList()
          ..sort((a, b) {
            final scoreCompare = b.score.compareTo(a.score);
            if (scoreCompare != 0) return scoreCompare;
            return b.technique.riskScore.compareTo(a.technique.riskScore);
          });

    return scored.take(limit).map((entry) => entry.technique).toList();
  }

  static int _relevanceScore(
    AttackTechnique technique,
    Set<String> normalizedPlatforms,
    List<String> preferredTactics,
  ) {
    var score = 0;

    if (preferredTactics.any(technique.tactics.contains)) {
      score += 4;
    }

    final techniquePlatforms = technique.platforms.map(_normalize).toSet();
    if (normalizedPlatforms.isNotEmpty &&
        techniquePlatforms.any(normalizedPlatforms.contains)) {
      score += 4;
    }

    if (technique.subTechniqueIds.isNotEmpty) {
      score += 1;
    }

    if (technique.riskScore >= 7.0) {
      score += 1;
    }

    return score;
  }

  static String _normalize(String value) => value.trim().toLowerCase();
}
