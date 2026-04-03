// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coverage_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CoverageStatus _$CoverageStatusFromJson(Map<String, dynamic> json) {
  return _CoverageStatus.fromJson(json);
}

/// @nodoc
mixin _$CoverageStatus {
  String get techniqueId => throw _privateConstructorUsedError;
  CoverageLevel get level => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String>? get relatedControls => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this CoverageStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoverageStatusCopyWith<CoverageStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageStatusCopyWith<$Res> {
  factory $CoverageStatusCopyWith(
    CoverageStatus value,
    $Res Function(CoverageStatus) then,
  ) = _$CoverageStatusCopyWithImpl<$Res, CoverageStatus>;
  @useResult
  $Res call({
    String techniqueId,
    CoverageLevel level,
    String? notes,
    List<String>? relatedControls,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$CoverageStatusCopyWithImpl<$Res, $Val extends CoverageStatus>
    implements $CoverageStatusCopyWith<$Res> {
  _$CoverageStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? level = null,
    Object? notes = freezed,
    Object? relatedControls = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as CoverageLevel,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedControls: freezed == relatedControls
                ? _value.relatedControls
                : relatedControls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoverageStatusImplCopyWith<$Res>
    implements $CoverageStatusCopyWith<$Res> {
  factory _$$CoverageStatusImplCopyWith(
    _$CoverageStatusImpl value,
    $Res Function(_$CoverageStatusImpl) then,
  ) = __$$CoverageStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String techniqueId,
    CoverageLevel level,
    String? notes,
    List<String>? relatedControls,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$CoverageStatusImplCopyWithImpl<$Res>
    extends _$CoverageStatusCopyWithImpl<$Res, _$CoverageStatusImpl>
    implements _$$CoverageStatusImplCopyWith<$Res> {
  __$$CoverageStatusImplCopyWithImpl(
    _$CoverageStatusImpl _value,
    $Res Function(_$CoverageStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? level = null,
    Object? notes = freezed,
    Object? relatedControls = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$CoverageStatusImpl(
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as CoverageLevel,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedControls: freezed == relatedControls
            ? _value._relatedControls
            : relatedControls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageStatusImpl implements _CoverageStatus {
  const _$CoverageStatusImpl({
    required this.techniqueId,
    required this.level,
    this.notes,
    final List<String>? relatedControls,
    this.lastUpdated,
  }) : _relatedControls = relatedControls;

  factory _$CoverageStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageStatusImplFromJson(json);

  @override
  final String techniqueId;
  @override
  final CoverageLevel level;
  @override
  final String? notes;
  final List<String>? _relatedControls;
  @override
  List<String>? get relatedControls {
    final value = _relatedControls;
    if (value == null) return null;
    if (_relatedControls is EqualUnmodifiableListView) return _relatedControls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'CoverageStatus(techniqueId: $techniqueId, level: $level, notes: $notes, relatedControls: $relatedControls, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageStatusImpl &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._relatedControls,
              _relatedControls,
            ) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    techniqueId,
    level,
    notes,
    const DeepCollectionEquality().hash(_relatedControls),
    lastUpdated,
  );

  /// Create a copy of CoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverageStatusImplCopyWith<_$CoverageStatusImpl> get copyWith =>
      __$$CoverageStatusImplCopyWithImpl<_$CoverageStatusImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageStatusImplToJson(this);
  }
}

abstract class _CoverageStatus implements CoverageStatus {
  const factory _CoverageStatus({
    required final String techniqueId,
    required final CoverageLevel level,
    final String? notes,
    final List<String>? relatedControls,
    final DateTime? lastUpdated,
  }) = _$CoverageStatusImpl;

  factory _CoverageStatus.fromJson(Map<String, dynamic> json) =
      _$CoverageStatusImpl.fromJson;

  @override
  String get techniqueId;
  @override
  CoverageLevel get level;
  @override
  String? get notes;
  @override
  List<String>? get relatedControls;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of CoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageStatusImplCopyWith<_$CoverageStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
