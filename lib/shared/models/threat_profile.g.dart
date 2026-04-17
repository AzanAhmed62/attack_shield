// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threat_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NamedThreatImpl _$$NamedThreatImplFromJson(Map<String, dynamic> json) =>
    _$NamedThreatImpl(
      techniqueId: json['techniqueId'] as String,
      plainName: json['plainName'] as String,
      plainDescription: json['plainDescription'] as String,
      riskReason: json['riskReason'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$$NamedThreatImplToJson(_$NamedThreatImpl instance) =>
    <String, dynamic>{
      'techniqueId': instance.techniqueId,
      'plainName': instance.plainName,
      'plainDescription': instance.plainDescription,
      'riskReason': instance.riskReason,
      'riskScore': instance.riskScore,
      'priority': instance.priority,
    };

_$CoverageSuggestionImpl _$$CoverageSuggestionImplFromJson(
  Map<String, dynamic> json,
) => _$CoverageSuggestionImpl(
  techniqueId: json['techniqueId'] as String,
  suggestedLevel: json['suggestedLevel'] as String,
  reason: json['reason'] as String,
  controlSource: json['controlSource'] as String,
);

Map<String, dynamic> _$$CoverageSuggestionImplToJson(
  _$CoverageSuggestionImpl instance,
) => <String, dynamic>{
  'techniqueId': instance.techniqueId,
  'suggestedLevel': instance.suggestedLevel,
  'reason': instance.reason,
  'controlSource': instance.controlSource,
};

_$ThreatProfileImpl _$$ThreatProfileImplFromJson(Map<String, dynamic> json) =>
    _$ThreatProfileImpl(
      organizationId: json['organizationId'] as String,
      sector: $enumDecode(_$OrgSectorEnumMap, json['sector']),
      baselineRiskScore: (json['baselineRiskScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      riskSummary: json['riskSummary'] as String,
      topThreats:
          (json['topThreats'] as List<dynamic>?)
              ?.map((e) => NamedThreat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      priorityTechniqueIds:
          (json['priorityTechniqueIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      coverageSuggestions:
          (json['coverageSuggestions'] as List<dynamic>?)
              ?.map(
                (e) => CoverageSuggestion.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      sectorInsight: json['sectorInsight'] as String,
      commonThreatActors:
          (json['commonThreatActors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$ThreatProfileImplToJson(_$ThreatProfileImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'sector': _$OrgSectorEnumMap[instance.sector]!,
      'baselineRiskScore': instance.baselineRiskScore,
      'riskLevel': instance.riskLevel,
      'riskSummary': instance.riskSummary,
      'topThreats': instance.topThreats,
      'priorityTechniqueIds': instance.priorityTechniqueIds,
      'coverageSuggestions': instance.coverageSuggestions,
      'sectorInsight': instance.sectorInsight,
      'commonThreatActors': instance.commonThreatActors,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

const _$OrgSectorEnumMap = {
  OrgSector.healthcare: 'healthcare',
  OrgSector.finance: 'finance',
  OrgSector.education: 'education',
  OrgSector.retail: 'retail',
  OrgSector.government: 'government',
  OrgSector.technology: 'technology',
  OrgSector.manufacturing: 'manufacturing',
  OrgSector.energy: 'energy',
  OrgSector.sme: 'sme',
  OrgSector.personal: 'personal',
  OrgSector.other: 'other',
};
