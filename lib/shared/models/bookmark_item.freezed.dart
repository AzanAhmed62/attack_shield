// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BookmarkItem _$BookmarkItemFromJson(Map<String, dynamic> json) {
  return _BookmarkItem.fromJson(json);
}

/// @nodoc
mixin _$BookmarkItem {
  String get id => throw _privateConstructorUsedError;
  String get techniqueId => throw _privateConstructorUsedError;
  String get techniqueName => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get bookmarkedAt => throw _privateConstructorUsedError;

  /// Serializes this BookmarkItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkItemCopyWith<BookmarkItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkItemCopyWith<$Res> {
  factory $BookmarkItemCopyWith(
    BookmarkItem value,
    $Res Function(BookmarkItem) then,
  ) = _$BookmarkItemCopyWithImpl<$Res, BookmarkItem>;
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String techniqueName,
    String? notes,
    DateTime? bookmarkedAt,
  });
}

/// @nodoc
class _$BookmarkItemCopyWithImpl<$Res, $Val extends BookmarkItem>
    implements $BookmarkItemCopyWith<$Res> {
  _$BookmarkItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? notes = freezed,
    Object? bookmarkedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueName: null == techniqueName
                ? _value.techniqueName
                : techniqueName // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookmarkedAt: freezed == bookmarkedAt
                ? _value.bookmarkedAt
                : bookmarkedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookmarkItemImplCopyWith<$Res>
    implements $BookmarkItemCopyWith<$Res> {
  factory _$$BookmarkItemImplCopyWith(
    _$BookmarkItemImpl value,
    $Res Function(_$BookmarkItemImpl) then,
  ) = __$$BookmarkItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String techniqueName,
    String? notes,
    DateTime? bookmarkedAt,
  });
}

/// @nodoc
class __$$BookmarkItemImplCopyWithImpl<$Res>
    extends _$BookmarkItemCopyWithImpl<$Res, _$BookmarkItemImpl>
    implements _$$BookmarkItemImplCopyWith<$Res> {
  __$$BookmarkItemImplCopyWithImpl(
    _$BookmarkItemImpl _value,
    $Res Function(_$BookmarkItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? notes = freezed,
    Object? bookmarkedAt = freezed,
  }) {
    return _then(
      _$BookmarkItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueName: null == techniqueName
            ? _value.techniqueName
            : techniqueName // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookmarkedAt: freezed == bookmarkedAt
            ? _value.bookmarkedAt
            : bookmarkedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkItemImpl implements _BookmarkItem {
  const _$BookmarkItemImpl({
    required this.id,
    required this.techniqueId,
    required this.techniqueName,
    this.notes,
    this.bookmarkedAt,
  });

  factory _$BookmarkItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkItemImplFromJson(json);

  @override
  final String id;
  @override
  final String techniqueId;
  @override
  final String techniqueName;
  @override
  final String? notes;
  @override
  final DateTime? bookmarkedAt;

  @override
  String toString() {
    return 'BookmarkItem(id: $id, techniqueId: $techniqueId, techniqueName: $techniqueName, notes: $notes, bookmarkedAt: $bookmarkedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.techniqueName, techniqueName) ||
                other.techniqueName == techniqueName) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.bookmarkedAt, bookmarkedAt) ||
                other.bookmarkedAt == bookmarkedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    techniqueId,
    techniqueName,
    notes,
    bookmarkedAt,
  );

  /// Create a copy of BookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkItemImplCopyWith<_$BookmarkItemImpl> get copyWith =>
      __$$BookmarkItemImplCopyWithImpl<_$BookmarkItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkItemImplToJson(this);
  }
}

abstract class _BookmarkItem implements BookmarkItem {
  const factory _BookmarkItem({
    required final String id,
    required final String techniqueId,
    required final String techniqueName,
    final String? notes,
    final DateTime? bookmarkedAt,
  }) = _$BookmarkItemImpl;

  factory _BookmarkItem.fromJson(Map<String, dynamic> json) =
      _$BookmarkItemImpl.fromJson;

  @override
  String get id;
  @override
  String get techniqueId;
  @override
  String get techniqueName;
  @override
  String? get notes;
  @override
  DateTime? get bookmarkedAt;

  /// Create a copy of BookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkItemImplCopyWith<_$BookmarkItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
