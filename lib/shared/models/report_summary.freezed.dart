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
  DateTime get generatedAt => throw _privateConstructorUsedError;
  double get orgRiskScore => throw _privateConstructorUsedError;
  double get coveragePercent => throw _privateConstructorUsedError;
  int get totalTechniques => throw _privateConstructorUsedError;
  int get coveredCount => throw _privateConstructorUsedError;
  int get gapCount => throw _privateConstructorUsedError;
  String get aiNarrative => throw _privateConstructorUsedError;
  String? get pdfPath => throw _privateConstructorUsedError;

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
    DateTime generatedAt,
    double orgRiskScore,
    double coveragePercent,
    int totalTechniques,
    int coveredCount,
    int gapCount,
    String aiNarrative,
    String? pdfPath,
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
    Object? generatedAt = null,
    Object? orgRiskScore = null,
    Object? coveragePercent = null,
    Object? totalTechniques = null,
    Object? coveredCount = null,
    Object? gapCount = null,
    Object? aiNarrative = null,
    Object? pdfPath = freezed,
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
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            orgRiskScore: null == orgRiskScore
                ? _value.orgRiskScore
                : orgRiskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            coveragePercent: null == coveragePercent
                ? _value.coveragePercent
                : coveragePercent // ignore: cast_nullable_to_non_nullable
                      as double,
            totalTechniques: null == totalTechniques
                ? _value.totalTechniques
                : totalTechniques // ignore: cast_nullable_to_non_nullable
                      as int,
            coveredCount: null == coveredCount
                ? _value.coveredCount
                : coveredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            gapCount: null == gapCount
                ? _value.gapCount
                : gapCount // ignore: cast_nullable_to_non_nullable
                      as int,
            aiNarrative: null == aiNarrative
                ? _value.aiNarrative
                : aiNarrative // ignore: cast_nullable_to_non_nullable
                      as String,
            pdfPath: freezed == pdfPath
                ? _value.pdfPath
                : pdfPath // ignore: cast_nullable_to_non_nullable
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
    DateTime generatedAt,
    double orgRiskScore,
    double coveragePercent,
    int totalTechniques,
    int coveredCount,
    int gapCount,
    String aiNarrative,
    String? pdfPath,
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
    Object? generatedAt = null,
    Object? orgRiskScore = null,
    Object? coveragePercent = null,
    Object? totalTechniques = null,
    Object? coveredCount = null,
    Object? gapCount = null,
    Object? aiNarrative = null,
    Object? pdfPath = freezed,
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
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        orgRiskScore: null == orgRiskScore
            ? _value.orgRiskScore
            : orgRiskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        coveragePercent: null == coveragePercent
            ? _value.coveragePercent
            : coveragePercent // ignore: cast_nullable_to_non_nullable
                  as double,
        totalTechniques: null == totalTechniques
            ? _value.totalTechniques
            : totalTechniques // ignore: cast_nullable_to_non_nullable
                  as int,
        coveredCount: null == coveredCount
            ? _value.coveredCount
            : coveredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        gapCount: null == gapCount
            ? _value.gapCount
            : gapCount // ignore: cast_nullable_to_non_nullable
                  as int,
        aiNarrative: null == aiNarrative
            ? _value.aiNarrative
            : aiNarrative // ignore: cast_nullable_to_non_nullable
                  as String,
        pdfPath: freezed == pdfPath
            ? _value.pdfPath
            : pdfPath // ignore: cast_nullable_to_non_nullable
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
    required this.generatedAt,
    required this.orgRiskScore,
    required this.coveragePercent,
    required this.totalTechniques,
    required this.coveredCount,
    required this.gapCount,
    this.aiNarrative = '',
    this.pdfPath,
  });

  factory _$ReportSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime generatedAt;
  @override
  final double orgRiskScore;
  @override
  final double coveragePercent;
  @override
  final int totalTechniques;
  @override
  final int coveredCount;
  @override
  final int gapCount;
  @override
  @JsonKey()
  final String aiNarrative;
  @override
  final String? pdfPath;

  @override
  String toString() {
    return 'ReportSummary(id: $id, title: $title, generatedAt: $generatedAt, orgRiskScore: $orgRiskScore, coveragePercent: $coveragePercent, totalTechniques: $totalTechniques, coveredCount: $coveredCount, gapCount: $gapCount, aiNarrative: $aiNarrative, pdfPath: $pdfPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.orgRiskScore, orgRiskScore) ||
                other.orgRiskScore == orgRiskScore) &&
            (identical(other.coveragePercent, coveragePercent) ||
                other.coveragePercent == coveragePercent) &&
            (identical(other.totalTechniques, totalTechniques) ||
                other.totalTechniques == totalTechniques) &&
            (identical(other.coveredCount, coveredCount) ||
                other.coveredCount == coveredCount) &&
            (identical(other.gapCount, gapCount) ||
                other.gapCount == gapCount) &&
            (identical(other.aiNarrative, aiNarrative) ||
                other.aiNarrative == aiNarrative) &&
            (identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    generatedAt,
    orgRiskScore,
    coveragePercent,
    totalTechniques,
    coveredCount,
    gapCount,
    aiNarrative,
    pdfPath,
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
    required final DateTime generatedAt,
    required final double orgRiskScore,
    required final double coveragePercent,
    required final int totalTechniques,
    required final int coveredCount,
    required final int gapCount,
    final String aiNarrative,
    final String? pdfPath,
  }) = _$ReportSummaryImpl;

  factory _ReportSummary.fromJson(Map<String, dynamic> json) =
      _$ReportSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get generatedAt;
  @override
  double get orgRiskScore;
  @override
  double get coveragePercent;
  @override
  int get totalTechniques;
  @override
  int get coveredCount;
  @override
  int get gapCount;
  @override
  String get aiNarrative;
  @override
  String? get pdfPath;

  /// Create a copy of ReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportSummaryImplCopyWith<_$ReportSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
