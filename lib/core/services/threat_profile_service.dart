import 'package:attackshield/shared/models/models.dart';

/// ────────────────────────────────────────────────────────────────────────────
/// ThreatProfileService
///
/// Core academic contribution of Phase 2:
/// Maps an organization's sector, technology stack, and declared security
/// controls to a prioritised set of ATT&CK techniques and auto-generated
/// coverage suggestions.
///
/// Methodology:
///   1. Sector mapping  → base technique priority list (threat-intel sourced)
///   2. Tech stack      → additional relevant techniques per platform
///   3. Controls        → CoverageLevel suggestions per technique
///   4. Risk score      → weighted formula combining sector risk × coverage gap
///
/// Data sources: MITRE ATT&CK v14, Verizon DBIR 2024, CrowdStrike GTR 2025,
///               Microsoft MSTIC Annual Report 2024.
/// ────────────────────────────────────────────────────────────────────────────
class ThreatProfileService {
  // ── Sector → base priority technique IDs ──────────────────────────────────
  // Ordered by real-world frequency for that sector (threat intelligence sourced)
  static const Map<OrgSector, List<String>> _sectorTechniques = {
    OrgSector.healthcare: [
      'T1566', 'T1486', 'T1190', 'T1078', 'T1003',
      'T1021', 'T1070', 'T1041', 'T1547', 'T1562',
    ],
    OrgSector.finance: [
      'T1566', 'T1558', 'T1550', 'T1110', 'T1003',
      'T1071', 'T1573', 'T1059', 'T1021', 'T1486',
    ],
    OrgSector.education: [
      'T1566', 'T1486', 'T1110', 'T1078', 'T1204',
      'T1190', 'T1059', 'T1547', 'T1041', 'T1562',
    ],
    OrgSector.retail: [
      'T1566', 'T1486', 'T1056', 'T1190', 'T1195',
      'T1078', 'T1041', 'T1071', 'T1110', 'T1547',
    ],
    OrgSector.government: [
      'T1566', 'T1190', 'T1003', 'T1558', 'T1021',
      'T1486', 'T1195', 'T1070', 'T1562', 'T1573',
    ],
    OrgSector.technology: [
      'T1195', 'T1566', 'T1059', 'T1190', 'T1078',
      'T1003', 'T1550', 'T1486', 'T1021', 'T1547',
    ],
    OrgSector.manufacturing: [
      'T1566', 'T1486', 'T1190', 'T1059', 'T1078',
      'T1021', 'T1003', 'T1041', 'T1562', 'T1547',
    ],
    OrgSector.energy: [
      'T1566', 'T1190', 'T1059', 'T1078', 'T1486',
      'T1021', 'T1003', 'T1195', 'T1562', 'T1499',
    ],
    OrgSector.sme: [
      'T1566', 'T1486', 'T1078', 'T1204', 'T1110',
      'T1190', 'T1059', 'T1547', 'T1071', 'T1041',
    ],
    OrgSector.personal: [
      'T1566', 'T1204', 'T1110', 'T1078', 'T1486',
      'T1059', 'T1547', 'T1071', 'T1056', 'T1041',
    ],
    OrgSector.other: [
      'T1566', 'T1486', 'T1078', 'T1110', 'T1190',
      'T1059', 'T1547', 'T1071', 'T1041', 'T1204',
    ],
  };

  // ── TechStack → additional relevant technique IDs ─────────────────────────
  static const Map<TechStackItem, List<String>> _techTechniques = {
    TechStackItem.windows: [
      'T1059.001', 'T1059.003', 'T1547.001', 'T1003.001',
      'T1055', 'T1134', 'T1548.002', 'T1070.001',
    ],
    TechStackItem.macos: [
      'T1059.002', 'T1547.015', 'T1543.001', 'T1543.004',
      'T1548.001', 'T1070.002',
    ],
    TechStackItem.linux: [
      'T1059.004', 'T1543.002', 'T1003.008', 'T1548.001',
      'T1070.002', 'T1053.003',
    ],
    TechStackItem.office365: [
      'T1566.002', 'T1114', 'T1114.003', 'T1550.001',
      'T1078.004', 'T1048.002',
    ],
    TechStackItem.googleWorkspace: [
      'T1566.002', 'T1114', 'T1078.004', 'T1550.001',
      'T1048.002',
    ],
    TechStackItem.aws: [
      'T1078.004', 'T1580', 'T1537', 'T1190',
      'T1562.008', 'T1048',
    ],
    TechStackItem.azure: [
      'T1078.004', 'T1580', 'T1550.001', 'T1562.008',
      'T1190', 'T1048',
    ],
    TechStackItem.gcp: [
      'T1078.004', 'T1580', 'T1537', 'T1562.008',
    ],
    TechStackItem.activeDirectory: [
      'T1558', 'T1558.001', 'T1558.003', 'T1550.002',
      'T1550.003', 'T1087.002', 'T1484',
    ],
    TechStackItem.vmware: [
      'T1486', 'T1059', 'T1611', 'T1210',
    ],
    TechStackItem.containers: [
      'T1610', 'T1611', 'T1613', 'T1059.004',
      'T1190', 'T1078.004',
    ],
    TechStackItem.iot: [
      'T1190', 'T1059', 'T1110.001', 'T1498',
      'T1496', 'T1499',
    ],
    TechStackItem.networkDevices: [
      'T1599', 'T1600', 'T1601', 'T1110',
      'T1190', 'T1498',
    ],
  };

  // ── Controls → Coverage suggestions (techniqueId → suggestedLevel, reason) ─
  static const Map<SecurityControl, List<_ControlMapping>> _controlMappings = {
    SecurityControl.antivirus: [
      _ControlMapping('T1204', 'partiallyCovered', 'Antivirus'),
      _ControlMapping('T1486', 'partiallyCovered', 'Antivirus'),
      _ControlMapping('T1059', 'partiallyCovered', 'Antivirus'),
      _ControlMapping('T1055', 'partiallyCovered', 'Antivirus'),
      _ControlMapping('T1547', 'partiallyCovered', 'Antivirus'),
    ],
    SecurityControl.firewall: [
      _ControlMapping('T1071', 'partiallyCovered', 'Firewall'),
      _ControlMapping('T1572', 'partiallyCovered', 'Firewall'),
      _ControlMapping('T1090', 'partiallyCovered', 'Firewall'),
      _ControlMapping('T1046', 'partiallyCovered', 'Firewall'),
      _ControlMapping('T1190', 'partiallyCovered', 'Firewall'),
    ],
    SecurityControl.emailFiltering: [
      _ControlMapping('T1566', 'partiallyCovered', 'Email Filtering'),
      _ControlMapping('T1566.001', 'partiallyCovered', 'Email Filtering'),
      _ControlMapping('T1566.002', 'partiallyCovered', 'Email Filtering'),
      _ControlMapping('T1598', 'partiallyCovered', 'Email Filtering'),
      _ControlMapping('T1204', 'partiallyCovered', 'Email Filtering'),
    ],
    SecurityControl.edr: [
      _ControlMapping('T1059', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1059.001', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1059.003', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1055', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1003', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1003.001', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1486', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1543', 'partiallyCovered', 'EDR'),
      _ControlMapping('T1204', 'covered', 'EDR'),
    ],
    SecurityControl.siem: [
      _ControlMapping('T1070', 'partiallyCovered', 'SIEM'),
      _ControlMapping('T1070.001', 'partiallyCovered', 'SIEM'),
      _ControlMapping('T1562', 'partiallyCovered', 'SIEM'),
      _ControlMapping('T1562.001', 'partiallyCovered', 'SIEM'),
      _ControlMapping('T1110', 'partiallyCovered', 'SIEM'),
      _ControlMapping('T1021', 'partiallyCovered', 'SIEM'),
    ],
    SecurityControl.mfa: [
      _ControlMapping('T1078', 'partiallyCovered', 'MFA'),
      _ControlMapping('T1078.002', 'partiallyCovered', 'MFA'),
      _ControlMapping('T1078.003', 'partiallyCovered', 'MFA'),
      _ControlMapping('T1078.004', 'partiallyCovered', 'MFA'),
      _ControlMapping('T1110', 'covered', 'MFA'),
      _ControlMapping('T1110.004', 'covered', 'MFA'),
      _ControlMapping('T1556', 'partiallyCovered', 'MFA'),
      _ControlMapping('T1550', 'partiallyCovered', 'MFA'),
    ],
    SecurityControl.vpn: [
      _ControlMapping('T1133', 'partiallyCovered', 'VPN'),
      _ControlMapping('T1021', 'partiallyCovered', 'VPN'),
    ],
    SecurityControl.dlp: [
      _ControlMapping('T1041', 'partiallyCovered', 'DLP'),
      _ControlMapping('T1048', 'partiallyCovered', 'DLP'),
      _ControlMapping('T1567', 'partiallyCovered', 'DLP'),
      _ControlMapping('T1114', 'partiallyCovered', 'DLP'),
    ],
    SecurityControl.iam: [
      _ControlMapping('T1078', 'partiallyCovered', 'IAM'),
      _ControlMapping('T1136', 'partiallyCovered', 'IAM'),
      _ControlMapping('T1098', 'partiallyCovered', 'IAM'),
      _ControlMapping('T1087', 'partiallyCovered', 'IAM'),
    ],
    SecurityControl.backups: [
      _ControlMapping('T1486', 'partiallyCovered', 'Backups'),
      _ControlMapping('T1490', 'partiallyCovered', 'Backups'),
      _ControlMapping('T1485', 'partiallyCovered', 'Backups'),
    ],
    SecurityControl.patchManagement: [
      _ControlMapping('T1190', 'partiallyCovered', 'Patch Management'),
      _ControlMapping('T1210', 'partiallyCovered', 'Patch Management'),
      _ControlMapping('T1203', 'partiallyCovered', 'Patch Management'),
    ],
    SecurityControl.securityAwareness: [
      _ControlMapping('T1566', 'partiallyCovered', 'Security Awareness Training'),
      _ControlMapping('T1598', 'partiallyCovered', 'Security Awareness Training'),
      _ControlMapping('T1204', 'partiallyCovered', 'Security Awareness Training'),
    ],
    SecurityControl.none: [],
  };

  // ── Sector baseline risk scores (0–100) ────────────────────────────────────
  static const Map<OrgSector, double> _sectorBaselineRisk = {
    OrgSector.healthcare:    78.0,
    OrgSector.finance:       75.0,
    OrgSector.government:    72.0,
    OrgSector.energy:        70.0,
    OrgSector.technology:    68.0,
    OrgSector.manufacturing: 65.0,
    OrgSector.education:     62.0,
    OrgSector.retail:        60.0,
    OrgSector.sme:           55.0,
    OrgSector.personal:      40.0,
    OrgSector.other:         55.0,
  };

  // ── Sector insights (threat intelligence summaries) ───────────────────────
  static const Map<OrgSector, String> _sectorInsights = {
    OrgSector.healthcare:
        'Healthcare was the most targeted sector in 2024 — ransomware attacks increased 45%. Patient data breaches average \$10.9M per incident (IBM Cost of Data Breach Report 2024).',
    OrgSector.finance:
        'Financial services face the highest volume of credential attacks. 81% of intrusions in 2024-25 were malware-free, relying on stolen credentials and social engineering.',
    OrgSector.education:
        'Education institutions are primary targets for ransomware due to limited security budgets. Cloud attacks increased 136% in 2025.',
    OrgSector.retail:
        'Retail organizations face significant e-commerce fraud and supply chain attacks. Point-of-sale malware remains a key threat vector.',
    OrgSector.government:
        'Nation-state actors actively target government entities. Advanced persistent threat (APT) groups conduct long-dwell espionage campaigns averaging 197 days before detection.',
    OrgSector.technology:
        'Software supply chain attacks (like SolarWinds, XZ Utils) are a primary threat. Insider threats and IP theft are above-average risks.',
    OrgSector.manufacturing:
        'Industrial control system attacks rose 140% in 2024. Ransomware targeting OT/IT convergence can halt production lines.',
    OrgSector.energy:
        'Critical infrastructure attacks have escalated globally. State-sponsored actors prioritize power grid and utility disruption.',
    OrgSector.sme:
        'SMEs are disproportionately targeted — 46% of all cyberattacks hit small businesses. Limited IT resources make recovery costly.',
    OrgSector.personal:
        'Personal devices face phishing, credential theft, and ransomware. Social engineering is the #1 entry point for home users.',
    OrgSector.other:
        'Every organization faces phishing as the primary entry point. Unpatched vulnerabilities and weak credentials account for 80% of breaches.',
  };

  // ── Common threat actors per sector ──────────────────────────────────────
  static const Map<OrgSector, List<String>> _sectorThreatActors = {
    OrgSector.healthcare:    ['LockBit', 'ALPHV/BlackCat', 'Rhysida'],
    OrgSector.finance:       ['Scattered Spider', 'FIN7', 'Carbanak'],
    OrgSector.education:     ['Vice Society', 'LockBit', 'Royal'],
    OrgSector.retail:        ['Magecart', 'FIN7', 'LockBit'],
    OrgSector.government:    ['APT28', 'Volt Typhoon', 'APT41'],
    OrgSector.technology:    ['Scattered Spider', 'APT10', 'Lapsus\$'],
    OrgSector.manufacturing: ['LockBit', 'ALPHV', 'Cl0p'],
    OrgSector.energy:        ['Sandworm', 'Volt Typhoon', 'Dragonfly'],
    OrgSector.sme:           ['LockBit', 'Phobos', 'STOP/DJVU'],
    OrgSector.personal:      ['Generic phishing groups', 'Info-stealers'],
    OrgSector.other:         ['LockBit', 'Phishing-as-a-Service groups'],
  };

  // ── Plain-language threat names ────────────────────────────────────────────
  static const Map<String, _PlainThreat> _plainThreats = {
    'T1566': _PlainThreat(
      'Fake emails (Phishing)',
      'Attackers send deceptive emails that trick employees into clicking malicious links or attachments.',
    ),
    'T1486': _PlainThreat(
      'Ransomware — files encrypted for ransom',
      'Malware that locks all your files and demands payment. Can shut down entire organizations.',
    ),
    'T1190': _PlainThreat(
      'Exploiting your internet-facing systems',
      'Attackers find and exploit weaknesses in public-facing apps, websites, or servers.',
    ),
    'T1078': _PlainThreat(
      'Stolen or misused login credentials',
      'Attackers use real usernames and passwords — bought from leaks or stolen — to access systems.',
    ),
    'T1003': _PlainThreat(
      'Password theft from memory',
      'Attackers dump passwords stored in Windows memory to access more systems.',
    ),
    'T1110': _PlainThreat(
      'Brute force password guessing',
      'Automated tools try thousands of password combinations until one works.',
    ),
    'T1059': _PlainThreat(
      'Running malicious scripts',
      'Attackers run scripts (like PowerShell or bash) to execute commands and install malware.',
    ),
    'T1021': _PlainThreat(
      'Moving between computers (lateral movement)',
      'Once inside, attackers jump from one computer to another to reach valuable targets.',
    ),
    'T1204': _PlainThreat(
      'Tricking users into running malware',
      'Employees are deceived into opening a malicious file or clicking a fake update.',
    ),
    'T1195': _PlainThreat(
      'Supply chain attack',
      'Attackers compromise a trusted software vendor or update to reach their real target.',
    ),
    'T1556': _PlainThreat(
      'Bypassing or modifying login checks',
      'Attackers modify how authentication works to create backdoors or bypass passwords.',
    ),
    'T1558': _PlainThreat(
      'Kerberos ticket forgery (Golden Ticket)',
      'Attackers forge authentication tickets in Windows networks to gain unrestricted access.',
    ),
    'T1071': _PlainThreat(
      'Hidden communication channels',
      'Malware communicates with attackers by hiding inside normal web or DNS traffic.',
    ),
    'T1041': _PlainThreat(
      'Data theft over the internet',
      'Stolen files and data are sent to attacker-controlled servers over encrypted channels.',
    ),
    'T1547': _PlainThreat(
      'Malware that survives restarts',
      'Attackers configure malware to automatically run every time the computer starts.',
    ),
    'T1562': _PlainThreat(
      'Disabling your security tools',
      'Attackers turn off antivirus, firewalls, or logging so their activity is not detected.',
    ),
    'T1056': _PlainThreat(
      'Keylogging — recording what you type',
      'Malware silently records every keystroke, capturing passwords and sensitive data.',
    ),
    'T1114': _PlainThreat(
      'Email theft',
      'Attackers access and exfiltrate email contents, looking for sensitive information.',
    ),
    'T1550': _PlainThreat(
      'Using stolen session tokens (Pass-the-Hash)',
      'Attackers reuse stolen login tokens to access systems without knowing the actual password.',
    ),
    'T1573': _PlainThreat(
      'Encrypted attacker communications',
      'Malware uses encrypted channels to hide communications from security monitoring.',
    ),
  };

  // ──────────────────────────────────────────────────────────────────────────
  // PUBLIC API
  // ──────────────────────────────────────────────────────────────────────────

  /// Generate a ThreatProfile from an OrganizationProfile.
  static ThreatProfile generate(OrganizationProfile org) {
    // 1. Build priority technique list from sector + tech stack
    final priorityIds = _buildPriorityList(org);

    // 2. Build coverage suggestions from declared controls
    final suggestions = _buildCoverageSuggestions(org);

    // 3. Calculate baseline risk (before coverage applied)
    final baselineRisk = _calculateBaselineRisk(org, suggestions);

    // 4. Build named threats (top 10 for this org)
    final namedThreats = _buildNamedThreats(priorityIds, org.sector);

    // 5. Risk level and summary
    final riskLevel = _riskLevel(baselineRisk);
    final riskSummary = _buildRiskSummary(org, baselineRisk);

    return ThreatProfile(
      organizationId: org.id,
      sector: org.sector,
      baselineRiskScore: baselineRisk,
      riskLevel: riskLevel,
      riskSummary: riskSummary,
      topThreats: namedThreats,
      priorityTechniqueIds: priorityIds,
      coverageSuggestions: suggestions,
      sectorInsight: _sectorInsights[org.sector] ??
          'No specific sector data available.',
      commonThreatActors:
          _sectorThreatActors[org.sector] ?? [],
      generatedAt: DateTime.now(),
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  static List<String> _buildPriorityList(OrganizationProfile org) {
    final seen = <String>{};
    final result = <String>[];

    // Sector techniques first (highest priority)
    final sectorList = _sectorTechniques[org.sector] ?? _sectorTechniques[OrgSector.other]!;
    for (final id in sectorList) {
      if (seen.add(id)) result.add(id);
    }

    // Tech stack techniques next
    for (final techStr in org.techStack) {
      try {
        final tech = TechStackItem.values.firstWhere((e) => e.name == techStr);
        for (final id in (_techTechniques[tech] ?? [])) {
          if (seen.add(id)) result.add(id);
        }
      } catch (_) {}
    }

    return result;
  }

  static List<CoverageSuggestion> _buildCoverageSuggestions(
      OrganizationProfile org) {
    // Use a map to track the best (highest) suggestion per technique
    final best = <String, CoverageSuggestion>{};

    const levelOrder = ['notCovered', 'partiallyCovered', 'covered'];

    for (final ctrlStr in org.currentControls) {
      try {
        final ctrl = SecurityControl.values.firstWhere((e) => e.name == ctrlStr);
        for (final mapping in (_controlMappings[ctrl] ?? [])) {
          final existing = best[mapping.techniqueId];
          if (existing == null ||
              levelOrder.indexOf(mapping.suggestedLevel) >
                  levelOrder.indexOf(existing.suggestedLevel)) {
            best[mapping.techniqueId] = CoverageSuggestion(
              techniqueId: mapping.techniqueId,
              suggestedLevel: mapping.suggestedLevel,
              reason: '${mapping.controlSource} provides ${mapping.suggestedLevel == 'covered' ? 'full' : 'partial'} coverage for this technique.',
              controlSource: mapping.controlSource,
            );
          }
        }
      } catch (_) {}
    }

    return best.values.toList();
  }

  static double _calculateBaselineRisk(
    OrganizationProfile org,
    List<CoverageSuggestion> suggestions,
  ) {
    double baseline = _sectorBaselineRisk[org.sector] ?? 55.0;

    // Reduce risk for each security control declared
    final controls = org.securityControlItems;
    final reductionPerControl = {
      SecurityControl.mfa:               8.0,
      SecurityControl.edr:               7.0,
      SecurityControl.siem:              6.0,
      SecurityControl.emailFiltering:    5.0,
      SecurityControl.firewall:          4.0,
      SecurityControl.patchManagement:   4.0,
      SecurityControl.antivirus:         3.0,
      SecurityControl.backups:           3.0,
      SecurityControl.dlp:               3.0,
      SecurityControl.iam:               3.0,
      SecurityControl.vpn:               2.0,
      SecurityControl.securityAwareness: 4.0,
    };

    for (final ctrl in controls) {
      baseline -= reductionPerControl[ctrl] ?? 0.0;
    }

    return baseline.clamp(10.0, 95.0);
  }

  static List<NamedThreat> _buildNamedThreats(
      List<String> priorityIds, OrgSector sector) {
    final threats = <NamedThreat>[];
    int priority = 1;

    for (final id in priorityIds.take(10)) {
      final plain = _plainThreats[id];
      if (plain == null) continue;

      final riskReason = _buildRiskReason(id, sector);

      threats.add(NamedThreat(
        techniqueId: id,
        plainName: plain.name,
        plainDescription: plain.description,
        riskReason: riskReason,
        riskScore: _techniqueRiskScore(id),
        priority: priority++,
      ));
    }

    return threats;
  }

  static String _buildRiskReason(String techniqueId, OrgSector sector) {
    const reasonsBySector = <OrgSector, Map<String, String>>{
      OrgSector.healthcare: {
        'T1566': 'Healthcare workers receive high volumes of urgent emails — prime phishing targets.',
        'T1486': 'Ransomware groups specifically target hospitals to maximize pressure for payment.',
        'T1190': 'Internet-facing patient portals and PACS systems are frequently exploited.',
      },
      OrgSector.finance: {
        'T1566': 'Finance employees handle wire transfers — spearphishing has direct financial impact.',
        'T1558': 'Active Directory is standard in financial organizations — Kerberoasting is high risk.',
        'T1550': 'Credential theft enables fraudulent transaction authorization.',
      },
      OrgSector.education: {
        'T1566': 'Students and staff regularly share files via email — phishing success rates are high.',
        'T1486': 'Universities have large attack surfaces and often limited security budgets.',
        'T1110': 'Student portals and VPNs often have weak password policies.',
      },
    };

    final sectorMap = reasonsBySector[sector];
    if (sectorMap != null && sectorMap.containsKey(techniqueId)) {
      return sectorMap[techniqueId]!;
    }

    const genericReasons = <String, String>{
      'T1566': 'Phishing is the #1 initial access vector across all sectors.',
      'T1486': 'Ransomware causes average downtime of 22 days and millions in recovery costs.',
      'T1078': 'Stolen credentials are used in 61% of confirmed data breaches (Verizon DBIR 2024).',
      'T1110': 'Weak or reused passwords make brute force highly effective.',
      'T1190': 'Unpatched public-facing systems are actively scanned and exploited within hours.',
      'T1003': 'LSASS memory dumping gives attackers all domain credentials instantly.',
      'T1059': 'PowerShell and script abuse is in 84% of advanced attacks.',
      'T1021': 'Lateral movement allows attackers to reach crown jewel data.',
      'T1195': 'Supply chain attacks bypass perimeter defenses entirely.',
      'T1562': 'Disabling security tools allows attackers to operate undetected for weeks.',
    };

    return genericReasons[techniqueId] ??
        'This technique is commonly used by threat actors targeting your sector.';
  }

  static double _techniqueRiskScore(String id) {
    const scores = <String, double>{
      'T1486': 9.8, 'T1190': 9.2, 'T1566': 8.5, 'T1003': 9.5,
      'T1558': 9.3, 'T1550': 9.0, 'T1078': 8.8, 'T1059': 8.8,
      'T1562': 9.0, 'T1195': 9.5, 'T1110': 8.0, 'T1021': 8.5,
      'T1547': 7.8, 'T1056': 8.5, 'T1114': 7.5, 'T1573': 7.5,
      'T1071': 7.0, 'T1041': 8.0, 'T1204': 7.5, 'T1070': 8.0,
    };
    return scores[id] ?? scores[id.split('.').first] ?? 6.5;
  }

  static String _riskLevel(double score) {
    if (score >= 75) return 'Critical';
    if (score >= 60) return 'High';
    if (score >= 40) return 'Medium';
    if (score >= 20) return 'Low';
    return 'Minimal';
  }

  static String _buildRiskSummary(OrganizationProfile org, double risk) {
    final sector = org.sector.label;
    final level = _riskLevel(risk);
    final controls = org.securityControlItems;

    if (controls.isEmpty || controls.contains(SecurityControl.none)) {
      return '$sector with no security controls has a $level risk exposure. Immediate action recommended.';
    }

    final controlCount = controls.where((c) => c != SecurityControl.none).length;
    return '$sector with $controlCount active controls has a $level risk exposure (${risk.toStringAsFixed(0)}/100). ${_getActionableAdvice(org)}';
  }

  static String _getActionableAdvice(OrganizationProfile org) {
    final controls = org.securityControlItems;
    if (!controls.contains(SecurityControl.mfa)) {
      return 'Enabling MFA would reduce risk by ~8 points immediately.';
    }
    if (!controls.contains(SecurityControl.edr)) {
      return 'Deploying an EDR solution would significantly reduce endpoint risk.';
    }
    if (!controls.contains(SecurityControl.emailFiltering)) {
      return 'Email filtering would reduce phishing risk — the #1 entry point.';
    }
    return 'Review the priority gaps below for the highest-impact improvements.';
  }
}

// ── Internal helpers ───────────────────────────────────────────────────────

class _ControlMapping {
  final String techniqueId;
  final String suggestedLevel;
  final String controlSource;
  const _ControlMapping(this.techniqueId, this.suggestedLevel, this.controlSource);
}

class _PlainThreat {
  final String name;
  final String description;
  const _PlainThreat(this.name, this.description);
}
