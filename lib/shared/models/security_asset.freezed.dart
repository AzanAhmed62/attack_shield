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
  AssetType get type => throw _privateConstructorUsedError;
  AssetCriticality get criticality => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get relatedTechniqueIds => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<String> get platforms => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  DateTime? get discoveredAt => throw _privateConstructorUsedError;
  DateTime? get lastScanned => throw _privateConstructorUsedError;
  String? get owner => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get operatingSystem => throw _privateConstructorUsedError;

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
    AssetType type,
    AssetCriticality criticality,
    String description,
    List<String> relatedTechniqueIds,
    List<String> tags,
    List<String> platforms,
    DateTime createdAt,
    DateTime? lastUpdated,
    DateTime? discoveredAt,
    DateTime? lastScanned,
    String? owner,
    String? ipAddress,
    String? operatingSystem,
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
    Object? criticality = null,
    Object? description = null,
    Object? relatedTechniqueIds = null,
    Object? tags = null,
    Object? platforms = null,
    Object? createdAt = null,
    Object? lastUpdated = freezed,
    Object? discoveredAt = freezed,
    Object? lastScanned = freezed,
    Object? owner = freezed,
    Object? ipAddress = freezed,
    Object? operatingSystem = freezed,
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
                      as AssetType,
            criticality: null == criticality
                ? _value.criticality
                : criticality // ignore: cast_nullable_to_non_nullable
                      as AssetCriticality,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedTechniqueIds: null == relatedTechniqueIds
                ? _value.relatedTechniqueIds
                : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            platforms: null == platforms
                ? _value.platforms
                : platforms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            discoveredAt: freezed == discoveredAt
                ? _value.discoveredAt
                : discoveredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastScanned: freezed == lastScanned
                ? _value.lastScanned
                : lastScanned // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            owner: freezed == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                      as String?,
            ipAddress: freezed == ipAddress
                ? _value.ipAddress
                : ipAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            operatingSystem: freezed == operatingSystem
                ? _value.operatingSystem
                : operatingSystem // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    AssetType type,
    AssetCriticality criticality,
    String description,
    List<String> relatedTechniqueIds,
    List<String> tags,
    List<String> platforms,
    DateTime createdAt,
    DateTime? lastUpdated,
    DateTime? discoveredAt,
    DateTime? lastScanned,
    String? owner,
    String? ipAddress,
    String? operatingSystem,
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
    Object? criticality = null,
    Object? description = null,
    Object? relatedTechniqueIds = null,
    Object? tags = null,
    Object? platforms = null,
    Object? createdAt = null,
    Object? lastUpdated = freezed,
    Object? discoveredAt = freezed,
    Object? lastScanned = freezed,
    Object? owner = freezed,
    Object? ipAddress = freezed,
    Object? operatingSystem = freezed,
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
                  as AssetType,
        criticality: null == criticality
            ? _value.criticality
            : criticality // ignore: cast_nullable_to_non_nullable
                  as AssetCriticality,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedTechniqueIds: null == relatedTechniqueIds
            ? _value._relatedTechniqueIds
            : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        platforms: null == platforms
            ? _value._platforms
            : platforms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        discoveredAt: freezed == discoveredAt
            ? _value.discoveredAt
            : discoveredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastScanned: freezed == lastScanned
            ? _value.lastScanned
            : lastScanned // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        owner: freezed == owner
            ? _value.owner
            : owner // ignore: cast_nullable_to_non_nullable
                  as String?,
        ipAddress: freezed == ipAddress
            ? _value.ipAddress
            : ipAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        operatingSystem: freezed == operatingSystem
            ? _value.operatingSystem
            : operatingSystem // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    this.type = AssetType.server,
    this.criticality = AssetCriticality.medium,
    this.description = '',
    final List<String> relatedTechniqueIds = const [],
    final List<String> tags = const [],
    final List<String> platforms = const [],
    required this.createdAt,
    this.lastUpdated,
    this.discoveredAt,
    this.lastScanned,
    this.owner,
    this.ipAddress,
    this.operatingSystem,
  }) : _relatedTechniqueIds = relatedTechniqueIds,
       _tags = tags,
       _platforms = platforms;

  factory _$SecurityAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityAssetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final AssetType type;
  @override
  @JsonKey()
  final AssetCriticality criticality;
  @override
  @JsonKey()
  final String description;
  final List<String> _relatedTechniqueIds;
  @override
  @JsonKey()
  List<String> get relatedTechniqueIds {
    if (_relatedTechniqueIds is EqualUnmodifiableListView)
      return _relatedTechniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedTechniqueIds);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _platforms;
  @override
  @JsonKey()
  List<String> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUpdated;
  @override
  final DateTime? discoveredAt;
  @override
  final DateTime? lastScanned;
  @override
  final String? owner;
  @override
  final String? ipAddress;
  @override
  final String? operatingSystem;

  @override
  String toString() {
    return 'SecurityAsset(id: $id, name: $name, type: $type, criticality: $criticality, description: $description, relatedTechniqueIds: $relatedTechniqueIds, tags: $tags, platforms: $platforms, createdAt: $createdAt, lastUpdated: $lastUpdated, discoveredAt: $discoveredAt, lastScanned: $lastScanned, owner: $owner, ipAddress: $ipAddress, operatingSystem: $operatingSystem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityAssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.criticality, criticality) ||
                other.criticality == criticality) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._relatedTechniqueIds,
              _relatedTechniqueIds,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._platforms,
              _platforms,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.discoveredAt, discoveredAt) ||
                other.discoveredAt == discoveredAt) &&
            (identical(other.lastScanned, lastScanned) ||
                other.lastScanned == lastScanned) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.operatingSystem, operatingSystem) ||
                other.operatingSystem == operatingSystem));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    criticality,
    description,
    const DeepCollectionEquality().hash(_relatedTechniqueIds),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_platforms),
    createdAt,
    lastUpdated,
    discoveredAt,
    lastScanned,
    owner,
    ipAddress,
    operatingSystem,
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
    final AssetType type,
    final AssetCriticality criticality,
    final String description,
    final List<String> relatedTechniqueIds,
    final List<String> tags,
    final List<String> platforms,
    required final DateTime createdAt,
    final DateTime? lastUpdated,
    final DateTime? discoveredAt,
    final DateTime? lastScanned,
    final String? owner,
    final String? ipAddress,
    final String? operatingSystem,
  }) = _$SecurityAssetImpl;

  factory _SecurityAsset.fromJson(Map<String, dynamic> json) =
      _$SecurityAssetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  AssetType get type;
  @override
  AssetCriticality get criticality;
  @override
  String get description;
  @override
  List<String> get relatedTechniqueIds;
  @override
  List<String> get tags;
  @override
  List<String> get platforms;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastUpdated;
  @override
  DateTime? get discoveredAt;
  @override
  DateTime? get lastScanned;
  @override
  String? get owner;
  @override
  String? get ipAddress;
  @override
  String? get operatingSystem;

  /// Create a copy of SecurityAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityAssetImplCopyWith<_$SecurityAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
