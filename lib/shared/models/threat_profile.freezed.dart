// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'threat_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NamedThreat _$NamedThreatFromJson(Map<String, dynamic> json) {
  return _NamedThreat.fromJson(json);
}

/// @nodoc
mixin _$NamedThreat {
  String get techniqueId => throw _privateConstructorUsedError; // e.g. 'T1566'
  String get plainName =>
      throw _privateConstructorUsedError; // e.g. 'Fake emails (Phishing)'
  String get plainDescription =>
      throw _privateConstructorUsedError; // e.g. 'Attackers send emails pretending to be...'
  String get riskReason =>
      throw _privateConstructorUsedError; // e.g. 'Healthcare is the #1 phishing target'
  double get riskScore => throw _privateConstructorUsedError; // 0–10
  int get priority => throw _privateConstructorUsedError;

  /// Serializes this NamedThreat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NamedThreat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NamedThreatCopyWith<NamedThreat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamedThreatCopyWith<$Res> {
  factory $NamedThreatCopyWith(
    NamedThreat value,
    $Res Function(NamedThreat) then,
  ) = _$NamedThreatCopyWithImpl<$Res, NamedThreat>;
  @useResult
  $Res call({
    String techniqueId,
    String plainName,
    String plainDescription,
    String riskReason,
    double riskScore,
    int priority,
  });
}

/// @nodoc
class _$NamedThreatCopyWithImpl<$Res, $Val extends NamedThreat>
    implements $NamedThreatCopyWith<$Res> {
  _$NamedThreatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NamedThreat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? plainName = null,
    Object? plainDescription = null,
    Object? riskReason = null,
    Object? riskScore = null,
    Object? priority = null,
  }) {
    return _then(
      _value.copyWith(
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            plainName: null == plainName
                ? _value.plainName
                : plainName // ignore: cast_nullable_to_non_nullable
                      as String,
            plainDescription: null == plainDescription
                ? _value.plainDescription
                : plainDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            riskReason: null == riskReason
                ? _value.riskReason
                : riskReason // ignore: cast_nullable_to_non_nullable
                      as String,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NamedThreatImplCopyWith<$Res>
    implements $NamedThreatCopyWith<$Res> {
  factory _$$NamedThreatImplCopyWith(
    _$NamedThreatImpl value,
    $Res Function(_$NamedThreatImpl) then,
  ) = __$$NamedThreatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String techniqueId,
    String plainName,
    String plainDescription,
    String riskReason,
    double riskScore,
    int priority,
  });
}

/// @nodoc
class __$$NamedThreatImplCopyWithImpl<$Res>
    extends _$NamedThreatCopyWithImpl<$Res, _$NamedThreatImpl>
    implements _$$NamedThreatImplCopyWith<$Res> {
  __$$NamedThreatImplCopyWithImpl(
    _$NamedThreatImpl _value,
    $Res Function(_$NamedThreatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NamedThreat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? plainName = null,
    Object? plainDescription = null,
    Object? riskReason = null,
    Object? riskScore = null,
    Object? priority = null,
  }) {
    return _then(
      _$NamedThreatImpl(
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        plainName: null == plainName
            ? _value.plainName
            : plainName // ignore: cast_nullable_to_non_nullable
                  as String,
        plainDescription: null == plainDescription
            ? _value.plainDescription
            : plainDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        riskReason: null == riskReason
            ? _value.riskReason
            : riskReason // ignore: cast_nullable_to_non_nullable
                  as String,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedThreatImpl implements _NamedThreat {
  const _$NamedThreatImpl({
    required this.techniqueId,
    required this.plainName,
    required this.plainDescription,
    required this.riskReason,
    required this.riskScore,
    required this.priority,
  });

  factory _$NamedThreatImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamedThreatImplFromJson(json);

  @override
  final String techniqueId;
  // e.g. 'T1566'
  @override
  final String plainName;
  // e.g. 'Fake emails (Phishing)'
  @override
  final String plainDescription;
  // e.g. 'Attackers send emails pretending to be...'
  @override
  final String riskReason;
  // e.g. 'Healthcare is the #1 phishing target'
  @override
  final double riskScore;
  // 0–10
  @override
  final int priority;

  @override
  String toString() {
    return 'NamedThreat(techniqueId: $techniqueId, plainName: $plainName, plainDescription: $plainDescription, riskReason: $riskReason, riskScore: $riskScore, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedThreatImpl &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.plainName, plainName) ||
                other.plainName == plainName) &&
            (identical(other.plainDescription, plainDescription) ||
                other.plainDescription == plainDescription) &&
            (identical(other.riskReason, riskReason) ||
                other.riskReason == riskReason) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    techniqueId,
    plainName,
    plainDescription,
    riskReason,
    riskScore,
    priority,
  );

  /// Create a copy of NamedThreat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedThreatImplCopyWith<_$NamedThreatImpl> get copyWith =>
      __$$NamedThreatImplCopyWithImpl<_$NamedThreatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedThreatImplToJson(this);
  }
}

abstract class _NamedThreat implements NamedThreat {
  const factory _NamedThreat({
    required final String techniqueId,
    required final String plainName,
    required final String plainDescription,
    required final String riskReason,
    required final double riskScore,
    required final int priority,
  }) = _$NamedThreatImpl;

  factory _NamedThreat.fromJson(Map<String, dynamic> json) =
      _$NamedThreatImpl.fromJson;

  @override
  String get techniqueId; // e.g. 'T1566'
  @override
  String get plainName; // e.g. 'Fake emails (Phishing)'
  @override
  String get plainDescription; // e.g. 'Attackers send emails pretending to be...'
  @override
  String get riskReason; // e.g. 'Healthcare is the #1 phishing target'
  @override
  double get riskScore; // 0–10
  @override
  int get priority;

  /// Create a copy of NamedThreat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NamedThreatImplCopyWith<_$NamedThreatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CoverageSuggestion _$CoverageSuggestionFromJson(Map<String, dynamic> json) {
  return _CoverageSuggestion.fromJson(json);
}

/// @nodoc
mixin _$CoverageSuggestion {
  String get techniqueId => throw _privateConstructorUsedError;
  String get suggestedLevel =>
      throw _privateConstructorUsedError; // 'covered' | 'partiallyCovered' | 'notCovered'
  String get reason =>
      throw _privateConstructorUsedError; // e.g. 'MFA covers Valid Accounts partially'
  String get controlSource => throw _privateConstructorUsedError;

  /// Serializes this CoverageSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoverageSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoverageSuggestionCopyWith<CoverageSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageSuggestionCopyWith<$Res> {
  factory $CoverageSuggestionCopyWith(
    CoverageSuggestion value,
    $Res Function(CoverageSuggestion) then,
  ) = _$CoverageSuggestionCopyWithImpl<$Res, CoverageSuggestion>;
  @useResult
  $Res call({
    String techniqueId,
    String suggestedLevel,
    String reason,
    String controlSource,
  });
}

/// @nodoc
class _$CoverageSuggestionCopyWithImpl<$Res, $Val extends CoverageSuggestion>
    implements $CoverageSuggestionCopyWith<$Res> {
  _$CoverageSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoverageSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? suggestedLevel = null,
    Object? reason = null,
    Object? controlSource = null,
  }) {
    return _then(
      _value.copyWith(
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            suggestedLevel: null == suggestedLevel
                ? _value.suggestedLevel
                : suggestedLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            controlSource: null == controlSource
                ? _value.controlSource
                : controlSource // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoverageSuggestionImplCopyWith<$Res>
    implements $CoverageSuggestionCopyWith<$Res> {
  factory _$$CoverageSuggestionImplCopyWith(
    _$CoverageSuggestionImpl value,
    $Res Function(_$CoverageSuggestionImpl) then,
  ) = __$$CoverageSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String techniqueId,
    String suggestedLevel,
    String reason,
    String controlSource,
  });
}

/// @nodoc
class __$$CoverageSuggestionImplCopyWithImpl<$Res>
    extends _$CoverageSuggestionCopyWithImpl<$Res, _$CoverageSuggestionImpl>
    implements _$$CoverageSuggestionImplCopyWith<$Res> {
  __$$CoverageSuggestionImplCopyWithImpl(
    _$CoverageSuggestionImpl _value,
    $Res Function(_$CoverageSuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoverageSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? suggestedLevel = null,
    Object? reason = null,
    Object? controlSource = null,
  }) {
    return _then(
      _$CoverageSuggestionImpl(
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        suggestedLevel: null == suggestedLevel
            ? _value.suggestedLevel
            : suggestedLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        controlSource: null == controlSource
            ? _value.controlSource
            : controlSource // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageSuggestionImpl implements _CoverageSuggestion {
  const _$CoverageSuggestionImpl({
    required this.techniqueId,
    required this.suggestedLevel,
    required this.reason,
    required this.controlSource,
  });

  factory _$CoverageSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageSuggestionImplFromJson(json);

  @override
  final String techniqueId;
  @override
  final String suggestedLevel;
  // 'covered' | 'partiallyCovered' | 'notCovered'
  @override
  final String reason;
  // e.g. 'MFA covers Valid Accounts partially'
  @override
  final String controlSource;

  @override
  String toString() {
    return 'CoverageSuggestion(techniqueId: $techniqueId, suggestedLevel: $suggestedLevel, reason: $reason, controlSource: $controlSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageSuggestionImpl &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.suggestedLevel, suggestedLevel) ||
                other.suggestedLevel == suggestedLevel) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.controlSource, controlSource) ||
                other.controlSource == controlSource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    techniqueId,
    suggestedLevel,
    reason,
    controlSource,
  );

  /// Create a copy of CoverageSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverageSuggestionImplCopyWith<_$CoverageSuggestionImpl> get copyWith =>
      __$$CoverageSuggestionImplCopyWithImpl<_$CoverageSuggestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageSuggestionImplToJson(this);
  }
}

abstract class _CoverageSuggestion implements CoverageSuggestion {
  const factory _CoverageSuggestion({
    required final String techniqueId,
    required final String suggestedLevel,
    required final String reason,
    required final String controlSource,
  }) = _$CoverageSuggestionImpl;

  factory _CoverageSuggestion.fromJson(Map<String, dynamic> json) =
      _$CoverageSuggestionImpl.fromJson;

  @override
  String get techniqueId;
  @override
  String get suggestedLevel; // 'covered' | 'partiallyCovered' | 'notCovered'
  @override
  String get reason; // e.g. 'MFA covers Valid Accounts partially'
  @override
  String get controlSource;

  /// Create a copy of CoverageSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageSuggestionImplCopyWith<_$CoverageSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThreatProfile _$ThreatProfileFromJson(Map<String, dynamic> json) {
  return _ThreatProfile.fromJson(json);
}

/// @nodoc
mixin _$ThreatProfile {
  // Source
  String get organizationId => throw _privateConstructorUsedError;
  OrgSector get sector => throw _privateConstructorUsedError; // Overall posture
  double get baselineRiskScore =>
      throw _privateConstructorUsedError; // 0–100 before any coverage applied
  String get riskLevel =>
      throw _privateConstructorUsedError; // 'Critical' | 'High' | 'Medium' | 'Low'
  String get riskSummary =>
      throw _privateConstructorUsedError; // One-sentence plain English summary
  // Prioritised threats for this org (top 10)
  List<NamedThreat> get topThreats =>
      throw _privateConstructorUsedError; // Priority technique IDs (ordered by relevance to this org)
  List<String> get priorityTechniqueIds =>
      throw _privateConstructorUsedError; // Coverage suggestions based on declared controls
  List<CoverageSuggestion> get coverageSuggestions =>
      throw _privateConstructorUsedError; // Sector-specific insight
  String get sectorInsight =>
      throw _privateConstructorUsedError; // e.g. 'Healthcare orgs saw 45% more ransomware in 2024'
  List<String> get commonThreatActors =>
      throw _privateConstructorUsedError; // e.g. ['Scattered Spider', 'LockBit']
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this ThreatProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreatProfileCopyWith<ThreatProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreatProfileCopyWith<$Res> {
  factory $ThreatProfileCopyWith(
    ThreatProfile value,
    $Res Function(ThreatProfile) then,
  ) = _$ThreatProfileCopyWithImpl<$Res, ThreatProfile>;
  @useResult
  $Res call({
    String organizationId,
    OrgSector sector,
    double baselineRiskScore,
    String riskLevel,
    String riskSummary,
    List<NamedThreat> topThreats,
    List<String> priorityTechniqueIds,
    List<CoverageSuggestion> coverageSuggestions,
    String sectorInsight,
    List<String> commonThreatActors,
    DateTime generatedAt,
  });
}

/// @nodoc
class _$ThreatProfileCopyWithImpl<$Res, $Val extends ThreatProfile>
    implements $ThreatProfileCopyWith<$Res> {
  _$ThreatProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? sector = null,
    Object? baselineRiskScore = null,
    Object? riskLevel = null,
    Object? riskSummary = null,
    Object? topThreats = null,
    Object? priorityTechniqueIds = null,
    Object? coverageSuggestions = null,
    Object? sectorInsight = null,
    Object? commonThreatActors = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            organizationId: null == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                      as String,
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as OrgSector,
            baselineRiskScore: null == baselineRiskScore
                ? _value.baselineRiskScore
                : baselineRiskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            riskLevel: null == riskLevel
                ? _value.riskLevel
                : riskLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            riskSummary: null == riskSummary
                ? _value.riskSummary
                : riskSummary // ignore: cast_nullable_to_non_nullable
                      as String,
            topThreats: null == topThreats
                ? _value.topThreats
                : topThreats // ignore: cast_nullable_to_non_nullable
                      as List<NamedThreat>,
            priorityTechniqueIds: null == priorityTechniqueIds
                ? _value.priorityTechniqueIds
                : priorityTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            coverageSuggestions: null == coverageSuggestions
                ? _value.coverageSuggestions
                : coverageSuggestions // ignore: cast_nullable_to_non_nullable
                      as List<CoverageSuggestion>,
            sectorInsight: null == sectorInsight
                ? _value.sectorInsight
                : sectorInsight // ignore: cast_nullable_to_non_nullable
                      as String,
            commonThreatActors: null == commonThreatActors
                ? _value.commonThreatActors
                : commonThreatActors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThreatProfileImplCopyWith<$Res>
    implements $ThreatProfileCopyWith<$Res> {
  factory _$$ThreatProfileImplCopyWith(
    _$ThreatProfileImpl value,
    $Res Function(_$ThreatProfileImpl) then,
  ) = __$$ThreatProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String organizationId,
    OrgSector sector,
    double baselineRiskScore,
    String riskLevel,
    String riskSummary,
    List<NamedThreat> topThreats,
    List<String> priorityTechniqueIds,
    List<CoverageSuggestion> coverageSuggestions,
    String sectorInsight,
    List<String> commonThreatActors,
    DateTime generatedAt,
  });
}

/// @nodoc
class __$$ThreatProfileImplCopyWithImpl<$Res>
    extends _$ThreatProfileCopyWithImpl<$Res, _$ThreatProfileImpl>
    implements _$$ThreatProfileImplCopyWith<$Res> {
  __$$ThreatProfileImplCopyWithImpl(
    _$ThreatProfileImpl _value,
    $Res Function(_$ThreatProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? sector = null,
    Object? baselineRiskScore = null,
    Object? riskLevel = null,
    Object? riskSummary = null,
    Object? topThreats = null,
    Object? priorityTechniqueIds = null,
    Object? coverageSuggestions = null,
    Object? sectorInsight = null,
    Object? commonThreatActors = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$ThreatProfileImpl(
        organizationId: null == organizationId
            ? _value.organizationId
            : organizationId // ignore: cast_nullable_to_non_nullable
                  as String,
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as OrgSector,
        baselineRiskScore: null == baselineRiskScore
            ? _value.baselineRiskScore
            : baselineRiskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        riskLevel: null == riskLevel
            ? _value.riskLevel
            : riskLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        riskSummary: null == riskSummary
            ? _value.riskSummary
            : riskSummary // ignore: cast_nullable_to_non_nullable
                  as String,
        topThreats: null == topThreats
            ? _value._topThreats
            : topThreats // ignore: cast_nullable_to_non_nullable
                  as List<NamedThreat>,
        priorityTechniqueIds: null == priorityTechniqueIds
            ? _value._priorityTechniqueIds
            : priorityTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        coverageSuggestions: null == coverageSuggestions
            ? _value._coverageSuggestions
            : coverageSuggestions // ignore: cast_nullable_to_non_nullable
                  as List<CoverageSuggestion>,
        sectorInsight: null == sectorInsight
            ? _value.sectorInsight
            : sectorInsight // ignore: cast_nullable_to_non_nullable
                  as String,
        commonThreatActors: null == commonThreatActors
            ? _value._commonThreatActors
            : commonThreatActors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreatProfileImpl implements _ThreatProfile {
  const _$ThreatProfileImpl({
    required this.organizationId,
    required this.sector,
    required this.baselineRiskScore,
    required this.riskLevel,
    required this.riskSummary,
    final List<NamedThreat> topThreats = const [],
    final List<String> priorityTechniqueIds = const [],
    final List<CoverageSuggestion> coverageSuggestions = const [],
    required this.sectorInsight,
    final List<String> commonThreatActors = const [],
    required this.generatedAt,
  }) : _topThreats = topThreats,
       _priorityTechniqueIds = priorityTechniqueIds,
       _coverageSuggestions = coverageSuggestions,
       _commonThreatActors = commonThreatActors;

  factory _$ThreatProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatProfileImplFromJson(json);

  // Source
  @override
  final String organizationId;
  @override
  final OrgSector sector;
  // Overall posture
  @override
  final double baselineRiskScore;
  // 0–100 before any coverage applied
  @override
  final String riskLevel;
  // 'Critical' | 'High' | 'Medium' | 'Low'
  @override
  final String riskSummary;
  // One-sentence plain English summary
  // Prioritised threats for this org (top 10)
  final List<NamedThreat> _topThreats;
  // One-sentence plain English summary
  // Prioritised threats for this org (top 10)
  @override
  @JsonKey()
  List<NamedThreat> get topThreats {
    if (_topThreats is EqualUnmodifiableListView) return _topThreats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topThreats);
  }

  // Priority technique IDs (ordered by relevance to this org)
  final List<String> _priorityTechniqueIds;
  // Priority technique IDs (ordered by relevance to this org)
  @override
  @JsonKey()
  List<String> get priorityTechniqueIds {
    if (_priorityTechniqueIds is EqualUnmodifiableListView)
      return _priorityTechniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priorityTechniqueIds);
  }

  // Coverage suggestions based on declared controls
  final List<CoverageSuggestion> _coverageSuggestions;
  // Coverage suggestions based on declared controls
  @override
  @JsonKey()
  List<CoverageSuggestion> get coverageSuggestions {
    if (_coverageSuggestions is EqualUnmodifiableListView)
      return _coverageSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverageSuggestions);
  }

  // Sector-specific insight
  @override
  final String sectorInsight;
  // e.g. 'Healthcare orgs saw 45% more ransomware in 2024'
  final List<String> _commonThreatActors;
  // e.g. 'Healthcare orgs saw 45% more ransomware in 2024'
  @override
  @JsonKey()
  List<String> get commonThreatActors {
    if (_commonThreatActors is EqualUnmodifiableListView)
      return _commonThreatActors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonThreatActors);
  }

  // e.g. ['Scattered Spider', 'LockBit']
  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'ThreatProfile(organizationId: $organizationId, sector: $sector, baselineRiskScore: $baselineRiskScore, riskLevel: $riskLevel, riskSummary: $riskSummary, topThreats: $topThreats, priorityTechniqueIds: $priorityTechniqueIds, coverageSuggestions: $coverageSuggestions, sectorInsight: $sectorInsight, commonThreatActors: $commonThreatActors, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatProfileImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.baselineRiskScore, baselineRiskScore) ||
                other.baselineRiskScore == baselineRiskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.riskSummary, riskSummary) ||
                other.riskSummary == riskSummary) &&
            const DeepCollectionEquality().equals(
              other._topThreats,
              _topThreats,
            ) &&
            const DeepCollectionEquality().equals(
              other._priorityTechniqueIds,
              _priorityTechniqueIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._coverageSuggestions,
              _coverageSuggestions,
            ) &&
            (identical(other.sectorInsight, sectorInsight) ||
                other.sectorInsight == sectorInsight) &&
            const DeepCollectionEquality().equals(
              other._commonThreatActors,
              _commonThreatActors,
            ) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    organizationId,
    sector,
    baselineRiskScore,
    riskLevel,
    riskSummary,
    const DeepCollectionEquality().hash(_topThreats),
    const DeepCollectionEquality().hash(_priorityTechniqueIds),
    const DeepCollectionEquality().hash(_coverageSuggestions),
    sectorInsight,
    const DeepCollectionEquality().hash(_commonThreatActors),
    generatedAt,
  );

  /// Create a copy of ThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreatProfileImplCopyWith<_$ThreatProfileImpl> get copyWith =>
      __$$ThreatProfileImplCopyWithImpl<_$ThreatProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatProfileImplToJson(this);
  }
}

abstract class _ThreatProfile implements ThreatProfile {
  const factory _ThreatProfile({
    required final String organizationId,
    required final OrgSector sector,
    required final double baselineRiskScore,
    required final String riskLevel,
    required final String riskSummary,
    final List<NamedThreat> topThreats,
    final List<String> priorityTechniqueIds,
    final List<CoverageSuggestion> coverageSuggestions,
    required final String sectorInsight,
    final List<String> commonThreatActors,
    required final DateTime generatedAt,
  }) = _$ThreatProfileImpl;

  factory _ThreatProfile.fromJson(Map<String, dynamic> json) =
      _$ThreatProfileImpl.fromJson;

  // Source
  @override
  String get organizationId;
  @override
  OrgSector get sector; // Overall posture
  @override
  double get baselineRiskScore; // 0–100 before any coverage applied
  @override
  String get riskLevel; // 'Critical' | 'High' | 'Medium' | 'Low'
  @override
  String get riskSummary; // One-sentence plain English summary
  // Prioritised threats for this org (top 10)
  @override
  List<NamedThreat> get topThreats; // Priority technique IDs (ordered by relevance to this org)
  @override
  List<String> get priorityTechniqueIds; // Coverage suggestions based on declared controls
  @override
  List<CoverageSuggestion> get coverageSuggestions; // Sector-specific insight
  @override
  String get sectorInsight; // e.g. 'Healthcare orgs saw 45% more ransomware in 2024'
  @override
  List<String> get commonThreatActors; // e.g. ['Scattered Spider', 'LockBit']
  @override
  DateTime get generatedAt;

  /// Create a copy of ThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreatProfileImplCopyWith<_$ThreatProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
