import 'package:attackshield/shared/models/models.dart';
import '../../core/errors/errors.dart';

abstract class AttackTechniqueRepository {
  Future<List<AttackTechnique>> getAllTechniques();
  Future<AttackTechnique?> getTechniqueById(String id);
  Future<List<AttackTechnique>> getTechniquesByTactic(String tacticId);
  Future<List<AttackTechnique>> searchTechniques(String query);
  Future<List<AttackTechnique>> filterTechniques({
    List<String>? tactics,
    List<String>? platforms,
    double? minRiskScore,
  });
  Future<List<AttackTactic>> getAllTactics();
}

class AttackTechniqueRepositoryImpl implements AttackTechniqueRepository {
  AttackTechniqueRepositoryImpl();

  @override
  Future<List<AttackTechnique>> getAllTechniques() async {
    try {
      return _getMockTechniques();
    } catch (e) {
      throw DataException(message: 'Failed to fetch techniques: $e');
    }
  }

  @override
  Future<AttackTechnique?> getTechniqueById(String id) async {
    try {
      final techniques = await getAllTechniques();
      try {
        return techniques.firstWhere((t) => t.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByTactic(String tacticId) async {
    try {
      final techniques = await getAllTechniques();
      return techniques.where((t) => t.tactics.contains(tacticId)).toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch techniques by tactic: $e');
    }
  }

  @override
  Future<List<AttackTechnique>> searchTechniques(String query) async {
    try {
      final techniques = await getAllTechniques();
      final lowerQuery = query.toLowerCase();
      return techniques
          .where(
            (t) =>
                t.name.toLowerCase().contains(lowerQuery) ||
                t.id.toLowerCase().contains(lowerQuery) ||
                t.description.toLowerCase().contains(lowerQuery),
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
  }) async {
    try {
      var techniques = await getAllTechniques();

      if (tactics != null && tactics.isNotEmpty) {
        techniques = techniques
            .where((t) => t.tactics.any((tactic) => tactics.contains(tactic)))
            .toList();
      }

      if (platforms != null && platforms.isNotEmpty) {
        techniques = techniques
            .where(
              (t) =>
                  t.platforms.any((platform) => platforms.contains(platform)),
            )
            .toList();
      }

      if (minRiskScore != null) {
        techniques = techniques
            .where((t) => t.riskScore >= minRiskScore)
            .toList();
      }

      return techniques;
    } catch (e) {
      throw DataException(message: 'Failed to filter techniques: $e');
    }
  }

  @override
  Future<List<AttackTactic>> getAllTactics() async {
    try {
      return _getMockTactics();
    } catch (e) {
      throw DataException(message: 'Failed to fetch tactics: $e');
    }
  }

  // Mock data generators
  List<AttackTechnique> _getMockTechniques() {
    return const [
      AttackTechnique(
        id: 'T1566',
        name: 'Phishing',
        description:
            'Adversaries may send phishing messages to gain access or plant malware.',
        tactics: ['Initial Access'],
        platforms: ['Linux', 'macOS', 'Windows'],
        detectionIds: ['PRE0001'],
        mitigationIds: ['M1017', 'M1033'],
        riskScore: 8.5,
      ),
      AttackTechnique(
        id: 'T1190',
        name: 'Exploit Public-Facing Application',
        description:
            'Adversaries may attempt to take advantage of a weakness in an Internet-facing computer or program.',
        tactics: ['Initial Access'],
        platforms: ['Linux', 'macOS', 'Windows'],
        detectionIds: ['PRE0002'],
        mitigationIds: ['M1048'],
        riskScore: 9.0,
      ),
      AttackTechnique(
        id: 'T1078',
        name: 'Valid Accounts',
        description:
            'Adversaries may obtain and abuse credentials of existing accounts.',
        tactics: [
          'Defense Evasion',
          'Persistence',
          'Privilege Escalation',
          'Initial Access',
        ],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.5,
      ),
      AttackTechnique(
        id: 'T1547',
        name: 'Boot or Logon Autostart Execution',
        description:
            'Adversaries may configure system settings to automatically execute a program during system boot or logon.',
        tactics: ['Persistence', 'Privilege Escalation'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.0,
      ),
      AttackTechnique(
        id: 'T1071',
        name: 'Application Layer Protocol',
        description:
            'Adversaries may communicate using OSI application layer protocols.',
        tactics: ['Command and Control'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 6.5,
      ),
    ];
  }

  List<AttackTactic> _getMockTactics() {
    return const [
      AttackTactic(
        id: 'TA0001',
        name: 'Initial Access',
        description: 'The adversary is trying to get into your network.',
      ),
      AttackTactic(
        id: 'TA0002',
        name: 'Execution',
        description: 'The adversary is trying to run malicious code.',
      ),
      AttackTactic(
        id: 'TA0003',
        name: 'Persistence',
        description: 'The adversary is trying to keep their access.',
      ),
      AttackTactic(
        id: 'TA0004',
        name: 'Privilege Escalation',
        description:
            'The adversary is trying to gain higher-level permissions.',
      ),
      AttackTactic(
        id: 'TA0005',
        name: 'Defense Evasion',
        description: 'The adversary is trying to avoid being detected.',
      ),
      AttackTactic(
        id: 'TA0006',
        name: 'Credential Access',
        description:
            'The adversary is trying to steal account names and passwords.',
      ),
      AttackTactic(
        id: 'TA0007',
        name: 'Discovery',
        description: 'The adversary is trying to figure out your environment.',
      ),
      AttackTactic(
        id: 'TA0008',
        name: 'Lateral Movement',
        description:
            'The adversary is trying to move through your environment.',
      ),
      AttackTactic(
        id: 'TA0009',
        name: 'Collection',
        description: 'The adversary is trying to gather data of interest.',
      ),
      AttackTactic(
        id: 'TA0010',
        name: 'Exfiltration',
        description: 'The adversary is trying to steal data.',
      ),
      AttackTactic(
        id: 'TA0011',
        name: 'Command and Control',
        description:
            'The adversary is trying to communicate with compromised systems.',
      ),
      AttackTactic(
        id: 'TA0040',
        name: 'Impact',
        description:
            'The adversary is trying to manipulate, interrupt, or destroy your systems and data.',
      ),
    ];
  }
}
