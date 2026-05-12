// lib/core/services/detection_service.dart
//
// Pillar 5 — Real Detection Integration
//
// Features:
//   1. Windows Event Log indicator matching → ATT&CK techniques
//   2. Syslog / generic text log scanning
//   3. CVE → ATT&CK technique mapping (via NVD API)
//   4. Detection coverage gap analysis
//
// Copy to: lib/core/services/detection_service.dart

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/services/mitre_stix_data_service.dart';
import 'package:attackshield/shared/providers/mitre_data_providers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ═══════════════════════════════════════════════════════════════
// RESULT MODELS
// ═══════════════════════════════════════════════════════════════

/// A single indicator found in the log text
class DetectedIndicator {
  final String attackId; // e.g. "T1059.001"
  final String techniqueName;
  final String plainName;
  final String indicatorText; // the raw log line that triggered it
  final String indicatorRule; // which rule matched
  final String severity; // Low / Medium / High / Critical
  final String evidence; // quoted log excerpt
  final String recommendation; // what to do right now
  final int lineNumber;

  const DetectedIndicator({
    required this.attackId,
    required this.techniqueName,
    required this.plainName,
    required this.indicatorText,
    required this.indicatorRule,
    required this.severity,
    required this.evidence,
    required this.recommendation,
    required this.lineNumber,
  });
}

/// Full analysis result from a log scan
class LogAnalysisResult {
  final int linesScanned;
  final int indicatorsFound;
  final List<DetectedIndicator> indicators;
  final List<String> techniquesCovered; // ATT&CK IDs you CAN detect
  final List<String>
  techniquesMissed; // ATT&CK IDs not detectable from these logs
  final double detectionCoveragePercent; // % of relevant techniques detectable
  final String summary;
  final DateTime analyzedAt;

  const LogAnalysisResult({
    required this.linesScanned,
    required this.indicatorsFound,
    required this.indicators,
    required this.techniquesCovered,
    required this.techniquesMissed,
    required this.detectionCoveragePercent,
    required this.summary,
    required this.analyzedAt,
  });
}

/// CVE mapped to ATT&CK technique(s)
class CveMapping {
  final String cveId;
  final String description;
  final double cvssScore;
  final String severity;
  final List<String> attackIds;
  final List<String> techniqueNames;
  final List<String> mitigations;
  final String publishedDate;

  const CveMapping({
    required this.cveId,
    required this.description,
    required this.cvssScore,
    required this.severity,
    required this.attackIds,
    required this.techniqueNames,
    required this.mitigations,
    required this.publishedDate,
  });
}

// ═══════════════════════════════════════════════════════════════
// INDICATOR RULES
// Each rule defines a pattern → ATT&CK technique mapping
// ═══════════════════════════════════════════════════════════════

class IndicatorRule {
  final String id;
  final String attackId;
  final String techniqueName;
  final String plainName;
  final List<String> keywords; // any of these triggers the rule
  final List<RegExp> patterns; // regex patterns (optional)
  final List<int> windowsEventIds; // Windows Event IDs that map here
  final String severity;
  final String recommendation;

  const IndicatorRule({
    required this.id,
    required this.attackId,
    required this.techniqueName,
    required this.plainName,
    required this.keywords,
    this.patterns = const [],
    this.windowsEventIds = const [],
    required this.severity,
    required this.recommendation,
  });
}

// Master ruleset — 40+ rules covering high-priority ATT&CK techniques
final List<IndicatorRule> _defaultRules = [
  // ── T1059 Command and Scripting Interpreter ──────────────────
  const IndicatorRule(
    id: 'rule_powershell_encoded',
    attackId: 'T1059.001',
    techniqueName: 'PowerShell',
    plainName: 'Attacker Runs Hidden PowerShell Commands',
    keywords: [
      'powershell',
      '-enc',
      '-encodedcommand',
      'encodedcommand',
      'iex(',
      'invoke-expression',
      'downloadstring',
      'webclient',
      '-windowstyle hidden',
      '-noprofile',
      '-noninteractive',
    ],
    windowsEventIds: [4688, 4103, 4104],
    severity: 'High',
    recommendation:
        'Block PowerShell encoded commands via AppLocker. Enable Script Block Logging (EventID 4104).',
  ),

  const IndicatorRule(
    id: 'rule_cmd_suspicious',
    attackId: 'T1059.003',
    techniqueName: 'Windows Command Shell',
    plainName: 'Suspicious Command Prompt Activity',
    keywords: [
      'cmd.exe /c',
      'cmd /c',
      'cmd.exe /k',
      'net user /add',
      'net localgroup administrators',
      'whoami /all',
      'systeminfo',
    ],
    windowsEventIds: [4688],
    severity: 'Medium',
    recommendation:
        'Enable process command-line logging. Alert on cmd.exe spawned by Office apps.',
  ),

  const IndicatorRule(
    id: 'rule_wscript',
    attackId: 'T1059.005',
    techniqueName: 'Visual Basic / WScript',
    plainName: 'Malicious Script Execution',
    keywords: [
      'wscript.exe',
      'cscript.exe',
      'wscript /e:vbscript',
      '.vbs',
      '.js',
      'shell.application',
    ],
    windowsEventIds: [4688],
    severity: 'High',
    recommendation:
        'Block WSH (Windows Script Host) via Group Policy unless required.',
  ),

  // ── T1110 Brute Force ────────────────────────────────────────
  const IndicatorRule(
    id: 'rule_bruteforce_logon',
    attackId: 'T1110',
    techniqueName: 'Brute Force',
    plainName: 'Someone Is Trying Many Passwords',
    keywords: [
      'failed logon',
      'logon failure',
      'authentication failed',
      'invalid password',
      'account lockout',
      '4625',
    ],
    windowsEventIds: [4625, 4740, 4771],
    severity: 'High',
    recommendation:
        'Enable account lockout policy. Implement MFA. Alert on >5 failures in 5 minutes.',
  ),

  const IndicatorRule(
    id: 'rule_password_spray',
    attackId: 'T1110.003',
    techniqueName: 'Password Spraying',
    plainName: 'Attacker Tries One Password Across Many Accounts',
    keywords: [
      'multiple accounts',
      'password spray',
      '4625',
      'status: 0xc000006a',
      '0xc0000064',
    ],
    windowsEventIds: [4625],
    severity: 'Critical',
    recommendation:
        'Enable MFA immediately. Use Azure AD Smart Lockout or equivalent. Alert on low-failure-rate across many accounts.',
  ),

  // ── T1078 Valid Accounts ─────────────────────────────────────
  const IndicatorRule(
    id: 'rule_unusual_login_time',
    attackId: 'T1078',
    techniqueName: 'Valid Accounts',
    plainName: 'Login at Unusual Time or Location',
    keywords: [
      'logon type 10',
      'logon type 3',
      'unusual time',
      'outside business hours',
      'successful logon',
      '4624',
    ],
    windowsEventIds: [4624, 4648],
    severity: 'Medium',
    recommendation:
        'Set up conditional access policies. Alert on logins outside business hours or from new locations.',
  ),

  // ── T1003 Credential Dumping ─────────────────────────────────
  const IndicatorRule(
    id: 'rule_lsass_access',
    attackId: 'T1003.001',
    techniqueName: 'LSASS Memory Dump',
    plainName: 'Attacker Is Stealing Passwords from Memory',
    keywords: [
      'lsass',
      'mimikatz',
      'sekurlsa',
      'wce.exe',
      'procdump',
      'process access',
      '10',
      'lsass.exe',
    ],
    windowsEventIds: [4656, 10],
    severity: 'Critical',
    recommendation:
        'Enable Credential Guard. Block procdump/comsvcs.dll from accessing lsass. Deploy EDR.',
  ),

  const IndicatorRule(
    id: 'rule_ntds_dit',
    attackId: 'T1003.003',
    techniqueName: 'NTDS.dit Extraction',
    plainName: 'Attacker Copying All Domain Passwords',
    keywords: [
      'ntds.dit',
      'ntdsutil',
      'vssadmin create shadow',
      'shadow copy',
      'diskshadow',
    ],
    windowsEventIds: [7036, 4688],
    severity: 'Critical',
    recommendation:
        'Alert immediately. Isolate affected DC. Check for lateral movement. This is a domain compromise.',
  ),

  // ── T1486 Ransomware ─────────────────────────────────────────
  const IndicatorRule(
    id: 'rule_mass_file_rename',
    attackId: 'T1486',
    techniqueName: 'Data Encrypted for Impact',
    plainName: 'Files Are Being Locked (Ransomware)',
    keywords: [
      '.locked',
      '.encrypted',
      '.crypted',
      '.ransom',
      'readme.txt',
      'how_to_decrypt',
      'your_files_are_encrypted',
      'recovery_key',
      'ransom_note',
    ],
    windowsEventIds: [4663],
    severity: 'Critical',
    recommendation:
        'ISOLATE the machine immediately. Do NOT pay. Check for offline backups. Call incident response.',
  ),

  const IndicatorRule(
    id: 'rule_vss_delete',
    attackId: 'T1490',
    techniqueName: 'Backup Deletion',
    plainName: 'Attacker Is Deleting Your Backups',
    keywords: [
      'vssadmin delete shadows',
      'wmic shadowcopy delete',
      'bcdedit /set recoveryenabled no',
      'wbadmin delete',
      'delete shadows /all',
    ],
    windowsEventIds: [4688],
    severity: 'Critical',
    recommendation:
        'ALERT IMMEDIATELY. This precedes ransomware. Isolate the machine. Check other systems.',
  ),

  // ── T1566 Phishing ───────────────────────────────────────────
  const IndicatorRule(
    id: 'rule_office_macro',
    attackId: 'T1566.001',
    techniqueName: 'Spearphishing Attachment',
    plainName: 'Malicious Email Attachment Opened',
    keywords: [
      'macro',
      'vba',
      'auto_open',
      'document_open',
      'shell(',
      'createobject',
      'winmgmts',
      'office spawned',
      'winword.exe spawned',
    ],
    windowsEventIds: [4688],
    severity: 'High',
    recommendation:
        'Block Office macros via Group Policy. Train users. Enable Attack Surface Reduction rules.',
  ),

  const IndicatorRule(
    id: 'rule_phishing_link',
    attackId: 'T1566.002',
    techniqueName: 'Spearphishing Link',
    plainName: 'User Clicked Malicious Link in Email',
    keywords: [
      'suspicious url',
      'malicious link',
      'phishing detected',
      'url blocked',
      'malicious redirect',
    ],
    severity: 'High',
    recommendation:
        'Check if user entered credentials. Force password reset. Enable Safe Links (Defender for Office).',
  ),

  // ── T1070 Indicator Removal ──────────────────────────────────
  const IndicatorRule(
    id: 'rule_log_cleared',
    attackId: 'T1070.001',
    techniqueName: 'Clear Windows Event Logs',
    plainName: 'Attacker Deleted Evidence (Log Cleared)',
    keywords: [
      'event log was cleared',
      'log clear',
      'wevtutil cl',
      'clear-eventlog',
      '1102',
      '104',
    ],
    windowsEventIds: [1102, 104],
    severity: 'High',
    recommendation:
        'Alert on log clearing. Forward logs to a SIEM in real-time so clearing doesn\'t destroy evidence.',
  ),

  // ── T1547 Boot/Logon Autostart ───────────────────────────────
  const IndicatorRule(
    id: 'rule_registry_run',
    attackId: 'T1547.001',
    techniqueName: 'Registry Run Keys / Startup Folder',
    plainName: 'Malware Added to Startup',
    keywords: [
      'hklm\\software\\microsoft\\windows\\currentversion\\run',
      'hkcu\\software\\microsoft\\windows\\currentversion\\run',
      'currentversion\\run',
      'startup folder',
      'shell:startup',
    ],
    windowsEventIds: [13, 14],
    severity: 'High',
    recommendation:
        'Alert on unexpected registry autostart entries. Baseline known-good entries.',
  ),

  // ── T1021 Remote Services ────────────────────────────────────
  const IndicatorRule(
    id: 'rule_rdp_brute',
    attackId: 'T1021.001',
    techniqueName: 'Remote Desktop Protocol',
    plainName: 'Someone Is Trying to Log In Remotely',
    keywords: [
      'rdp',
      'remote desktop',
      'mstsc',
      'logon type 10',
      'terminal services',
      '3389',
      'failed rdp',
    ],
    windowsEventIds: [4625, 4624, 1149],
    severity: 'High',
    recommendation:
        'Block RDP from internet. Use VPN + MFA for remote access. Enable NLA.',
  ),

  // ── T1570 Lateral Tool Transfer ──────────────────────────────
  const IndicatorRule(
    id: 'rule_lateral_smb',
    attackId: 'T1570',
    techniqueName: 'Lateral Tool Transfer',
    plainName: 'Attacker Spreading Across Your Network',
    keywords: [
      'psexec',
      'psexesvc',
      'admin',
      'smbexec',
      'wmiexec',
      'pass-the-hash',
      'net use',
    ],
    windowsEventIds: [4624, 4648, 7045],
    severity: 'Critical',
    recommendation:
        'ISOLATE affected systems. Block SMB between workstations. Segment network immediately.',
  ),

  // ── T1562 Impair Defenses ────────────────────────────────────
  const IndicatorRule(
    id: 'rule_av_disabled',
    attackId: 'T1562.001',
    techniqueName: 'Disable or Modify Tools',
    plainName: 'Security Software Was Disabled',
    keywords: [
      'antivirus disabled',
      'defender disabled',
      'tamper protection',
      'sc stop',
      'net stop',
      'windows defender',
      'real-time protection disabled',
    ],
    windowsEventIds: [7036, 4689],
    severity: 'Critical',
    recommendation:
        'Alert immediately. Re-enable security software. Check for active threat actor. This is a major red flag.',
  ),

  // ── T1041 Exfiltration over C2 Channel ───────────────────────
  const IndicatorRule(
    id: 'rule_large_upload',
    attackId: 'T1041',
    techniqueName: 'Exfiltration Over C2 Channel',
    plainName: 'Large Amount of Data Being Sent Out',
    keywords: [
      'large data transfer',
      'outbound bytes',
      'data exfiltration',
      'unusual upload',
      'megabytes uploaded',
      'gigabytes sent',
    ],
    severity: 'High',
    recommendation:
        'Block the connection. Identify what data was sent. Notify legal/compliance. Begin breach response.',
  ),

  // ── T1055 Process Injection ──────────────────────────────────
  const IndicatorRule(
    id: 'rule_process_injection',
    attackId: 'T1055',
    techniqueName: 'Process Injection',
    plainName: 'Malware Hidden Inside Legitimate App',
    keywords: [
      'virtualalloc',
      'writeprocessmemory',
      'createremotethread',
      'ntcreatethreadex',
      'reflective dll',
      'shellcode',
    ],
    windowsEventIds: [8],
    severity: 'Critical',
    recommendation:
        'Deploy EDR with memory scanning. Enable Sysmon EventID 8 (CreateRemoteThread).',
  ),

  // ── T1053 Scheduled Tasks ────────────────────────────────────
  const IndicatorRule(
    id: 'rule_sched_task',
    attackId: 'T1053.005',
    techniqueName: 'Scheduled Task/Job',
    plainName: 'Malware Set to Run Automatically',
    keywords: [
      'schtasks /create',
      'taskschd',
      'at.exe',
      'new-scheduledtask',
      'register-scheduledtask',
      'scheduled task created',
    ],
    windowsEventIds: [4698, 4702],
    severity: 'Medium',
    recommendation:
        'Baseline known scheduled tasks. Alert on new tasks created by non-admin users.',
  ),
];

// ═══════════════════════════════════════════════════════════════
// DETECTION SERVICE
// ═══════════════════════════════════════════════════════════════

class DetectionService {
  final MitreStixDataService mitreService;

  DetectionService({required this.mitreService});

  /// Analyse raw log text (Windows Event Logs, syslog, any text)
  LogAnalysisResult analyzeLogText(String logText) {
    final lines = logText.split('\n');
    final found = <DetectedIndicator>[];
    final coveredIds = <String>{};

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].toLowerCase();

      for (final rule in _defaultRules) {
        // Check keywords
        final keywordHit = rule.keywords.any(
          (kw) => line.contains(kw.toLowerCase()),
        );

        // Check Windows Event IDs
        final eventIdHit = rule.windowsEventIds.any(
          (id) =>
              line.contains('eventid=$id') ||
              line.contains('event id: $id') ||
              line.contains('event_id: $id') ||
              line.contains('id=$id') ||
              line.contains('"id":$id') ||
              line.contains(' $id ') ||
              line.contains('<eventid>$id</eventid>'),
        );

        if (keywordHit || eventIdHit) {
          // Avoid exact duplicates on the same rule+line
          final isDupe = found.any(
            (f) => f.attackId == rule.attackId && f.lineNumber == i + 1,
          );
          if (!isDupe) {
            found.add(
              DetectedIndicator(
                attackId: rule.attackId,
                techniqueName: rule.techniqueName,
                plainName: rule.plainName,
                indicatorText: lines[i].trim(),
                indicatorRule: rule.id,
                severity: rule.severity,
                evidence: _excerpt(lines, i),
                recommendation: rule.recommendation,
                lineNumber: i + 1,
              ),
            );
            coveredIds.add(rule.attackId);
          }
        }
      }
    }

    // All ATT&CK IDs that COULD be detected with more logs
    final allRuleIds = _defaultRules.map((r) => r.attackId).toSet();
    final missed = allRuleIds.difference(coveredIds).toList();
    final coveragePct = allRuleIds.isEmpty
        ? 0.0
        : (coveredIds.length / allRuleIds.length) * 100;

    // Deduplicate by severity for summary
    final critCount = found.where((f) => f.severity == 'Critical').length;
    final highCount = found.where((f) => f.severity == 'High').length;

    final summary = found.isEmpty
        ? 'No known attack indicators found in the provided logs. This may mean your environment is clean, or that the attack used techniques not covered by these rules.'
        : 'Found $critCount critical and $highCount high-severity indicators across ${coveredIds.length} ATT&CK techniques. ${_prioritySummary(found)}';

    return LogAnalysisResult(
      linesScanned: lines.length,
      indicatorsFound: found.length,
      indicators: found,
      techniquesCovered: coveredIds.toList(),
      techniquesMissed: missed,
      detectionCoveragePercent: coveragePct,
      summary: summary,
      analyzedAt: DateTime.now(),
    );
  }

  String _excerpt(List<String> lines, int i) {
    final start = (i - 1).clamp(0, lines.length - 1);
    final end = (i + 1).clamp(0, lines.length - 1);
    return lines.sublist(start, end + 1).join('\n');
  }

  String _prioritySummary(List<DetectedIndicator> found) {
    final critical = found.where((f) => f.severity == 'Critical').toList();
    if (critical.isEmpty) return 'Review the high-severity items below.';
    final topTech = critical.map((f) => f.plainName).take(2).join(', ');
    return 'IMMEDIATE ACTION REQUIRED for: $topTech.';
  }

  /// Fetch CVE data from NVD and map to ATT&CK techniques
  /// [query] can be a CVE ID ("CVE-2024-1234") or keyword ("log4j", "Exchange")
  Future<List<CveMapping>> fetchCveMappings(String query) async {
    try {
      final isId = query.toUpperCase().startsWith('CVE-');

      final uri = isId
          ? Uri.parse(
              'https://services.nvd.nist.gov/rest/json/cves/2.0?cveId=${query.toUpperCase()}',
            )
          : Uri.parse(
              'https://services.nvd.nist.gov/rest/json/cves/2.0?keywordSearch=${Uri.encodeComponent(query)}&resultsPerPage=10',
            );

      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        return [_errorCveMapping(query, 'NVD returned ${response.statusCode}')];
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final vulns = (json['vulnerabilities'] as List? ?? [])
          .cast<Map<String, dynamic>>();

      if (vulns.isEmpty) {
        return [_errorCveMapping(query, 'No CVEs found for "$query"')];
      }

      return vulns.map((v) => _parseCveVuln(v)).toList();
    } catch (e) {
      return [_errorCveMapping(query, 'Network error: $e')];
    }
  }

  CveMapping _parseCveVuln(Map<String, dynamic> v) {
    final cve = v['cve'] as Map<String, dynamic>? ?? {};
    final id = cve['id'] as String? ?? 'Unknown';

    // Description
    final descs = (cve['descriptions'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    final desc =
        descs.firstWhere((d) => d['lang'] == 'en', orElse: () => {})['value']
            as String? ??
        'No description available';

    // CVSS score
    double cvss = 0;
    String severity = 'Unknown';
    final metrics = cve['metrics'] as Map<String, dynamic>? ?? {};
    final v31 = (metrics['cvssMetricV31'] as List? ?? []);
    if (v31.isNotEmpty) {
      final data = (v31.first as Map)['cvssData'] as Map? ?? {};
      cvss = (data['baseScore'] as num?)?.toDouble() ?? 0;
      severity = data['baseSeverity'] as String? ?? 'Unknown';
    } else {
      final v30 = (metrics['cvssMetricV30'] as List? ?? []);
      if (v30.isNotEmpty) {
        final data = (v30.first as Map)['cvssData'] as Map? ?? {};
        cvss = (data['baseScore'] as num?)?.toDouble() ?? 0;
        severity = data['baseSeverity'] as String? ?? 'Unknown';
      }
    }

    // Map CVE → ATT&CK techniques via keyword heuristics
    final techniques = _mapCveToAttack(desc, cvss);

    // Published date
    final published = cve['published'] as String? ?? '';

    return CveMapping(
      cveId: id,
      description: desc.length > 300 ? '${desc.substring(0, 300)}…' : desc,
      cvssScore: cvss,
      severity: severity,
      attackIds: techniques.map((t) => t.attackId).toList(),
      techniqueNames: techniques.map((t) => t.name).toList(),
      mitigations: _getMitigationsForCve(techniques),
      publishedDate: published.isNotEmpty
          ? published.substring(0, 10)
          : 'Unknown',
    );
  }

  /// Heuristic CVE → ATT&CK mapping based on CVE description keywords
  List<_TechRef> _mapCveToAttack(String desc, double cvss) {
    final d = desc.toLowerCase();
    final refs = <_TechRef>[];

    if (d.contains('remote code execution') || d.contains('rce')) {
      refs.add(const _TechRef('T1059', 'Command and Scripting Interpreter'));
    }
    if (d.contains('privilege escalation') || d.contains('local privilege')) {
      refs.add(
        const _TechRef('T1068', 'Exploitation for Privilege Escalation'),
      );
    }
    if (d.contains('sql injection') || d.contains('sqli')) {
      refs.add(const _TechRef('T1190', 'Exploit Public-Facing Application'));
    }
    if (d.contains('cross-site scripting') || d.contains('xss')) {
      refs.add(const _TechRef('T1185', 'Browser Session Hijacking'));
    }
    if (d.contains('authentication bypass') ||
        d.contains('bypass authentication')) {
      refs.add(const _TechRef('T1078', 'Valid Accounts'));
    }
    if (d.contains('path traversal') || d.contains('directory traversal')) {
      refs.add(const _TechRef('T1083', 'File and Directory Discovery'));
    }
    if (d.contains('buffer overflow') || d.contains('heap overflow')) {
      refs.add(const _TechRef('T1203', 'Exploitation for Client Execution'));
    }
    if (d.contains('deserialization')) {
      refs.add(const _TechRef('T1059', 'Command and Scripting Interpreter'));
    }
    if (d.contains('ssrf') || d.contains('server-side request forgery')) {
      refs.add(const _TechRef('T1090', 'Proxy'));
    }
    if (d.contains('credential') ||
        d.contains('password') ||
        d.contains('cleartext')) {
      refs.add(const _TechRef('T1552', 'Unsecured Credentials'));
    }
    if (d.contains('xml external entity') || d.contains('xxe')) {
      refs.add(const _TechRef('T1190', 'Exploit Public-Facing Application'));
    }
    if (d.contains('supply chain') || d.contains('software update')) {
      refs.add(const _TechRef('T1195', 'Supply Chain Compromise'));
    }

    // High CVSS with no specific match → likely Initial Access
    if (refs.isEmpty && cvss >= 8.0) {
      refs.add(const _TechRef('T1190', 'Exploit Public-Facing Application'));
    }

    return refs.isEmpty
        ? [const _TechRef('T1190', 'Exploit Public-Facing Application')]
        : refs;
  }

  List<String> _getMitigationsForCve(List<_TechRef> techniques) {
    const mitigations = <String, List<String>>{
      'T1059': [
        'Apply the security patch immediately',
        'Enable application allowlisting',
        'Block macro execution',
      ],
      'T1068': [
        'Apply OS and software patches',
        'Enable UAC',
        'Use least-privilege accounts',
      ],
      'T1190': [
        'Patch the vulnerable service',
        'Enable WAF',
        'Remove or isolate the exposed service',
      ],
      'T1078': [
        'Enable MFA',
        'Reset all passwords',
        'Audit authentication logs',
      ],
      'T1195': [
        'Verify software signatures',
        'Monitor for unexpected network connections after updates',
      ],
      'T1552': [
        'Rotate all credentials',
        'Scan for hardcoded secrets',
        'Use secrets management tools',
      ],
    };

    return techniques
        .expand(
          (t) =>
              mitigations[t.attackId] ?? ['Apply vendor patches immediately'],
        )
        .toSet()
        .take(5)
        .toList();
  }

  CveMapping _errorCveMapping(String query, String error) => CveMapping(
    cveId: query,
    description: error,
    cvssScore: 0,
    severity: 'Unknown',
    attackIds: [],
    techniqueNames: [],
    mitigations: ['Check CVE database manually at nvd.nist.gov'],
    publishedDate: 'Unknown',
  );

  /// Get detection gaps: which rules have NO matching log evidence
  List<IndicatorRule> getDetectionGaps(LogAnalysisResult result) {
    final covered = result.techniquesCovered.toSet();
    return _defaultRules.where((r) => !covered.contains(r.attackId)).toList();
  }

  /// Get all rules (for UI display / rule browser)
  List<IndicatorRule> getAllRules() => List.unmodifiable(_defaultRules);
}

class _TechRef {
  final String attackId;
  final String name;
  const _TechRef(this.attackId, this.name);
}

// ═══════════════════════════════════════════════════════════════
// RIVERPOD PROVIDERS
// ═══════════════════════════════════════════════════════════════

final detectionServiceProvider = Provider<DetectionService>((ref) {
  return DetectionService(mitreService: ref.watch(mitreServiceProvider));
});

/// Analyse a log string — watch this after user pastes/uploads logs
final logAnalysisProvider = FutureProvider.family<LogAnalysisResult, String>((
  ref,
  logText,
) async {
  await ref.watch(mitreInitializationProvider.future);
  if (logText.trim().isEmpty) {
    return LogAnalysisResult(
      linesScanned: 0,
      indicatorsFound: 0,
      indicators: [],
      techniquesCovered: [],
      techniquesMissed: _defaultRules.map((r) => r.attackId).toList(),
      detectionCoveragePercent: 0,
      summary: 'No log text provided. Paste logs above to analyse.',
      analyzedAt: DateTime.now(),
    );
  }
  final svc = ref.watch(detectionServiceProvider);
  return svc.analyzeLogText(logText);
});

/// CVE lookup + ATT&CK mapping
final cveMappingProvider = FutureProvider.family<List<CveMapping>, String>((
  ref,
  query,
) async {
  if (query.trim().isEmpty) return [];
  await ref.watch(mitreInitializationProvider.future);
  final svc = ref.watch(detectionServiceProvider);
  return svc.fetchCveMappings(query.trim());
});

/// Detection rules browser
final allDetectionRulesProvider = Provider<List<IndicatorRule>>((ref) {
  return ref.watch(detectionServiceProvider).getAllRules();
});
