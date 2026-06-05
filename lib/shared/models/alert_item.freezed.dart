// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AlertItem _$AlertItemFromJson(Map<String, dynamic> json) {
  return _AlertItem.fromJson(json);
}

/// @nodoc
mixin _$AlertItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  AlertPriority get priority => throw _privateConstructorUsedError;
  AlertStatus get status => throw _privateConstructorUsedError;
  String get source =>
      throw _privateConstructorUsedError; // Technique linkage (new)
  String? get linkedTechniqueId => throw _privateConstructorUsedError;
  @Deprecated('Use linkedTechniqueId')
  String? get relatedTechniqueId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Read tracking (new)
  bool get isRead => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this AlertItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertItemCopyWith<AlertItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertItemCopyWith<$Res> {
  factory $AlertItemCopyWith(AlertItem value, $Res Function(AlertItem) then) =
      _$AlertItemCopyWithImpl<$Res, AlertItem>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    AlertPriority priority,
    AlertStatus status,
    String source,
    String? linkedTechniqueId,
    @Deprecated('Use linkedTechniqueId') String? relatedTechniqueId,
    DateTime createdAt,
    DateTime? updatedAt,
    bool isRead,
    String? notes,
  });
}

/// @nodoc
class _$AlertItemCopyWithImpl<$Res, $Val extends AlertItem>
    implements $AlertItemCopyWith<$Res> {
  _$AlertItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? source = null,
    Object? linkedTechniqueId = freezed,
    Object? relatedTechniqueId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isRead = null,
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
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as AlertPriority,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AlertStatus,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            linkedTechniqueId: freezed == linkedTechniqueId
                ? _value.linkedTechniqueId
                : linkedTechniqueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedTechniqueId: freezed == relatedTechniqueId
                ? _value.relatedTechniqueId
                : relatedTechniqueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$AlertItemImplCopyWith<$Res>
    implements $AlertItemCopyWith<$Res> {
  factory _$$AlertItemImplCopyWith(
    _$AlertItemImpl value,
    $Res Function(_$AlertItemImpl) then,
  ) = __$$AlertItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    AlertPriority priority,
    AlertStatus status,
    String source,
    String? linkedTechniqueId,
    @Deprecated('Use linkedTechniqueId') String? relatedTechniqueId,
    DateTime createdAt,
    DateTime? updatedAt,
    bool isRead,
    String? notes,
  });
}

/// @nodoc
class __$$AlertItemImplCopyWithImpl<$Res>
    extends _$AlertItemCopyWithImpl<$Res, _$AlertItemImpl>
    implements _$$AlertItemImplCopyWith<$Res> {
  __$$AlertItemImplCopyWithImpl(
    _$AlertItemImpl _value,
    $Res Function(_$AlertItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? source = null,
    Object? linkedTechniqueId = freezed,
    Object? relatedTechniqueId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isRead = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$AlertItemImpl(
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
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as AlertPriority,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AlertStatus,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        linkedTechniqueId: freezed == linkedTechniqueId
            ? _value.linkedTechniqueId
            : linkedTechniqueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedTechniqueId: freezed == relatedTechniqueId
            ? _value.relatedTechniqueId
            : relatedTechniqueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$AlertItemImpl implements _AlertItem {
  const _$AlertItemImpl({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = AlertPriority.medium,
    this.status = AlertStatus.open,
    this.source = 'Manual',
    this.linkedTechniqueId,
    @Deprecated('Use linkedTechniqueId') this.relatedTechniqueId,
    required this.createdAt,
    this.updatedAt,
    this.isRead = false,
    this.notes,
  });

  factory _$AlertItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final AlertPriority priority;
  @override
  @JsonKey()
  final AlertStatus status;
  @override
  @JsonKey()
  final String source;
  // Technique linkage (new)
  @override
  final String? linkedTechniqueId;
  @override
  @Deprecated('Use linkedTechniqueId')
  final String? relatedTechniqueId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  // Read tracking (new)
  @override
  @JsonKey()
  final bool isRead;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AlertItem(id: $id, title: $title, description: $description, priority: $priority, status: $status, source: $source, linkedTechniqueId: $linkedTechniqueId, relatedTechniqueId: $relatedTechniqueId, createdAt: $createdAt, updatedAt: $updatedAt, isRead: $isRead, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.linkedTechniqueId, linkedTechniqueId) ||
                other.linkedTechniqueId == linkedTechniqueId) &&
            (identical(other.relatedTechniqueId, relatedTechniqueId) ||
                other.relatedTechniqueId == relatedTechniqueId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    priority,
    status,
    source,
    linkedTechniqueId,
    relatedTechniqueId,
    createdAt,
    updatedAt,
    isRead,
    notes,
  );

  /// Create a copy of AlertItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertItemImplCopyWith<_$AlertItemImpl> get copyWith =>
      __$$AlertItemImplCopyWithImpl<_$AlertItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertItemImplToJson(this);
  }
}

abstract class _AlertItem implements AlertItem {
  const factory _AlertItem({
    required final String id,
    required final String title,
    final String description,
    final AlertPriority priority,
    final AlertStatus status,
    final String source,
    final String? linkedTechniqueId,
    @Deprecated('Use linkedTechniqueId') final String? relatedTechniqueId,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final bool isRead,
    final String? notes,
  }) = _$AlertItemImpl;

  factory _AlertItem.fromJson(Map<String, dynamic> json) =
      _$AlertItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  AlertPriority get priority;
  @override
  AlertStatus get status;
  @override
  String get source; // Technique linkage (new)
  @override
  String? get linkedTechniqueId;
  @override
  @Deprecated('Use linkedTechniqueId')
  String? get relatedTechniqueId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // Read tracking (new)
  @override
  bool get isRead;
  @override
  String? get notes;

  /// Create a copy of AlertItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertItemImplCopyWith<_$AlertItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
