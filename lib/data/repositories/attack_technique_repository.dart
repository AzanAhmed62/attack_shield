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
  // Cached after first load — avoids rebuilding the list on every call.
  List<AttackTechnique>? _cachedTechniques;
  List<AttackTactic>? _cachedTactics;

  @override
  Future<List<AttackTechnique>> getAllTechniques() async {
    try {
      _cachedTechniques ??= _buildTechniqueDataset();
      return _cachedTechniques!;
    } catch (e) {
      throw DataException(message: 'Failed to fetch techniques: $e');
    }
  }

  @override
  Future<AttackTechnique?> getTechniqueById(String id) async {
    try {
      final techniques = await getAllTechniques();
      return techniques.firstWhere(
        (t) => t.id == id,
        orElse: () => throw StateError('Not found'),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByTactic(
    String tacticName,
  ) async {
    try {
      final techniques = await getAllTechniques();
      return techniques
          .where(
            (t) => t.tactics.any(
              (tac) => tac.toLowerCase() == tacticName.toLowerCase(),
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
      final q = query.toLowerCase();
      return techniques
          .where(
            (t) =>
                t.name.toLowerCase().contains(q) ||
                t.id.toLowerCase().contains(q) ||
                t.description.toLowerCase().contains(q) ||
                t.tactics.any((tac) => tac.toLowerCase().contains(q)),
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
        result = result
            .where(
              (t) => t.tactics.any(
                (tac) => tactics.any(
                  (f) => f.toLowerCase() == tac.toLowerCase(),
                ),
              ),
            )
            .toList();
      }

      if (platforms != null && platforms.isNotEmpty) {
        result = result
            .where(
              (t) => t.platforms.any(
                (p) =>
                    platforms.any((f) => f.toLowerCase() == p.toLowerCase()),
              ),
            )
            .toList();
      }

      if (minRiskScore != null) {
        result =
            result.where((t) => t.riskScore >= minRiskScore).toList();
      }

      if (maxRiskScore != null) {
        result =
            result.where((t) => t.riskScore <= maxRiskScore).toList();
      }

      return result;
    } catch (e) {
      throw DataException(message: 'Failed to filter techniques: $e');
    }
  }

  @override
  Future<List<AttackTactic>> getAllTactics() async {
    try {
      _cachedTactics ??= _buildTacticDataset();
      return _cachedTactics!;
    } catch (e) {
      throw DataException(message: 'Failed to fetch tactics: $e');
    }
  }

  @override
  Future<AttackTactic?> getTacticById(String id) async {
    try {
      final tactics = await getAllTactics();
      return tactics.firstWhere(
        (t) => t.id == id,
        orElse: () => throw StateError('Not found'),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<AttackTechnique>> getHighRiskTechniques({
    int limit = 10,
  }) async {
    final techniques = await getAllTechniques();
    final sorted = [...techniques]
      ..sort((a, b) => b.riskScore.compareTo(a.riskScore));
    return sorted.take(limit).toList();
  }

  @override
  Future<List<AttackTechnique>> getTechniquesByPlatform(
    String platform,
  ) async {
    try {
      final techniques = await getAllTechniques();
      return techniques
          .where(
            (t) => t.platforms.any(
              (p) => p.toLowerCase() == platform.toLowerCase(),
            ),
          )
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to filter by platform: $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TACTIC DATASET  (12 MITRE ATT&CK tactics — Enterprise v14)
  // ─────────────────────────────────────────────────────────────────────────

  List<AttackTactic> _buildTacticDataset() {
    return const [
      AttackTactic(
        id: 'TA0043',
        name: 'Reconnaissance',
        shortName: 'reconnaissance',
        description:
            'The adversary is trying to gather information they can use to plan future operations.',
        techniqueIds: ['T1595', 'T1592', 'T1589', 'T1590', 'T1591', 'T1598', 'T1597', 'T1596', 'T1593', 'T1594'],
      ),
      AttackTactic(
        id: 'TA0042',
        name: 'Resource Development',
        shortName: 'resource-development',
        description:
            'The adversary is trying to establish resources they can use to support operations.',
        techniqueIds: ['T1583', 'T1586', 'T1584', 'T1587', 'T1585', 'T1588', 'T1608'],
      ),
      AttackTactic(
        id: 'TA0001',
        name: 'Initial Access',
        shortName: 'initial-access',
        description:
            'The adversary is trying to get into your network.',
        techniqueIds: ['T1189', 'T1190', 'T1133', 'T1200', 'T1566', 'T1091', 'T1195', 'T1199', 'T1078'],
      ),
      AttackTactic(
        id: 'TA0002',
        name: 'Execution',
        shortName: 'execution',
        description:
            'The adversary is trying to run malicious code.',
        techniqueIds: ['T1059', 'T1203', 'T1559', 'T1106', 'T1053', 'T1129', 'T1072', 'T1569', 'T1204', 'T1047'],
      ),
      AttackTactic(
        id: 'TA0003',
        name: 'Persistence',
        shortName: 'persistence',
        description:
            'The adversary is trying to maintain their foothold.',
        techniqueIds: ['T1098', 'T1197', 'T1547', 'T1037', 'T1176', 'T1554', 'T1136', 'T1543', 'T1546', 'T1133', 'T1574', 'T1525', 'T1556', 'T1137', 'T1542', 'T1053', 'T1505', 'T1078'],
      ),
      AttackTactic(
        id: 'TA0004',
        name: 'Privilege Escalation',
        shortName: 'privilege-escalation',
        description:
            'The adversary is trying to gain higher-level permissions.',
        techniqueIds: ['T1548', 'T1134', 'T1547', 'T1037', 'T1543', 'T1484', 'T1611', 'T1574', 'T1055', 'T1053', 'T1078'],
      ),
      AttackTactic(
        id: 'TA0005',
        name: 'Defense Evasion',
        shortName: 'defense-evasion',
        description:
            'The adversary is trying to avoid being detected.',
        techniqueIds: ['T1548', 'T1134', 'T1197', 'T1622', 'T1140', 'T1006', 'T1484', 'T1480', 'T1211', 'T1222', 'T1564', 'T1574', 'T1562', 'T1070', 'T1202', 'T1036', 'T1556', 'T1578', 'T1112', 'T1601', 'T1599', 'T1027', 'T1055', 'T1207', 'T1014', 'T1218', 'T1216', 'T1553', 'T1221', 'T1205', 'T1127', 'T1535', 'T1550', 'T1078'],
      ),
      AttackTactic(
        id: 'TA0006',
        name: 'Credential Access',
        shortName: 'credential-access',
        description:
            'The adversary is trying to steal account names and passwords.',
        techniqueIds: ['T1110', 'T1555', 'T1212', 'T1187', 'T1606', 'T1056', 'T1557', 'T1556', 'T1111', 'T1621', 'T1040', 'T1003', 'T1528', 'T1558', 'T1539', 'T1649'],
      ),
      AttackTactic(
        id: 'TA0007',
        name: 'Discovery',
        shortName: 'discovery',
        description:
            'The adversary is trying to figure out your environment.',
        techniqueIds: ['T1087', 'T1010', 'T1217', 'T1580', 'T1538', 'T1526', 'T1619', 'T1613', 'T1622', 'T1652', 'T1083', 'T1615', 'T1046', 'T1135', 'T1040', 'T1201', 'T1120', 'T1069', 'T1057', 'T1012', 'T1018', 'T1518', 'T1082', 'T1016', 'T1049', 'T1033', 'T1007', 'T1124', 'T1497'],
      ),
      AttackTactic(
        id: 'TA0008',
        name: 'Lateral Movement',
        shortName: 'lateral-movement',
        description:
            'The adversary is trying to move through your environment.',
        techniqueIds: ['T1210', 'T1534', 'T1570', 'T1563', 'T1021', 'T1091', 'T1072', 'T1080', 'T1550'],
      ),
      AttackTactic(
        id: 'TA0009',
        name: 'Collection',
        shortName: 'collection',
        description:
            'The adversary is trying to gather data of interest to their goal.',
        techniqueIds: ['T1557', 'T1560', 'T1123', 'T1119', 'T1115', 'T1530', 'T1602', 'T1213', 'T1005', 'T1039', 'T1025', 'T1074', 'T1114', 'T1185', 'T1113', 'T1125'],
      ),
      AttackTactic(
        id: 'TA0011',
        name: 'Command and Control',
        shortName: 'command-and-control',
        description:
            'The adversary is trying to communicate with compromised systems to control them.',
        techniqueIds: ['T1071', 'T1092', 'T1132', 'T1001', 'T1568', 'T1573', 'T1008', 'T1105', 'T1104', 'T1095', 'T1571', 'T1572', 'T1090', 'T1219', 'T1205', 'T1102'],
      ),
      AttackTactic(
        id: 'TA0010',
        name: 'Exfiltration',
        shortName: 'exfiltration',
        description:
            'The adversary is trying to steal data.',
        techniqueIds: ['T1020', 'T1030', 'T1048', 'T1041', 'T1011', 'T1052', 'T1567', 'T1029', 'T1537'],
      ),
      AttackTactic(
        id: 'TA0040',
        name: 'Impact',
        shortName: 'impact',
        description:
            'The adversary is trying to manipulate, interrupt, or destroy your systems and data.',
        techniqueIds: ['T1531', 'T1485', 'T1486', 'T1565', 'T1491', 'T1561', 'T1499', 'T1495', 'T1490', 'T1498', 'T1496', 'T1489', 'T1529'],
      ),
    ];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TECHNIQUE DATASET  (110+ techniques — MITRE ATT&CK Enterprise v14)
  // Each entry includes: tactic(s), platforms, risk score, detection notes,
  // mitigation notes, and sub-techniques where applicable.
  // ─────────────────────────────────────────────────────────────────────────

  List<AttackTechnique> _buildTechniqueDataset() {
    return [

      // ── RECONNAISSANCE ──────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1595',
        name: 'Active Scanning',
        description: 'Adversaries may execute active reconnaissance scans to gather information about target hosts, IP blocks, and open services.',
        tactics: ['Reconnaissance'],
        platforms: ['PRE'],
        riskScore: 5.0,
        detectionNotes: ['Monitor for unusual network scanning activity', 'Detect port sweeps and service enumeration'],
        mitigationNotes: ['Pre-compromise mitigation; limit internet-facing exposure'],
        subTechniques: [
          AttackSubTechnique(id: 'T1595.001', name: 'Scanning IP Blocks', description: 'Adversaries may scan victim IP blocks to gather information for targeting.', riskScore: 4.5),
          AttackSubTechnique(id: 'T1595.002', name: 'Vulnerability Scanning', description: 'Adversaries may scan victims for vulnerabilities to use during targeting.', riskScore: 6.0),
          AttackSubTechnique(id: 'T1595.003', name: 'Wordlist Scanning', description: 'Adversaries may iteratively probe infrastructure using brute-forcing and crawling techniques.', riskScore: 5.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1592',
        name: 'Gather Victim Host Information',
        description: 'Adversaries may gather information about the victim\'s hosts that can be used during targeting.',
        tactics: ['Reconnaissance'],
        platforms: ['PRE'],
        riskScore: 4.5,
        detectionNotes: ['Pre-compromise; difficult to detect directly'],
        mitigationNotes: ['Limit public exposure of host/system details'],
        subTechniques: [
          AttackSubTechnique(id: 'T1592.001', name: 'Hardware', description: 'Adversaries may gather information about victim hardware.', riskScore: 4.0),
          AttackSubTechnique(id: 'T1592.002', name: 'Software', description: 'Adversaries may gather information about software on victim hosts.', riskScore: 4.5),
          AttackSubTechnique(id: 'T1592.004', name: 'Client Configurations', description: 'Adversaries may gather information about victim client configurations.', riskScore: 4.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1598',
        name: 'Phishing for Information',
        description: 'Adversaries may send phishing messages to elicit sensitive information that can be used during targeting.',
        tactics: ['Reconnaissance'],
        platforms: ['PRE'],
        riskScore: 6.5,
        detectionNotes: ['Monitor for suspicious email patterns', 'User reporting of suspicious messages'],
        mitigationNotes: ['Security awareness training', 'Email filtering'],
        subTechniques: [
          AttackSubTechnique(id: 'T1598.001', name: 'Spearphishing Service', description: 'Adversaries may send spearphishing messages via third-party services.', riskScore: 6.0),
          AttackSubTechnique(id: 'T1598.002', name: 'Spearphishing Attachment', description: 'Adversaries may send spearphishing messages with a malicious attachment.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1598.003', name: 'Spearphishing Link', description: 'Adversaries may send spearphishing messages with a malicious link.', riskScore: 6.5),
        ],
      ),

      // ── INITIAL ACCESS ───────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1566',
        name: 'Phishing',
        description: 'Adversaries may send phishing messages to gain access to victim systems. All forms of phishing are electronically delivered social engineering.',
        tactics: ['Initial Access'],
        platforms: ['Linux', 'macOS', 'Windows', 'Office Suite', 'SaaS'],
        riskScore: 8.5,
        detectionNotes: [
          'Monitor email for unusual sender domains',
          'Detect macro-enabled Office documents from external sources',
          'Anti-phishing email gateway alerts',
        ],
        mitigationNotes: [
          'User training (M1017)',
          'Antivirus/Antimalware (M1049)',
          'Email filtering — block executable attachments',
          'Multi-factor authentication to limit impact',
        ],
        subTechniques: [
          AttackSubTechnique(id: 'T1566.001', name: 'Spearphishing Attachment', description: 'Adversaries may send spearphishing emails with a malicious attachment to gain access.', platforms: ['Linux', 'macOS', 'Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1566.002', name: 'Spearphishing Link', description: 'Adversaries may send spearphishing emails with a malicious link to gain access.', platforms: ['Linux', 'macOS', 'Windows', 'Office Suite'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1566.003', name: 'Spearphishing via Service', description: 'Adversaries may send spearphishing messages via third-party services.', platforms: ['Linux', 'macOS', 'Windows'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1566.004', name: 'Spearphishing Voice', description: 'Adversaries may use voice communications to manipulate a victim into providing sensitive info.', platforms: ['Linux', 'macOS', 'Windows'], riskScore: 7.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1190',
        name: 'Exploit Public-Facing Application',
        description: 'Adversaries may attempt to take advantage of a weakness in an Internet-facing computer or program using software, data, or commands.',
        tactics: ['Initial Access'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network', 'Containers', 'IaaS'],
        riskScore: 9.2,
        detectionNotes: [
          'Monitor web application logs for unusual requests',
          'IDS/IPS signatures for known exploit patterns',
          'WAF alerts',
        ],
        mitigationNotes: [
          'Application isolation and sandboxing (M1048)',
          'Exploit protection (M1050)',
          'Privileged account management',
          'Regular patching and vulnerability management',
        ],
      ),
      const AttackTechnique(
        id: 'T1078',
        name: 'Valid Accounts',
        description: 'Adversaries may obtain and abuse credentials of existing accounts as a means of gaining Initial Access, Persistence, Privilege Escalation, or Defense Evasion.',
        tactics: ['Defense Evasion', 'Persistence', 'Privilege Escalation', 'Initial Access'],
        platforms: ['Windows', 'Azure AD', 'Office 365', 'SaaS', 'IaaS', 'Linux', 'macOS', 'Google Workspace', 'Containers', 'Network'],
        riskScore: 8.8,
        detectionNotes: [
          'Correlate logins from unusual geographies or times',
          'SIEM alerting on impossible travel',
          'Monitor for use of default or guest accounts',
        ],
        mitigationNotes: [
          'Multi-factor authentication (M1032)',
          'Privileged account management (M1026)',
          'Password policies',
          'Account use policies',
        ],
        subTechniques: [
          AttackSubTechnique(id: 'T1078.001', name: 'Default Accounts', description: 'Adversaries may obtain and abuse credentials of a default account.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1078.002', name: 'Domain Accounts', description: 'Adversaries may obtain and abuse credentials of domain accounts.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1078.003', name: 'Local Accounts', description: 'Adversaries may obtain and abuse credentials of a local account.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1078.004', name: 'Cloud Accounts', description: 'Adversaries may obtain and abuse credentials of cloud accounts.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1133',
        name: 'External Remote Services',
        description: 'Adversaries may leverage external-facing remote services to initially access and persist within a network.',
        tactics: ['Initial Access', 'Persistence'],
        platforms: ['Windows', 'Linux'],
        riskScore: 8.0,
        detectionNotes: ['Monitor VPN and RDP logs', 'Detect anomalous login times or sources'],
        mitigationNotes: ['Limit access to remote services', 'MFA for all remote access', 'Network segmentation'],
      ),
      const AttackTechnique(
        id: 'T1195',
        name: 'Supply Chain Compromise',
        description: 'Adversaries may manipulate products or product delivery mechanisms prior to receipt by a final consumer.',
        tactics: ['Initial Access'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 9.5,
        detectionNotes: ['Monitor for unexpected software updates', 'Software integrity checking'],
        mitigationNotes: ['Use trusted vendors', 'Validate software integrity with checksums', 'Code signing'],
        subTechniques: [
          AttackSubTechnique(id: 'T1195.001', name: 'Compromise Software Dependencies', description: 'Adversaries may manipulate software dependencies prior to distribution.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1195.002', name: 'Compromise Software Supply Chain', description: 'Adversaries may manipulate application software prior to delivery.', riskScore: 9.5),
          AttackSubTechnique(id: 'T1195.003', name: 'Compromise Hardware Supply Chain', description: 'Adversaries may manipulate hardware components to create backdoors.', riskScore: 9.8),
        ],
      ),
      const AttackTechnique(
        id: 'T1189',
        name: 'Drive-by Compromise',
        description: 'Adversaries may gain access to a system through a user visiting a website over the normal course of browsing.',
        tactics: ['Initial Access'],
        platforms: ['Windows', 'Linux', 'macOS', 'SaaS'],
        riskScore: 7.5,
        detectionNotes: ['Web proxy logs for unusual sites', 'Browser exploit detection'],
        mitigationNotes: ['Browser sandboxing', 'Exploit protection', 'Web filtering', 'Keep browsers patched'],
      ),

      // ── EXECUTION ────────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1059',
        name: 'Command and Scripting Interpreter',
        description: 'Adversaries may abuse command and script interpreters to execute commands, scripts, or binaries.',
        tactics: ['Execution'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network', 'IaaS', 'Office Suite', 'Azure AD'],
        riskScore: 8.8,
        detectionNotes: [
          'Monitor process execution logs for cmd.exe, powershell.exe, bash',
          'Script block logging in PowerShell',
          'Command-line argument analysis',
        ],
        mitigationNotes: [
          'Restrict execution of scripts via Group Policy',
          'Application control (M1038)',
          'Code signing',
          'Disable or restrict PowerShell where not needed',
        ],
        subTechniques: [
          AttackSubTechnique(id: 'T1059.001', name: 'PowerShell', description: 'Adversaries may abuse PowerShell commands and scripts.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1059.002', name: 'AppleScript', description: 'Adversaries may abuse AppleScript for execution on macOS.', platforms: ['macOS'], riskScore: 6.5),
          AttackSubTechnique(id: 'T1059.003', name: 'Windows Command Shell', description: 'Adversaries may abuse the Windows command shell for execution.', platforms: ['Windows'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1059.004', name: 'Unix Shell', description: 'Adversaries may abuse Unix shell commands and scripts.', platforms: ['Linux', 'macOS'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1059.005', name: 'Visual Basic', description: 'Adversaries may abuse VBScript for execution.', platforms: ['Windows', 'macOS', 'Linux'], riskScore: 7.0),
          AttackSubTechnique(id: 'T1059.006', name: 'Python', description: 'Adversaries may abuse Python commands and scripts.', platforms: ['Linux', 'Windows', 'macOS'], riskScore: 7.0),
          AttackSubTechnique(id: 'T1059.007', name: 'JavaScript', description: 'Adversaries may abuse JavaScript for execution.', platforms: ['Windows', 'macOS', 'Linux'], riskScore: 7.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1053',
        name: 'Scheduled Task/Job',
        description: 'Adversaries may abuse task scheduling functionality to facilitate initial or recurring execution of malicious code.',
        tactics: ['Execution', 'Persistence', 'Privilege Escalation'],
        platforms: ['Windows', 'Linux', 'macOS', 'Containers', 'IaaS'],
        riskScore: 7.8,
        detectionNotes: ['Monitor Task Scheduler events', 'Audit crontab and at jobs', 'Alert on unusual scheduled task creation'],
        mitigationNotes: ['Audit scheduled tasks regularly', 'Restrict task creation permissions', 'Operating system configuration hardening'],
        subTechniques: [
          AttackSubTechnique(id: 'T1053.002', name: 'At', description: 'Adversaries may abuse the at utility to perform task scheduling.', riskScore: 6.5),
          AttackSubTechnique(id: 'T1053.003', name: 'Cron', description: 'Adversaries may abuse the cron utility to perform task scheduling.', platforms: ['Linux', 'macOS'], riskScore: 7.0),
          AttackSubTechnique(id: 'T1053.005', name: 'Scheduled Task', description: 'Adversaries may abuse the Windows Task Scheduler to perform task scheduling.', platforms: ['Windows'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1053.007', name: 'Container Orchestration Job', description: 'Adversaries may abuse container orchestration job scheduling.', platforms: ['Containers'], riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1204',
        name: 'User Execution',
        description: 'An adversary may rely upon specific actions by a user in order to gain execution.',
        tactics: ['Execution'],
        platforms: ['Linux', 'macOS', 'Windows', 'IaaS', 'Containers'],
        riskScore: 7.5,
        detectionNotes: ['Monitor for unusual processes spawned from user actions', 'Email attachment execution monitoring'],
        mitigationNotes: ['User training', 'Application whitelisting', 'Restrict script execution'],
        subTechniques: [
          AttackSubTechnique(id: 'T1204.001', name: 'Malicious Link', description: 'User clicks on malicious link leading to execution.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1204.002', name: 'Malicious File', description: 'User opens malicious file leading to execution.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1204.003', name: 'Malicious Image', description: 'Adversaries may rely on a user running a malicious image.', riskScore: 7.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1047',
        name: 'Windows Management Instrumentation',
        description: 'Adversaries may abuse Windows Management Instrumentation (WMI) to execute malicious commands and payloads.',
        tactics: ['Execution'],
        platforms: ['Windows'],
        riskScore: 8.0,
        detectionNotes: ['Monitor WMI activity logs', 'Detect unusual WMI queries and event subscriptions'],
        mitigationNotes: ['Privileged account management', 'Disable WMI service if not needed', 'Network segmentation'],
      ),

      // ── PERSISTENCE ──────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1547',
        name: 'Boot or Logon Autostart Execution',
        description: 'Adversaries may configure system settings to automatically execute a program during system boot or logon.',
        tactics: ['Persistence', 'Privilege Escalation'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.8,
        detectionNotes: ['Monitor registry Run keys', 'Audit startup folder contents', 'Review /etc/rc.d, launchd plists'],
        mitigationNotes: ['Audit autostart locations regularly', 'Application control', 'User account management'],
        subTechniques: [
          AttackSubTechnique(id: 'T1547.001', name: 'Registry Run Keys / Startup Folder', description: 'Adding programs to registry run keys or startup folder for persistence.', platforms: ['Windows'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1547.004', name: 'Winlogon Helper DLL', description: 'Adversaries may abuse features of Winlogon to execute DLLs.', platforms: ['Windows'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1547.006', name: 'Kernel Modules and Extensions', description: 'Adversaries may modify the kernel to automatically execute programs on boot.', platforms: ['Linux', 'macOS'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1547.009', name: 'Shortcut Modification', description: 'Adversaries may create or modify shortcuts to run malicious code.', platforms: ['Windows', 'Linux', 'macOS'], riskScore: 6.5),
          AttackSubTechnique(id: 'T1547.011', name: 'Plist Modification', description: 'Adversaries may modify plist files to automatically run their malware.', platforms: ['macOS'], riskScore: 7.0),
          AttackSubTechnique(id: 'T1547.015', name: 'Login Items', description: 'Adversaries may add login items to macOS to achieve persistence.', platforms: ['macOS'], riskScore: 7.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1136',
        name: 'Create Account',
        description: 'Adversaries may create an account to maintain access to victim systems.',
        tactics: ['Persistence'],
        platforms: ['Windows', 'Azure AD', 'Office 365', 'SaaS', 'IaaS', 'Linux', 'macOS', 'Network', 'Containers', 'Google Workspace'],
        riskScore: 7.5,
        detectionNotes: ['Alert on new account creation events', 'Monitor for accounts created outside normal provisioning'],
        mitigationNotes: ['Privileged account management', 'Operating system configuration', 'Network segmentation'],
        subTechniques: [
          AttackSubTechnique(id: 'T1136.001', name: 'Local Account', description: 'Creating a local account for persistence.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1136.002', name: 'Domain Account', description: 'Creating a domain account for persistence.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1136.003', name: 'Cloud Account', description: 'Creating a cloud account for persistence.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1505',
        name: 'Server Software Component',
        description: 'Adversaries may abuse legitimate extensible development features of servers to establish persistent access.',
        tactics: ['Persistence'],
        platforms: ['Windows', 'Linux', 'macOS', 'Network'],
        riskScore: 8.5,
        detectionNotes: ['Monitor for new web shell files on servers', 'Detect suspicious IIS modules', 'File integrity monitoring'],
        mitigationNotes: ['Privileged account management', 'Disable or remove web shells', 'Application vetting'],
        subTechniques: [
          AttackSubTechnique(id: 'T1505.001', name: 'SQL Stored Procedures', description: 'Adversaries may abuse SQL stored procedures for persistence.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1505.003', name: 'Web Shell', description: 'Adversaries may backdoor web servers with web shells for persistent access.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1505.004', name: 'IIS Components', description: 'Adversaries may install malicious components for IIS web server.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1505.005', name: 'Terminal Services DLL', description: 'Adversaries may abuse components of Terminal Services to enable persistent access.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1543',
        name: 'Create or Modify System Process',
        description: 'Adversaries may create or modify system-level processes to repeatedly execute malicious payloads.',
        tactics: ['Persistence', 'Privilege Escalation'],
        platforms: ['Windows', 'macOS', 'Linux', 'Containers'],
        riskScore: 8.0,
        detectionNotes: ['Monitor service creation and modification events', 'Detect unusual launchd jobs', 'Audit systemd units'],
        mitigationNotes: ['Operating system configuration hardening', 'Privileged account management', 'Code signing'],
        subTechniques: [
          AttackSubTechnique(id: 'T1543.001', name: 'Launch Agent', description: 'Adversaries may create or modify launch agents on macOS.', platforms: ['macOS'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1543.002', name: 'Systemd Service', description: 'Adversaries may create or modify systemd services on Linux.', platforms: ['Linux'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1543.003', name: 'Windows Service', description: 'Adversaries may create or modify Windows services for persistence.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1543.004', name: 'Launch Daemon', description: 'Adversaries may create or modify launch daemons on macOS.', platforms: ['macOS'], riskScore: 8.0),
        ],
      ),

      // ── PRIVILEGE ESCALATION ─────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1548',
        name: 'Abuse Elevation Control Mechanism',
        description: 'Adversaries may circumvent mechanisms designed to control elevated privileges to gain higher-level permissions.',
        tactics: ['Privilege Escalation', 'Defense Evasion'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 8.2,
        detectionNotes: ['Monitor UAC bypass attempts', 'Audit sudo usage logs on Linux/macOS', 'Detect setuid/setgid abuse'],
        mitigationNotes: ['User account control configuration', 'Privileged account management', 'Audit policies'],
        subTechniques: [
          AttackSubTechnique(id: 'T1548.001', name: 'Setuid and Setgid', description: 'An adversary may perform shell escapes or exploit vulnerabilities in setuid/setgid binaries.', platforms: ['Linux', 'macOS'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1548.002', name: 'Bypass User Account Control', description: 'Adversaries may bypass UAC mechanisms to elevate process privileges.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1548.003', name: 'Sudo and Sudo Caching', description: 'Adversaries may perform sudo caching and/or use the sudoers file to elevate privileges.', platforms: ['Linux', 'macOS'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1548.004', name: 'Elevated Execution with Prompt', description: 'Adversaries may leverage the AuthorizationExecuteWithPrivileges API to escalate privileges.', platforms: ['macOS'], riskScore: 7.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1134',
        name: 'Access Token Manipulation',
        description: 'Adversaries may modify access tokens to operate under a different user or system security context.',
        tactics: ['Defense Evasion', 'Privilege Escalation'],
        platforms: ['Windows'],
        riskScore: 8.5,
        detectionNotes: ['Monitor token manipulation API calls', 'Detect unusual process privilege changes'],
        mitigationNotes: ['Privileged account management', 'User account control'],
        subTechniques: [
          AttackSubTechnique(id: 'T1134.001', name: 'Token Impersonation/Theft', description: 'Adversaries may duplicate then impersonate another user\'s existing token.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1134.002', name: 'Create Process with Token', description: 'Adversaries may create a new process with an existing token.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1134.003', name: 'Make and Impersonate Token', description: 'Adversaries may make new tokens if they know credentials of a user.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1134.004', name: 'Parent PID Spoofing', description: 'Adversaries may spoof the parent process identifier (PPID) of a new process.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1134.005', name: 'SID-History Injection', description: 'Adversaries may use SID-History injection to escalate privileges.', riskScore: 8.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1055',
        name: 'Process Injection',
        description: 'Adversaries may inject code into processes in order to evade process-based defenses and possibly elevate privileges.',
        tactics: ['Defense Evasion', 'Privilege Escalation'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 9.0,
        detectionNotes: ['Monitor for process hollowing indicators', 'Detect unusual memory writes to other processes', 'EDR process injection alerts'],
        mitigationNotes: ['Behavior prevention on endpoint', 'Privileged account management'],
        subTechniques: [
          AttackSubTechnique(id: 'T1055.001', name: 'Dynamic-link Library Injection', description: 'Adversaries may inject DLLs into running processes.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1055.002', name: 'Portable Executable Injection', description: 'Adversaries may inject portable executables into running processes.', platforms: ['Windows'], riskScore: 9.0),
          AttackSubTechnique(id: 'T1055.003', name: 'Thread Execution Hijacking', description: 'Adversaries may inject malicious code into hijacked processes.', platforms: ['Windows'], riskScore: 9.0),
          AttackSubTechnique(id: 'T1055.009', name: 'Proc Memory', description: 'Adversaries may inject malicious code into processes via the /proc filesystem.', platforms: ['Linux'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1055.012', name: 'Process Hollowing', description: 'Adversaries may inject malicious code into suspended and hollowed processes.', platforms: ['Windows'], riskScore: 9.0),
        ],
      ),

      // ── DEFENSE EVASION ──────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1027',
        name: 'Obfuscated Files or Information',
        description: 'Adversaries may attempt to make an executable or file difficult to discover or analyze by encrypting, encoding, or otherwise obfuscating its contents.',
        tactics: ['Defense Evasion'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.5,
        detectionNotes: ['Static and dynamic malware analysis', 'Entropy analysis on suspicious files', 'Script deobfuscation'],
        mitigationNotes: ['Antivirus/antimalware', 'Behavior-based detection', 'Application control'],
        subTechniques: [
          AttackSubTechnique(id: 'T1027.001', name: 'Binary Padding', description: 'Adversaries may use binary padding to add junk data to payloads.', riskScore: 6.0),
          AttackSubTechnique(id: 'T1027.002', name: 'Software Packing', description: 'Adversaries may pack or encrypt payloads to obfuscate them.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1027.004', name: 'Compile After Delivery', description: 'Adversaries may attempt to make payloads difficult to discover by delivering them uncompiled.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1027.005', name: 'Indicator Removal from Tools', description: 'Adversaries may remove indicators from tools to avoid detection.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1027.010', name: 'Command Obfuscation', description: 'Adversaries may obfuscate content during command execution.', riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1562',
        name: 'Impair Defenses',
        description: 'Adversaries may maliciously modify components of a victim environment in order to hinder or disable defensive mechanisms.',
        tactics: ['Defense Evasion'],
        platforms: ['Windows', 'macOS', 'Linux', 'Containers', 'IaaS', 'Network', 'Office Suite'],
        riskScore: 9.0,
        detectionNotes: ['Monitor for AV/EDR process termination', 'Alert on firewall rule changes', 'Audit logging configuration changes'],
        mitigationNotes: ['Restrict access to security tools', 'User account control', 'Software configuration hardening'],
        subTechniques: [
          AttackSubTechnique(id: 'T1562.001', name: 'Disable or Modify Tools', description: 'Adversaries may disable security tools to evade detection.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1562.002', name: 'Disable Windows Event Logging', description: 'Adversaries may disable Windows event logging to limit collection.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1562.004', name: 'Disable or Modify System Firewall', description: 'Adversaries may disable or modify the system firewall.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1562.006', name: 'Indicator Blocking', description: 'An adversary may attempt to block indicators or events from being collected.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1562.008', name: 'Disable or Modify Cloud Logs', description: 'Adversaries may disable or modify cloud logging to evade detection.', platforms: ['IaaS', 'Azure AD', 'Google Workspace'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1562.009', name: 'Safe Mode Boot', description: 'Adversaries may abuse Windows safe mode to disable endpoint defenses.', platforms: ['Windows'], riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1036',
        name: 'Masquerading',
        description: 'Adversaries may attempt to manipulate features of their artifacts to make them appear legitimate or benign.',
        tactics: ['Defense Evasion'],
        platforms: ['Linux', 'macOS', 'Windows', 'Containers'],
        riskScore: 7.5,
        detectionNotes: ['Monitor process names vs. binary paths', 'Detect file extension mismatches', 'Hash-based file validation'],
        mitigationNotes: ['Code signing', 'Execution prevention', 'Restrict file and directory permissions'],
        subTechniques: [
          AttackSubTechnique(id: 'T1036.001', name: 'Invalid Code Signature', description: 'Adversaries may attempt to mimic features of valid code signatures.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1036.003', name: 'Rename System Utilities', description: 'Adversaries may rename legitimate system utilities to try to evade detection.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1036.004', name: 'Masquerade Task or Service', description: 'Adversaries may attempt to manipulate the name of a task or service to make it appear legitimate.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1036.005', name: 'Match Legitimate Name or Location', description: 'Adversaries may match or approximate the name or location of legitimate files.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1036.007', name: 'Double File Extension', description: 'Adversaries may abuse a double extension in the filename as a means of masquerading the true file type.', riskScore: 6.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1070',
        name: 'Indicator Removal',
        description: 'Adversaries may delete or modify artifacts generated within systems to remove evidence of their presence.',
        tactics: ['Defense Evasion'],
        platforms: ['Linux', 'macOS', 'Windows', 'Containers', 'Network', 'Office Suite'],
        riskScore: 8.0,
        detectionNotes: ['Monitor log deletion events', 'File integrity monitoring', 'SIEM retention policies'],
        mitigationNotes: ['Remote data storage for logs', 'Encrypt and restrict log access', 'Forensic artifact retention'],
        subTechniques: [
          AttackSubTechnique(id: 'T1070.001', name: 'Clear Windows Event Logs', description: 'Adversaries may clear Windows Event Logs to hide activity.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1070.002', name: 'Clear Linux or Mac System Logs', description: 'Adversaries may clear Linux or macOS system logs.', platforms: ['Linux', 'macOS'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1070.003', name: 'Clear Command History', description: 'Adversaries may clear command history to hide their actions.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1070.004', name: 'File Deletion', description: 'Adversaries may delete files left behind after intrusion.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1070.006', name: 'Timestomp', description: 'Adversaries may modify file time attributes to hide new or changes to existing files.', riskScore: 7.0),
        ],
      ),

      // ── CREDENTIAL ACCESS ────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1003',
        name: 'OS Credential Dumping',
        description: 'Adversaries may attempt to dump credentials to obtain account login and credential material.',
        tactics: ['Credential Access'],
        platforms: ['Windows', 'Linux', 'macOS'],
        riskScore: 9.5,
        detectionNotes: [
          'Monitor LSASS access events',
          'Alert on use of tools like Mimikatz, ProcDump against lsass.exe',
          'Detect SAM/NTDS.dit access',
        ],
        mitigationNotes: [
          'Credential Guard (Windows 10+)',
          'Privileged account management',
          'Protected users group',
          'LSASS audit policies',
        ],
        subTechniques: [
          AttackSubTechnique(id: 'T1003.001', name: 'LSASS Memory', description: 'Adversaries may attempt to access credential material stored in LSASS.', platforms: ['Windows'], riskScore: 9.5),
          AttackSubTechnique(id: 'T1003.002', name: 'Security Account Manager', description: 'Adversaries may attempt to extract credential material from the SAM database.', platforms: ['Windows'], riskScore: 9.0),
          AttackSubTechnique(id: 'T1003.003', name: 'NTDS', description: 'Adversaries may attempt to access or create a copy of the Active Directory domain database.', platforms: ['Windows'], riskScore: 9.8),
          AttackSubTechnique(id: 'T1003.004', name: 'LSA Secrets', description: 'Adversaries with SYSTEM access may attempt to access LSA secrets.', platforms: ['Windows'], riskScore: 9.0),
          AttackSubTechnique(id: 'T1003.007', name: 'Proc Filesystem', description: 'Adversaries may gather credentials from information stored in the /proc filesystem.', platforms: ['Linux'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1003.008', name: '/etc/passwd and /etc/shadow', description: 'Adversaries may attempt to dump the contents of /etc/passwd and /etc/shadow.', platforms: ['Linux'], riskScore: 9.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1110',
        name: 'Brute Force',
        description: 'Adversaries may use brute force techniques to gain access to accounts when passwords are unknown or obtained through hash dumping.',
        tactics: ['Credential Access'],
        platforms: ['Windows', 'Azure AD', 'Office 365', 'SaaS', 'IaaS', 'Linux', 'macOS', 'Google Workspace', 'Containers', 'Network'],
        riskScore: 8.0,
        detectionNotes: ['Monitor failed login attempts', 'Account lockout alerting', 'Detect credential stuffing patterns'],
        mitigationNotes: ['Account lockout policies', 'Multi-factor authentication', 'Password strength requirements'],
        subTechniques: [
          AttackSubTechnique(id: 'T1110.001', name: 'Password Guessing', description: 'Adversaries may try a number of common passwords to gain access.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1110.002', name: 'Password Cracking', description: 'Adversaries may use offline password cracking to decrypt hashed credentials.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1110.003', name: 'Password Spraying', description: 'Adversaries may use a single common password against many accounts.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1110.004', name: 'Credential Stuffing', description: 'Adversaries may use credentials obtained from breach dumps.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1556',
        name: 'Modify Authentication Process',
        description: 'Adversaries may modify authentication mechanisms and processes to access user credentials or enable otherwise unwarranted access to accounts.',
        tactics: ['Credential Access', 'Defense Evasion', 'Persistence'],
        platforms: ['Windows', 'Linux', 'macOS', 'Network', 'IaaS', 'Azure AD', 'Google Workspace'],
        riskScore: 9.0,
        detectionNotes: ['Monitor for changes to authentication modules', 'Audit PAM configuration changes', 'Track registry modifications to authentication providers'],
        mitigationNotes: ['Multi-factor authentication', 'Privileged account management', 'Audit policies'],
        subTechniques: [
          AttackSubTechnique(id: 'T1556.001', name: 'Domain Controller Authentication', description: 'Adversaries may patch the authentication process on a domain controller.', platforms: ['Windows'], riskScore: 9.5),
          AttackSubTechnique(id: 'T1556.002', name: 'Password Filter DLL', description: 'Adversaries may register malicious password filter DLLs.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1556.003', name: 'Pluggable Authentication Modules', description: 'Adversaries may modify PAM to achieve credential access.', platforms: ['Linux', 'macOS'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1556.004', name: 'Network Device Authentication', description: 'Adversaries may use patch system images to hard-code a password.', platforms: ['Network'], riskScore: 9.0),
          AttackSubTechnique(id: 'T1556.006', name: 'Multi-Factor Authentication', description: 'Adversaries may disable or modify MFA mechanisms.', riskScore: 9.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1558',
        name: 'Steal or Forge Kerberos Tickets',
        description: 'Adversaries may attempt to subvert Kerberos authentication by stealing or forging Kerberos tickets.',
        tactics: ['Credential Access'],
        platforms: ['Windows'],
        riskScore: 9.3,
        detectionNotes: ['Monitor for abnormal Kerberos ticket requests', 'Detect Golden/Silver ticket usage', 'AS-REP roasting detection'],
        mitigationNotes: ['Privileged account management', 'Encrypt/protect sensitive accounts', 'AES encryption for Kerberos'],
        subTechniques: [
          AttackSubTechnique(id: 'T1558.001', name: 'Golden Ticket', description: 'Adversaries may forge Kerberos ticket-granting tickets (TGT) using the KRBTGT account NTLM hash.', riskScore: 9.8),
          AttackSubTechnique(id: 'T1558.002', name: 'Silver Ticket', description: 'Adversaries may forge Kerberos ticket granting service tickets.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1558.003', name: 'Kerberoasting', description: 'Adversaries may abuse valid Kerberos tickets to obtain service account credential material.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1558.004', name: 'AS-REP Roasting', description: 'Adversaries may reveal credentials of accounts that have disabled Kerberos preauthentication.', riskScore: 8.0),
        ],
      ),

      // ── DISCOVERY ────────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1082',
        name: 'System Information Discovery',
        description: 'An adversary may attempt to get detailed information about the operating system and hardware.',
        tactics: ['Discovery'],
        platforms: ['Windows', 'IaaS', 'Linux', 'macOS', 'Network'],
        riskScore: 5.5,
        detectionNotes: ['Monitor system commands like systeminfo, uname', 'Audit WMI queries for system info'],
        mitigationNotes: ['Operating system configuration', 'Limit information returned from queries'],
      ),
      const AttackTechnique(
        id: 'T1083',
        name: 'File and Directory Discovery',
        description: 'Adversaries may enumerate files and directories or may search in specific locations of a host for certain information.',
        tactics: ['Discovery'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 5.0,
        detectionNotes: ['Monitor for mass file enumeration', 'File access audit logs'],
        mitigationNotes: ['Restrict file permissions', 'Least privilege access'],
      ),
      const AttackTechnique(
        id: 'T1046',
        name: 'Network Service Discovery',
        description: 'Adversaries may attempt to get a listing of services running on remote hosts and local network infrastructure.',
        tactics: ['Discovery'],
        platforms: ['Windows', 'IaaS', 'Linux', 'macOS', 'Containers', 'Network'],
        riskScore: 6.5,
        detectionNotes: ['Detect port scanning activity', 'Network traffic anomaly detection'],
        mitigationNotes: ['Network segmentation', 'Firewall rules to limit scanning', 'Disable unnecessary services'],
      ),
      const AttackTechnique(
        id: 'T1087',
        name: 'Account Discovery',
        description: 'Adversaries may attempt to get a listing of accounts on a system or within an environment.',
        tactics: ['Discovery'],
        platforms: ['Windows', 'Azure AD', 'Office 365', 'SaaS', 'IaaS', 'Linux', 'macOS', 'Google Workspace'],
        riskScore: 6.0,
        detectionNotes: ['Monitor for commands like net user, id, getent passwd', 'LDAP query monitoring'],
        mitigationNotes: ['Restrict directory service access', 'Least privilege principle'],
        subTechniques: [
          AttackSubTechnique(id: 'T1087.001', name: 'Local Account', description: 'Adversaries may attempt to get a listing of local system accounts.', riskScore: 5.5),
          AttackSubTechnique(id: 'T1087.002', name: 'Domain Account', description: 'Adversaries may attempt to get a listing of domain accounts.', riskScore: 6.5),
          AttackSubTechnique(id: 'T1087.003', name: 'Email Account', description: 'Adversaries may attempt to get a listing of email accounts.', riskScore: 6.0),
          AttackSubTechnique(id: 'T1087.004', name: 'Cloud Account', description: 'Adversaries may attempt to get a listing of cloud accounts.', riskScore: 6.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1018',
        name: 'Remote System Discovery',
        description: 'Adversaries may attempt to get a listing of other systems by IP address, hostname, or other logical identifier on a network.',
        tactics: ['Discovery'],
        platforms: ['Windows', 'IaaS', 'Linux', 'macOS'],
        riskScore: 6.0,
        detectionNotes: ['Monitor for ping sweeps and ARP scans', 'Detect use of net view, arp -a'],
        mitigationNotes: ['Network segmentation', 'Firewall rules', 'Disable NBNS/LLMNR'],
      ),
      const AttackTechnique(
        id: 'T1057',
        name: 'Process Discovery',
        description: 'Adversaries may attempt to get information about running processes on a system.',
        tactics: ['Discovery'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 5.5,
        detectionNotes: ['Monitor tasklist, ps commands', 'Detect automated process enumeration'],
        mitigationNotes: ['Endpoint detection and response', 'Limit information returned'],
      ),

      // ── LATERAL MOVEMENT ─────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1021',
        name: 'Remote Services',
        description: 'Adversaries may use valid accounts to log into a service specifically designed to accept remote connections.',
        tactics: ['Lateral Movement'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 8.5,
        detectionNotes: ['Monitor RDP login events', 'Alert on unusual SSH authentication', 'Review VNC connections'],
        mitigationNotes: ['Multi-factor authentication', 'Network segmentation', 'Disable unnecessary services'],
        subTechniques: [
          AttackSubTechnique(id: 'T1021.001', name: 'Remote Desktop Protocol', description: 'Adversaries may use Valid Accounts to log into a computer using RDP.', platforms: ['Windows'], riskScore: 8.5),
          AttackSubTechnique(id: 'T1021.002', name: 'SMB/Windows Admin Shares', description: 'Adversaries may use Valid Accounts to interact with a remote network share using Server Message Block.', platforms: ['Windows'], riskScore: 8.0),
          AttackSubTechnique(id: 'T1021.003', name: 'Distributed Component Object Model', description: 'Adversaries may use DCOM for lateral movement.', platforms: ['Windows'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1021.004', name: 'SSH', description: 'Adversaries may use Valid Accounts to log into remote machines using Secure Shell.', platforms: ['Linux', 'macOS'], riskScore: 7.5),
          AttackSubTechnique(id: 'T1021.005', name: 'VNC', description: 'Adversaries may use Valid Accounts to remotely control machines using VNC.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1021.006', name: 'Windows Remote Management', description: 'Adversaries may use Valid Accounts to interact with remote systems using Windows Remote Management.', platforms: ['Windows'], riskScore: 8.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1210',
        name: 'Exploitation of Remote Services',
        description: 'Adversaries may exploit remote services to gain unauthorized access to internal systems once inside of a network.',
        tactics: ['Lateral Movement'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 9.0,
        detectionNotes: ['Monitor network for exploit signatures', 'IDS/IPS rules for known vulnerabilities', 'Alert on unusual inter-host connections'],
        mitigationNotes: ['Disable or remove vulnerable services', 'Network segmentation', 'Patch management'],
      ),
      const AttackTechnique(
        id: 'T1550',
        name: 'Use Alternate Authentication Material',
        description: 'Adversaries may use alternate authentication material, such as password hashes, Kerberos tickets, to move laterally.',
        tactics: ['Defense Evasion', 'Lateral Movement'],
        platforms: ['Windows', 'Office 365', 'SaaS', 'IaaS', 'Azure AD', 'Google Workspace'],
        riskScore: 9.0,
        detectionNotes: ['Detect Pass-the-Hash activity', 'Monitor for unusual Kerberos ticket usage', 'Alert on web session cookie reuse from unusual sources'],
        mitigationNotes: ['Privileged account management', 'MFA', 'Credential Guard', 'Update password hashes regularly'],
        subTechniques: [
          AttackSubTechnique(id: 'T1550.001', name: 'Application Access Token', description: 'Adversaries may use stolen application access tokens to bypass authentication.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1550.002', name: 'Pass the Hash', description: 'Adversaries may "pass the hash" using stolen password hashes to move laterally.', platforms: ['Windows'], riskScore: 9.5),
          AttackSubTechnique(id: 'T1550.003', name: 'Pass the Ticket', description: 'Adversaries may "pass the ticket" using stolen Kerberos tickets to move laterally.', platforms: ['Windows'], riskScore: 9.5),
          AttackSubTechnique(id: 'T1550.004', name: 'Web Session Cookie', description: 'Adversaries can use stolen session cookies to authenticate to web applications.', riskScore: 8.5),
        ],
      ),

      // ── COLLECTION ───────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1560',
        name: 'Archive Collected Data',
        description: 'An adversary may compress and/or encrypt data that is collected prior to exfiltration.',
        tactics: ['Collection'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.0,
        detectionNotes: ['Monitor for unusual use of zip, tar, rar', 'Detect large archive file creation', 'Data volume anomaly detection'],
        mitigationNotes: ['DLP controls', 'Audit access to compression tools', 'Restrict archiving utilities'],
        subTechniques: [
          AttackSubTechnique(id: 'T1560.001', name: 'Archive via Utility', description: 'Adversaries may use utilities such as zip/rar to compress data.', riskScore: 6.5),
          AttackSubTechnique(id: 'T1560.002', name: 'Archive via Library', description: 'Adversaries may compress or encrypt data using custom or third-party libraries.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1560.003', name: 'Archive via Custom Method', description: 'Adversaries may compress or encrypt interally developed tools.', riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1113',
        name: 'Screen Capture',
        description: 'Adversaries may attempt to take screen captures of the desktop to gather information over the course of an operation.',
        tactics: ['Collection'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 6.5,
        detectionNotes: ['Monitor screenshot API calls', 'Detect tools like Screenshot, scrot'],
        mitigationNotes: ['Endpoint detection and response', 'Behavior-based detection'],
      ),
      const AttackTechnique(
        id: 'T1056',
        name: 'Input Capture',
        description: 'Adversaries may use methods of capturing user input to obtain credentials or collect information.',
        tactics: ['Collection', 'Credential Access'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network'],
        riskScore: 8.5,
        detectionNotes: ['Monitor for keylogging drivers', 'Detect unusual API hooks', 'EDR behavioral detection'],
        mitigationNotes: ['Antivirus/antimalware', 'Privileged account management', 'Credential managers'],
        subTechniques: [
          AttackSubTechnique(id: 'T1056.001', name: 'Keylogging', description: 'Adversaries may log user keystrokes to intercept credentials or other information.', riskScore: 9.0),
          AttackSubTechnique(id: 'T1056.002', name: 'GUI Input Capture', description: 'Adversaries may mimic common operating system GUI components to prompt users for credentials.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1056.003', name: 'Web Portal Capture', description: 'Adversaries may install code on externally facing portals to capture credentials.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1056.004', name: 'Credential API Hooking', description: 'Adversaries may hook into Windows API functions to collect user credentials.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1114',
        name: 'Email Collection',
        description: 'Adversaries may target user email to collect sensitive information.',
        tactics: ['Collection'],
        platforms: ['Windows', 'Office 365', 'Google Workspace'],
        riskScore: 7.5,
        detectionNotes: ['Monitor for unusual email exports', 'Detect Mail forwarding rule creation', 'OAuth permission reviews'],
        mitigationNotes: ['Encrypt sensitive email content', 'MFA', 'Restrict email forwarding policies'],
        subTechniques: [
          AttackSubTechnique(id: 'T1114.001', name: 'Local Email Collection', description: 'Adversaries may target user email on local systems.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1114.002', name: 'Remote Email Collection', description: 'Adversaries may target an Exchange server or Office 365 to collect email.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1114.003', name: 'Email Forwarding Rule', description: 'Adversaries may setup email forwarding rules to collect sensitive data.', riskScore: 7.5),
        ],
      ),

      // ── COMMAND AND CONTROL ──────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1071',
        name: 'Application Layer Protocol',
        description: 'Adversaries may communicate using OSI application layer protocols to avoid detection/network filtering.',
        tactics: ['Command and Control'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network'],
        riskScore: 7.0,
        detectionNotes: ['Monitor for unusual HTTP/HTTPS traffic patterns', 'DNS query frequency analysis', 'Detect beaconing behavior'],
        mitigationNotes: ['Network intrusion prevention', 'SSL/TLS inspection', 'DNS filtering'],
        subTechniques: [
          AttackSubTechnique(id: 'T1071.001', name: 'Web Protocols', description: 'Adversaries may communicate using application layer protocols associated with web traffic (HTTP/HTTPS).', riskScore: 7.5),
          AttackSubTechnique(id: 'T1071.002', name: 'File Transfer Protocols', description: 'Adversaries may communicate using FTP or SFTP for C2.', riskScore: 6.5),
          AttackSubTechnique(id: 'T1071.003', name: 'Mail Protocols', description: 'Adversaries may communicate using email protocols (SMTP, IMAP, POP3) for C2.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1071.004', name: 'DNS', description: 'Adversaries may communicate using DNS to encapsulate commands/responses.', riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1573',
        name: 'Encrypted Channel',
        description: 'Adversaries may employ a known encryption algorithm to conceal command and control traffic.',
        tactics: ['Command and Control'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network'],
        riskScore: 7.5,
        detectionNotes: ['SSL/TLS inspection', 'Traffic volume anomaly detection', 'Detect non-standard port usage with TLS'],
        mitigationNotes: ['SSL/TLS inspection at network boundary', 'Network traffic analysis'],
        subTechniques: [
          AttackSubTechnique(id: 'T1573.001', name: 'Symmetric Cryptography', description: 'Adversaries may employ symmetric encryption to conceal C2 traffic.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1573.002', name: 'Asymmetric Cryptography', description: 'Adversaries may employ asymmetric encryption to conceal C2 traffic.', riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1105',
        name: 'Ingress Tool Transfer',
        description: 'Adversaries may transfer tools or other files from an external system into a compromised environment.',
        tactics: ['Command and Control'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.0,
        detectionNotes: ['Monitor for downloads from unusual sources', 'Web proxy logs for tool downloads', 'Detect curl/wget/certutil usage for downloading executables'],
        mitigationNotes: ['Network intrusion prevention', 'Application control', 'Restrict internet access for servers'],
      ),
      const AttackTechnique(
        id: 'T1572',
        name: 'Protocol Tunneling',
        description: 'Adversaries may tunnel network communications to and from a victim system within a separate protocol to avoid detection.',
        tactics: ['Command and Control'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 7.5,
        detectionNotes: ['Detect DNS tunneling via anomaly analysis', 'Monitor for unusual SSH usage', 'Network traffic analysis for tunneled protocols'],
        mitigationNotes: ['Network intrusion prevention', 'Filter traffic to allowed services only', 'DNS filtering'],
      ),

      // ── EXFILTRATION ─────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1041',
        name: 'Exfiltration Over C2 Channel',
        description: 'Adversaries may steal data by exfiltrating it over an existing command and control channel.',
        tactics: ['Exfiltration'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 8.0,
        detectionNotes: ['Monitor C2 traffic volume anomalies', 'Data loss prevention alerts', 'Detect large outbound data flows'],
        mitigationNotes: ['DLP controls', 'Network traffic analysis', 'Data encryption in transit'],
      ),
      const AttackTechnique(
        id: 'T1048',
        name: 'Exfiltration Over Alternative Protocol',
        description: 'Adversaries may steal data by exfiltrating it over a different protocol than that of the existing command and control channel.',
        tactics: ['Exfiltration'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network'],
        riskScore: 8.5,
        detectionNotes: ['Monitor for unusual DNS query sizes (DNS exfil)', 'Detect ICMP data exfiltration', 'Email attachment monitoring'],
        mitigationNotes: ['Network filtering', 'DLP controls', 'DNS monitoring and filtering'],
        subTechniques: [
          AttackSubTechnique(id: 'T1048.001', name: 'Exfiltration Over Symmetric Encrypted Non-C2 Protocol', description: 'Adversaries may steal data by exfiltrating it over a symmetrically encrypted network protocol.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1048.002', name: 'Exfiltration Over Asymmetric Encrypted Non-C2 Protocol', description: 'Adversaries may steal data by exfiltrating over asymmetrically encrypted protocols.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1048.003', name: 'Exfiltration Over Unencrypted Non-C2 Protocol', description: 'Adversaries may steal data by exfiltrating it over a cleartext protocol.', riskScore: 8.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1567',
        name: 'Exfiltration Over Web Service',
        description: 'Adversaries may use an existing, legitimate external Web service to exfiltrate data.',
        tactics: ['Exfiltration'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 8.0,
        detectionNotes: ['Monitor uploads to cloud storage (Drive, Dropbox, etc.)', 'DLP controls for cloud services', 'User behavior analytics'],
        mitigationNotes: ['Restrict web service access', 'Proxy controls', 'DLP policies'],
        subTechniques: [
          AttackSubTechnique(id: 'T1567.001', name: 'Exfiltration to Code Repository', description: 'Adversaries may exfiltrate data to a code repository.', riskScore: 7.5),
          AttackSubTechnique(id: 'T1567.002', name: 'Exfiltration to Cloud Storage', description: 'Adversaries may exfiltrate data to a cloud storage service.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1567.003', name: 'Exfiltration to Text Storage Sites', description: 'Adversaries may exfiltrate data to text storage sites such as Pastebin.', riskScore: 7.0),
          AttackSubTechnique(id: 'T1567.004', name: 'Exfiltration Over Webhook', description: 'Adversaries may exfiltrate data via webhook endpoints.', riskScore: 7.5),
        ],
      ),

      // ── IMPACT ───────────────────────────────────────────────────────────
      const AttackTechnique(
        id: 'T1486',
        name: 'Data Encrypted for Impact',
        description: 'Adversaries may encrypt data on target systems or on large numbers of systems in a network to interrupt availability to system and network resources.',
        tactics: ['Impact'],
        platforms: ['Linux', 'macOS', 'Windows', 'IaaS'],
        riskScore: 9.8,
        detectionNotes: [
          'Monitor for mass file encryption activity',
          'Shadow copy deletion events',
          'Ransomware behavioral indicators',
          'File extension mass changes',
        ],
        mitigationNotes: [
          'Data backups (offline and immutable)',
          'User account management',
          'Behavior prevention on endpoint',
          'Restrict admin access',
        ],
      ),
      const AttackTechnique(
        id: 'T1490',
        name: 'Inhibit System Recovery',
        description: 'Adversaries may delete or remove built-in operating system data and turn off services designed to aid in the recovery of a corrupted system.',
        tactics: ['Impact'],
        platforms: ['Windows', 'macOS', 'Linux', 'Network'],
        riskScore: 9.5,
        detectionNotes: ['Monitor for vssadmin delete shadows', 'Detect backup deletion commands', 'Alert on recovery service disabling'],
        mitigationNotes: ['Immutable backups', 'Privileged account management', 'Restrict vssadmin access'],
      ),
      const AttackTechnique(
        id: 'T1499',
        name: 'Endpoint Denial of Service',
        description: 'Adversaries may perform Endpoint Denial of Service (DoS) attacks to degrade or block the availability of services to users.',
        tactics: ['Impact'],
        platforms: ['Linux', 'macOS', 'Windows'],
        riskScore: 8.5,
        detectionNotes: ['Monitor for high CPU/memory consumption', 'Detect flood attacks', 'Resource exhaustion alerts'],
        mitigationNotes: ['DDoS protection services', 'Rate limiting', 'Network traffic analysis'],
        subTechniques: [
          AttackSubTechnique(id: 'T1499.001', name: 'OS Exhaustion Flood', description: 'Adversaries may target resource-intensive features of the operating system to cause a DoS.', riskScore: 8.0),
          AttackSubTechnique(id: 'T1499.002', name: 'Service Exhaustion Flood', description: 'Adversaries may target the different network services provided by systems to conduct a DoS.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1499.003', name: 'Application Exhaustion Flood', description: 'Adversaries may target resource-intensive features of web applications to cause a DoS.', riskScore: 8.5),
          AttackSubTechnique(id: 'T1499.004', name: 'Application or System Exploitation', description: 'Adversaries may exploit software vulnerabilities that can cause an application or system to crash and deny availability.', riskScore: 9.0),
        ],
      ),
      const AttackTechnique(
        id: 'T1485',
        name: 'Data Destruction',
        description: 'Adversaries may destroy data and files on specific systems or in large numbers on a network to interrupt availability.',
        tactics: ['Impact'],
        platforms: ['Linux', 'macOS', 'Windows', 'IaaS'],
        riskScore: 9.5,
        detectionNotes: ['Monitor for mass file deletion', 'Detect database wiping commands', 'Unusual rm/del usage at scale'],
        mitigationNotes: ['Immutable backups', 'Data recovery capabilities', 'Restrict delete permissions'],
      ),
      const AttackTechnique(
        id: 'T1496',
        name: 'Resource Hijacking',
        description: 'Adversaries may leverage the resources of co-opted systems in order to solve resource intensive problems such as cryptocurrency mining.',
        tactics: ['Impact'],
        platforms: ['Windows', 'IaaS', 'Linux', 'macOS', 'Containers'],
        riskScore: 7.5,
        detectionNotes: ['Monitor for high CPU usage by unknown processes', 'Detect cryptominer network patterns', 'Cloud cost anomaly alerts'],
        mitigationNotes: ['Application control', 'Behavior-based detection', 'Cloud resource monitoring'],
      ),
      const AttackTechnique(
        id: 'T1491',
        name: 'Defacement',
        description: 'Adversaries may modify visual content available internally or externally to an enterprise network, thus affecting the integrity of the original content.',
        tactics: ['Impact'],
        platforms: ['Linux', 'macOS', 'Windows', 'IaaS'],
        riskScore: 7.0,
        detectionNotes: ['File integrity monitoring for web content', 'Monitor for unauthorized web changes'],
        mitigationNotes: ['Restrict write access to web directories', 'File integrity monitoring', 'Regular backups'],
        subTechniques: [
          AttackSubTechnique(id: 'T1491.001', name: 'Internal Defacement', description: 'Adversaries may deface systems internal to an organization.', riskScore: 6.5),
          AttackSubTechnique(id: 'T1491.002', name: 'External Defacement', description: 'Adversaries may modify publicly visible content.', riskScore: 7.5),
        ],
      ),
      const AttackTechnique(
        id: 'T1529',
        name: 'System Shutdown/Reboot',
        description: 'Adversaries may shutdown/reboot systems to interrupt access to, or aid in the destruction of, those systems.',
        tactics: ['Impact'],
        platforms: ['Linux', 'macOS', 'Windows', 'Network'],
        riskScore: 8.0,
        detectionNotes: ['Monitor shutdown/reboot events', 'Detect unexpected system restarts'],
        mitigationNotes: ['Privileged account management', 'Restrict shutdown permissions'],
      ),
    ];
  }
}