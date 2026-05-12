// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuidedSimulationScenarioImpl _$$GuidedSimulationScenarioImplFromJson(
  Map<String, dynamic> json,
) => _$GuidedSimulationScenarioImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  attackNarrative: json['attackNarrative'] as String,
  involvedTactics: (json['involvedTactics'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  involvedTechniques: (json['involvedTechniques'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  difficulty: json['difficulty'] as String,
  estimatedDurationMinutes: (json['estimatedDurationMinutes'] as num).toInt(),
  threatActorProfile: json['threatActorProfile'] as String,
  targetedSectors: (json['targetedSectors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  checkpoints: (json['checkpoints'] as List<dynamic>)
      .map((e) => SimulationCheckpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  remediationPlaybook: (json['remediationPlaybook'] as List<dynamic>)
      .map((e) => RemediationAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdBy: json['createdBy'] as String,
  createdDate: DateTime.parse(json['createdDate'] as String),
  version: (json['version'] as num).toInt(),
);

Map<String, dynamic> _$$GuidedSimulationScenarioImplToJson(
  _$GuidedSimulationScenarioImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'attackNarrative': instance.attackNarrative,
  'involvedTactics': instance.involvedTactics,
  'involvedTechniques': instance.involvedTechniques,
  'difficulty': instance.difficulty,
  'estimatedDurationMinutes': instance.estimatedDurationMinutes,
  'threatActorProfile': instance.threatActorProfile,
  'targetedSectors': instance.targetedSectors,
  'checkpoints': instance.checkpoints,
  'remediationPlaybook': instance.remediationPlaybook,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate.toIso8601String(),
  'version': instance.version,
};

_$SimulationCheckpointImpl _$$SimulationCheckpointImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationCheckpointImpl(
  id: json['id'] as String,
  sequenceNumber: (json['sequenceNumber'] as num).toInt(),
  attackStepNarrative: json['attackStepNarrative'] as String,
  techniqueId: json['techniqueId'] as String,
  techniqueName: json['techniqueName'] as String,
  whatToCheck: json['whatToCheck'] as String,
  indicatorExamples: (json['indicatorExamples'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  evidenceType: json['evidenceType'] as String,
  detectionTool: json['detectionTool'] as String,
  successIndicators: (json['successIndicators'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  failureIndicators: (json['failureIndicators'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  pointsIfDetected: (json['pointsIfDetected'] as num).toInt(),
  pointsIfMissed: (json['pointsIfMissed'] as num).toInt(),
);

Map<String, dynamic> _$$SimulationCheckpointImplToJson(
  _$SimulationCheckpointImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sequenceNumber': instance.sequenceNumber,
  'attackStepNarrative': instance.attackStepNarrative,
  'techniqueId': instance.techniqueId,
  'techniqueName': instance.techniqueName,
  'whatToCheck': instance.whatToCheck,
  'indicatorExamples': instance.indicatorExamples,
  'evidenceType': instance.evidenceType,
  'detectionTool': instance.detectionTool,
  'successIndicators': instance.successIndicators,
  'failureIndicators': instance.failureIndicators,
  'pointsIfDetected': instance.pointsIfDetected,
  'pointsIfMissed': instance.pointsIfMissed,
};

_$CheckpointEvidenceImpl _$$CheckpointEvidenceImplFromJson(
  Map<String, dynamic> json,
) => _$CheckpointEvidenceImpl(
  checkpointId: json['checkpointId'] as String,
  evidenceType: json['evidenceType'] as String,
  screenshotPath: json['screenshotPath'] as String?,
  logExcerpt: json['logExcerpt'] as String?,
  yesNoAnswer: json['yesNoAnswer'] as bool?,
  textResponse: json['textResponse'] as String?,
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
);

Map<String, dynamic> _$$CheckpointEvidenceImplToJson(
  _$CheckpointEvidenceImpl instance,
) => <String, dynamic>{
  'checkpointId': instance.checkpointId,
  'evidenceType': instance.evidenceType,
  'screenshotPath': instance.screenshotPath,
  'logExcerpt': instance.logExcerpt,
  'yesNoAnswer': instance.yesNoAnswer,
  'textResponse': instance.textResponse,
  'submittedAt': instance.submittedAt?.toIso8601String(),
};

_$CheckpointEvaluationImpl _$$CheckpointEvaluationImplFromJson(
  Map<String, dynamic> json,
) => _$CheckpointEvaluationImpl(
  checkpointId: json['checkpointId'] as String,
  evaluationType: json['evaluationType'] as String,
  evaluation: json['evaluation'] as String,
  pointsAwarded: (json['pointsAwarded'] as num).toInt(),
  feedback: json['feedback'] as String,
  suggestedActions: (json['suggestedActions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  evaluatedAt: json['evaluatedAt'] == null
      ? null
      : DateTime.parse(json['evaluatedAt'] as String),
);

Map<String, dynamic> _$$CheckpointEvaluationImplToJson(
  _$CheckpointEvaluationImpl instance,
) => <String, dynamic>{
  'checkpointId': instance.checkpointId,
  'evaluationType': instance.evaluationType,
  'evaluation': instance.evaluation,
  'pointsAwarded': instance.pointsAwarded,
  'feedback': instance.feedback,
  'suggestedActions': instance.suggestedActions,
  'evaluatedAt': instance.evaluatedAt?.toIso8601String(),
};

_$SimulationSessionImpl _$$SimulationSessionImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationSessionImpl(
  id: json['id'] as String,
  scenarioId: json['scenarioId'] as String,
  userId: json['userId'] as String,
  organizationId: json['organizationId'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  status: json['status'] as String,
  evidenceSubmissions: (json['evidenceSubmissions'] as List<dynamic>)
      .map((e) => CheckpointEvidence.fromJson(e as Map<String, dynamic>))
      .toList(),
  evaluations: (json['evaluations'] as List<dynamic>)
      .map((e) => CheckpointEvaluation.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentCheckpointIndex: (json['currentCheckpointIndex'] as num).toInt(),
  hasViewedNarrative: json['hasViewedNarrative'] as bool,
);

Map<String, dynamic> _$$SimulationSessionImplToJson(
  _$SimulationSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'scenarioId': instance.scenarioId,
  'userId': instance.userId,
  'organizationId': instance.organizationId,
  'startedAt': instance.startedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'status': instance.status,
  'evidenceSubmissions': instance.evidenceSubmissions,
  'evaluations': instance.evaluations,
  'currentCheckpointIndex': instance.currentCheckpointIndex,
  'hasViewedNarrative': instance.hasViewedNarrative,
};

_$DefensiveReadinessScoreImpl _$$DefensiveReadinessScoreImplFromJson(
  Map<String, dynamic> json,
) => _$DefensiveReadinessScoreImpl(
  sessionId: json['sessionId'] as String,
  scenarioId: json['scenarioId'] as String,
  totalPointsPossible: (json['totalPointsPossible'] as num).toInt(),
  pointsEarned: (json['pointsEarned'] as num).toInt(),
  percentageScore: (json['percentageScore'] as num).toDouble(),
  gradeLevel: json['gradeLevel'] as String,
  readinessLevel: json['readinessLevel'] as String,
  scoreByTactic: Map<String, int>.from(json['scoreByTactic'] as Map),
  detectedTechniques: (json['detectedTechniques'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  missedTechniques: (json['missedTechniques'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  strongAreas: (json['strongAreas'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  weakAreas: (json['weakAreas'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  prioritizedRemediations: (json['prioritizedRemediations'] as List<dynamic>)
      .map((e) => RemediationAction.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DefensiveReadinessScoreImplToJson(
  _$DefensiveReadinessScoreImpl instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'scenarioId': instance.scenarioId,
  'totalPointsPossible': instance.totalPointsPossible,
  'pointsEarned': instance.pointsEarned,
  'percentageScore': instance.percentageScore,
  'gradeLevel': instance.gradeLevel,
  'readinessLevel': instance.readinessLevel,
  'scoreByTactic': instance.scoreByTactic,
  'detectedTechniques': instance.detectedTechniques,
  'missedTechniques': instance.missedTechniques,
  'strongAreas': instance.strongAreas,
  'weakAreas': instance.weakAreas,
  'prioritizedRemediations': instance.prioritizedRemediations,
};

_$RemediationActionImpl _$$RemediationActionImplFromJson(
  Map<String, dynamic> json,
) => _$RemediationActionImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  relatedTechnique: json['relatedTechnique'] as String,
  relatedMitigation: json['relatedMitigation'] as String,
  priority: (json['priority'] as num).toInt(),
  difficulty: json['difficulty'] as String,
  targetedTool: json['targetedTool'] as String,
  implementationSteps: (json['implementationSteps'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  expectedOutcome: json['expectedOutcome'] as String,
);

Map<String, dynamic> _$$RemediationActionImplToJson(
  _$RemediationActionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'relatedTechnique': instance.relatedTechnique,
  'relatedMitigation': instance.relatedMitigation,
  'priority': instance.priority,
  'difficulty': instance.difficulty,
  'targetedTool': instance.targetedTool,
  'implementationSteps': instance.implementationSteps,
  'expectedOutcome': instance.expectedOutcome,
};

_$SimulationAnalyticsImpl _$$SimulationAnalyticsImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationAnalyticsImpl(
  userId: json['userId'] as String,
  organizationId: json['organizationId'] as String,
  totalScenariosCompleted: (json['totalScenariosCompleted'] as num).toInt(),
  averageScorePercentage: (json['averageScorePercentage'] as num).toDouble(),
  completedScenarioIds: (json['completedScenarioIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  averageScoreByTactic: (json['averageScoreByTactic'] as Map<String, dynamic>)
      .map((k, e) => MapEntry(k, (e as num).toDouble())),
  consistentlyDetectedTechniques:
      (json['consistentlyDetectedTechniques'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  consistentlyMissedTechniques:
      (json['consistentlyMissedTechniques'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  overallDefensiveProfile: json['overallDefensiveProfile'] as String,
  lastSimulationDate: DateTime.parse(json['lastSimulationDate'] as String),
  recentSessions: (json['recentSessions'] as List<dynamic>)
      .map((e) => SimulationSessionSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SimulationAnalyticsImplToJson(
  _$SimulationAnalyticsImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'organizationId': instance.organizationId,
  'totalScenariosCompleted': instance.totalScenariosCompleted,
  'averageScorePercentage': instance.averageScorePercentage,
  'completedScenarioIds': instance.completedScenarioIds,
  'averageScoreByTactic': instance.averageScoreByTactic,
  'consistentlyDetectedTechniques': instance.consistentlyDetectedTechniques,
  'consistentlyMissedTechniques': instance.consistentlyMissedTechniques,
  'overallDefensiveProfile': instance.overallDefensiveProfile,
  'lastSimulationDate': instance.lastSimulationDate.toIso8601String(),
  'recentSessions': instance.recentSessions,
};

_$SimulationSessionSummaryImpl _$$SimulationSessionSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationSessionSummaryImpl(
  sessionId: json['sessionId'] as String,
  scenarioTitle: json['scenarioTitle'] as String,
  completedDate: DateTime.parse(json['completedDate'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  scorePercentage: (json['scorePercentage'] as num).toDouble(),
  gradeLevel: json['gradeLevel'] as String,
  checkpointsDetected: (json['checkpointsDetected'] as num).toInt(),
  checkpointsMissed: (json['checkpointsMissed'] as num).toInt(),
);

Map<String, dynamic> _$$SimulationSessionSummaryImplToJson(
  _$SimulationSessionSummaryImpl instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'scenarioTitle': instance.scenarioTitle,
  'completedDate': instance.completedDate.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'scorePercentage': instance.scorePercentage,
  'gradeLevel': instance.gradeLevel,
  'checkpointsDetected': instance.checkpointsDetected,
  'checkpointsMissed': instance.checkpointsMissed,
};
