import 'package:freezed_annotation/freezed_annotation.dart';

// ════════════════════════════════════════════════════════════════════════════════
// GUIDED SIMULATION ENGINE — Data Models
//
// Purpose: Walk users through realistic attack scenarios step-by-step, collecting
// evidence at each checkpoint, scoring their defensive readiness against real TTPs.
//
// Unique feature: Defensive (user perspective), not offensive (red team perspective)
// Target: Non-technical users who can recognize attack indicators
// ════════════════════════════════════════════════════════════════════════════════

part 'simulation_models.freezed.dart';
part 'simulation_models.g.dart';

/// ════════════════════════════════════════════════════════════════════════════════
/// GUIDED SIMULATION SCENARIO
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class GuidedSimulationScenario with _$GuidedSimulationScenario {
  const factory GuidedSimulationScenario({
    required String id,
    required String title,
    required String description,
    required String attackNarrative,
    required List<String> involvedTactics,
    required List<String> involvedTechniques,
    required String difficulty, // 'beginner', 'intermediate', 'advanced'
    required int estimatedDurationMinutes,
    required String threatActorProfile,
    required List<String> targetedSectors,
    required List<SimulationCheckpoint> checkpoints,
    required List<RemediationAction> remediationPlaybook,
    required String createdBy, // 'system', 'community', 'ai_generated'
    required DateTime createdDate,
    required int version,
  }) = _GuidedSimulationScenario;

  factory GuidedSimulationScenario.fromJson(Map<String, dynamic> json) =>
      _$GuidedSimulationScenarioFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SIMULATION CHECKPOINT
///
/// Each checkpoint represents one step in the attack chain where the user can:
/// 1. Read what to check for
/// 2. Submit evidence (screenshot, log excerpt, yes/no answer)
/// 3. Get scored on whether they detected it
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class SimulationCheckpoint with _$SimulationCheckpoint {
  const factory SimulationCheckpoint({
    required String id,
    required int sequenceNumber,
    required String attackStepNarrative,
    required String techniqueId,
    required String techniqueName,
    required String whatToCheck, // Plain English: "Look for..."
    required List<String> indicatorExamples, // Real examples user might see
    required String
    evidenceType, // 'screenshot', 'log_excerpt', 'yes_no', 'text'
    required String
    detectionTool, // 'Windows Event Viewer', 'Email Gateway', 'EDR', etc.
    required List<String> successIndicators, // What indicates detection success
    required List<String> failureIndicators, // What indicates miss
    required int pointsIfDetected,
    required int pointsIfMissed,
  }) = _SimulationCheckpoint;

  factory SimulationCheckpoint.fromJson(Map<String, dynamic> json) =>
      _$SimulationCheckpointFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// CHECKPOINT EVIDENCE
///
/// What the user submits as proof of detection at each checkpoint
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class CheckpointEvidence with _$CheckpointEvidence {
  const factory CheckpointEvidence({
    required String checkpointId,
    required String
    evidenceType, // 'screenshot', 'log_excerpt', 'yes_no', 'text'
    String? screenshotPath, // File path if screenshot
    String? logExcerpt, // Copied log line
    bool? yesNoAnswer, // true = detected, false = missed
    String? textResponse, // Free-form text answer
    @Default(null) DateTime? submittedAt,
  }) = _CheckpointEvidence;

  factory CheckpointEvidence.fromJson(Map<String, dynamic> json) =>
      _$CheckpointEvidenceFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// CHECKPOINT EVALUATION
///
/// System's scoring of user's evidence at each checkpoint
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class CheckpointEvaluation with _$CheckpointEvaluation {
  const factory CheckpointEvaluation({
    required String checkpointId,
    required String evaluationType, // 'automated', 'manual', 'ai_assisted'
    required String
    evaluation, // 'detected', 'missed', 'partial', 'inconclusive'
    required int pointsAwarded,
    required String feedback, // Explanation of score
    required List<String> suggestedActions, // What to do next
    @Default(null) DateTime? evaluatedAt,
  }) = _CheckpointEvaluation;

  factory CheckpointEvaluation.fromJson(Map<String, dynamic> json) =>
      _$CheckpointEvaluationFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SIMULATION SESSION
///
/// One user's run-through of a scenario from start to finish
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class SimulationSession with _$SimulationSession {
  const factory SimulationSession({
    required String id,
    required String scenarioId,
    required String userId,
    required String organizationId,
    required DateTime startedAt,
    DateTime? completedAt,
    required String status, // 'in_progress', 'completed', 'abandoned'
    required List<CheckpointEvidence> evidenceSubmissions,
    required List<CheckpointEvaluation> evaluations,
    required int currentCheckpointIndex,
    required bool hasViewedNarrative,
  }) = _SimulationSession;

  factory SimulationSession.fromJson(Map<String, dynamic> json) =>
      _$SimulationSessionFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// DEFENSIVE READINESS SCORE
///
/// Per-scenario score showing how well the user detected the attack
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class DefensiveReadinessScore with _$DefensiveReadinessScore {
  const factory DefensiveReadinessScore({
    required String sessionId,
    required String scenarioId,
    required int totalPointsPossible,
    required int pointsEarned,
    required double percentageScore, // 0-100
    required String gradeLevel, // 'A', 'B', 'C', 'D', 'F'
    required String
    readinessLevel, // 'Expert', 'Proficient', 'Developing', 'Novice'
    required Map<String, int> scoreByTactic, // Score per tactic involved
    required List<String> detectedTechniques, // Techniques user caught
    required List<String> missedTechniques, // Techniques user missed
    required List<String> strongAreas, // "Detection is strong for..."
    required List<String> weakAreas, // "Detection needs work for..."
    required List<RemediationAction> prioritizedRemediations,
  }) = _DefensiveReadinessScore;

  factory DefensiveReadinessScore.fromJson(Map<String, dynamic> json) =>
      _$DefensiveReadinessScoreFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// REMEDIATION ACTION
///
/// Specific, actionable fix for a detection gap or weakness
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class RemediationAction with _$RemediationAction {
  const factory RemediationAction({
    required String id,
    required String title,
    required String description,
    required String relatedTechnique,
    required String relatedMitigation, // MITRE mitigation ID (M1234)
    required int priority, // 1=critical, 2=high, 3=medium, 4=low
    required String difficulty, // 'quick_win', 'moderate', 'complex'
    required String targetedTool, // 'Windows Defender', 'Email Gateway', etc.
    required List<String> implementationSteps,
    required String expectedOutcome,
  }) = _RemediationAction;

  factory RemediationAction.fromJson(Map<String, dynamic> json) =>
      _$RemediationActionFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SIMULATION ANALYTICS
///
/// Track performance across multiple simulation runs
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class SimulationAnalytics with _$SimulationAnalytics {
  const factory SimulationAnalytics({
    required String userId,
    required String organizationId,
    required int totalScenariosCompleted,
    required double averageScorePercentage,
    required List<String> completedScenarioIds,
    required Map<String, double> averageScoreByTactic, // T1234 -> 75.5%
    required List<String> consistentlyDetectedTechniques,
    required List<String> consistentlyMissedTechniques,
    required String overallDefensiveProfile, // Based on patterns
    required DateTime lastSimulationDate,
    required List<SimulationSessionSummary> recentSessions,
  }) = _SimulationAnalytics;

  factory SimulationAnalytics.fromJson(Map<String, dynamic> json) =>
      _$SimulationAnalyticsFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SIMULATION SESSION SUMMARY
///
/// Quick summary of one completed session for analytics
/// ════════════════════════════════════════════════════════════════════════════════

@freezed
class SimulationSessionSummary with _$SimulationSessionSummary {
  const factory SimulationSessionSummary({
    required String sessionId,
    required String scenarioTitle,
    required DateTime completedDate,
    required int durationMinutes,
    required double scorePercentage,
    required String gradeLevel,
    required int checkpointsDetected,
    required int checkpointsMissed,
  }) = _SimulationSessionSummary;

  factory SimulationSessionSummary.fromJson(Map<String, dynamic> json) =>
      _$SimulationSessionSummaryFromJson(json);
}

/// ════════════════════════════════════════════════════════════════════════════════
/// PRE-BUILT SCENARIOS (System Scenarios)
///
/// Predefined realistic attack scenarios based on MITRE ATT&CK tactics
/// ════════════════════════════════════════════════════════════════════════════════

class PredefinedScenarios {
  /// Scenario 1: Initial Access — Phishing Campaign
  static GuidedSimulationScenario
  phishingCampaignScenario() =>   GuidedSimulationScenario(
    id: 'scenario_phishing_001',
    title: 'Email Phishing Campaign — Detection Challenge',
    description:
        'An attacker sends phishing emails to your organization. Can you spot and block them?',
    attackNarrative:
        'Your CEO receives a seemingly legitimate email from "payroll@company.com" asking them to '
        'update their banking information for the 401k system. The email looks professional, includes company branding, '
        'and uses the CEO\'s name. However, the attacker has registered a lookalike domain and compromised a third-party '
        'email relay. Can your defenses catch this? What should your email gateway show? What should your users do?',
    involvedTactics: ['TA0001'], // Initial Access
    involvedTechniques: ['T1566.001', 'T1566.002'], // Phishing
    difficulty: 'beginner',
    estimatedDurationMinutes: 5,
    threatActorProfile: 'Generic phishing campaign (likely crimeware)',
    targetedSectors: ['All'],
    checkpoints: [], // Populated by engine
    remediationPlaybook: [], // Populated by engine
    createdBy: 'system',
    createdDate: DateTime(2026, 4, 24),
    version: 1,
  );

  /// Scenario 2: Execution — Malware Execution via Script
  static GuidedSimulationScenario
  malwareExecutionScenario() =>   GuidedSimulationScenario(
    id: 'scenario_malware_exec_001',
    title: 'Malware Execution — PowerShell Script Injection',
    description:
        'A user downloads what looks like an Excel file but contains a malicious script. What does your endpoint protection show?',
    attackNarrative:
        'An attacker distributes a malicious Excel file via email or torrent. When opened, it uses Excel\'s macro feature '
        'to execute a PowerShell script in the background. The script downloads a second-stage payload (ransomware or info stealer). '
        'Your user doesn\'t see anything unusual. Can your EDR detect the suspicious PowerShell activity? Can your email gateway block the file?',
    involvedTactics: ['TA0002'], // Execution
    involvedTechniques: ['T1204.002', 'T1059.001', 'T1566.001'],
    difficulty: 'intermediate',
    estimatedDurationMinutes: 8,
    threatActorProfile: 'Ransomware operator or APT group',
    targetedSectors: ['Finance', 'Healthcare', 'Government'],
    checkpoints: [],
    remediationPlaybook: [],
    createdBy: 'system',
    createdDate: DateTime(2026, 4, 24),
    version: 1,
  );

  /// Scenario 3: Persistence — Scheduled Task Creation
  static GuidedSimulationScenario
  persistenceScenario() =>   GuidedSimulationScenario(
    id: 'scenario_persistence_001',
    title: 'Persistence — Hidden Scheduled Task',
    description:
        'An attacker has gained access to a workstation and created a hidden scheduled task to maintain persistence.',
    attackNarrative:
        'After compromising a Windows machine via RDP brute force, the attacker creates a hidden scheduled task that runs '
        'malware every 4 hours. The malware connects back to a command-and-control server. The user doesn\'t notice anything unusual. '
        'Your detection needs to find this scheduled task and the network connection. Can your SIEM or EDR catch it?',
    involvedTactics: ['TA0003'], // Persistence
    involvedTechniques: ['T1053.005', 'T1071.001'], // Scheduled Task + C2
    difficulty: 'advanced',
    estimatedDurationMinutes: 10,
    threatActorProfile: 'Opportunistic access broker',
    targetedSectors: ['All'],
    checkpoints: [],
    remediationPlaybook: [],
    createdBy: 'system',
    createdDate: DateTime(2026, 4, 24),
    version: 1,
  );

  /// Scenario 4: Privilege Escalation — Credential Dumping
  static GuidedSimulationScenario
  credentialDumpingScenario() =>   GuidedSimulationScenario(
    id: 'scenario_priv_esc_001',
    title: 'Privilege Escalation — Credential Dumping',
    description:
        'An attacker with user-level access attempts to dump NTLM hashes from the local SAM database.',
    attackNarrative:
        'A standard user account has been compromised. The attacker runs a tool like Mimikatz or similar to extract cached credentials '
        'from the Windows Security Accounts Manager. They are looking for admin credentials to escalate their access. '
        'Can your EDR detect the credential dumping attempt? Will your SIEM flag the suspicious process?',
    involvedTactics: ['TA0004'], // Privilege Escalation
    involvedTechniques: ['T1003.001'], // OS Credential Dumping
    difficulty: 'advanced',
    estimatedDurationMinutes: 8,
    threatActorProfile: 'Post-compromise attacker',
    targetedSectors: ['All'],
    checkpoints: [],
    remediationPlaybook: [],
    createdBy: 'system',
    createdDate: DateTime(2026, 4, 24),
    version: 1,
  );

  /// Scenario 5: Defense Evasion — Disabling Windows Defender
  static GuidedSimulationScenario
  evasionScenario() =>   GuidedSimulationScenario(
    id: 'scenario_evasion_001',
    title: 'Defense Evasion — Antivirus Disablement',
    description: 'An attacker disables Windows Defender to operate undetected.',
    attackNarrative:
        'Using admin credentials (obtained via credential theft), the attacker modifies Windows Defender settings or uses PowerShell '
        'to disable real-time scanning and exclude folders from protection. They then deploy malware into the excluded folder. '
        'Can you detect when Windows Defender is disabled? Can you alert on suspicious registry modifications?',
    involvedTactics: ['TA0005'], // Defense Evasion
    involvedTechniques: [
      'T1562.001',
      'T1112',
    ], // Disable Windows Defender + Modify Registry
    difficulty: 'intermediate',
    estimatedDurationMinutes: 7,
    threatActorProfile: 'Post-compromise attacker',
    targetedSectors: ['All'],
    checkpoints: [],
    remediationPlaybook: [],
    createdBy: 'system',
    createdDate: DateTime(2026, 4, 24),
    version: 1,
  );
}

/// ════════════════════════════════════════════════════════════════════════════════
/// CHECKPOINT HELPER FACTORY
///
/// Generate realistic checkpoints for a scenario
/// ════════════════════════════════════════════════════════════════════════════════

class SimulationCheckpointFactory {
  /// Generate checkpoint for T1566.001 (Spearphishing Attachment)
  static SimulationCheckpoint
  spearphishingCheckpoint() => const SimulationCheckpoint(
    id: 'checkpoint_T1566_001_email_gateway',
    sequenceNumber: 1,
    attackStepNarrative:
        'The attacker sends a phishing email with a malicious attachment to an executive.',
    techniqueId: 'T1566.001',
    techniqueName: 'Spearphishing Attachment',
    whatToCheck:
        'Check your email gateway (Gmail, Office 365, Proofpoint, etc.) for emails with suspicious attachments.',
    indicatorExamples: [
      'Email from unfamiliar sender or suspicious domain (e.g., "payroll@co-mpany.com")',
      'Email requesting urgent action (password update, banking info, contract signature)',
      'Attachment type suspicious: .exe, .msi, .scr, .com, or macro-enabled .xls/.doc',
      'Sender claims to be internal but domain is external',
    ],
    evidenceType: 'screenshot',
    detectionTool: 'Email Gateway (Gmail, Office 365, Proofpoint)',
    successIndicators: [
      'Email was quarantined or flagged as spam',
      'Attachment was blocked or sandboxed',
      'Email showed security warning to recipient',
    ],
    failureIndicators: [
      'Email delivered to inbox undetected',
      'Attachment was not scanned or blocked',
      'No security warning shown to user',
    ],
    pointsIfDetected: 20,
    pointsIfMissed: 0,
  );

  /// Generate checkpoint for T1204.002 (User Execution: Malicious File)
  static SimulationCheckpoint
  userExecutionCheckpoint() => const SimulationCheckpoint(
    id: 'checkpoint_T1204_002_file_execution',
    sequenceNumber: 2,
    attackStepNarrative:
        'Despite the email warning, the user clicks the attachment and opens the malicious file.',
    techniqueId: 'T1204.002',
    techniqueName: 'User Execution — Malicious File',
    whatToCheck:
        'Check your endpoint detection and response (EDR) or antivirus for suspicious file execution.',
    indicatorExamples: [
      'File execution from Downloads folder or AppData folder',
      'Process parent is explorer.exe or Word/Excel process',
      'File has suspicious name (invoice_2024.exe, update.scr)',
      'Hash not in Windows Defender SmartScreen database',
    ],
    evidenceType: 'log_excerpt',
    detectionTool: 'EDR (Defender for Endpoint, CrowdStrike, SentinelOne)',
    successIndicators: [
      'EDR blocked execution of suspicious file',
      'Antivirus quarantined the file',
      'Process was terminated before malware executed',
    ],
    failureIndicators: [
      'File executed without interference',
      'No EDR alert generated',
      'Process ran with full privileges',
    ],
    pointsIfDetected: 25,
    pointsIfMissed: 0,
  );

  /// Generate checkpoint for T1059.001 (PowerShell - Command and Scripting Interpreter)
  static SimulationCheckpoint
  powershellCheckpoint() => const SimulationCheckpoint(
    id: 'checkpoint_T1059_001_powershell',
    sequenceNumber: 3,
    attackStepNarrative:
        'The malware spawns a PowerShell process to download the second-stage payload.',
    techniqueId: 'T1059.001',
    techniqueName: 'Command and Scripting Interpreter — PowerShell',
    whatToCheck:
        'Check for suspicious PowerShell execution with encoded commands or suspicious network connections.',
    indicatorExamples: [
      'Event ID 4688: powershell.exe spawned with argument "-NoProfile -ExecutionPolicy Bypass"',
      'Event ID 4688: powershell.exe with argument containing "-enc" or "-e" (encoded command)',
      'Suspicious parent process: Word/Excel spawning PowerShell',
      'PowerShell command downloading from unusual URL (IWR, Invoke-WebRequest, DownloadFile)',
    ],
    evidenceType: 'log_excerpt',
    detectionTool: 'Windows Event Viewer (Event ID 4688), EDR, SIEM',
    successIndicators: [
      'PowerShell execution blocked by Windows Defender',
      'Process terminated by EDR before network connection',
      'SIEM generated alert for suspicious PowerShell activity',
    ],
    failureIndicators: [
      'PowerShell executed without logging',
      'Encoded command executed silently',
      'No alert on network connection',
    ],
    pointsIfDetected: 30,
    pointsIfMissed: 0,
  );
}
