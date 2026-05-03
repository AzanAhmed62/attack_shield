// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plain_language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlainLanguageMappingImpl _$$PlainLanguageMappingImplFromJson(
  Map<String, dynamic> json,
) => _$PlainLanguageMappingImpl(
  techniqueId: json['techniqueId'] as String,
  plainName: json['plainName'] as String,
  realWorldScenario: json['realWorldScenario'] as String,
  dangerLevel: json['dangerLevel'] as String,
  targetedTypes: json['targetedTypes'] as String,
  howYouWouldKnow: json['howYouWouldKnow'] as String,
  singleActionToTake: json['singleActionToTake'] as String,
  icon: json['icon'] as String,
  color: json['color'] as String,
  industryNotes: json['industryNotes'] as String? ?? '',
);

Map<String, dynamic> _$$PlainLanguageMappingImplToJson(
  _$PlainLanguageMappingImpl instance,
) => <String, dynamic>{
  'techniqueId': instance.techniqueId,
  'plainName': instance.plainName,
  'realWorldScenario': instance.realWorldScenario,
  'dangerLevel': instance.dangerLevel,
  'targetedTypes': instance.targetedTypes,
  'howYouWouldKnow': instance.howYouWouldKnow,
  'singleActionToTake': instance.singleActionToTake,
  'icon': instance.icon,
  'color': instance.color,
  'industryNotes': instance.industryNotes,
};

_$PlainCoverageStatusImpl _$$PlainCoverageStatusImplFromJson(
  Map<String, dynamic> json,
) => _$PlainCoverageStatusImpl(
  technicalStatus: json['technicalStatus'] as String,
  plainStatus: json['plainStatus'] as String,
  statusEmoji: json['statusEmoji'] as String,
  plainMeaning: json['plainMeaning'] as String,
  suggestion: json['suggestion'] as String,
  urgencyScore: (json['urgencyScore'] as num).toInt(),
);

Map<String, dynamic> _$$PlainCoverageStatusImplToJson(
  _$PlainCoverageStatusImpl instance,
) => <String, dynamic>{
  'technicalStatus': instance.technicalStatus,
  'plainStatus': instance.plainStatus,
  'statusEmoji': instance.statusEmoji,
  'plainMeaning': instance.plainMeaning,
  'suggestion': instance.suggestion,
  'urgencyScore': instance.urgencyScore,
};

_$OrganizationProfileV2Impl _$$OrganizationProfileV2ImplFromJson(
  Map<String, dynamic> json,
) => _$OrganizationProfileV2Impl(
  id: json['id'] as String,
  name: json['name'] as String,
  sector: $enumDecode(_$BusinessSectorEnumMap, json['sector']),
  size: $enumDecode(_$OrganizationSizeEnumMap, json['size']),
  technology: $enumDecode(_$PrimaryTechnologyEnumMap, json['technology']),
  currentDefenses: (json['currentDefenses'] as List<dynamic>)
      .map((e) => $enumDecode(_$ExistingDefensesEnumMap, e))
      .toList(),
  userTechLevel: $enumDecode(_$UserTechLevelEnumMap, json['userTechLevel']),
  appMode: json['appMode'] as String,
  baselineRiskScore: (json['baselineRiskScore'] as num).toDouble(),
  prioritizedTechniqueIds: (json['prioritizedTechniqueIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  suggestedCoverageLevels: Map<String, String>.from(
    json['suggestedCoverageLevels'] as Map,
  ),
  description: json['description'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$OrganizationProfileV2ImplToJson(
  _$OrganizationProfileV2Impl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sector': _$BusinessSectorEnumMap[instance.sector]!,
  'size': _$OrganizationSizeEnumMap[instance.size]!,
  'technology': _$PrimaryTechnologyEnumMap[instance.technology]!,
  'currentDefenses': instance.currentDefenses
      .map((e) => _$ExistingDefensesEnumMap[e]!)
      .toList(),
  'userTechLevel': _$UserTechLevelEnumMap[instance.userTechLevel]!,
  'appMode': instance.appMode,
  'baselineRiskScore': instance.baselineRiskScore,
  'prioritizedTechniqueIds': instance.prioritizedTechniqueIds,
  'suggestedCoverageLevels': instance.suggestedCoverageLevels,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$BusinessSectorEnumMap = {
  BusinessSector.healthcare: 'healthcare',
  BusinessSector.finance: 'finance',
  BusinessSector.education: 'education',
  BusinessSector.retail: 'retail',
  BusinessSector.manufacturing: 'manufacturing',
  BusinessSector.government: 'government',
  BusinessSector.nonprofit: 'nonprofit',
  BusinessSector.technology: 'technology',
  BusinessSector.hospitality: 'hospitality',
  BusinessSector.other: 'other',
};

const _$OrganizationSizeEnumMap = {
  OrganizationSize.solo: 'solo',
  OrganizationSize.small: 'small',
  OrganizationSize.medium: 'medium',
  OrganizationSize.largeSmall: 'largesmall',
  OrganizationSize.large: 'large',
};

const _$PrimaryTechnologyEnumMap = {
  PrimaryTechnology.windowsOnly: 'windows_only',
  PrimaryTechnology.macOnly: 'mac_only',
  PrimaryTechnology.linuxOnly: 'linux_only',
  PrimaryTechnology.mixedOnPrem: 'mixed_onprem',
  PrimaryTechnology.cloudPrimary: 'cloud_primary',
  PrimaryTechnology.hybrid: 'hybrid',
};

const _$ExistingDefensesEnumMap = {
  ExistingDefenses.nothing: 'nothing',
  ExistingDefenses.basicAv: 'basic_av',
  ExistingDefenses.avAndFirewall: 'av_firewall',
  ExistingDefenses.mfa: 'mfa',
  ExistingDefenses.edr: 'edr',
  ExistingDefenses.siem: 'siem',
  ExistingDefenses.comprehensive: 'comprehensive',
};

const _$UserTechLevelEnumMap = {
  UserTechLevel.notTechnical: 'not_technical',
  UserTechLevel.someTechnical: 'some_technical',
  UserTechLevel.veryTechnical: 'very_technical',
};

_$GeneratedThreatProfileImpl _$$GeneratedThreatProfileImplFromJson(
  Map<String, dynamic> json,
) => _$GeneratedThreatProfileImpl(
  threatSummary: json['threatSummary'] as String,
  sectorDescription: json['sectorDescription'] as String,
  topThreats: (json['topThreats'] as List<dynamic>)
      .map((e) => PrioritizedTechnique.fromJson(e as Map<String, dynamic>))
      .toList(),
  typicalThreatActors: (json['typicalThreatActors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  commonAttackChains: (json['commonAttackChains'] as List<dynamic>)
      .map((e) => AttackChain.fromJson(e as Map<String, dynamic>))
      .toList(),
  initialRecommendations: (json['initialRecommendations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  complianceNotes: json['complianceNotes'] as String? ?? '',
  generatedAt: DateTime.parse(json['generatedAt'] as String),
);

Map<String, dynamic> _$$GeneratedThreatProfileImplToJson(
  _$GeneratedThreatProfileImpl instance,
) => <String, dynamic>{
  'threatSummary': instance.threatSummary,
  'sectorDescription': instance.sectorDescription,
  'topThreats': instance.topThreats,
  'typicalThreatActors': instance.typicalThreatActors,
  'commonAttackChains': instance.commonAttackChains,
  'initialRecommendations': instance.initialRecommendations,
  'complianceNotes': instance.complianceNotes,
  'generatedAt': instance.generatedAt.toIso8601String(),
};

_$PrioritizedTechniqueImpl _$$PrioritizedTechniqueImplFromJson(
  Map<String, dynamic> json,
) => _$PrioritizedTechniqueImpl(
  techniqueId: json['techniqueId'] as String,
  techniqueName: json['techniqueName'] as String,
  plainLanguageName: json['plainLanguageName'] as String,
  priorityScore: (json['priorityScore'] as num).toDouble(),
  whyMatters: json['whyMatters'] as String,
  suggestedCoverage: json['suggestedCoverage'] as String,
  prevalenceInSector: json['prevalenceInSector'] as String? ?? '',
  averageImpact: json['averageImpact'] as String? ?? '',
);

Map<String, dynamic> _$$PrioritizedTechniqueImplToJson(
  _$PrioritizedTechniqueImpl instance,
) => <String, dynamic>{
  'techniqueId': instance.techniqueId,
  'techniqueName': instance.techniqueName,
  'plainLanguageName': instance.plainLanguageName,
  'priorityScore': instance.priorityScore,
  'whyMatters': instance.whyMatters,
  'suggestedCoverage': instance.suggestedCoverage,
  'prevalenceInSector': instance.prevalenceInSector,
  'averageImpact': instance.averageImpact,
};

_$AttackChainImpl _$$AttackChainImplFromJson(Map<String, dynamic> json) =>
    _$AttackChainImpl(
      name: json['name'] as String,
      techniques: (json['techniques'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      realWorldExample: json['realWorldExample'] as String,
      typicalTimeline: json['typicalTimeline'] as String? ?? '',
      typicalCost: json['typicalCost'] as String? ?? '',
    );

Map<String, dynamic> _$$AttackChainImplToJson(_$AttackChainImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'techniques': instance.techniques,
      'description': instance.description,
      'realWorldExample': instance.realWorldExample,
      'typicalTimeline': instance.typicalTimeline,
      'typicalCost': instance.typicalCost,
    };

_$SectorProfileImpl _$$SectorProfileImplFromJson(Map<String, dynamic> json) =>
    _$SectorProfileImpl(
      sector: $enumDecode(_$BusinessSectorEnumMap, json['sector']),
      description: json['description'] as String,
      icon: json['icon'] as String,
      topThreats: (json['topThreats'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      commonThreatActors: (json['commonThreatActors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      techniqueRiskMultipliers:
          (json['techniqueRiskMultipliers'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ),
      complianceRequirements: (json['complianceRequirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      averageBreachCost: json['averageBreachCost'] as String,
    );

Map<String, dynamic> _$$SectorProfileImplToJson(_$SectorProfileImpl instance) =>
    <String, dynamic>{
      'sector': _$BusinessSectorEnumMap[instance.sector]!,
      'description': instance.description,
      'icon': instance.icon,
      'topThreats': instance.topThreats,
      'commonThreatActors': instance.commonThreatActors,
      'techniqueRiskMultipliers': instance.techniqueRiskMultipliers,
      'complianceRequirements': instance.complianceRequirements,
      'averageBreachCost': instance.averageBreachCost,
    };
