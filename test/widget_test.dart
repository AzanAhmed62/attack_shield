import 'package:attackshield/core/services/asset_technique_mapper.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssetTechniqueMapper', () {
    test('returns tactic recommendations for known asset types', () {
      final asset = SecurityAsset(
        id: 'asset-1',
        name: 'Prod Cloud',
        type: 'Cloud',
        criticality: AssetCriticality.high,
        discoveredAt: DateTime(2026, 1, 1),
      );

      expect(
        AssetTechniqueMapper.recommendedTactics(asset),
        containsAll(const ['Credential Access', 'Persistence', 'Exfiltration']),
      );
    });

    test('prioritizes platform and tactic aligned techniques', () {
      final asset = SecurityAsset(
        id: 'asset-2',
        name: 'Windows Server',
        type: 'Server',
        platforms: const ['Windows'],
        discoveredAt: DateTime(2026, 1, 1),
      );

      const matching = AttackTechnique(
        id: 'T1003',
        name: 'Credential Dumping',
        description: 'Steal credentials from OS stores.',
        tactics: ['Credential Access'],
        platforms: ['Windows'],
        riskScore: 8.0,
      );
      const nonMatching = AttackTechnique(
        id: 'T1496',
        name: 'Resource Hijacking',
        description: 'Use victim resources for miner workloads.',
        tactics: ['Impact'],
        platforms: ['Linux'],
        riskScore: 9.0,
      );

      final related = AssetTechniqueMapper.relatedTechniques(
        asset,
        [nonMatching, matching],
        limit: 1,
      );

      expect(related, isNotEmpty);
      expect(related.first.id, matching.id);
      expect(related.length, 1);
    });
  });
}
