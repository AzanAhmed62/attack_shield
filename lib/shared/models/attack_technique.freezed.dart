// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attack_technique.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttackTechnique _$AttackTechniqueFromJson(Map<String, dynamic> json) {
  return _AttackTechnique.fromJson(json);
}

/// @nodoc
mixin _$AttackTechnique {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get tactics => throw _privateConstructorUsedError;
  List<String> get platforms => throw _privateConstructorUsedError;
  List<String> get detectionIds => throw _privateConstructorUsedError;
  List<String> get mitigationIds => throw _privateConstructorUsedError;
  List<String> get relatedTechniqueIds => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;
  String? get externalUrl => throw _privateConstructorUsedError;

  /// Serializes this AttackTechnique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttackTechniqueCopyWith<AttackTechnique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttackTechniqueCopyWith<$Res> {
  factory $AttackTechniqueCopyWith(
    AttackTechnique value,
    $Res Function(AttackTechnique) then,
  ) = _$AttackTechniqueCopyWithImpl<$Res, AttackTechnique>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> tactics,
    List<String> platforms,
    List<String> detectionIds,
    List<String> mitigationIds,
    List<String> relatedTechniqueIds,
    double riskScore,
    String? source,
    DateTime? lastModified,
    String? externalUrl,
  });
}

/// @nodoc
class _$AttackTechniqueCopyWithImpl<$Res, $Val extends AttackTechnique>
    implements $AttackTechniqueCopyWith<$Res> {
  _$AttackTechniqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? tactics = null,
    Object? platforms = null,
    Object? detectionIds = null,
    Object? mitigationIds = null,
    Object? relatedTechniqueIds = null,
    Object? riskScore = null,
    Object? source = freezed,
    Object? lastModified = freezed,
    Object? externalUrl = freezed,
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
            tactics: null == tactics
                ? _value.tactics
                : tactics // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            platforms: null == platforms
                ? _value.platforms
                : platforms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            detectionIds: null == detectionIds
                ? _value.detectionIds
                : detectionIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mitigationIds: null == mitigationIds
                ? _value.mitigationIds
                : mitigationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            relatedTechniqueIds: null == relatedTechniqueIds
                ? _value.relatedTechniqueIds
                : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastModified: freezed == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            externalUrl: freezed == externalUrl
                ? _value.externalUrl
                : externalUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttackTechniqueImplCopyWith<$Res>
    implements $AttackTechniqueCopyWith<$Res> {
  factory _$$AttackTechniqueImplCopyWith(
    _$AttackTechniqueImpl value,
    $Res Function(_$AttackTechniqueImpl) then,
  ) = __$$AttackTechniqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> tactics,
    List<String> platforms,
    List<String> detectionIds,
    List<String> mitigationIds,
    List<String> relatedTechniqueIds,
    double riskScore,
    String? source,
    DateTime? lastModified,
    String? externalUrl,
  });
}

/// @nodoc
class __$$AttackTechniqueImplCopyWithImpl<$Res>
    extends _$AttackTechniqueCopyWithImpl<$Res, _$AttackTechniqueImpl>
    implements _$$AttackTechniqueImplCopyWith<$Res> {
  __$$AttackTechniqueImplCopyWithImpl(
    _$AttackTechniqueImpl _value,
    $Res Function(_$AttackTechniqueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? tactics = null,
    Object? platforms = null,
    Object? detectionIds = null,
    Object? mitigationIds = null,
    Object? relatedTechniqueIds = null,
    Object? riskScore = null,
    Object? source = freezed,
    Object? lastModified = freezed,
    Object? externalUrl = freezed,
  }) {
    return _then(
      _$AttackTechniqueImpl(
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
        tactics: null == tactics
            ? _value._tactics
            : tactics // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        platforms: null == platforms
            ? _value._platforms
            : platforms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        detectionIds: null == detectionIds
            ? _value._detectionIds
            : detectionIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mitigationIds: null == mitigationIds
            ? _value._mitigationIds
            : mitigationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        relatedTechniqueIds: null == relatedTechniqueIds
            ? _value._relatedTechniqueIds
            : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastModified: freezed == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        externalUrl: freezed == externalUrl
            ? _value.externalUrl
            : externalUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackTechniqueImpl implements _AttackTechnique {
  const _$AttackTechniqueImpl({
    required this.id,
    required this.name,
    required this.description,
    required final List<String> tactics,
    final List<String> platforms = const [],
    final List<String> detectionIds = const [],
    final List<String> mitigationIds = const [],
    final List<String> relatedTechniqueIds = const [],
    this.riskScore = 5.0,
    this.source,
    this.lastModified,
    this.externalUrl,
  }) : _tactics = tactics,
       _platforms = platforms,
       _detectionIds = detectionIds,
       _mitigationIds = mitigationIds,
       _relatedTechniqueIds = relatedTechniqueIds;

  factory _$AttackTechniqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTechniqueImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<String> _tactics;
  @override
  List<String> get tactics {
    if (_tactics is EqualUnmodifiableListView) return _tactics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tactics);
  }

  final List<String> _platforms;
  @override
  @JsonKey()
  List<String> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  final List<String> _detectionIds;
  @override
  @JsonKey()
  List<String> get detectionIds {
    if (_detectionIds is EqualUnmodifiableListView) return _detectionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectionIds);
  }

  final List<String> _mitigationIds;
  @override
  @JsonKey()
  List<String> get mitigationIds {
    if (_mitigationIds is EqualUnmodifiableListView) return _mitigationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mitigationIds);
  }

  final List<String> _relatedTechniqueIds;
  @override
  @JsonKey()
  List<String> get relatedTechniqueIds {
    if (_relatedTechniqueIds is EqualUnmodifiableListView)
      return _relatedTechniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedTechniqueIds);
  }

  @override
  @JsonKey()
  final double riskScore;
  @override
  final String? source;
  @override
  final DateTime? lastModified;
  @override
  final String? externalUrl;

  @override
  String toString() {
    return 'AttackTechnique(id: $id, name: $name, description: $description, tactics: $tactics, platforms: $platforms, detectionIds: $detectionIds, mitigationIds: $mitigationIds, relatedTechniqueIds: $relatedTechniqueIds, riskScore: $riskScore, source: $source, lastModified: $lastModified, externalUrl: $externalUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackTechniqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tactics, _tactics) &&
            const DeepCollectionEquality().equals(
              other._platforms,
              _platforms,
            ) &&
            const DeepCollectionEquality().equals(
              other._detectionIds,
              _detectionIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._mitigationIds,
              _mitigationIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._relatedTechniqueIds,
              _relatedTechniqueIds,
            ) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_tactics),
    const DeepCollectionEquality().hash(_platforms),
    const DeepCollectionEquality().hash(_detectionIds),
    const DeepCollectionEquality().hash(_mitigationIds),
    const DeepCollectionEquality().hash(_relatedTechniqueIds),
    riskScore,
    source,
    lastModified,
    externalUrl,
  );

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttackTechniqueImplCopyWith<_$AttackTechniqueImpl> get copyWith =>
      __$$AttackTechniqueImplCopyWithImpl<_$AttackTechniqueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttackTechniqueImplToJson(this);
  }
}

abstract class _AttackTechnique implements AttackTechnique {
  const factory _AttackTechnique({
    required final String id,
    required final String name,
    required final String description,
    required final List<String> tactics,
    final List<String> platforms,
    final List<String> detectionIds,
    final List<String> mitigationIds,
    final List<String> relatedTechniqueIds,
    final double riskScore,
    final String? source,
    final DateTime? lastModified,
    final String? externalUrl,
  }) = _$AttackTechniqueImpl;

  factory _AttackTechnique.fromJson(Map<String, dynamic> json) =
      _$AttackTechniqueImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get tactics;
  @override
  List<String> get platforms;
  @override
  List<String> get detectionIds;
  @override
  List<String> get mitigationIds;
  @override
  List<String> get relatedTechniqueIds;
  @override
  double get riskScore;
  @override
  String? get source;
  @override
  DateTime? get lastModified;
  @override
  String? get externalUrl;

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackTechniqueImplCopyWith<_$AttackTechniqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
