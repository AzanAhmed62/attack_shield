// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) {
  return _ReportSummary.fromJson(json);
}

/// @nodoc
mixin _$ReportSummary {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get totalTechniquesReviewed => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  double get coveragePercentage => throw _privateConstructorUsedError;
  List<String> get topRiskyTechniques => throw _privateConstructorUsedError;
  List<String> get unresolvedGaps => throw _privateConstructorUsedError;
  List<String> get recommendedActions => throw _privateConstructorUsedError;
  DateTime? get generatedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ReportSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportSummaryCopyWith<ReportSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportSummaryCopyWith<$Res> {
  factory $ReportSummaryCopyWith(
    ReportSummary value,
    $Res Function(ReportSummary) then,
  ) = _$ReportSummaryCopyWithImpl<$Res, ReportSummary>;
  @useResult
  $Res call({
    String id,
    String title,
    int totalTechniquesReviewed,
    double riskScore,
    double coveragePercentage,
    List<String> topRiskyTechniques,
    List<String> unresolvedGaps,
    List<String> recommendedActions,
    DateTime? generatedAt,
    String? notes,
  });
}

/// @nodoc
class _$ReportSummaryCopyWithImpl<$Res, $Val extends ReportSummary>
    implements $ReportSummaryCopyWith<$Res> {
  _$ReportSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? totalTechniquesReviewed = null,
    Object? riskScore = null,
    Object? coveragePercentage = null,
    Object? topRiskyTechniques = null,
    Object? unresolvedGaps = null,
    Object? recommendedActions = null,
    Object? generatedAt = freezed,
    Object? notes = freezed,
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
            totalTechniquesReviewed: null == totalTechniquesReviewed
                ? _value.totalTechniquesReviewed
                : totalTechniquesReviewed // ignore: cast_nullable_to_non_nullable
                      as int,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            coveragePercentage: null == coveragePercentage
                ? _value.coveragePercentage
                : coveragePercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            topRiskyTechniques: null == topRiskyTechniques
                ? _value.topRiskyTechniques
                : topRiskyTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            unresolvedGaps: null == unresolvedGaps
                ? _value.unresolvedGaps
                : unresolvedGaps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            recommendedActions: null == recommendedActions
                ? _value.recommendedActions
                : recommendedActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            generatedAt: freezed == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportSummaryImplCopyWith<$Res>
    implements $ReportSummaryCopyWith<$Res> {
  factory _$$ReportSummaryImplCopyWith(
    _$ReportSummaryImpl value,
    $Res Function(_$ReportSummaryImpl) then,
  ) = __$$ReportSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    int totalTechniquesReviewed,
    double riskScore,
    double coveragePercentage,
    List<String> topRiskyTechniques,
    List<String> unresolvedGaps,
    List<String> recommendedActions,
    DateTime? generatedAt,
    String? notes,
  });
}

/// @nodoc
class __$$ReportSummaryImplCopyWithImpl<$Res>
    extends _$ReportSummaryCopyWithImpl<$Res, _$ReportSummaryImpl>
    implements _$$ReportSummaryImplCopyWith<$Res> {
  __$$ReportSummaryImplCopyWithImpl(
    _$ReportSummaryImpl _value,
    $Res Function(_$ReportSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? totalTechniquesReviewed = null,
    Object? riskScore = null,
    Object? coveragePercentage = null,
    Object? topRiskyTechniques = null,
    Object? unresolvedGaps = null,
    Object? recommendedActions = null,
    Object? generatedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$ReportSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        totalTechniquesReviewed: null == totalTechniquesReviewed
            ? _value.totalTechniquesReviewed
            : totalTechniquesReviewed // ignore: cast_nullable_to_non_nullable
                  as int,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        coveragePercentage: null == coveragePercentage
            ? _value.coveragePercentage
            : coveragePercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        topRiskyTechniques: null == topRiskyTechniques
            ? _value._topRiskyTechniques
            : topRiskyTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        unresolvedGaps: null == unresolvedGaps
            ? _value._unresolvedGaps
            : unresolvedGaps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        recommendedActions: null == recommendedActions
            ? _value._recommendedActions
            : recommendedActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        generatedAt: freezed == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportSummaryImpl implements _ReportSummary {
  const _$ReportSummaryImpl({
    required this.id,
    required this.title,
    this.totalTechniquesReviewed = 0,
    this.riskScore = 0.0,
    this.coveragePercentage = 0.0,
    final List<String> topRiskyTechniques = const [],
    final List<String> unresolvedGaps = const [],
    final List<String> recommendedActions = const [],
    this.generatedAt,
    this.notes,
  }) : _topRiskyTechniques = topRiskyTechniques,
       _unresolvedGaps = unresolvedGaps,
       _recommendedActions = recommendedActions;

  factory _$ReportSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int totalTechniquesReviewed;
  @override
  @JsonKey()
  final double riskScore;
  @override
  @JsonKey()
  final double coveragePercentage;
  final List<String> _topRiskyTechniques;
  @override
  @JsonKey()
  List<String> get topRiskyTechniques {
    if (_topRiskyTechniques is EqualUnmodifiableListView)
      return _topRiskyTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topRiskyTechniques);
  }

  final List<String> _unresolvedGaps;
  @override
  @JsonKey()
  List<String> get unresolvedGaps {
    if (_unresolvedGaps is EqualUnmodifiableListView) return _unresolvedGaps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unresolvedGaps);
  }

  final List<String> _recommendedActions;
  @override
  @JsonKey()
  List<String> get recommendedActions {
    if (_recommendedActions is EqualUnmodifiableListView)
      return _recommendedActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedActions);
  }

  @override
  final DateTime? generatedAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'ReportSummary(id: $id, title: $title, totalTechniquesReviewed: $totalTechniquesReviewed, riskScore: $riskScore, coveragePercentage: $coveragePercentage, topRiskyTechniques: $topRiskyTechniques, unresolvedGaps: $unresolvedGaps, recommendedActions: $recommendedActions, generatedAt: $generatedAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(
                  other.totalTechniquesReviewed,
                  totalTechniquesReviewed,
                ) ||
                other.totalTechniquesReviewed == totalTechniquesReviewed) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.coveragePercentage, coveragePercentage) ||
                other.coveragePercentage == coveragePercentage) &&
            const DeepCollectionEquality().equals(
              other._topRiskyTechniques,
              _topRiskyTechniques,
            ) &&
            const DeepCollectionEquality().equals(
              other._unresolvedGaps,
              _unresolvedGaps,
            ) &&
            const DeepCollectionEquality().equals(
              other._recommendedActions,
              _recommendedActions,
            ) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    totalTechniquesReviewed,
    riskScore,
    coveragePercentage,
    const DeepCollectionEquality().hash(_topRiskyTechniques),
    const DeepCollectionEquality().hash(_unresolvedGaps),
    const DeepCollectionEquality().hash(_recommendedActions),
    generatedAt,
    notes,
  );

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportSummaryImplCopyWith<_$ReportSummaryImpl> get copyWith =>
      __$$ReportSummaryImplCopyWithImpl<_$ReportSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportSummaryImplToJson(this);
  }
}

abstract class _ReportSummary implements ReportSummary {
  const factory _ReportSummary({
    required final String id,
    required final String title,
    final int totalTechniquesReviewed,
    final double riskScore,
    final double coveragePercentage,
    final List<String> topRiskyTechniques,
    final List<String> unresolvedGaps,
    final List<String> recommendedActions,
    final DateTime? generatedAt,
    final String? notes,
  }) = _$ReportSummaryImpl;

  factory _ReportSummary.fromJson(Map<String, dynamic> json) =
      _$ReportSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get totalTechniquesReviewed;
  @override
  double get riskScore;
  @override
  double get coveragePercentage;
  @override
  List<String> get topRiskyTechniques;
  @override
  List<String> get unresolvedGaps;
  @override
  List<String> get recommendedActions;
  @override
  DateTime? get generatedAt;
  @override
  String? get notes;

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportSummaryImplCopyWith<_$ReportSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
