// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SecurityAlert _$SecurityAlertFromJson(Map<String, dynamic> json) {
  return _SecurityAlert.fromJson(json);
}

/// @nodoc
mixin _$SecurityAlert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get severity =>
      throw _privateConstructorUsedError; // 'critical' | 'high' | 'medium' | 'low'
  String get source => throw _privateConstructorUsedError;
  String? get linkedTechniqueId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'open' | 'resolved'
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this SecurityAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityAlertCopyWith<SecurityAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityAlertCopyWith<$Res> {
  factory $SecurityAlertCopyWith(
    SecurityAlert value,
    $Res Function(SecurityAlert) then,
  ) = _$SecurityAlertCopyWithImpl<$Res, SecurityAlert>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String severity,
    String source,
    String? linkedTechniqueId,
    DateTime createdAt,
    bool isRead,
    String status,
    String? notes,
  });
}

/// @nodoc
class _$SecurityAlertCopyWithImpl<$Res, $Val extends SecurityAlert>
    implements $SecurityAlertCopyWith<$Res> {
  _$SecurityAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? source = null,
    Object? linkedTechniqueId = freezed,
    Object? createdAt = null,
    Object? isRead = null,
    Object? status = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            linkedTechniqueId: freezed == linkedTechniqueId
                ? _value.linkedTechniqueId
                : linkedTechniqueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$SecurityAlertImplCopyWith<$Res>
    implements $SecurityAlertCopyWith<$Res> {
  factory _$$SecurityAlertImplCopyWith(
    _$SecurityAlertImpl value,
    $Res Function(_$SecurityAlertImpl) then,
  ) = __$$SecurityAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String severity,
    String source,
    String? linkedTechniqueId,
    DateTime createdAt,
    bool isRead,
    String status,
    String? notes,
  });
}

/// @nodoc
class __$$SecurityAlertImplCopyWithImpl<$Res>
    extends _$SecurityAlertCopyWithImpl<$Res, _$SecurityAlertImpl>
    implements _$$SecurityAlertImplCopyWith<$Res> {
  __$$SecurityAlertImplCopyWithImpl(
    _$SecurityAlertImpl _value,
    $Res Function(_$SecurityAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? source = null,
    Object? linkedTechniqueId = freezed,
    Object? createdAt = null,
    Object? isRead = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$SecurityAlertImpl(
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
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        linkedTechniqueId: freezed == linkedTechniqueId
            ? _value.linkedTechniqueId
            : linkedTechniqueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$SecurityAlertImpl implements _SecurityAlert {
  const _$SecurityAlertImpl({
    required this.id,
    required this.title,
    this.description = '',
    this.severity = 'medium',
    this.source = 'Manual',
    this.linkedTechniqueId,
    required this.createdAt,
    this.isRead = false,
    this.status = 'open',
    this.notes,
  });

  factory _$SecurityAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String severity;
  // 'critical' | 'high' | 'medium' | 'low'
  @override
  @JsonKey()
  final String source;
  @override
  final String? linkedTechniqueId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final String status;
  // 'open' | 'resolved'
  @override
  final String? notes;

  @override
  String toString() {
    return 'SecurityAlert(id: $id, title: $title, description: $description, severity: $severity, source: $source, linkedTechniqueId: $linkedTechniqueId, createdAt: $createdAt, isRead: $isRead, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.linkedTechniqueId, linkedTechniqueId) ||
                other.linkedTechniqueId == linkedTechniqueId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    severity,
    source,
    linkedTechniqueId,
    createdAt,
    isRead,
    status,
    notes,
  );

  /// Create a copy of SecurityAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityAlertImplCopyWith<_$SecurityAlertImpl> get copyWith =>
      __$$SecurityAlertImplCopyWithImpl<_$SecurityAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityAlertImplToJson(this);
  }
}

abstract class _SecurityAlert implements SecurityAlert {
  const factory _SecurityAlert({
    required final String id,
    required final String title,
    final String description,
    final String severity,
    final String source,
    final String? linkedTechniqueId,
    required final DateTime createdAt,
    final bool isRead,
    final String status,
    final String? notes,
  }) = _$SecurityAlertImpl;

  factory _SecurityAlert.fromJson(Map<String, dynamic> json) =
      _$SecurityAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get severity; // 'critical' | 'high' | 'medium' | 'low'
  @override
  String get source;
  @override
  String? get linkedTechniqueId;
  @override
  DateTime get createdAt;
  @override
  bool get isRead;
  @override
  String get status; // 'open' | 'resolved'
  @override
  String? get notes;

  /// Create a copy of SecurityAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityAlertImplCopyWith<_$SecurityAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
