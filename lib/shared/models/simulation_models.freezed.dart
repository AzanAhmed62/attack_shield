// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GuidedSimulationScenario _$GuidedSimulationScenarioFromJson(
  Map<String, dynamic> json,
) {
  return _GuidedSimulationScenario.fromJson(json);
}

/// @nodoc
mixin _$GuidedSimulationScenario {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get attackNarrative => throw _privateConstructorUsedError;
  List<String> get involvedTactics => throw _privateConstructorUsedError;
  List<String> get involvedTechniques => throw _privateConstructorUsedError;
  String get difficulty =>
      throw _privateConstructorUsedError; // 'beginner', 'intermediate', 'advanced'
  int get estimatedDurationMinutes => throw _privateConstructorUsedError;
  String get threatActorProfile => throw _privateConstructorUsedError;
  List<String> get targetedSectors => throw _privateConstructorUsedError;
  List<SimulationCheckpoint> get checkpoints =>
      throw _privateConstructorUsedError;
  List<RemediationAction> get remediationPlaybook =>
      throw _privateConstructorUsedError;
  String get createdBy =>
      throw _privateConstructorUsedError; // 'system', 'community', 'ai_generated'
  DateTime get createdDate => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this GuidedSimulationScenario to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuidedSimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuidedSimulationScenarioCopyWith<GuidedSimulationScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuidedSimulationScenarioCopyWith<$Res> {
  factory $GuidedSimulationScenarioCopyWith(
    GuidedSimulationScenario value,
    $Res Function(GuidedSimulationScenario) then,
  ) = _$GuidedSimulationScenarioCopyWithImpl<$Res, GuidedSimulationScenario>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String attackNarrative,
    List<String> involvedTactics,
    List<String> involvedTechniques,
    String difficulty,
    int estimatedDurationMinutes,
    String threatActorProfile,
    List<String> targetedSectors,
    List<SimulationCheckpoint> checkpoints,
    List<RemediationAction> remediationPlaybook,
    String createdBy,
    DateTime createdDate,
    int version,
  });
}

/// @nodoc
class _$GuidedSimulationScenarioCopyWithImpl<
  $Res,
  $Val extends GuidedSimulationScenario
>
    implements $GuidedSimulationScenarioCopyWith<$Res> {
  _$GuidedSimulationScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuidedSimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? attackNarrative = null,
    Object? involvedTactics = null,
    Object? involvedTechniques = null,
    Object? difficulty = null,
    Object? estimatedDurationMinutes = null,
    Object? threatActorProfile = null,
    Object? targetedSectors = null,
    Object? checkpoints = null,
    Object? remediationPlaybook = null,
    Object? createdBy = null,
    Object? createdDate = null,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            attackNarrative: null == attackNarrative
                ? _value.attackNarrative
                : attackNarrative // ignore: cast_nullable_to_non_nullable
                      as String,
            involvedTactics: null == involvedTactics
                ? _value.involvedTactics
                : involvedTactics // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            involvedTechniques: null == involvedTechniques
                ? _value.involvedTechniques
                : involvedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDurationMinutes: null == estimatedDurationMinutes
                ? _value.estimatedDurationMinutes
                : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            threatActorProfile: null == threatActorProfile
                ? _value.threatActorProfile
                : threatActorProfile // ignore: cast_nullable_to_non_nullable
                      as String,
            targetedSectors: null == targetedSectors
                ? _value.targetedSectors
                : targetedSectors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            checkpoints: null == checkpoints
                ? _value.checkpoints
                : checkpoints // ignore: cast_nullable_to_non_nullable
                      as List<SimulationCheckpoint>,
            remediationPlaybook: null == remediationPlaybook
                ? _value.remediationPlaybook
                : remediationPlaybook // ignore: cast_nullable_to_non_nullable
                      as List<RemediationAction>,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdDate: null == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GuidedSimulationScenarioImplCopyWith<$Res>
    implements $GuidedSimulationScenarioCopyWith<$Res> {
  factory _$$GuidedSimulationScenarioImplCopyWith(
    _$GuidedSimulationScenarioImpl value,
    $Res Function(_$GuidedSimulationScenarioImpl) then,
  ) = __$$GuidedSimulationScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String attackNarrative,
    List<String> involvedTactics,
    List<String> involvedTechniques,
    String difficulty,
    int estimatedDurationMinutes,
    String threatActorProfile,
    List<String> targetedSectors,
    List<SimulationCheckpoint> checkpoints,
    List<RemediationAction> remediationPlaybook,
    String createdBy,
    DateTime createdDate,
    int version,
  });
}

/// @nodoc
class __$$GuidedSimulationScenarioImplCopyWithImpl<$Res>
    extends
        _$GuidedSimulationScenarioCopyWithImpl<
          $Res,
          _$GuidedSimulationScenarioImpl
        >
    implements _$$GuidedSimulationScenarioImplCopyWith<$Res> {
  __$$GuidedSimulationScenarioImplCopyWithImpl(
    _$GuidedSimulationScenarioImpl _value,
    $Res Function(_$GuidedSimulationScenarioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuidedSimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? attackNarrative = null,
    Object? involvedTactics = null,
    Object? involvedTechniques = null,
    Object? difficulty = null,
    Object? estimatedDurationMinutes = null,
    Object? threatActorProfile = null,
    Object? targetedSectors = null,
    Object? checkpoints = null,
    Object? remediationPlaybook = null,
    Object? createdBy = null,
    Object? createdDate = null,
    Object? version = null,
  }) {
    return _then(
      _$GuidedSimulationScenarioImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        attackNarrative: null == attackNarrative
            ? _value.attackNarrative
            : attackNarrative // ignore: cast_nullable_to_non_nullable
                  as String,
        involvedTactics: null == involvedTactics
            ? _value._involvedTactics
            : involvedTactics // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        involvedTechniques: null == involvedTechniques
            ? _value._involvedTechniques
            : involvedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDurationMinutes: null == estimatedDurationMinutes
            ? _value.estimatedDurationMinutes
            : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        threatActorProfile: null == threatActorProfile
            ? _value.threatActorProfile
            : threatActorProfile // ignore: cast_nullable_to_non_nullable
                  as String,
        targetedSectors: null == targetedSectors
            ? _value._targetedSectors
            : targetedSectors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        checkpoints: null == checkpoints
            ? _value._checkpoints
            : checkpoints // ignore: cast_nullable_to_non_nullable
                  as List<SimulationCheckpoint>,
        remediationPlaybook: null == remediationPlaybook
            ? _value._remediationPlaybook
            : remediationPlaybook // ignore: cast_nullable_to_non_nullable
                  as List<RemediationAction>,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdDate: null == createdDate
            ? _value.createdDate
            : createdDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GuidedSimulationScenarioImpl implements _GuidedSimulationScenario {
  const _$GuidedSimulationScenarioImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.attackNarrative,
    required final List<String> involvedTactics,
    required final List<String> involvedTechniques,
    required this.difficulty,
    required this.estimatedDurationMinutes,
    required this.threatActorProfile,
    required final List<String> targetedSectors,
    required final List<SimulationCheckpoint> checkpoints,
    required final List<RemediationAction> remediationPlaybook,
    required this.createdBy,
    required this.createdDate,
    required this.version,
  }) : _involvedTactics = involvedTactics,
       _involvedTechniques = involvedTechniques,
       _targetedSectors = targetedSectors,
       _checkpoints = checkpoints,
       _remediationPlaybook = remediationPlaybook;

  factory _$GuidedSimulationScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuidedSimulationScenarioImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String attackNarrative;
  final List<String> _involvedTactics;
  @override
  List<String> get involvedTactics {
    if (_involvedTactics is EqualUnmodifiableListView) return _involvedTactics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_involvedTactics);
  }

  final List<String> _involvedTechniques;
  @override
  List<String> get involvedTechniques {
    if (_involvedTechniques is EqualUnmodifiableListView)
      return _involvedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_involvedTechniques);
  }

  @override
  final String difficulty;
  // 'beginner', 'intermediate', 'advanced'
  @override
  final int estimatedDurationMinutes;
  @override
  final String threatActorProfile;
  final List<String> _targetedSectors;
  @override
  List<String> get targetedSectors {
    if (_targetedSectors is EqualUnmodifiableListView) return _targetedSectors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetedSectors);
  }

  final List<SimulationCheckpoint> _checkpoints;
  @override
  List<SimulationCheckpoint> get checkpoints {
    if (_checkpoints is EqualUnmodifiableListView) return _checkpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checkpoints);
  }

  final List<RemediationAction> _remediationPlaybook;
  @override
  List<RemediationAction> get remediationPlaybook {
    if (_remediationPlaybook is EqualUnmodifiableListView)
      return _remediationPlaybook;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remediationPlaybook);
  }

  @override
  final String createdBy;
  // 'system', 'community', 'ai_generated'
  @override
  final DateTime createdDate;
  @override
  final int version;

  @override
  String toString() {
    return 'GuidedSimulationScenario(id: $id, title: $title, description: $description, attackNarrative: $attackNarrative, involvedTactics: $involvedTactics, involvedTechniques: $involvedTechniques, difficulty: $difficulty, estimatedDurationMinutes: $estimatedDurationMinutes, threatActorProfile: $threatActorProfile, targetedSectors: $targetedSectors, checkpoints: $checkpoints, remediationPlaybook: $remediationPlaybook, createdBy: $createdBy, createdDate: $createdDate, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuidedSimulationScenarioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.attackNarrative, attackNarrative) ||
                other.attackNarrative == attackNarrative) &&
            const DeepCollectionEquality().equals(
              other._involvedTactics,
              _involvedTactics,
            ) &&
            const DeepCollectionEquality().equals(
              other._involvedTechniques,
              _involvedTechniques,
            ) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(
                  other.estimatedDurationMinutes,
                  estimatedDurationMinutes,
                ) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.threatActorProfile, threatActorProfile) ||
                other.threatActorProfile == threatActorProfile) &&
            const DeepCollectionEquality().equals(
              other._targetedSectors,
              _targetedSectors,
            ) &&
            const DeepCollectionEquality().equals(
              other._checkpoints,
              _checkpoints,
            ) &&
            const DeepCollectionEquality().equals(
              other._remediationPlaybook,
              _remediationPlaybook,
            ) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    attackNarrative,
    const DeepCollectionEquality().hash(_involvedTactics),
    const DeepCollectionEquality().hash(_involvedTechniques),
    difficulty,
    estimatedDurationMinutes,
    threatActorProfile,
    const DeepCollectionEquality().hash(_targetedSectors),
    const DeepCollectionEquality().hash(_checkpoints),
    const DeepCollectionEquality().hash(_remediationPlaybook),
    createdBy,
    createdDate,
    version,
  );

  /// Create a copy of GuidedSimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuidedSimulationScenarioImplCopyWith<_$GuidedSimulationScenarioImpl>
  get copyWith =>
      __$$GuidedSimulationScenarioImplCopyWithImpl<
        _$GuidedSimulationScenarioImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuidedSimulationScenarioImplToJson(this);
  }
}

abstract class _GuidedSimulationScenario implements GuidedSimulationScenario {
  const factory _GuidedSimulationScenario({
    required final String id,
    required final String title,
    required final String description,
    required final String attackNarrative,
    required final List<String> involvedTactics,
    required final List<String> involvedTechniques,
    required final String difficulty,
    required final int estimatedDurationMinutes,
    required final String threatActorProfile,
    required final List<String> targetedSectors,
    required final List<SimulationCheckpoint> checkpoints,
    required final List<RemediationAction> remediationPlaybook,
    required final String createdBy,
    required final DateTime createdDate,
    required final int version,
  }) = _$GuidedSimulationScenarioImpl;

  factory _GuidedSimulationScenario.fromJson(Map<String, dynamic> json) =
      _$GuidedSimulationScenarioImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get attackNarrative;
  @override
  List<String> get involvedTactics;
  @override
  List<String> get involvedTechniques;
  @override
  String get difficulty; // 'beginner', 'intermediate', 'advanced'
  @override
  int get estimatedDurationMinutes;
  @override
  String get threatActorProfile;
  @override
  List<String> get targetedSectors;
  @override
  List<SimulationCheckpoint> get checkpoints;
  @override
  List<RemediationAction> get remediationPlaybook;
  @override
  String get createdBy; // 'system', 'community', 'ai_generated'
  @override
  DateTime get createdDate;
  @override
  int get version;

  /// Create a copy of GuidedSimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuidedSimulationScenarioImplCopyWith<_$GuidedSimulationScenarioImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SimulationCheckpoint _$SimulationCheckpointFromJson(Map<String, dynamic> json) {
  return _SimulationCheckpoint.fromJson(json);
}

/// @nodoc
mixin _$SimulationCheckpoint {
  String get id => throw _privateConstructorUsedError;
  int get sequenceNumber => throw _privateConstructorUsedError;
  String get attackStepNarrative => throw _privateConstructorUsedError;
  String get techniqueId => throw _privateConstructorUsedError;
  String get techniqueName => throw _privateConstructorUsedError;
  String get whatToCheck =>
      throw _privateConstructorUsedError; // Plain English: "Look for..."
  List<String> get indicatorExamples =>
      throw _privateConstructorUsedError; // Real examples user might see
  String get evidenceType =>
      throw _privateConstructorUsedError; // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  String get detectionTool =>
      throw _privateConstructorUsedError; // 'Windows Event Viewer', 'Email Gateway', 'EDR', etc.
  List<String> get successIndicators =>
      throw _privateConstructorUsedError; // What indicates detection success
  List<String> get failureIndicators =>
      throw _privateConstructorUsedError; // What indicates miss
  int get pointsIfDetected => throw _privateConstructorUsedError;
  int get pointsIfMissed => throw _privateConstructorUsedError;

  /// Serializes this SimulationCheckpoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationCheckpoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationCheckpointCopyWith<SimulationCheckpoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationCheckpointCopyWith<$Res> {
  factory $SimulationCheckpointCopyWith(
    SimulationCheckpoint value,
    $Res Function(SimulationCheckpoint) then,
  ) = _$SimulationCheckpointCopyWithImpl<$Res, SimulationCheckpoint>;
  @useResult
  $Res call({
    String id,
    int sequenceNumber,
    String attackStepNarrative,
    String techniqueId,
    String techniqueName,
    String whatToCheck,
    List<String> indicatorExamples,
    String evidenceType,
    String detectionTool,
    List<String> successIndicators,
    List<String> failureIndicators,
    int pointsIfDetected,
    int pointsIfMissed,
  });
}

/// @nodoc
class _$SimulationCheckpointCopyWithImpl<
  $Res,
  $Val extends SimulationCheckpoint
>
    implements $SimulationCheckpointCopyWith<$Res> {
  _$SimulationCheckpointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationCheckpoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sequenceNumber = null,
    Object? attackStepNarrative = null,
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? whatToCheck = null,
    Object? indicatorExamples = null,
    Object? evidenceType = null,
    Object? detectionTool = null,
    Object? successIndicators = null,
    Object? failureIndicators = null,
    Object? pointsIfDetected = null,
    Object? pointsIfMissed = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sequenceNumber: null == sequenceNumber
                ? _value.sequenceNumber
                : sequenceNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            attackStepNarrative: null == attackStepNarrative
                ? _value.attackStepNarrative
                : attackStepNarrative // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueName: null == techniqueName
                ? _value.techniqueName
                : techniqueName // ignore: cast_nullable_to_non_nullable
                      as String,
            whatToCheck: null == whatToCheck
                ? _value.whatToCheck
                : whatToCheck // ignore: cast_nullable_to_non_nullable
                      as String,
            indicatorExamples: null == indicatorExamples
                ? _value.indicatorExamples
                : indicatorExamples // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            evidenceType: null == evidenceType
                ? _value.evidenceType
                : evidenceType // ignore: cast_nullable_to_non_nullable
                      as String,
            detectionTool: null == detectionTool
                ? _value.detectionTool
                : detectionTool // ignore: cast_nullable_to_non_nullable
                      as String,
            successIndicators: null == successIndicators
                ? _value.successIndicators
                : successIndicators // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            failureIndicators: null == failureIndicators
                ? _value.failureIndicators
                : failureIndicators // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pointsIfDetected: null == pointsIfDetected
                ? _value.pointsIfDetected
                : pointsIfDetected // ignore: cast_nullable_to_non_nullable
                      as int,
            pointsIfMissed: null == pointsIfMissed
                ? _value.pointsIfMissed
                : pointsIfMissed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationCheckpointImplCopyWith<$Res>
    implements $SimulationCheckpointCopyWith<$Res> {
  factory _$$SimulationCheckpointImplCopyWith(
    _$SimulationCheckpointImpl value,
    $Res Function(_$SimulationCheckpointImpl) then,
  ) = __$$SimulationCheckpointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int sequenceNumber,
    String attackStepNarrative,
    String techniqueId,
    String techniqueName,
    String whatToCheck,
    List<String> indicatorExamples,
    String evidenceType,
    String detectionTool,
    List<String> successIndicators,
    List<String> failureIndicators,
    int pointsIfDetected,
    int pointsIfMissed,
  });
}

/// @nodoc
class __$$SimulationCheckpointImplCopyWithImpl<$Res>
    extends _$SimulationCheckpointCopyWithImpl<$Res, _$SimulationCheckpointImpl>
    implements _$$SimulationCheckpointImplCopyWith<$Res> {
  __$$SimulationCheckpointImplCopyWithImpl(
    _$SimulationCheckpointImpl _value,
    $Res Function(_$SimulationCheckpointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationCheckpoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sequenceNumber = null,
    Object? attackStepNarrative = null,
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? whatToCheck = null,
    Object? indicatorExamples = null,
    Object? evidenceType = null,
    Object? detectionTool = null,
    Object? successIndicators = null,
    Object? failureIndicators = null,
    Object? pointsIfDetected = null,
    Object? pointsIfMissed = null,
  }) {
    return _then(
      _$SimulationCheckpointImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sequenceNumber: null == sequenceNumber
            ? _value.sequenceNumber
            : sequenceNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        attackStepNarrative: null == attackStepNarrative
            ? _value.attackStepNarrative
            : attackStepNarrative // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueName: null == techniqueName
            ? _value.techniqueName
            : techniqueName // ignore: cast_nullable_to_non_nullable
                  as String,
        whatToCheck: null == whatToCheck
            ? _value.whatToCheck
            : whatToCheck // ignore: cast_nullable_to_non_nullable
                  as String,
        indicatorExamples: null == indicatorExamples
            ? _value._indicatorExamples
            : indicatorExamples // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        evidenceType: null == evidenceType
            ? _value.evidenceType
            : evidenceType // ignore: cast_nullable_to_non_nullable
                  as String,
        detectionTool: null == detectionTool
            ? _value.detectionTool
            : detectionTool // ignore: cast_nullable_to_non_nullable
                  as String,
        successIndicators: null == successIndicators
            ? _value._successIndicators
            : successIndicators // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        failureIndicators: null == failureIndicators
            ? _value._failureIndicators
            : failureIndicators // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pointsIfDetected: null == pointsIfDetected
            ? _value.pointsIfDetected
            : pointsIfDetected // ignore: cast_nullable_to_non_nullable
                  as int,
        pointsIfMissed: null == pointsIfMissed
            ? _value.pointsIfMissed
            : pointsIfMissed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationCheckpointImpl implements _SimulationCheckpoint {
  const _$SimulationCheckpointImpl({
    required this.id,
    required this.sequenceNumber,
    required this.attackStepNarrative,
    required this.techniqueId,
    required this.techniqueName,
    required this.whatToCheck,
    required final List<String> indicatorExamples,
    required this.evidenceType,
    required this.detectionTool,
    required final List<String> successIndicators,
    required final List<String> failureIndicators,
    required this.pointsIfDetected,
    required this.pointsIfMissed,
  }) : _indicatorExamples = indicatorExamples,
       _successIndicators = successIndicators,
       _failureIndicators = failureIndicators;

  factory _$SimulationCheckpointImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationCheckpointImplFromJson(json);

  @override
  final String id;
  @override
  final int sequenceNumber;
  @override
  final String attackStepNarrative;
  @override
  final String techniqueId;
  @override
  final String techniqueName;
  @override
  final String whatToCheck;
  // Plain English: "Look for..."
  final List<String> _indicatorExamples;
  // Plain English: "Look for..."
  @override
  List<String> get indicatorExamples {
    if (_indicatorExamples is EqualUnmodifiableListView)
      return _indicatorExamples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_indicatorExamples);
  }

  // Real examples user might see
  @override
  final String evidenceType;
  // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  @override
  final String detectionTool;
  // 'Windows Event Viewer', 'Email Gateway', 'EDR', etc.
  final List<String> _successIndicators;
  // 'Windows Event Viewer', 'Email Gateway', 'EDR', etc.
  @override
  List<String> get successIndicators {
    if (_successIndicators is EqualUnmodifiableListView)
      return _successIndicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successIndicators);
  }

  // What indicates detection success
  final List<String> _failureIndicators;
  // What indicates detection success
  @override
  List<String> get failureIndicators {
    if (_failureIndicators is EqualUnmodifiableListView)
      return _failureIndicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failureIndicators);
  }

  // What indicates miss
  @override
  final int pointsIfDetected;
  @override
  final int pointsIfMissed;

  @override
  String toString() {
    return 'SimulationCheckpoint(id: $id, sequenceNumber: $sequenceNumber, attackStepNarrative: $attackStepNarrative, techniqueId: $techniqueId, techniqueName: $techniqueName, whatToCheck: $whatToCheck, indicatorExamples: $indicatorExamples, evidenceType: $evidenceType, detectionTool: $detectionTool, successIndicators: $successIndicators, failureIndicators: $failureIndicators, pointsIfDetected: $pointsIfDetected, pointsIfMissed: $pointsIfMissed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationCheckpointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sequenceNumber, sequenceNumber) ||
                other.sequenceNumber == sequenceNumber) &&
            (identical(other.attackStepNarrative, attackStepNarrative) ||
                other.attackStepNarrative == attackStepNarrative) &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.techniqueName, techniqueName) ||
                other.techniqueName == techniqueName) &&
            (identical(other.whatToCheck, whatToCheck) ||
                other.whatToCheck == whatToCheck) &&
            const DeepCollectionEquality().equals(
              other._indicatorExamples,
              _indicatorExamples,
            ) &&
            (identical(other.evidenceType, evidenceType) ||
                other.evidenceType == evidenceType) &&
            (identical(other.detectionTool, detectionTool) ||
                other.detectionTool == detectionTool) &&
            const DeepCollectionEquality().equals(
              other._successIndicators,
              _successIndicators,
            ) &&
            const DeepCollectionEquality().equals(
              other._failureIndicators,
              _failureIndicators,
            ) &&
            (identical(other.pointsIfDetected, pointsIfDetected) ||
                other.pointsIfDetected == pointsIfDetected) &&
            (identical(other.pointsIfMissed, pointsIfMissed) ||
                other.pointsIfMissed == pointsIfMissed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sequenceNumber,
    attackStepNarrative,
    techniqueId,
    techniqueName,
    whatToCheck,
    const DeepCollectionEquality().hash(_indicatorExamples),
    evidenceType,
    detectionTool,
    const DeepCollectionEquality().hash(_successIndicators),
    const DeepCollectionEquality().hash(_failureIndicators),
    pointsIfDetected,
    pointsIfMissed,
  );

  /// Create a copy of SimulationCheckpoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationCheckpointImplCopyWith<_$SimulationCheckpointImpl>
  get copyWith =>
      __$$SimulationCheckpointImplCopyWithImpl<_$SimulationCheckpointImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationCheckpointImplToJson(this);
  }
}

abstract class _SimulationCheckpoint implements SimulationCheckpoint {
  const factory _SimulationCheckpoint({
    required final String id,
    required final int sequenceNumber,
    required final String attackStepNarrative,
    required final String techniqueId,
    required final String techniqueName,
    required final String whatToCheck,
    required final List<String> indicatorExamples,
    required final String evidenceType,
    required final String detectionTool,
    required final List<String> successIndicators,
    required final List<String> failureIndicators,
    required final int pointsIfDetected,
    required final int pointsIfMissed,
  }) = _$SimulationCheckpointImpl;

  factory _SimulationCheckpoint.fromJson(Map<String, dynamic> json) =
      _$SimulationCheckpointImpl.fromJson;

  @override
  String get id;
  @override
  int get sequenceNumber;
  @override
  String get attackStepNarrative;
  @override
  String get techniqueId;
  @override
  String get techniqueName;
  @override
  String get whatToCheck; // Plain English: "Look for..."
  @override
  List<String> get indicatorExamples; // Real examples user might see
  @override
  String get evidenceType; // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  @override
  String get detectionTool; // 'Windows Event Viewer', 'Email Gateway', 'EDR', etc.
  @override
  List<String> get successIndicators; // What indicates detection success
  @override
  List<String> get failureIndicators; // What indicates miss
  @override
  int get pointsIfDetected;
  @override
  int get pointsIfMissed;

  /// Create a copy of SimulationCheckpoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationCheckpointImplCopyWith<_$SimulationCheckpointImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CheckpointEvidence _$CheckpointEvidenceFromJson(Map<String, dynamic> json) {
  return _CheckpointEvidence.fromJson(json);
}

/// @nodoc
mixin _$CheckpointEvidence {
  String get checkpointId => throw _privateConstructorUsedError;
  String get evidenceType =>
      throw _privateConstructorUsedError; // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  String? get screenshotPath =>
      throw _privateConstructorUsedError; // File path if screenshot
  String? get logExcerpt =>
      throw _privateConstructorUsedError; // Copied log line
  bool? get yesNoAnswer =>
      throw _privateConstructorUsedError; // true = detected, false = missed
  String? get textResponse =>
      throw _privateConstructorUsedError; // Free-form text answer
  DateTime? get submittedAt => throw _privateConstructorUsedError;

  /// Serializes this CheckpointEvidence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckpointEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckpointEvidenceCopyWith<CheckpointEvidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckpointEvidenceCopyWith<$Res> {
  factory $CheckpointEvidenceCopyWith(
    CheckpointEvidence value,
    $Res Function(CheckpointEvidence) then,
  ) = _$CheckpointEvidenceCopyWithImpl<$Res, CheckpointEvidence>;
  @useResult
  $Res call({
    String checkpointId,
    String evidenceType,
    String? screenshotPath,
    String? logExcerpt,
    bool? yesNoAnswer,
    String? textResponse,
    DateTime? submittedAt,
  });
}

/// @nodoc
class _$CheckpointEvidenceCopyWithImpl<$Res, $Val extends CheckpointEvidence>
    implements $CheckpointEvidenceCopyWith<$Res> {
  _$CheckpointEvidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckpointEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkpointId = null,
    Object? evidenceType = null,
    Object? screenshotPath = freezed,
    Object? logExcerpt = freezed,
    Object? yesNoAnswer = freezed,
    Object? textResponse = freezed,
    Object? submittedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            checkpointId: null == checkpointId
                ? _value.checkpointId
                : checkpointId // ignore: cast_nullable_to_non_nullable
                      as String,
            evidenceType: null == evidenceType
                ? _value.evidenceType
                : evidenceType // ignore: cast_nullable_to_non_nullable
                      as String,
            screenshotPath: freezed == screenshotPath
                ? _value.screenshotPath
                : screenshotPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            logExcerpt: freezed == logExcerpt
                ? _value.logExcerpt
                : logExcerpt // ignore: cast_nullable_to_non_nullable
                      as String?,
            yesNoAnswer: freezed == yesNoAnswer
                ? _value.yesNoAnswer
                : yesNoAnswer // ignore: cast_nullable_to_non_nullable
                      as bool?,
            textResponse: freezed == textResponse
                ? _value.textResponse
                : textResponse // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckpointEvidenceImplCopyWith<$Res>
    implements $CheckpointEvidenceCopyWith<$Res> {
  factory _$$CheckpointEvidenceImplCopyWith(
    _$CheckpointEvidenceImpl value,
    $Res Function(_$CheckpointEvidenceImpl) then,
  ) = __$$CheckpointEvidenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String checkpointId,
    String evidenceType,
    String? screenshotPath,
    String? logExcerpt,
    bool? yesNoAnswer,
    String? textResponse,
    DateTime? submittedAt,
  });
}

/// @nodoc
class __$$CheckpointEvidenceImplCopyWithImpl<$Res>
    extends _$CheckpointEvidenceCopyWithImpl<$Res, _$CheckpointEvidenceImpl>
    implements _$$CheckpointEvidenceImplCopyWith<$Res> {
  __$$CheckpointEvidenceImplCopyWithImpl(
    _$CheckpointEvidenceImpl _value,
    $Res Function(_$CheckpointEvidenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckpointEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkpointId = null,
    Object? evidenceType = null,
    Object? screenshotPath = freezed,
    Object? logExcerpt = freezed,
    Object? yesNoAnswer = freezed,
    Object? textResponse = freezed,
    Object? submittedAt = freezed,
  }) {
    return _then(
      _$CheckpointEvidenceImpl(
        checkpointId: null == checkpointId
            ? _value.checkpointId
            : checkpointId // ignore: cast_nullable_to_non_nullable
                  as String,
        evidenceType: null == evidenceType
            ? _value.evidenceType
            : evidenceType // ignore: cast_nullable_to_non_nullable
                  as String,
        screenshotPath: freezed == screenshotPath
            ? _value.screenshotPath
            : screenshotPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        logExcerpt: freezed == logExcerpt
            ? _value.logExcerpt
            : logExcerpt // ignore: cast_nullable_to_non_nullable
                  as String?,
        yesNoAnswer: freezed == yesNoAnswer
            ? _value.yesNoAnswer
            : yesNoAnswer // ignore: cast_nullable_to_non_nullable
                  as bool?,
        textResponse: freezed == textResponse
            ? _value.textResponse
            : textResponse // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckpointEvidenceImpl implements _CheckpointEvidence {
  const _$CheckpointEvidenceImpl({
    required this.checkpointId,
    required this.evidenceType,
    this.screenshotPath,
    this.logExcerpt,
    this.yesNoAnswer,
    this.textResponse,
    this.submittedAt = null,
  });

  factory _$CheckpointEvidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckpointEvidenceImplFromJson(json);

  @override
  final String checkpointId;
  @override
  final String evidenceType;
  // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  @override
  final String? screenshotPath;
  // File path if screenshot
  @override
  final String? logExcerpt;
  // Copied log line
  @override
  final bool? yesNoAnswer;
  // true = detected, false = missed
  @override
  final String? textResponse;
  // Free-form text answer
  @override
  @JsonKey()
  final DateTime? submittedAt;

  @override
  String toString() {
    return 'CheckpointEvidence(checkpointId: $checkpointId, evidenceType: $evidenceType, screenshotPath: $screenshotPath, logExcerpt: $logExcerpt, yesNoAnswer: $yesNoAnswer, textResponse: $textResponse, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckpointEvidenceImpl &&
            (identical(other.checkpointId, checkpointId) ||
                other.checkpointId == checkpointId) &&
            (identical(other.evidenceType, evidenceType) ||
                other.evidenceType == evidenceType) &&
            (identical(other.screenshotPath, screenshotPath) ||
                other.screenshotPath == screenshotPath) &&
            (identical(other.logExcerpt, logExcerpt) ||
                other.logExcerpt == logExcerpt) &&
            (identical(other.yesNoAnswer, yesNoAnswer) ||
                other.yesNoAnswer == yesNoAnswer) &&
            (identical(other.textResponse, textResponse) ||
                other.textResponse == textResponse) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    checkpointId,
    evidenceType,
    screenshotPath,
    logExcerpt,
    yesNoAnswer,
    textResponse,
    submittedAt,
  );

  /// Create a copy of CheckpointEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckpointEvidenceImplCopyWith<_$CheckpointEvidenceImpl> get copyWith =>
      __$$CheckpointEvidenceImplCopyWithImpl<_$CheckpointEvidenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckpointEvidenceImplToJson(this);
  }
}

abstract class _CheckpointEvidence implements CheckpointEvidence {
  const factory _CheckpointEvidence({
    required final String checkpointId,
    required final String evidenceType,
    final String? screenshotPath,
    final String? logExcerpt,
    final bool? yesNoAnswer,
    final String? textResponse,
    final DateTime? submittedAt,
  }) = _$CheckpointEvidenceImpl;

  factory _CheckpointEvidence.fromJson(Map<String, dynamic> json) =
      _$CheckpointEvidenceImpl.fromJson;

  @override
  String get checkpointId;
  @override
  String get evidenceType; // 'screenshot', 'log_excerpt', 'yes_no', 'text'
  @override
  String? get screenshotPath; // File path if screenshot
  @override
  String? get logExcerpt; // Copied log line
  @override
  bool? get yesNoAnswer; // true = detected, false = missed
  @override
  String? get textResponse; // Free-form text answer
  @override
  DateTime? get submittedAt;

  /// Create a copy of CheckpointEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckpointEvidenceImplCopyWith<_$CheckpointEvidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckpointEvaluation _$CheckpointEvaluationFromJson(Map<String, dynamic> json) {
  return _CheckpointEvaluation.fromJson(json);
}

/// @nodoc
mixin _$CheckpointEvaluation {
  String get checkpointId => throw _privateConstructorUsedError;
  String get evaluationType =>
      throw _privateConstructorUsedError; // 'automated', 'manual', 'ai_assisted'
  String get evaluation =>
      throw _privateConstructorUsedError; // 'detected', 'missed', 'partial', 'inconclusive'
  int get pointsAwarded => throw _privateConstructorUsedError;
  String get feedback =>
      throw _privateConstructorUsedError; // Explanation of score
  List<String> get suggestedActions =>
      throw _privateConstructorUsedError; // What to do next
  DateTime? get evaluatedAt => throw _privateConstructorUsedError;

  /// Serializes this CheckpointEvaluation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckpointEvaluation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckpointEvaluationCopyWith<CheckpointEvaluation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckpointEvaluationCopyWith<$Res> {
  factory $CheckpointEvaluationCopyWith(
    CheckpointEvaluation value,
    $Res Function(CheckpointEvaluation) then,
  ) = _$CheckpointEvaluationCopyWithImpl<$Res, CheckpointEvaluation>;
  @useResult
  $Res call({
    String checkpointId,
    String evaluationType,
    String evaluation,
    int pointsAwarded,
    String feedback,
    List<String> suggestedActions,
    DateTime? evaluatedAt,
  });
}

/// @nodoc
class _$CheckpointEvaluationCopyWithImpl<
  $Res,
  $Val extends CheckpointEvaluation
>
    implements $CheckpointEvaluationCopyWith<$Res> {
  _$CheckpointEvaluationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckpointEvaluation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkpointId = null,
    Object? evaluationType = null,
    Object? evaluation = null,
    Object? pointsAwarded = null,
    Object? feedback = null,
    Object? suggestedActions = null,
    Object? evaluatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            checkpointId: null == checkpointId
                ? _value.checkpointId
                : checkpointId // ignore: cast_nullable_to_non_nullable
                      as String,
            evaluationType: null == evaluationType
                ? _value.evaluationType
                : evaluationType // ignore: cast_nullable_to_non_nullable
                      as String,
            evaluation: null == evaluation
                ? _value.evaluation
                : evaluation // ignore: cast_nullable_to_non_nullable
                      as String,
            pointsAwarded: null == pointsAwarded
                ? _value.pointsAwarded
                : pointsAwarded // ignore: cast_nullable_to_non_nullable
                      as int,
            feedback: null == feedback
                ? _value.feedback
                : feedback // ignore: cast_nullable_to_non_nullable
                      as String,
            suggestedActions: null == suggestedActions
                ? _value.suggestedActions
                : suggestedActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            evaluatedAt: freezed == evaluatedAt
                ? _value.evaluatedAt
                : evaluatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckpointEvaluationImplCopyWith<$Res>
    implements $CheckpointEvaluationCopyWith<$Res> {
  factory _$$CheckpointEvaluationImplCopyWith(
    _$CheckpointEvaluationImpl value,
    $Res Function(_$CheckpointEvaluationImpl) then,
  ) = __$$CheckpointEvaluationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String checkpointId,
    String evaluationType,
    String evaluation,
    int pointsAwarded,
    String feedback,
    List<String> suggestedActions,
    DateTime? evaluatedAt,
  });
}

/// @nodoc
class __$$CheckpointEvaluationImplCopyWithImpl<$Res>
    extends _$CheckpointEvaluationCopyWithImpl<$Res, _$CheckpointEvaluationImpl>
    implements _$$CheckpointEvaluationImplCopyWith<$Res> {
  __$$CheckpointEvaluationImplCopyWithImpl(
    _$CheckpointEvaluationImpl _value,
    $Res Function(_$CheckpointEvaluationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckpointEvaluation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkpointId = null,
    Object? evaluationType = null,
    Object? evaluation = null,
    Object? pointsAwarded = null,
    Object? feedback = null,
    Object? suggestedActions = null,
    Object? evaluatedAt = freezed,
  }) {
    return _then(
      _$CheckpointEvaluationImpl(
        checkpointId: null == checkpointId
            ? _value.checkpointId
            : checkpointId // ignore: cast_nullable_to_non_nullable
                  as String,
        evaluationType: null == evaluationType
            ? _value.evaluationType
            : evaluationType // ignore: cast_nullable_to_non_nullable
                  as String,
        evaluation: null == evaluation
            ? _value.evaluation
            : evaluation // ignore: cast_nullable_to_non_nullable
                  as String,
        pointsAwarded: null == pointsAwarded
            ? _value.pointsAwarded
            : pointsAwarded // ignore: cast_nullable_to_non_nullable
                  as int,
        feedback: null == feedback
            ? _value.feedback
            : feedback // ignore: cast_nullable_to_non_nullable
                  as String,
        suggestedActions: null == suggestedActions
            ? _value._suggestedActions
            : suggestedActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        evaluatedAt: freezed == evaluatedAt
            ? _value.evaluatedAt
            : evaluatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckpointEvaluationImpl implements _CheckpointEvaluation {
  const _$CheckpointEvaluationImpl({
    required this.checkpointId,
    required this.evaluationType,
    required this.evaluation,
    required this.pointsAwarded,
    required this.feedback,
    required final List<String> suggestedActions,
    this.evaluatedAt = null,
  }) : _suggestedActions = suggestedActions;

  factory _$CheckpointEvaluationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckpointEvaluationImplFromJson(json);

  @override
  final String checkpointId;
  @override
  final String evaluationType;
  // 'automated', 'manual', 'ai_assisted'
  @override
  final String evaluation;
  // 'detected', 'missed', 'partial', 'inconclusive'
  @override
  final int pointsAwarded;
  @override
  final String feedback;
  // Explanation of score
  final List<String> _suggestedActions;
  // Explanation of score
  @override
  List<String> get suggestedActions {
    if (_suggestedActions is EqualUnmodifiableListView)
      return _suggestedActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedActions);
  }

  // What to do next
  @override
  @JsonKey()
  final DateTime? evaluatedAt;

  @override
  String toString() {
    return 'CheckpointEvaluation(checkpointId: $checkpointId, evaluationType: $evaluationType, evaluation: $evaluation, pointsAwarded: $pointsAwarded, feedback: $feedback, suggestedActions: $suggestedActions, evaluatedAt: $evaluatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckpointEvaluationImpl &&
            (identical(other.checkpointId, checkpointId) ||
                other.checkpointId == checkpointId) &&
            (identical(other.evaluationType, evaluationType) ||
                other.evaluationType == evaluationType) &&
            (identical(other.evaluation, evaluation) ||
                other.evaluation == evaluation) &&
            (identical(other.pointsAwarded, pointsAwarded) ||
                other.pointsAwarded == pointsAwarded) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality().equals(
              other._suggestedActions,
              _suggestedActions,
            ) &&
            (identical(other.evaluatedAt, evaluatedAt) ||
                other.evaluatedAt == evaluatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    checkpointId,
    evaluationType,
    evaluation,
    pointsAwarded,
    feedback,
    const DeepCollectionEquality().hash(_suggestedActions),
    evaluatedAt,
  );

  /// Create a copy of CheckpointEvaluation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckpointEvaluationImplCopyWith<_$CheckpointEvaluationImpl>
  get copyWith =>
      __$$CheckpointEvaluationImplCopyWithImpl<_$CheckpointEvaluationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckpointEvaluationImplToJson(this);
  }
}

abstract class _CheckpointEvaluation implements CheckpointEvaluation {
  const factory _CheckpointEvaluation({
    required final String checkpointId,
    required final String evaluationType,
    required final String evaluation,
    required final int pointsAwarded,
    required final String feedback,
    required final List<String> suggestedActions,
    final DateTime? evaluatedAt,
  }) = _$CheckpointEvaluationImpl;

  factory _CheckpointEvaluation.fromJson(Map<String, dynamic> json) =
      _$CheckpointEvaluationImpl.fromJson;

  @override
  String get checkpointId;
  @override
  String get evaluationType; // 'automated', 'manual', 'ai_assisted'
  @override
  String get evaluation; // 'detected', 'missed', 'partial', 'inconclusive'
  @override
  int get pointsAwarded;
  @override
  String get feedback; // Explanation of score
  @override
  List<String> get suggestedActions; // What to do next
  @override
  DateTime? get evaluatedAt;

  /// Create a copy of CheckpointEvaluation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckpointEvaluationImplCopyWith<_$CheckpointEvaluationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SimulationSession _$SimulationSessionFromJson(Map<String, dynamic> json) {
  return _SimulationSession.fromJson(json);
}

/// @nodoc
mixin _$SimulationSession {
  String get id => throw _privateConstructorUsedError;
  String get scenarioId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'in_progress', 'completed', 'abandoned'
  List<CheckpointEvidence> get evidenceSubmissions =>
      throw _privateConstructorUsedError;
  List<CheckpointEvaluation> get evaluations =>
      throw _privateConstructorUsedError;
  int get currentCheckpointIndex => throw _privateConstructorUsedError;
  bool get hasViewedNarrative => throw _privateConstructorUsedError;

  /// Serializes this SimulationSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationSessionCopyWith<SimulationSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationSessionCopyWith<$Res> {
  factory $SimulationSessionCopyWith(
    SimulationSession value,
    $Res Function(SimulationSession) then,
  ) = _$SimulationSessionCopyWithImpl<$Res, SimulationSession>;
  @useResult
  $Res call({
    String id,
    String scenarioId,
    String userId,
    String organizationId,
    DateTime startedAt,
    DateTime? completedAt,
    String status,
    List<CheckpointEvidence> evidenceSubmissions,
    List<CheckpointEvaluation> evaluations,
    int currentCheckpointIndex,
    bool hasViewedNarrative,
  });
}

/// @nodoc
class _$SimulationSessionCopyWithImpl<$Res, $Val extends SimulationSession>
    implements $SimulationSessionCopyWith<$Res> {
  _$SimulationSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scenarioId = null,
    Object? userId = null,
    Object? organizationId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? evidenceSubmissions = null,
    Object? evaluations = null,
    Object? currentCheckpointIndex = null,
    Object? hasViewedNarrative = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            scenarioId: null == scenarioId
                ? _value.scenarioId
                : scenarioId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            organizationId: null == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            evidenceSubmissions: null == evidenceSubmissions
                ? _value.evidenceSubmissions
                : evidenceSubmissions // ignore: cast_nullable_to_non_nullable
                      as List<CheckpointEvidence>,
            evaluations: null == evaluations
                ? _value.evaluations
                : evaluations // ignore: cast_nullable_to_non_nullable
                      as List<CheckpointEvaluation>,
            currentCheckpointIndex: null == currentCheckpointIndex
                ? _value.currentCheckpointIndex
                : currentCheckpointIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            hasViewedNarrative: null == hasViewedNarrative
                ? _value.hasViewedNarrative
                : hasViewedNarrative // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationSessionImplCopyWith<$Res>
    implements $SimulationSessionCopyWith<$Res> {
  factory _$$SimulationSessionImplCopyWith(
    _$SimulationSessionImpl value,
    $Res Function(_$SimulationSessionImpl) then,
  ) = __$$SimulationSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String scenarioId,
    String userId,
    String organizationId,
    DateTime startedAt,
    DateTime? completedAt,
    String status,
    List<CheckpointEvidence> evidenceSubmissions,
    List<CheckpointEvaluation> evaluations,
    int currentCheckpointIndex,
    bool hasViewedNarrative,
  });
}

/// @nodoc
class __$$SimulationSessionImplCopyWithImpl<$Res>
    extends _$SimulationSessionCopyWithImpl<$Res, _$SimulationSessionImpl>
    implements _$$SimulationSessionImplCopyWith<$Res> {
  __$$SimulationSessionImplCopyWithImpl(
    _$SimulationSessionImpl _value,
    $Res Function(_$SimulationSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scenarioId = null,
    Object? userId = null,
    Object? organizationId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? evidenceSubmissions = null,
    Object? evaluations = null,
    Object? currentCheckpointIndex = null,
    Object? hasViewedNarrative = null,
  }) {
    return _then(
      _$SimulationSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        scenarioId: null == scenarioId
            ? _value.scenarioId
            : scenarioId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        organizationId: null == organizationId
            ? _value.organizationId
            : organizationId // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        evidenceSubmissions: null == evidenceSubmissions
            ? _value._evidenceSubmissions
            : evidenceSubmissions // ignore: cast_nullable_to_non_nullable
                  as List<CheckpointEvidence>,
        evaluations: null == evaluations
            ? _value._evaluations
            : evaluations // ignore: cast_nullable_to_non_nullable
                  as List<CheckpointEvaluation>,
        currentCheckpointIndex: null == currentCheckpointIndex
            ? _value.currentCheckpointIndex
            : currentCheckpointIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        hasViewedNarrative: null == hasViewedNarrative
            ? _value.hasViewedNarrative
            : hasViewedNarrative // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationSessionImpl implements _SimulationSession {
  const _$SimulationSessionImpl({
    required this.id,
    required this.scenarioId,
    required this.userId,
    required this.organizationId,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required final List<CheckpointEvidence> evidenceSubmissions,
    required final List<CheckpointEvaluation> evaluations,
    required this.currentCheckpointIndex,
    required this.hasViewedNarrative,
  }) : _evidenceSubmissions = evidenceSubmissions,
       _evaluations = evaluations;

  factory _$SimulationSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String scenarioId;
  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String status;
  // 'in_progress', 'completed', 'abandoned'
  final List<CheckpointEvidence> _evidenceSubmissions;
  // 'in_progress', 'completed', 'abandoned'
  @override
  List<CheckpointEvidence> get evidenceSubmissions {
    if (_evidenceSubmissions is EqualUnmodifiableListView)
      return _evidenceSubmissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceSubmissions);
  }

  final List<CheckpointEvaluation> _evaluations;
  @override
  List<CheckpointEvaluation> get evaluations {
    if (_evaluations is EqualUnmodifiableListView) return _evaluations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evaluations);
  }

  @override
  final int currentCheckpointIndex;
  @override
  final bool hasViewedNarrative;

  @override
  String toString() {
    return 'SimulationSession(id: $id, scenarioId: $scenarioId, userId: $userId, organizationId: $organizationId, startedAt: $startedAt, completedAt: $completedAt, status: $status, evidenceSubmissions: $evidenceSubmissions, evaluations: $evaluations, currentCheckpointIndex: $currentCheckpointIndex, hasViewedNarrative: $hasViewedNarrative)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scenarioId, scenarioId) ||
                other.scenarioId == scenarioId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._evidenceSubmissions,
              _evidenceSubmissions,
            ) &&
            const DeepCollectionEquality().equals(
              other._evaluations,
              _evaluations,
            ) &&
            (identical(other.currentCheckpointIndex, currentCheckpointIndex) ||
                other.currentCheckpointIndex == currentCheckpointIndex) &&
            (identical(other.hasViewedNarrative, hasViewedNarrative) ||
                other.hasViewedNarrative == hasViewedNarrative));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scenarioId,
    userId,
    organizationId,
    startedAt,
    completedAt,
    status,
    const DeepCollectionEquality().hash(_evidenceSubmissions),
    const DeepCollectionEquality().hash(_evaluations),
    currentCheckpointIndex,
    hasViewedNarrative,
  );

  /// Create a copy of SimulationSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationSessionImplCopyWith<_$SimulationSessionImpl> get copyWith =>
      __$$SimulationSessionImplCopyWithImpl<_$SimulationSessionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationSessionImplToJson(this);
  }
}

abstract class _SimulationSession implements SimulationSession {
  const factory _SimulationSession({
    required final String id,
    required final String scenarioId,
    required final String userId,
    required final String organizationId,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final String status,
    required final List<CheckpointEvidence> evidenceSubmissions,
    required final List<CheckpointEvaluation> evaluations,
    required final int currentCheckpointIndex,
    required final bool hasViewedNarrative,
  }) = _$SimulationSessionImpl;

  factory _SimulationSession.fromJson(Map<String, dynamic> json) =
      _$SimulationSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get scenarioId;
  @override
  String get userId;
  @override
  String get organizationId;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String get status; // 'in_progress', 'completed', 'abandoned'
  @override
  List<CheckpointEvidence> get evidenceSubmissions;
  @override
  List<CheckpointEvaluation> get evaluations;
  @override
  int get currentCheckpointIndex;
  @override
  bool get hasViewedNarrative;

  /// Create a copy of SimulationSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationSessionImplCopyWith<_$SimulationSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DefensiveReadinessScore _$DefensiveReadinessScoreFromJson(
  Map<String, dynamic> json,
) {
  return _DefensiveReadinessScore.fromJson(json);
}

/// @nodoc
mixin _$DefensiveReadinessScore {
  String get sessionId => throw _privateConstructorUsedError;
  String get scenarioId => throw _privateConstructorUsedError;
  int get totalPointsPossible => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;
  double get percentageScore => throw _privateConstructorUsedError; // 0-100
  String get gradeLevel =>
      throw _privateConstructorUsedError; // 'A', 'B', 'C', 'D', 'F'
  String get readinessLevel =>
      throw _privateConstructorUsedError; // 'Expert', 'Proficient', 'Developing', 'Novice'
  Map<String, int> get scoreByTactic =>
      throw _privateConstructorUsedError; // Score per tactic involved
  List<String> get detectedTechniques =>
      throw _privateConstructorUsedError; // Techniques user caught
  List<String> get missedTechniques =>
      throw _privateConstructorUsedError; // Techniques user missed
  List<String> get strongAreas =>
      throw _privateConstructorUsedError; // "Detection is strong for..."
  List<String> get weakAreas =>
      throw _privateConstructorUsedError; // "Detection needs work for..."
  List<RemediationAction> get prioritizedRemediations =>
      throw _privateConstructorUsedError;

  /// Serializes this DefensiveReadinessScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DefensiveReadinessScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DefensiveReadinessScoreCopyWith<DefensiveReadinessScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefensiveReadinessScoreCopyWith<$Res> {
  factory $DefensiveReadinessScoreCopyWith(
    DefensiveReadinessScore value,
    $Res Function(DefensiveReadinessScore) then,
  ) = _$DefensiveReadinessScoreCopyWithImpl<$Res, DefensiveReadinessScore>;
  @useResult
  $Res call({
    String sessionId,
    String scenarioId,
    int totalPointsPossible,
    int pointsEarned,
    double percentageScore,
    String gradeLevel,
    String readinessLevel,
    Map<String, int> scoreByTactic,
    List<String> detectedTechniques,
    List<String> missedTechniques,
    List<String> strongAreas,
    List<String> weakAreas,
    List<RemediationAction> prioritizedRemediations,
  });
}

/// @nodoc
class _$DefensiveReadinessScoreCopyWithImpl<
  $Res,
  $Val extends DefensiveReadinessScore
>
    implements $DefensiveReadinessScoreCopyWith<$Res> {
  _$DefensiveReadinessScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DefensiveReadinessScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenarioId = null,
    Object? totalPointsPossible = null,
    Object? pointsEarned = null,
    Object? percentageScore = null,
    Object? gradeLevel = null,
    Object? readinessLevel = null,
    Object? scoreByTactic = null,
    Object? detectedTechniques = null,
    Object? missedTechniques = null,
    Object? strongAreas = null,
    Object? weakAreas = null,
    Object? prioritizedRemediations = null,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            scenarioId: null == scenarioId
                ? _value.scenarioId
                : scenarioId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalPointsPossible: null == totalPointsPossible
                ? _value.totalPointsPossible
                : totalPointsPossible // ignore: cast_nullable_to_non_nullable
                      as int,
            pointsEarned: null == pointsEarned
                ? _value.pointsEarned
                : pointsEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            percentageScore: null == percentageScore
                ? _value.percentageScore
                : percentageScore // ignore: cast_nullable_to_non_nullable
                      as double,
            gradeLevel: null == gradeLevel
                ? _value.gradeLevel
                : gradeLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            readinessLevel: null == readinessLevel
                ? _value.readinessLevel
                : readinessLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            scoreByTactic: null == scoreByTactic
                ? _value.scoreByTactic
                : scoreByTactic // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            detectedTechniques: null == detectedTechniques
                ? _value.detectedTechniques
                : detectedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            missedTechniques: null == missedTechniques
                ? _value.missedTechniques
                : missedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            strongAreas: null == strongAreas
                ? _value.strongAreas
                : strongAreas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            weakAreas: null == weakAreas
                ? _value.weakAreas
                : weakAreas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            prioritizedRemediations: null == prioritizedRemediations
                ? _value.prioritizedRemediations
                : prioritizedRemediations // ignore: cast_nullable_to_non_nullable
                      as List<RemediationAction>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DefensiveReadinessScoreImplCopyWith<$Res>
    implements $DefensiveReadinessScoreCopyWith<$Res> {
  factory _$$DefensiveReadinessScoreImplCopyWith(
    _$DefensiveReadinessScoreImpl value,
    $Res Function(_$DefensiveReadinessScoreImpl) then,
  ) = __$$DefensiveReadinessScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionId,
    String scenarioId,
    int totalPointsPossible,
    int pointsEarned,
    double percentageScore,
    String gradeLevel,
    String readinessLevel,
    Map<String, int> scoreByTactic,
    List<String> detectedTechniques,
    List<String> missedTechniques,
    List<String> strongAreas,
    List<String> weakAreas,
    List<RemediationAction> prioritizedRemediations,
  });
}

/// @nodoc
class __$$DefensiveReadinessScoreImplCopyWithImpl<$Res>
    extends
        _$DefensiveReadinessScoreCopyWithImpl<
          $Res,
          _$DefensiveReadinessScoreImpl
        >
    implements _$$DefensiveReadinessScoreImplCopyWith<$Res> {
  __$$DefensiveReadinessScoreImplCopyWithImpl(
    _$DefensiveReadinessScoreImpl _value,
    $Res Function(_$DefensiveReadinessScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DefensiveReadinessScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenarioId = null,
    Object? totalPointsPossible = null,
    Object? pointsEarned = null,
    Object? percentageScore = null,
    Object? gradeLevel = null,
    Object? readinessLevel = null,
    Object? scoreByTactic = null,
    Object? detectedTechniques = null,
    Object? missedTechniques = null,
    Object? strongAreas = null,
    Object? weakAreas = null,
    Object? prioritizedRemediations = null,
  }) {
    return _then(
      _$DefensiveReadinessScoreImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        scenarioId: null == scenarioId
            ? _value.scenarioId
            : scenarioId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalPointsPossible: null == totalPointsPossible
            ? _value.totalPointsPossible
            : totalPointsPossible // ignore: cast_nullable_to_non_nullable
                  as int,
        pointsEarned: null == pointsEarned
            ? _value.pointsEarned
            : pointsEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        percentageScore: null == percentageScore
            ? _value.percentageScore
            : percentageScore // ignore: cast_nullable_to_non_nullable
                  as double,
        gradeLevel: null == gradeLevel
            ? _value.gradeLevel
            : gradeLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        readinessLevel: null == readinessLevel
            ? _value.readinessLevel
            : readinessLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        scoreByTactic: null == scoreByTactic
            ? _value._scoreByTactic
            : scoreByTactic // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        detectedTechniques: null == detectedTechniques
            ? _value._detectedTechniques
            : detectedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        missedTechniques: null == missedTechniques
            ? _value._missedTechniques
            : missedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        strongAreas: null == strongAreas
            ? _value._strongAreas
            : strongAreas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        weakAreas: null == weakAreas
            ? _value._weakAreas
            : weakAreas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        prioritizedRemediations: null == prioritizedRemediations
            ? _value._prioritizedRemediations
            : prioritizedRemediations // ignore: cast_nullable_to_non_nullable
                  as List<RemediationAction>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DefensiveReadinessScoreImpl implements _DefensiveReadinessScore {
  const _$DefensiveReadinessScoreImpl({
    required this.sessionId,
    required this.scenarioId,
    required this.totalPointsPossible,
    required this.pointsEarned,
    required this.percentageScore,
    required this.gradeLevel,
    required this.readinessLevel,
    required final Map<String, int> scoreByTactic,
    required final List<String> detectedTechniques,
    required final List<String> missedTechniques,
    required final List<String> strongAreas,
    required final List<String> weakAreas,
    required final List<RemediationAction> prioritizedRemediations,
  }) : _scoreByTactic = scoreByTactic,
       _detectedTechniques = detectedTechniques,
       _missedTechniques = missedTechniques,
       _strongAreas = strongAreas,
       _weakAreas = weakAreas,
       _prioritizedRemediations = prioritizedRemediations;

  factory _$DefensiveReadinessScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$DefensiveReadinessScoreImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String scenarioId;
  @override
  final int totalPointsPossible;
  @override
  final int pointsEarned;
  @override
  final double percentageScore;
  // 0-100
  @override
  final String gradeLevel;
  // 'A', 'B', 'C', 'D', 'F'
  @override
  final String readinessLevel;
  // 'Expert', 'Proficient', 'Developing', 'Novice'
  final Map<String, int> _scoreByTactic;
  // 'Expert', 'Proficient', 'Developing', 'Novice'
  @override
  Map<String, int> get scoreByTactic {
    if (_scoreByTactic is EqualUnmodifiableMapView) return _scoreByTactic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_scoreByTactic);
  }

  // Score per tactic involved
  final List<String> _detectedTechniques;
  // Score per tactic involved
  @override
  List<String> get detectedTechniques {
    if (_detectedTechniques is EqualUnmodifiableListView)
      return _detectedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectedTechniques);
  }

  // Techniques user caught
  final List<String> _missedTechniques;
  // Techniques user caught
  @override
  List<String> get missedTechniques {
    if (_missedTechniques is EqualUnmodifiableListView)
      return _missedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missedTechniques);
  }

  // Techniques user missed
  final List<String> _strongAreas;
  // Techniques user missed
  @override
  List<String> get strongAreas {
    if (_strongAreas is EqualUnmodifiableListView) return _strongAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strongAreas);
  }

  // "Detection is strong for..."
  final List<String> _weakAreas;
  // "Detection is strong for..."
  @override
  List<String> get weakAreas {
    if (_weakAreas is EqualUnmodifiableListView) return _weakAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weakAreas);
  }

  // "Detection needs work for..."
  final List<RemediationAction> _prioritizedRemediations;
  // "Detection needs work for..."
  @override
  List<RemediationAction> get prioritizedRemediations {
    if (_prioritizedRemediations is EqualUnmodifiableListView)
      return _prioritizedRemediations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prioritizedRemediations);
  }

  @override
  String toString() {
    return 'DefensiveReadinessScore(sessionId: $sessionId, scenarioId: $scenarioId, totalPointsPossible: $totalPointsPossible, pointsEarned: $pointsEarned, percentageScore: $percentageScore, gradeLevel: $gradeLevel, readinessLevel: $readinessLevel, scoreByTactic: $scoreByTactic, detectedTechniques: $detectedTechniques, missedTechniques: $missedTechniques, strongAreas: $strongAreas, weakAreas: $weakAreas, prioritizedRemediations: $prioritizedRemediations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefensiveReadinessScoreImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.scenarioId, scenarioId) ||
                other.scenarioId == scenarioId) &&
            (identical(other.totalPointsPossible, totalPointsPossible) ||
                other.totalPointsPossible == totalPointsPossible) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.percentageScore, percentageScore) ||
                other.percentageScore == percentageScore) &&
            (identical(other.gradeLevel, gradeLevel) ||
                other.gradeLevel == gradeLevel) &&
            (identical(other.readinessLevel, readinessLevel) ||
                other.readinessLevel == readinessLevel) &&
            const DeepCollectionEquality().equals(
              other._scoreByTactic,
              _scoreByTactic,
            ) &&
            const DeepCollectionEquality().equals(
              other._detectedTechniques,
              _detectedTechniques,
            ) &&
            const DeepCollectionEquality().equals(
              other._missedTechniques,
              _missedTechniques,
            ) &&
            const DeepCollectionEquality().equals(
              other._strongAreas,
              _strongAreas,
            ) &&
            const DeepCollectionEquality().equals(
              other._weakAreas,
              _weakAreas,
            ) &&
            const DeepCollectionEquality().equals(
              other._prioritizedRemediations,
              _prioritizedRemediations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    scenarioId,
    totalPointsPossible,
    pointsEarned,
    percentageScore,
    gradeLevel,
    readinessLevel,
    const DeepCollectionEquality().hash(_scoreByTactic),
    const DeepCollectionEquality().hash(_detectedTechniques),
    const DeepCollectionEquality().hash(_missedTechniques),
    const DeepCollectionEquality().hash(_strongAreas),
    const DeepCollectionEquality().hash(_weakAreas),
    const DeepCollectionEquality().hash(_prioritizedRemediations),
  );

  /// Create a copy of DefensiveReadinessScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DefensiveReadinessScoreImplCopyWith<_$DefensiveReadinessScoreImpl>
  get copyWith =>
      __$$DefensiveReadinessScoreImplCopyWithImpl<
        _$DefensiveReadinessScoreImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DefensiveReadinessScoreImplToJson(this);
  }
}

abstract class _DefensiveReadinessScore implements DefensiveReadinessScore {
  const factory _DefensiveReadinessScore({
    required final String sessionId,
    required final String scenarioId,
    required final int totalPointsPossible,
    required final int pointsEarned,
    required final double percentageScore,
    required final String gradeLevel,
    required final String readinessLevel,
    required final Map<String, int> scoreByTactic,
    required final List<String> detectedTechniques,
    required final List<String> missedTechniques,
    required final List<String> strongAreas,
    required final List<String> weakAreas,
    required final List<RemediationAction> prioritizedRemediations,
  }) = _$DefensiveReadinessScoreImpl;

  factory _DefensiveReadinessScore.fromJson(Map<String, dynamic> json) =
      _$DefensiveReadinessScoreImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get scenarioId;
  @override
  int get totalPointsPossible;
  @override
  int get pointsEarned;
  @override
  double get percentageScore; // 0-100
  @override
  String get gradeLevel; // 'A', 'B', 'C', 'D', 'F'
  @override
  String get readinessLevel; // 'Expert', 'Proficient', 'Developing', 'Novice'
  @override
  Map<String, int> get scoreByTactic; // Score per tactic involved
  @override
  List<String> get detectedTechniques; // Techniques user caught
  @override
  List<String> get missedTechniques; // Techniques user missed
  @override
  List<String> get strongAreas; // "Detection is strong for..."
  @override
  List<String> get weakAreas; // "Detection needs work for..."
  @override
  List<RemediationAction> get prioritizedRemediations;

  /// Create a copy of DefensiveReadinessScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DefensiveReadinessScoreImplCopyWith<_$DefensiveReadinessScoreImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RemediationAction _$RemediationActionFromJson(Map<String, dynamic> json) {
  return _RemediationAction.fromJson(json);
}

/// @nodoc
mixin _$RemediationAction {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get relatedTechnique => throw _privateConstructorUsedError;
  String get relatedMitigation =>
      throw _privateConstructorUsedError; // MITRE mitigation ID (M1234)
  int get priority =>
      throw _privateConstructorUsedError; // 1=critical, 2=high, 3=medium, 4=low
  String get difficulty =>
      throw _privateConstructorUsedError; // 'quick_win', 'moderate', 'complex'
  String get targetedTool =>
      throw _privateConstructorUsedError; // 'Windows Defender', 'Email Gateway', etc.
  List<String> get implementationSteps => throw _privateConstructorUsedError;
  String get expectedOutcome => throw _privateConstructorUsedError;

  /// Serializes this RemediationAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemediationAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemediationActionCopyWith<RemediationAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemediationActionCopyWith<$Res> {
  factory $RemediationActionCopyWith(
    RemediationAction value,
    $Res Function(RemediationAction) then,
  ) = _$RemediationActionCopyWithImpl<$Res, RemediationAction>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String relatedTechnique,
    String relatedMitigation,
    int priority,
    String difficulty,
    String targetedTool,
    List<String> implementationSteps,
    String expectedOutcome,
  });
}

/// @nodoc
class _$RemediationActionCopyWithImpl<$Res, $Val extends RemediationAction>
    implements $RemediationActionCopyWith<$Res> {
  _$RemediationActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemediationAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? relatedTechnique = null,
    Object? relatedMitigation = null,
    Object? priority = null,
    Object? difficulty = null,
    Object? targetedTool = null,
    Object? implementationSteps = null,
    Object? expectedOutcome = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedTechnique: null == relatedTechnique
                ? _value.relatedTechnique
                : relatedTechnique // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedMitigation: null == relatedMitigation
                ? _value.relatedMitigation
                : relatedMitigation // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            targetedTool: null == targetedTool
                ? _value.targetedTool
                : targetedTool // ignore: cast_nullable_to_non_nullable
                      as String,
            implementationSteps: null == implementationSteps
                ? _value.implementationSteps
                : implementationSteps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            expectedOutcome: null == expectedOutcome
                ? _value.expectedOutcome
                : expectedOutcome // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RemediationActionImplCopyWith<$Res>
    implements $RemediationActionCopyWith<$Res> {
  factory _$$RemediationActionImplCopyWith(
    _$RemediationActionImpl value,
    $Res Function(_$RemediationActionImpl) then,
  ) = __$$RemediationActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String relatedTechnique,
    String relatedMitigation,
    int priority,
    String difficulty,
    String targetedTool,
    List<String> implementationSteps,
    String expectedOutcome,
  });
}

/// @nodoc
class __$$RemediationActionImplCopyWithImpl<$Res>
    extends _$RemediationActionCopyWithImpl<$Res, _$RemediationActionImpl>
    implements _$$RemediationActionImplCopyWith<$Res> {
  __$$RemediationActionImplCopyWithImpl(
    _$RemediationActionImpl _value,
    $Res Function(_$RemediationActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RemediationAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? relatedTechnique = null,
    Object? relatedMitigation = null,
    Object? priority = null,
    Object? difficulty = null,
    Object? targetedTool = null,
    Object? implementationSteps = null,
    Object? expectedOutcome = null,
  }) {
    return _then(
      _$RemediationActionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedTechnique: null == relatedTechnique
            ? _value.relatedTechnique
            : relatedTechnique // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedMitigation: null == relatedMitigation
            ? _value.relatedMitigation
            : relatedMitigation // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        targetedTool: null == targetedTool
            ? _value.targetedTool
            : targetedTool // ignore: cast_nullable_to_non_nullable
                  as String,
        implementationSteps: null == implementationSteps
            ? _value._implementationSteps
            : implementationSteps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        expectedOutcome: null == expectedOutcome
            ? _value.expectedOutcome
            : expectedOutcome // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RemediationActionImpl implements _RemediationAction {
  const _$RemediationActionImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.relatedTechnique,
    required this.relatedMitigation,
    required this.priority,
    required this.difficulty,
    required this.targetedTool,
    required final List<String> implementationSteps,
    required this.expectedOutcome,
  }) : _implementationSteps = implementationSteps;

  factory _$RemediationActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemediationActionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String relatedTechnique;
  @override
  final String relatedMitigation;
  // MITRE mitigation ID (M1234)
  @override
  final int priority;
  // 1=critical, 2=high, 3=medium, 4=low
  @override
  final String difficulty;
  // 'quick_win', 'moderate', 'complex'
  @override
  final String targetedTool;
  // 'Windows Defender', 'Email Gateway', etc.
  final List<String> _implementationSteps;
  // 'Windows Defender', 'Email Gateway', etc.
  @override
  List<String> get implementationSteps {
    if (_implementationSteps is EqualUnmodifiableListView)
      return _implementationSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_implementationSteps);
  }

  @override
  final String expectedOutcome;

  @override
  String toString() {
    return 'RemediationAction(id: $id, title: $title, description: $description, relatedTechnique: $relatedTechnique, relatedMitigation: $relatedMitigation, priority: $priority, difficulty: $difficulty, targetedTool: $targetedTool, implementationSteps: $implementationSteps, expectedOutcome: $expectedOutcome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemediationActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.relatedTechnique, relatedTechnique) ||
                other.relatedTechnique == relatedTechnique) &&
            (identical(other.relatedMitigation, relatedMitigation) ||
                other.relatedMitigation == relatedMitigation) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.targetedTool, targetedTool) ||
                other.targetedTool == targetedTool) &&
            const DeepCollectionEquality().equals(
              other._implementationSteps,
              _implementationSteps,
            ) &&
            (identical(other.expectedOutcome, expectedOutcome) ||
                other.expectedOutcome == expectedOutcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    relatedTechnique,
    relatedMitigation,
    priority,
    difficulty,
    targetedTool,
    const DeepCollectionEquality().hash(_implementationSteps),
    expectedOutcome,
  );

  /// Create a copy of RemediationAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemediationActionImplCopyWith<_$RemediationActionImpl> get copyWith =>
      __$$RemediationActionImplCopyWithImpl<_$RemediationActionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RemediationActionImplToJson(this);
  }
}

abstract class _RemediationAction implements RemediationAction {
  const factory _RemediationAction({
    required final String id,
    required final String title,
    required final String description,
    required final String relatedTechnique,
    required final String relatedMitigation,
    required final int priority,
    required final String difficulty,
    required final String targetedTool,
    required final List<String> implementationSteps,
    required final String expectedOutcome,
  }) = _$RemediationActionImpl;

  factory _RemediationAction.fromJson(Map<String, dynamic> json) =
      _$RemediationActionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get relatedTechnique;
  @override
  String get relatedMitigation; // MITRE mitigation ID (M1234)
  @override
  int get priority; // 1=critical, 2=high, 3=medium, 4=low
  @override
  String get difficulty; // 'quick_win', 'moderate', 'complex'
  @override
  String get targetedTool; // 'Windows Defender', 'Email Gateway', etc.
  @override
  List<String> get implementationSteps;
  @override
  String get expectedOutcome;

  /// Create a copy of RemediationAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemediationActionImplCopyWith<_$RemediationActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SimulationAnalytics _$SimulationAnalyticsFromJson(Map<String, dynamic> json) {
  return _SimulationAnalytics.fromJson(json);
}

/// @nodoc
mixin _$SimulationAnalytics {
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  int get totalScenariosCompleted => throw _privateConstructorUsedError;
  double get averageScorePercentage => throw _privateConstructorUsedError;
  List<String> get completedScenarioIds => throw _privateConstructorUsedError;
  Map<String, double> get averageScoreByTactic =>
      throw _privateConstructorUsedError; // T1234 -> 75.5%
  List<String> get consistentlyDetectedTechniques =>
      throw _privateConstructorUsedError;
  List<String> get consistentlyMissedTechniques =>
      throw _privateConstructorUsedError;
  String get overallDefensiveProfile =>
      throw _privateConstructorUsedError; // Based on patterns
  DateTime get lastSimulationDate => throw _privateConstructorUsedError;
  List<SimulationSessionSummary> get recentSessions =>
      throw _privateConstructorUsedError;

  /// Serializes this SimulationAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationAnalyticsCopyWith<SimulationAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationAnalyticsCopyWith<$Res> {
  factory $SimulationAnalyticsCopyWith(
    SimulationAnalytics value,
    $Res Function(SimulationAnalytics) then,
  ) = _$SimulationAnalyticsCopyWithImpl<$Res, SimulationAnalytics>;
  @useResult
  $Res call({
    String userId,
    String organizationId,
    int totalScenariosCompleted,
    double averageScorePercentage,
    List<String> completedScenarioIds,
    Map<String, double> averageScoreByTactic,
    List<String> consistentlyDetectedTechniques,
    List<String> consistentlyMissedTechniques,
    String overallDefensiveProfile,
    DateTime lastSimulationDate,
    List<SimulationSessionSummary> recentSessions,
  });
}

/// @nodoc
class _$SimulationAnalyticsCopyWithImpl<$Res, $Val extends SimulationAnalytics>
    implements $SimulationAnalyticsCopyWith<$Res> {
  _$SimulationAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? totalScenariosCompleted = null,
    Object? averageScorePercentage = null,
    Object? completedScenarioIds = null,
    Object? averageScoreByTactic = null,
    Object? consistentlyDetectedTechniques = null,
    Object? consistentlyMissedTechniques = null,
    Object? overallDefensiveProfile = null,
    Object? lastSimulationDate = null,
    Object? recentSessions = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            organizationId: null == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalScenariosCompleted: null == totalScenariosCompleted
                ? _value.totalScenariosCompleted
                : totalScenariosCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            averageScorePercentage: null == averageScorePercentage
                ? _value.averageScorePercentage
                : averageScorePercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            completedScenarioIds: null == completedScenarioIds
                ? _value.completedScenarioIds
                : completedScenarioIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            averageScoreByTactic: null == averageScoreByTactic
                ? _value.averageScoreByTactic
                : averageScoreByTactic // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            consistentlyDetectedTechniques:
                null == consistentlyDetectedTechniques
                ? _value.consistentlyDetectedTechniques
                : consistentlyDetectedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            consistentlyMissedTechniques: null == consistentlyMissedTechniques
                ? _value.consistentlyMissedTechniques
                : consistentlyMissedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            overallDefensiveProfile: null == overallDefensiveProfile
                ? _value.overallDefensiveProfile
                : overallDefensiveProfile // ignore: cast_nullable_to_non_nullable
                      as String,
            lastSimulationDate: null == lastSimulationDate
                ? _value.lastSimulationDate
                : lastSimulationDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            recentSessions: null == recentSessions
                ? _value.recentSessions
                : recentSessions // ignore: cast_nullable_to_non_nullable
                      as List<SimulationSessionSummary>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationAnalyticsImplCopyWith<$Res>
    implements $SimulationAnalyticsCopyWith<$Res> {
  factory _$$SimulationAnalyticsImplCopyWith(
    _$SimulationAnalyticsImpl value,
    $Res Function(_$SimulationAnalyticsImpl) then,
  ) = __$$SimulationAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String organizationId,
    int totalScenariosCompleted,
    double averageScorePercentage,
    List<String> completedScenarioIds,
    Map<String, double> averageScoreByTactic,
    List<String> consistentlyDetectedTechniques,
    List<String> consistentlyMissedTechniques,
    String overallDefensiveProfile,
    DateTime lastSimulationDate,
    List<SimulationSessionSummary> recentSessions,
  });
}

/// @nodoc
class __$$SimulationAnalyticsImplCopyWithImpl<$Res>
    extends _$SimulationAnalyticsCopyWithImpl<$Res, _$SimulationAnalyticsImpl>
    implements _$$SimulationAnalyticsImplCopyWith<$Res> {
  __$$SimulationAnalyticsImplCopyWithImpl(
    _$SimulationAnalyticsImpl _value,
    $Res Function(_$SimulationAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? totalScenariosCompleted = null,
    Object? averageScorePercentage = null,
    Object? completedScenarioIds = null,
    Object? averageScoreByTactic = null,
    Object? consistentlyDetectedTechniques = null,
    Object? consistentlyMissedTechniques = null,
    Object? overallDefensiveProfile = null,
    Object? lastSimulationDate = null,
    Object? recentSessions = null,
  }) {
    return _then(
      _$SimulationAnalyticsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        organizationId: null == organizationId
            ? _value.organizationId
            : organizationId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalScenariosCompleted: null == totalScenariosCompleted
            ? _value.totalScenariosCompleted
            : totalScenariosCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        averageScorePercentage: null == averageScorePercentage
            ? _value.averageScorePercentage
            : averageScorePercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        completedScenarioIds: null == completedScenarioIds
            ? _value._completedScenarioIds
            : completedScenarioIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        averageScoreByTactic: null == averageScoreByTactic
            ? _value._averageScoreByTactic
            : averageScoreByTactic // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        consistentlyDetectedTechniques: null == consistentlyDetectedTechniques
            ? _value._consistentlyDetectedTechniques
            : consistentlyDetectedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        consistentlyMissedTechniques: null == consistentlyMissedTechniques
            ? _value._consistentlyMissedTechniques
            : consistentlyMissedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        overallDefensiveProfile: null == overallDefensiveProfile
            ? _value.overallDefensiveProfile
            : overallDefensiveProfile // ignore: cast_nullable_to_non_nullable
                  as String,
        lastSimulationDate: null == lastSimulationDate
            ? _value.lastSimulationDate
            : lastSimulationDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        recentSessions: null == recentSessions
            ? _value._recentSessions
            : recentSessions // ignore: cast_nullable_to_non_nullable
                  as List<SimulationSessionSummary>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationAnalyticsImpl implements _SimulationAnalytics {
  const _$SimulationAnalyticsImpl({
    required this.userId,
    required this.organizationId,
    required this.totalScenariosCompleted,
    required this.averageScorePercentage,
    required final List<String> completedScenarioIds,
    required final Map<String, double> averageScoreByTactic,
    required final List<String> consistentlyDetectedTechniques,
    required final List<String> consistentlyMissedTechniques,
    required this.overallDefensiveProfile,
    required this.lastSimulationDate,
    required final List<SimulationSessionSummary> recentSessions,
  }) : _completedScenarioIds = completedScenarioIds,
       _averageScoreByTactic = averageScoreByTactic,
       _consistentlyDetectedTechniques = consistentlyDetectedTechniques,
       _consistentlyMissedTechniques = consistentlyMissedTechniques,
       _recentSessions = recentSessions;

  factory _$SimulationAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationAnalyticsImplFromJson(json);

  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final int totalScenariosCompleted;
  @override
  final double averageScorePercentage;
  final List<String> _completedScenarioIds;
  @override
  List<String> get completedScenarioIds {
    if (_completedScenarioIds is EqualUnmodifiableListView)
      return _completedScenarioIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedScenarioIds);
  }

  final Map<String, double> _averageScoreByTactic;
  @override
  Map<String, double> get averageScoreByTactic {
    if (_averageScoreByTactic is EqualUnmodifiableMapView)
      return _averageScoreByTactic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_averageScoreByTactic);
  }

  // T1234 -> 75.5%
  final List<String> _consistentlyDetectedTechniques;
  // T1234 -> 75.5%
  @override
  List<String> get consistentlyDetectedTechniques {
    if (_consistentlyDetectedTechniques is EqualUnmodifiableListView)
      return _consistentlyDetectedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consistentlyDetectedTechniques);
  }

  final List<String> _consistentlyMissedTechniques;
  @override
  List<String> get consistentlyMissedTechniques {
    if (_consistentlyMissedTechniques is EqualUnmodifiableListView)
      return _consistentlyMissedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consistentlyMissedTechniques);
  }

  @override
  final String overallDefensiveProfile;
  // Based on patterns
  @override
  final DateTime lastSimulationDate;
  final List<SimulationSessionSummary> _recentSessions;
  @override
  List<SimulationSessionSummary> get recentSessions {
    if (_recentSessions is EqualUnmodifiableListView) return _recentSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSessions);
  }

  @override
  String toString() {
    return 'SimulationAnalytics(userId: $userId, organizationId: $organizationId, totalScenariosCompleted: $totalScenariosCompleted, averageScorePercentage: $averageScorePercentage, completedScenarioIds: $completedScenarioIds, averageScoreByTactic: $averageScoreByTactic, consistentlyDetectedTechniques: $consistentlyDetectedTechniques, consistentlyMissedTechniques: $consistentlyMissedTechniques, overallDefensiveProfile: $overallDefensiveProfile, lastSimulationDate: $lastSimulationDate, recentSessions: $recentSessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationAnalyticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(
                  other.totalScenariosCompleted,
                  totalScenariosCompleted,
                ) ||
                other.totalScenariosCompleted == totalScenariosCompleted) &&
            (identical(other.averageScorePercentage, averageScorePercentage) ||
                other.averageScorePercentage == averageScorePercentage) &&
            const DeepCollectionEquality().equals(
              other._completedScenarioIds,
              _completedScenarioIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._averageScoreByTactic,
              _averageScoreByTactic,
            ) &&
            const DeepCollectionEquality().equals(
              other._consistentlyDetectedTechniques,
              _consistentlyDetectedTechniques,
            ) &&
            const DeepCollectionEquality().equals(
              other._consistentlyMissedTechniques,
              _consistentlyMissedTechniques,
            ) &&
            (identical(
                  other.overallDefensiveProfile,
                  overallDefensiveProfile,
                ) ||
                other.overallDefensiveProfile == overallDefensiveProfile) &&
            (identical(other.lastSimulationDate, lastSimulationDate) ||
                other.lastSimulationDate == lastSimulationDate) &&
            const DeepCollectionEquality().equals(
              other._recentSessions,
              _recentSessions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    organizationId,
    totalScenariosCompleted,
    averageScorePercentage,
    const DeepCollectionEquality().hash(_completedScenarioIds),
    const DeepCollectionEquality().hash(_averageScoreByTactic),
    const DeepCollectionEquality().hash(_consistentlyDetectedTechniques),
    const DeepCollectionEquality().hash(_consistentlyMissedTechniques),
    overallDefensiveProfile,
    lastSimulationDate,
    const DeepCollectionEquality().hash(_recentSessions),
  );

  /// Create a copy of SimulationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationAnalyticsImplCopyWith<_$SimulationAnalyticsImpl> get copyWith =>
      __$$SimulationAnalyticsImplCopyWithImpl<_$SimulationAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationAnalyticsImplToJson(this);
  }
}

abstract class _SimulationAnalytics implements SimulationAnalytics {
  const factory _SimulationAnalytics({
    required final String userId,
    required final String organizationId,
    required final int totalScenariosCompleted,
    required final double averageScorePercentage,
    required final List<String> completedScenarioIds,
    required final Map<String, double> averageScoreByTactic,
    required final List<String> consistentlyDetectedTechniques,
    required final List<String> consistentlyMissedTechniques,
    required final String overallDefensiveProfile,
    required final DateTime lastSimulationDate,
    required final List<SimulationSessionSummary> recentSessions,
  }) = _$SimulationAnalyticsImpl;

  factory _SimulationAnalytics.fromJson(Map<String, dynamic> json) =
      _$SimulationAnalyticsImpl.fromJson;

  @override
  String get userId;
  @override
  String get organizationId;
  @override
  int get totalScenariosCompleted;
  @override
  double get averageScorePercentage;
  @override
  List<String> get completedScenarioIds;
  @override
  Map<String, double> get averageScoreByTactic; // T1234 -> 75.5%
  @override
  List<String> get consistentlyDetectedTechniques;
  @override
  List<String> get consistentlyMissedTechniques;
  @override
  String get overallDefensiveProfile; // Based on patterns
  @override
  DateTime get lastSimulationDate;
  @override
  List<SimulationSessionSummary> get recentSessions;

  /// Create a copy of SimulationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationAnalyticsImplCopyWith<_$SimulationAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SimulationSessionSummary _$SimulationSessionSummaryFromJson(
  Map<String, dynamic> json,
) {
  return _SimulationSessionSummary.fromJson(json);
}

/// @nodoc
mixin _$SimulationSessionSummary {
  String get sessionId => throw _privateConstructorUsedError;
  String get scenarioTitle => throw _privateConstructorUsedError;
  DateTime get completedDate => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  double get scorePercentage => throw _privateConstructorUsedError;
  String get gradeLevel => throw _privateConstructorUsedError;
  int get checkpointsDetected => throw _privateConstructorUsedError;
  int get checkpointsMissed => throw _privateConstructorUsedError;

  /// Serializes this SimulationSessionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationSessionSummaryCopyWith<SimulationSessionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationSessionSummaryCopyWith<$Res> {
  factory $SimulationSessionSummaryCopyWith(
    SimulationSessionSummary value,
    $Res Function(SimulationSessionSummary) then,
  ) = _$SimulationSessionSummaryCopyWithImpl<$Res, SimulationSessionSummary>;
  @useResult
  $Res call({
    String sessionId,
    String scenarioTitle,
    DateTime completedDate,
    int durationMinutes,
    double scorePercentage,
    String gradeLevel,
    int checkpointsDetected,
    int checkpointsMissed,
  });
}

/// @nodoc
class _$SimulationSessionSummaryCopyWithImpl<
  $Res,
  $Val extends SimulationSessionSummary
>
    implements $SimulationSessionSummaryCopyWith<$Res> {
  _$SimulationSessionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenarioTitle = null,
    Object? completedDate = null,
    Object? durationMinutes = null,
    Object? scorePercentage = null,
    Object? gradeLevel = null,
    Object? checkpointsDetected = null,
    Object? checkpointsMissed = null,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            scenarioTitle: null == scenarioTitle
                ? _value.scenarioTitle
                : scenarioTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            completedDate: null == completedDate
                ? _value.completedDate
                : completedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            scorePercentage: null == scorePercentage
                ? _value.scorePercentage
                : scorePercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            gradeLevel: null == gradeLevel
                ? _value.gradeLevel
                : gradeLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            checkpointsDetected: null == checkpointsDetected
                ? _value.checkpointsDetected
                : checkpointsDetected // ignore: cast_nullable_to_non_nullable
                      as int,
            checkpointsMissed: null == checkpointsMissed
                ? _value.checkpointsMissed
                : checkpointsMissed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationSessionSummaryImplCopyWith<$Res>
    implements $SimulationSessionSummaryCopyWith<$Res> {
  factory _$$SimulationSessionSummaryImplCopyWith(
    _$SimulationSessionSummaryImpl value,
    $Res Function(_$SimulationSessionSummaryImpl) then,
  ) = __$$SimulationSessionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionId,
    String scenarioTitle,
    DateTime completedDate,
    int durationMinutes,
    double scorePercentage,
    String gradeLevel,
    int checkpointsDetected,
    int checkpointsMissed,
  });
}

/// @nodoc
class __$$SimulationSessionSummaryImplCopyWithImpl<$Res>
    extends
        _$SimulationSessionSummaryCopyWithImpl<
          $Res,
          _$SimulationSessionSummaryImpl
        >
    implements _$$SimulationSessionSummaryImplCopyWith<$Res> {
  __$$SimulationSessionSummaryImplCopyWithImpl(
    _$SimulationSessionSummaryImpl _value,
    $Res Function(_$SimulationSessionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenarioTitle = null,
    Object? completedDate = null,
    Object? durationMinutes = null,
    Object? scorePercentage = null,
    Object? gradeLevel = null,
    Object? checkpointsDetected = null,
    Object? checkpointsMissed = null,
  }) {
    return _then(
      _$SimulationSessionSummaryImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        scenarioTitle: null == scenarioTitle
            ? _value.scenarioTitle
            : scenarioTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        completedDate: null == completedDate
            ? _value.completedDate
            : completedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        scorePercentage: null == scorePercentage
            ? _value.scorePercentage
            : scorePercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        gradeLevel: null == gradeLevel
            ? _value.gradeLevel
            : gradeLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        checkpointsDetected: null == checkpointsDetected
            ? _value.checkpointsDetected
            : checkpointsDetected // ignore: cast_nullable_to_non_nullable
                  as int,
        checkpointsMissed: null == checkpointsMissed
            ? _value.checkpointsMissed
            : checkpointsMissed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationSessionSummaryImpl implements _SimulationSessionSummary {
  const _$SimulationSessionSummaryImpl({
    required this.sessionId,
    required this.scenarioTitle,
    required this.completedDate,
    required this.durationMinutes,
    required this.scorePercentage,
    required this.gradeLevel,
    required this.checkpointsDetected,
    required this.checkpointsMissed,
  });

  factory _$SimulationSessionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationSessionSummaryImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String scenarioTitle;
  @override
  final DateTime completedDate;
  @override
  final int durationMinutes;
  @override
  final double scorePercentage;
  @override
  final String gradeLevel;
  @override
  final int checkpointsDetected;
  @override
  final int checkpointsMissed;

  @override
  String toString() {
    return 'SimulationSessionSummary(sessionId: $sessionId, scenarioTitle: $scenarioTitle, completedDate: $completedDate, durationMinutes: $durationMinutes, scorePercentage: $scorePercentage, gradeLevel: $gradeLevel, checkpointsDetected: $checkpointsDetected, checkpointsMissed: $checkpointsMissed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationSessionSummaryImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.scenarioTitle, scenarioTitle) ||
                other.scenarioTitle == scenarioTitle) &&
            (identical(other.completedDate, completedDate) ||
                other.completedDate == completedDate) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.scorePercentage, scorePercentage) ||
                other.scorePercentage == scorePercentage) &&
            (identical(other.gradeLevel, gradeLevel) ||
                other.gradeLevel == gradeLevel) &&
            (identical(other.checkpointsDetected, checkpointsDetected) ||
                other.checkpointsDetected == checkpointsDetected) &&
            (identical(other.checkpointsMissed, checkpointsMissed) ||
                other.checkpointsMissed == checkpointsMissed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    scenarioTitle,
    completedDate,
    durationMinutes,
    scorePercentage,
    gradeLevel,
    checkpointsDetected,
    checkpointsMissed,
  );

  /// Create a copy of SimulationSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationSessionSummaryImplCopyWith<_$SimulationSessionSummaryImpl>
  get copyWith =>
      __$$SimulationSessionSummaryImplCopyWithImpl<
        _$SimulationSessionSummaryImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationSessionSummaryImplToJson(this);
  }
}

abstract class _SimulationSessionSummary implements SimulationSessionSummary {
  const factory _SimulationSessionSummary({
    required final String sessionId,
    required final String scenarioTitle,
    required final DateTime completedDate,
    required final int durationMinutes,
    required final double scorePercentage,
    required final String gradeLevel,
    required final int checkpointsDetected,
    required final int checkpointsMissed,
  }) = _$SimulationSessionSummaryImpl;

  factory _SimulationSessionSummary.fromJson(Map<String, dynamic> json) =
      _$SimulationSessionSummaryImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get scenarioTitle;
  @override
  DateTime get completedDate;
  @override
  int get durationMinutes;
  @override
  double get scorePercentage;
  @override
  String get gradeLevel;
  @override
  int get checkpointsDetected;
  @override
  int get checkpointsMissed;

  /// Create a copy of SimulationSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationSessionSummaryImplCopyWith<_$SimulationSessionSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
