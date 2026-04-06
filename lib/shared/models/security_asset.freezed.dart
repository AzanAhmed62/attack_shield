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
  String get description => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'Network' | 'Server' | 'Workstation' | 'Application' | 'Cloud'
  AssetCriticality get criticality => throw _privateConstructorUsedError;
  List<String> get platforms =>
      throw _privateConstructorUsedError; // OS/platforms this asset runs
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime get discoveredAt => throw _privateConstructorUsedError;
  DateTime? get lastScanned => throw _privateConstructorUsedError;

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
    String description,
    String type,
    AssetCriticality criticality,
    List<String> platforms,
    List<String> tags,
    DateTime discoveredAt,
    DateTime? lastScanned,
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
    Object? description = null,
    Object? type = null,
    Object? criticality = null,
    Object? platforms = null,
    Object? tags = null,
    Object? discoveredAt = null,
    Object? lastScanned = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            criticality: null == criticality
                ? _value.criticality
                : criticality // ignore: cast_nullable_to_non_nullable
                      as AssetCriticality,
            platforms: null == platforms
                ? _value.platforms
                : platforms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            discoveredAt: null == discoveredAt
                ? _value.discoveredAt
                : discoveredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastScanned: freezed == lastScanned
                ? _value.lastScanned
                : lastScanned // ignore: cast_nullable_to_non_nullable
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
    String description,
    String type,
    AssetCriticality criticality,
    List<String> platforms,
    List<String> tags,
    DateTime discoveredAt,
    DateTime? lastScanned,
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
    Object? description = null,
    Object? type = null,
    Object? criticality = null,
    Object? platforms = null,
    Object? tags = null,
    Object? discoveredAt = null,
    Object? lastScanned = freezed,
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
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        criticality: null == criticality
            ? _value.criticality
            : criticality // ignore: cast_nullable_to_non_nullable
                  as AssetCriticality,
        platforms: null == platforms
            ? _value._platforms
            : platforms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        discoveredAt: null == discoveredAt
            ? _value.discoveredAt
            : discoveredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastScanned: freezed == lastScanned
            ? _value.lastScanned
            : lastScanned // ignore: cast_nullable_to_non_nullable
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
    this.description = '',
    this.type = '',
    this.criticality = AssetCriticality.medium,
    final List<String> platforms = const [],
    final List<String> tags = const [],
    required this.discoveredAt,
    this.lastScanned,
  }) : _platforms = platforms,
       _tags = tags;

  factory _$SecurityAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityAssetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String type;
  // 'Network' | 'Server' | 'Workstation' | 'Application' | 'Cloud'
  @override
  @JsonKey()
  final AssetCriticality criticality;
  final List<String> _platforms;
  @override
  @JsonKey()
  List<String> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  // OS/platforms this asset runs
  final List<String> _tags;
  // OS/platforms this asset runs
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime discoveredAt;
  @override
  final DateTime? lastScanned;

  @override
  String toString() {
    return 'SecurityAsset(id: $id, name: $name, description: $description, type: $type, criticality: $criticality, platforms: $platforms, tags: $tags, discoveredAt: $discoveredAt, lastScanned: $lastScanned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityAssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.criticality, criticality) ||
                other.criticality == criticality) &&
            const DeepCollectionEquality().equals(
              other._platforms,
              _platforms,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.discoveredAt, discoveredAt) ||
                other.discoveredAt == discoveredAt) &&
            (identical(other.lastScanned, lastScanned) ||
                other.lastScanned == lastScanned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    criticality,
    const DeepCollectionEquality().hash(_platforms),
    const DeepCollectionEquality().hash(_tags),
    discoveredAt,
    lastScanned,
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
    final String description,
    final String type,
    final AssetCriticality criticality,
    final List<String> platforms,
    final List<String> tags,
    required final DateTime discoveredAt,
    final DateTime? lastScanned,
  }) = _$SecurityAssetImpl;

  factory _SecurityAsset.fromJson(Map<String, dynamic> json) =
      _$SecurityAssetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get type; // 'Network' | 'Server' | 'Workstation' | 'Application' | 'Cloud'
  @override
  AssetCriticality get criticality;
  @override
  List<String> get platforms; // OS/platforms this asset runs
  @override
  List<String> get tags;
  @override
  DateTime get discoveredAt;
  @override
  DateTime? get lastScanned;

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityAssetImplCopyWith<_$SecurityAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
