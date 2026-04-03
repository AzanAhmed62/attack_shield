// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationResult _$SimulationResultFromJson(Map<String, dynamic> json) {
  return _SimulationResult.fromJson(json);
}

/// @nodoc
mixin _$SimulationResult {
  String get id => throw _privateConstructorUsedError;
  String get scenarioId => throw _privateConstructorUsedError;
  TestResult get result => throw _privateConstructorUsedError;
  String get observations => throw _privateConstructorUsedError;
  String get recommendations => throw _privateConstructorUsedError;
  DateTime get testedAt => throw _privateConstructorUsedError;
  String get testedBy => throw _privateConstructorUsedError;

  /// Serializes this SimulationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationResultCopyWith<SimulationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationResultCopyWith<$Res> {
  factory $SimulationResultCopyWith(
    SimulationResult value,
    $Res Function(SimulationResult) then,
  ) = _$SimulationResultCopyWithImpl<$Res, SimulationResult>;
  @useResult
  $Res call({
    String id,
    String scenarioId,
    TestResult result,
    String observations,
    String recommendations,
    DateTime testedAt,
    String testedBy,
  });
}

/// @nodoc
class _$SimulationResultCopyWithImpl<$Res, $Val extends SimulationResult>
    implements $SimulationResultCopyWith<$Res> {
  _$SimulationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scenarioId = null,
    Object? result = null,
    Object? observations = null,
    Object? recommendations = null,
    Object? testedAt = null,
    Object? testedBy = null,
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
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as TestResult,
            observations: null == observations
                ? _value.observations
                : observations // ignore: cast_nullable_to_non_nullable
                      as String,
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as String,
            testedAt: null == testedAt
                ? _value.testedAt
                : testedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            testedBy: null == testedBy
                ? _value.testedBy
                : testedBy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationResultImplCopyWith<$Res>
    implements $SimulationResultCopyWith<$Res> {
  factory _$$SimulationResultImplCopyWith(
    _$SimulationResultImpl value,
    $Res Function(_$SimulationResultImpl) then,
  ) = __$$SimulationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String scenarioId,
    TestResult result,
    String observations,
    String recommendations,
    DateTime testedAt,
    String testedBy,
  });
}

/// @nodoc
class __$$SimulationResultImplCopyWithImpl<$Res>
    extends _$SimulationResultCopyWithImpl<$Res, _$SimulationResultImpl>
    implements _$$SimulationResultImplCopyWith<$Res> {
  __$$SimulationResultImplCopyWithImpl(
    _$SimulationResultImpl _value,
    $Res Function(_$SimulationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scenarioId = null,
    Object? result = null,
    Object? observations = null,
    Object? recommendations = null,
    Object? testedAt = null,
    Object? testedBy = null,
  }) {
    return _then(
      _$SimulationResultImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        scenarioId: null == scenarioId
            ? _value.scenarioId
            : scenarioId // ignore: cast_nullable_to_non_nullable
                  as String,
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as TestResult,
        observations: null == observations
            ? _value.observations
            : observations // ignore: cast_nullable_to_non_nullable
                  as String,
        recommendations: null == recommendations
            ? _value.recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as String,
        testedAt: null == testedAt
            ? _value.testedAt
            : testedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        testedBy: null == testedBy
            ? _value.testedBy
            : testedBy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationResultImpl implements _SimulationResult {
  const _$SimulationResultImpl({
    required this.id,
    required this.scenarioId,
    required this.result,
    required this.observations,
    required this.recommendations,
    required this.testedAt,
    required this.testedBy,
  });

  factory _$SimulationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationResultImplFromJson(json);

  @override
  final String id;
  @override
  final String scenarioId;
  @override
  final TestResult result;
  @override
  final String observations;
  @override
  final String recommendations;
  @override
  final DateTime testedAt;
  @override
  final String testedBy;

  @override
  String toString() {
    return 'SimulationResult(id: $id, scenarioId: $scenarioId, result: $result, observations: $observations, recommendations: $recommendations, testedAt: $testedAt, testedBy: $testedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scenarioId, scenarioId) ||
                other.scenarioId == scenarioId) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.observations, observations) ||
                other.observations == observations) &&
            (identical(other.recommendations, recommendations) ||
                other.recommendations == recommendations) &&
            (identical(other.testedAt, testedAt) ||
                other.testedAt == testedAt) &&
            (identical(other.testedBy, testedBy) ||
                other.testedBy == testedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scenarioId,
    result,
    observations,
    recommendations,
    testedAt,
    testedBy,
  );

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      __$$SimulationResultImplCopyWithImpl<_$SimulationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationResultImplToJson(this);
  }
}

abstract class _SimulationResult implements SimulationResult {
  const factory _SimulationResult({
    required final String id,
    required final String scenarioId,
    required final TestResult result,
    required final String observations,
    required final String recommendations,
    required final DateTime testedAt,
    required final String testedBy,
  }) = _$SimulationResultImpl;

  factory _SimulationResult.fromJson(Map<String, dynamic> json) =
      _$SimulationResultImpl.fromJson;

  @override
  String get id;
  @override
  String get scenarioId;
  @override
  TestResult get result;
  @override
  String get observations;
  @override
  String get recommendations;
  @override
  DateTime get testedAt;
  @override
  String get testedBy;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
