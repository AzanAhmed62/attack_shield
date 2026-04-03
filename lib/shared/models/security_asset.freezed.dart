// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SecurityAsset _$SecurityAssetFromJson(Map<String, dynamic> json) {
  return _SecurityAsset.fromJson(json);
}

/// @nodoc
mixin _$SecurityAsset {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // e.g., 'Server', 'Workstation', 'Network', 'Application'
  String? get description => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get platform => throw _privateConstructorUsedError;
  List<String> get relatedTechniques => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SecurityAsset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityAssetCopyWith<SecurityAsset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityAssetCopyWith<$Res> {
  factory $SecurityAssetCopyWith(
    SecurityAsset value,
    $Res Function(SecurityAsset) then,
  ) = _$SecurityAssetCopyWithImpl<$Res, SecurityAsset>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String? description,
    String? location,
    String? platform,
    List<String> relatedTechniques,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$SecurityAssetCopyWithImpl<$Res, $Val extends SecurityAsset>
    implements $SecurityAssetCopyWith<$Res> {
  _$SecurityAssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? platform = freezed,
    Object? relatedTechniques = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            platform: freezed == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedTechniques: null == relatedTechniques
                ? _value.relatedTechniques
                : relatedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SecurityAssetImplCopyWith<$Res>
    implements $SecurityAssetCopyWith<$Res> {
  factory _$$SecurityAssetImplCopyWith(
    _$SecurityAssetImpl value,
    $Res Function(_$SecurityAssetImpl) then,
  ) = __$$SecurityAssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String? description,
    String? location,
    String? platform,
    List<String> relatedTechniques,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$SecurityAssetImplCopyWithImpl<$Res>
    extends _$SecurityAssetCopyWithImpl<$Res, _$SecurityAssetImpl>
    implements _$$SecurityAssetImplCopyWith<$Res> {
  __$$SecurityAssetImplCopyWithImpl(
    _$SecurityAssetImpl _value,
    $Res Function(_$SecurityAssetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? platform = freezed,
    Object? relatedTechniques = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SecurityAssetImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        platform: freezed == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedTechniques: null == relatedTechniques
            ? _value._relatedTechniques
            : relatedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityAssetImpl implements _SecurityAsset {
  const _$SecurityAssetImpl({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    this.location,
    this.platform,
    final List<String> relatedTechniques = const [],
    this.createdAt,
  }) : _relatedTechniques = relatedTechniques;

  factory _$SecurityAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityAssetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  // e.g., 'Server', 'Workstation', 'Network', 'Application'
  @override
  final String? description;
  @override
  final String? location;
  @override
  final String? platform;
  final List<String> _relatedTechniques;
  @override
  @JsonKey()
  List<String> get relatedTechniques {
    if (_relatedTechniques is EqualUnmodifiableListView)
      return _relatedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedTechniques);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SecurityAsset(id: $id, name: $name, type: $type, description: $description, location: $location, platform: $platform, relatedTechniques: $relatedTechniques, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityAssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            const DeepCollectionEquality().equals(
              other._relatedTechniques,
              _relatedTechniques,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    description,
    location,
    platform,
    const DeepCollectionEquality().hash(_relatedTechniques),
    createdAt,
  );

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityAssetImplCopyWith<_$SecurityAssetImpl> get copyWith =>
      __$$SecurityAssetImplCopyWithImpl<_$SecurityAssetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityAssetImplToJson(this);
  }
}

abstract class _SecurityAsset implements SecurityAsset {
  const factory _SecurityAsset({
    required final String id,
    required final String name,
    required final String type,
    final String? description,
    final String? location,
    final String? platform,
    final List<String> relatedTechniques,
    final DateTime? createdAt,
  }) = _$SecurityAssetImpl;

  factory _SecurityAsset.fromJson(Map<String, dynamic> json) =
      _$SecurityAssetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type; // e.g., 'Server', 'Workstation', 'Network', 'Application'
  @override
  String? get description;
  @override
  String? get location;
  @override
  String? get platform;
  @override
  List<String> get relatedTechniques;
  @override
  DateTime? get createdAt;

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityAssetImplCopyWith<_$SecurityAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
