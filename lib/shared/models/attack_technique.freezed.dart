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

AttackSubTechnique _$AttackSubTechniqueFromJson(Map<String, dynamic> json) {
  return _AttackSubTechnique.fromJson(json);
}

/// @nodoc
mixin _$AttackSubTechnique {
  String get id => throw _privateConstructorUsedError; // e.g. "T1566.001"
  String get name =>
      throw _privateConstructorUsedError; // e.g. "Spearphishing Attachment"
  String get description => throw _privateConstructorUsedError;
  List<String> get platforms => throw _privateConstructorUsedError;
  List<String> get detectionIds => throw _privateConstructorUsedError;
  List<String> get mitigationIds => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;

  /// Serializes this AttackSubTechnique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttackSubTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttackSubTechniqueCopyWith<AttackSubTechnique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttackSubTechniqueCopyWith<$Res> {
  factory $AttackSubTechniqueCopyWith(
    AttackSubTechnique value,
    $Res Function(AttackSubTechnique) then,
  ) = _$AttackSubTechniqueCopyWithImpl<$Res, AttackSubTechnique>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> platforms,
    List<String> detectionIds,
    List<String> mitigationIds,
    double riskScore,
  });
}

/// @nodoc
class _$AttackSubTechniqueCopyWithImpl<$Res, $Val extends AttackSubTechnique>
    implements $AttackSubTechniqueCopyWith<$Res> {
  _$AttackSubTechniqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttackSubTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? platforms = null,
    Object? detectionIds = null,
    Object? mitigationIds = null,
    Object? riskScore = null,
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
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttackSubTechniqueImplCopyWith<$Res>
    implements $AttackSubTechniqueCopyWith<$Res> {
  factory _$$AttackSubTechniqueImplCopyWith(
    _$AttackSubTechniqueImpl value,
    $Res Function(_$AttackSubTechniqueImpl) then,
  ) = __$$AttackSubTechniqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> platforms,
    List<String> detectionIds,
    List<String> mitigationIds,
    double riskScore,
  });
}

/// @nodoc
class __$$AttackSubTechniqueImplCopyWithImpl<$Res>
    extends _$AttackSubTechniqueCopyWithImpl<$Res, _$AttackSubTechniqueImpl>
    implements _$$AttackSubTechniqueImplCopyWith<$Res> {
  __$$AttackSubTechniqueImplCopyWithImpl(
    _$AttackSubTechniqueImpl _value,
    $Res Function(_$AttackSubTechniqueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttackSubTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? platforms = null,
    Object? detectionIds = null,
    Object? mitigationIds = null,
    Object? riskScore = null,
  }) {
    return _then(
      _$AttackSubTechniqueImpl(
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
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackSubTechniqueImpl implements _AttackSubTechnique {
  const _$AttackSubTechniqueImpl({
    required this.id,
    required this.name,
    required this.description,
    final List<String> platforms = const [],
    final List<String> detectionIds = const [],
    final List<String> mitigationIds = const [],
    this.riskScore = 5.0,
  }) : _platforms = platforms,
       _detectionIds = detectionIds,
       _mitigationIds = mitigationIds;

  factory _$AttackSubTechniqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackSubTechniqueImplFromJson(json);

  @override
  final String id;
  // e.g. "T1566.001"
  @override
  final String name;
  // e.g. "Spearphishing Attachment"
  @override
  final String description;
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

  @override
  @JsonKey()
  final double riskScore;

  @override
  String toString() {
    return 'AttackSubTechnique(id: $id, name: $name, description: $description, platforms: $platforms, detectionIds: $detectionIds, mitigationIds: $mitigationIds, riskScore: $riskScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackSubTechniqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_platforms),
    const DeepCollectionEquality().hash(_detectionIds),
    const DeepCollectionEquality().hash(_mitigationIds),
    riskScore,
  );

  /// Create a copy of AttackSubTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttackSubTechniqueImplCopyWith<_$AttackSubTechniqueImpl> get copyWith =>
      __$$AttackSubTechniqueImplCopyWithImpl<_$AttackSubTechniqueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttackSubTechniqueImplToJson(this);
  }
}

abstract class _AttackSubTechnique implements AttackSubTechnique {
  const factory _AttackSubTechnique({
    required final String id,
    required final String name,
    required final String description,
    final List<String> platforms,
    final List<String> detectionIds,
    final List<String> mitigationIds,
    final double riskScore,
  }) = _$AttackSubTechniqueImpl;

  factory _AttackSubTechnique.fromJson(Map<String, dynamic> json) =
      _$AttackSubTechniqueImpl.fromJson;

  @override
  String get id; // e.g. "T1566.001"
  @override
  String get name; // e.g. "Spearphishing Attachment"
  @override
  String get description;
  @override
  List<String> get platforms;
  @override
  List<String> get detectionIds;
  @override
  List<String> get mitigationIds;
  @override
  double get riskScore;

  /// Create a copy of AttackSubTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackSubTechniqueImplCopyWith<_$AttackSubTechniqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttackTechnique _$AttackTechniqueFromJson(Map<String, dynamic> json) {
  return _AttackTechnique.fromJson(json);
}

/// @nodoc
mixin _$AttackTechnique {
  String get id => throw _privateConstructorUsedError; // e.g. "T1566"
  String get name => throw _privateConstructorUsedError; // e.g. "Phishing"
  String get description => throw _privateConstructorUsedError;
  List<String> get tactics =>
      throw _privateConstructorUsedError; // tactic names this belongs to
  List<String> get platforms => throw _privateConstructorUsedError;
  List<String> get detectionIds => throw _privateConstructorUsedError;
  List<String> get mitigationIds => throw _privateConstructorUsedError;
  List<String> get relatedTechniqueIds => throw _privateConstructorUsedError;
  List<AttackSubTechnique> get subTechniques =>
      throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError; // 0.0 – 10.0
  String? get source => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;
  String? get externalUrl =>
      throw _privateConstructorUsedError; // Defensive enrichment fields
  List<String> get detectionNotes =>
      throw _privateConstructorUsedError; // free-text detection hints
  List<String> get mitigationNotes =>
      throw _privateConstructorUsedError; // free-text mitigation hints
  String? get dataSource => throw _privateConstructorUsedError;

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
    List<AttackSubTechnique> subTechniques,
    double riskScore,
    String? source,
    DateTime? lastModified,
    String? externalUrl,
    List<String> detectionNotes,
    List<String> mitigationNotes,
    String? dataSource,
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
    Object? subTechniques = null,
    Object? riskScore = null,
    Object? source = freezed,
    Object? lastModified = freezed,
    Object? externalUrl = freezed,
    Object? detectionNotes = null,
    Object? mitigationNotes = null,
    Object? dataSource = freezed,
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
            subTechniques: null == subTechniques
                ? _value.subTechniques
                : subTechniques // ignore: cast_nullable_to_non_nullable
                      as List<AttackSubTechnique>,
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
            detectionNotes: null == detectionNotes
                ? _value.detectionNotes
                : detectionNotes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mitigationNotes: null == mitigationNotes
                ? _value.mitigationNotes
                : mitigationNotes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            dataSource: freezed == dataSource
                ? _value.dataSource
                : dataSource // ignore: cast_nullable_to_non_nullable
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
    List<AttackSubTechnique> subTechniques,
    double riskScore,
    String? source,
    DateTime? lastModified,
    String? externalUrl,
    List<String> detectionNotes,
    List<String> mitigationNotes,
    String? dataSource,
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
    Object? subTechniques = null,
    Object? riskScore = null,
    Object? source = freezed,
    Object? lastModified = freezed,
    Object? externalUrl = freezed,
    Object? detectionNotes = null,
    Object? mitigationNotes = null,
    Object? dataSource = freezed,
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
        subTechniques: null == subTechniques
            ? _value._subTechniques
            : subTechniques // ignore: cast_nullable_to_non_nullable
                  as List<AttackSubTechnique>,
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
        detectionNotes: null == detectionNotes
            ? _value._detectionNotes
            : detectionNotes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mitigationNotes: null == mitigationNotes
            ? _value._mitigationNotes
            : mitigationNotes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        dataSource: freezed == dataSource
            ? _value.dataSource
            : dataSource // ignore: cast_nullable_to_non_nullable
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
    final List<AttackSubTechnique> subTechniques = const [],
    this.riskScore = 5.0,
    this.source,
    this.lastModified,
    this.externalUrl,
    final List<String> detectionNotes = const [],
    final List<String> mitigationNotes = const [],
    this.dataSource,
  }) : _tactics = tactics,
       _platforms = platforms,
       _detectionIds = detectionIds,
       _mitigationIds = mitigationIds,
       _relatedTechniqueIds = relatedTechniqueIds,
       _subTechniques = subTechniques,
       _detectionNotes = detectionNotes,
       _mitigationNotes = mitigationNotes;

  factory _$AttackTechniqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTechniqueImplFromJson(json);

  @override
  final String id;
  // e.g. "T1566"
  @override
  final String name;
  // e.g. "Phishing"
  @override
  final String description;
  final List<String> _tactics;
  @override
  List<String> get tactics {
    if (_tactics is EqualUnmodifiableListView) return _tactics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tactics);
  }

  // tactic names this belongs to
  final List<String> _platforms;
  // tactic names this belongs to
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

  final List<AttackSubTechnique> _subTechniques;
  @override
  @JsonKey()
  List<AttackSubTechnique> get subTechniques {
    if (_subTechniques is EqualUnmodifiableListView) return _subTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subTechniques);
  }

  @override
  @JsonKey()
  final double riskScore;
  // 0.0 – 10.0
  @override
  final String? source;
  @override
  final DateTime? lastModified;
  @override
  final String? externalUrl;
  // Defensive enrichment fields
  final List<String> _detectionNotes;
  // Defensive enrichment fields
  @override
  @JsonKey()
  List<String> get detectionNotes {
    if (_detectionNotes is EqualUnmodifiableListView) return _detectionNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectionNotes);
  }

  // free-text detection hints
  final List<String> _mitigationNotes;
  // free-text detection hints
  @override
  @JsonKey()
  List<String> get mitigationNotes {
    if (_mitigationNotes is EqualUnmodifiableListView) return _mitigationNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mitigationNotes);
  }

  // free-text mitigation hints
  @override
  final String? dataSource;

  @override
  String toString() {
    return 'AttackTechnique(id: $id, name: $name, description: $description, tactics: $tactics, platforms: $platforms, detectionIds: $detectionIds, mitigationIds: $mitigationIds, relatedTechniqueIds: $relatedTechniqueIds, subTechniques: $subTechniques, riskScore: $riskScore, source: $source, lastModified: $lastModified, externalUrl: $externalUrl, detectionNotes: $detectionNotes, mitigationNotes: $mitigationNotes, dataSource: $dataSource)';
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
            const DeepCollectionEquality().equals(
              other._subTechniques,
              _subTechniques,
            ) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl) &&
            const DeepCollectionEquality().equals(
              other._detectionNotes,
              _detectionNotes,
            ) &&
            const DeepCollectionEquality().equals(
              other._mitigationNotes,
              _mitigationNotes,
            ) &&
            (identical(other.dataSource, dataSource) ||
                other.dataSource == dataSource));
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
    const DeepCollectionEquality().hash(_subTechniques),
    riskScore,
    source,
    lastModified,
    externalUrl,
    const DeepCollectionEquality().hash(_detectionNotes),
    const DeepCollectionEquality().hash(_mitigationNotes),
    dataSource,
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
    final List<AttackSubTechnique> subTechniques,
    final double riskScore,
    final String? source,
    final DateTime? lastModified,
    final String? externalUrl,
    final List<String> detectionNotes,
    final List<String> mitigationNotes,
    final String? dataSource,
  }) = _$AttackTechniqueImpl;

  factory _AttackTechnique.fromJson(Map<String, dynamic> json) =
      _$AttackTechniqueImpl.fromJson;

  @override
  String get id; // e.g. "T1566"
  @override
  String get name; // e.g. "Phishing"
  @override
  String get description;
  @override
  List<String> get tactics; // tactic names this belongs to
  @override
  List<String> get platforms;
  @override
  List<String> get detectionIds;
  @override
  List<String> get mitigationIds;
  @override
  List<String> get relatedTechniqueIds;
  @override
  List<AttackSubTechnique> get subTechniques;
  @override
  double get riskScore; // 0.0 – 10.0
  @override
  String? get source;
  @override
  DateTime? get lastModified;
  @override
  String? get externalUrl; // Defensive enrichment fields
  @override
  List<String> get detectionNotes; // free-text detection hints
  @override
  List<String> get mitigationNotes; // free-text mitigation hints
  @override
  String? get dataSource;

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackTechniqueImplCopyWith<_$AttackTechniqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttackTactic _$AttackTacticFromJson(Map<String, dynamic> json) {
  return _AttackTactic.fromJson(json);
}

/// @nodoc
mixin _$AttackTactic {
  String get id => throw _privateConstructorUsedError; // e.g. "TA0001"
  String get name =>
      throw _privateConstructorUsedError; // e.g. "Initial Access"
  String get description => throw _privateConstructorUsedError;
  List<String> get techniqueIds => throw _privateConstructorUsedError;
  String? get shortName => throw _privateConstructorUsedError;

  /// Serializes this AttackTactic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttackTacticCopyWith<AttackTactic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttackTacticCopyWith<$Res> {
  factory $AttackTacticCopyWith(
    AttackTactic value,
    $Res Function(AttackTactic) then,
  ) = _$AttackTacticCopyWithImpl<$Res, AttackTactic>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> techniqueIds,
    String? shortName,
  });
}

/// @nodoc
class _$AttackTacticCopyWithImpl<$Res, $Val extends AttackTactic>
    implements $AttackTacticCopyWith<$Res> {
  _$AttackTacticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? techniqueIds = null,
    Object? shortName = freezed,
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
            techniqueIds: null == techniqueIds
                ? _value.techniqueIds
                : techniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            shortName: freezed == shortName
                ? _value.shortName
                : shortName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttackTacticImplCopyWith<$Res>
    implements $AttackTacticCopyWith<$Res> {
  factory _$$AttackTacticImplCopyWith(
    _$AttackTacticImpl value,
    $Res Function(_$AttackTacticImpl) then,
  ) = __$$AttackTacticImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String> techniqueIds,
    String? shortName,
  });
}

/// @nodoc
class __$$AttackTacticImplCopyWithImpl<$Res>
    extends _$AttackTacticCopyWithImpl<$Res, _$AttackTacticImpl>
    implements _$$AttackTacticImplCopyWith<$Res> {
  __$$AttackTacticImplCopyWithImpl(
    _$AttackTacticImpl _value,
    $Res Function(_$AttackTacticImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? techniqueIds = null,
    Object? shortName = freezed,
  }) {
    return _then(
      _$AttackTacticImpl(
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
        techniqueIds: null == techniqueIds
            ? _value._techniqueIds
            : techniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        shortName: freezed == shortName
            ? _value.shortName
            : shortName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackTacticImpl implements _AttackTactic {
  const _$AttackTacticImpl({
    required this.id,
    required this.name,
    required this.description,
    final List<String> techniqueIds = const [],
    this.shortName,
  }) : _techniqueIds = techniqueIds;

  factory _$AttackTacticImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTacticImplFromJson(json);

  @override
  final String id;
  // e.g. "TA0001"
  @override
  final String name;
  // e.g. "Initial Access"
  @override
  final String description;
  final List<String> _techniqueIds;
  @override
  @JsonKey()
  List<String> get techniqueIds {
    if (_techniqueIds is EqualUnmodifiableListView) return _techniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniqueIds);
  }

  @override
  final String? shortName;

  @override
  String toString() {
    return 'AttackTactic(id: $id, name: $name, description: $description, techniqueIds: $techniqueIds, shortName: $shortName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackTacticImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._techniqueIds,
              _techniqueIds,
            ) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_techniqueIds),
    shortName,
  );

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttackTacticImplCopyWith<_$AttackTacticImpl> get copyWith =>
      __$$AttackTacticImplCopyWithImpl<_$AttackTacticImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttackTacticImplToJson(this);
  }
}

abstract class _AttackTactic implements AttackTactic {
  const factory _AttackTactic({
    required final String id,
    required final String name,
    required final String description,
    final List<String> techniqueIds,
    final String? shortName,
  }) = _$AttackTacticImpl;

  factory _AttackTactic.fromJson(Map<String, dynamic> json) =
      _$AttackTacticImpl.fromJson;

  @override
  String get id; // e.g. "TA0001"
  @override
  String get name; // e.g. "Initial Access"
  @override
  String get description;
  @override
  List<String> get techniqueIds;
  @override
  String? get shortName;

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackTacticImplCopyWith<_$AttackTacticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
