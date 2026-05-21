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

AttackTactic _$AttackTacticFromJson(Map<String, dynamic> json) {
  return _AttackTactic.fromJson(json);
}

/// @nodoc
mixin _$AttackTactic {
  String get id => throw _privateConstructorUsedError; // "TA0001"
  String get name => throw _privateConstructorUsedError; // "Initial Access"
  String get shortName =>
      throw _privateConstructorUsedError; // "initial-access" (from STIX kill_chain)
  String get description => throw _privateConstructorUsedError;
  List<String> get techniqueIds => throw _privateConstructorUsedError;

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
    String shortName,
    String description,
    List<String> techniqueIds,
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
    Object? shortName = null,
    Object? description = null,
    Object? techniqueIds = null,
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
            shortName: null == shortName
                ? _value.shortName
                : shortName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueIds: null == techniqueIds
                ? _value.techniqueIds
                : techniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
    String shortName,
    String description,
    List<String> techniqueIds,
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
    Object? shortName = null,
    Object? description = null,
    Object? techniqueIds = null,
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
        shortName: null == shortName
            ? _value.shortName
            : shortName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueIds: null == techniqueIds
            ? _value._techniqueIds
            : techniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
    required this.shortName,
    required this.description,
    final List<String> techniqueIds = const [],
  }) : _techniqueIds = techniqueIds;

  factory _$AttackTacticImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTacticImplFromJson(json);

  @override
  final String id;
  // "TA0001"
  @override
  final String name;
  // "Initial Access"
  @override
  final String shortName;
  // "initial-access" (from STIX kill_chain)
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
  String toString() {
    return 'AttackTactic(id: $id, name: $name, shortName: $shortName, description: $description, techniqueIds: $techniqueIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackTacticImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._techniqueIds,
              _techniqueIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    shortName,
    description,
    const DeepCollectionEquality().hash(_techniqueIds),
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
    required final String shortName,
    required final String description,
    final List<String> techniqueIds,
  }) = _$AttackTacticImpl;

  factory _AttackTactic.fromJson(Map<String, dynamic> json) =
      _$AttackTacticImpl.fromJson;

  @override
  String get id; // "TA0001"
  @override
  String get name; // "Initial Access"
  @override
  String get shortName; // "initial-access" (from STIX kill_chain)
  @override
  String get description;
  @override
  List<String> get techniqueIds;

  /// Create a copy of AttackTactic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackTacticImplCopyWith<_$AttackTacticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttackTechnique _$AttackTechniqueFromJson(Map<String, dynamic> json) {
  return _AttackTechnique.fromJson(json);
}

/// @nodoc
mixin _$AttackTechnique {
  // Core identifiers
  String get id => throw _privateConstructorUsedError; // "T1566"
  String get stixId =>
      throw _privateConstructorUsedError; // "attack-pattern--xxx" (internal STIX UUID)
  String get name => throw _privateConstructorUsedError; // "Phishing"
  String get description =>
      throw _privateConstructorUsedError; // Full STIX description
  // Classification
  List<String> get tactics =>
      throw _privateConstructorUsedError; // tactic shortNames e.g. ["initial-access"]
  List<String> get tacticIds =>
      throw _privateConstructorUsedError; // TA numbers e.g. ["TA0001"]
  List<String> get platforms =>
      throw _privateConstructorUsedError; // ["Windows", "macOS", ...]
  List<String> get dataSources =>
      throw _privateConstructorUsedError; // from x_mitre_data_sources
  // References to related objects (resolved by repo)
  List<String> get mitigationIds =>
      throw _privateConstructorUsedError; // T-IDs or names of mitigations
  List<String> get detectionIds => throw _privateConstructorUsedError;
  List<String> get relatedTechniqueIds =>
      throw _privateConstructorUsedError; // Sub-technique support
  bool get isSubTechnique => throw _privateConstructorUsedError;
  String? get parentTechniqueId =>
      throw _privateConstructorUsedError; // "T1566" if this is T1566.001
  List<String> get subTechniqueIds =>
      throw _privateConstructorUsedError; // IDs of children
  // Risk
  double get riskScore =>
      throw _privateConstructorUsedError; // 0–10, computed from STIX metadata
  // Metadata
  String? get url => throw _privateConstructorUsedError; // MITRE ATT&CK URL
  String? get created => throw _privateConstructorUsedError;
  String? get modified =>
      throw _privateConstructorUsedError; // Plain-language enrichment (populated by PlainLanguageService)
  String? get plainTitle => throw _privateConstructorUsedError;
  String? get plainSummary => throw _privateConstructorUsedError;
  String? get businessRisk => throw _privateConstructorUsedError;
  List<String> get remediationSteps => throw _privateConstructorUsedError;

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
    String stixId,
    String name,
    String description,
    List<String> tactics,
    List<String> tacticIds,
    List<String> platforms,
    List<String> dataSources,
    List<String> mitigationIds,
    List<String> detectionIds,
    List<String> relatedTechniqueIds,
    bool isSubTechnique,
    String? parentTechniqueId,
    List<String> subTechniqueIds,
    double riskScore,
    String? url,
    String? created,
    String? modified,
    String? plainTitle,
    String? plainSummary,
    String? businessRisk,
    List<String> remediationSteps,
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
    Object? stixId = null,
    Object? name = null,
    Object? description = null,
    Object? tactics = null,
    Object? tacticIds = null,
    Object? platforms = null,
    Object? dataSources = null,
    Object? mitigationIds = null,
    Object? detectionIds = null,
    Object? relatedTechniqueIds = null,
    Object? isSubTechnique = null,
    Object? parentTechniqueId = freezed,
    Object? subTechniqueIds = null,
    Object? riskScore = null,
    Object? url = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? plainTitle = freezed,
    Object? plainSummary = freezed,
    Object? businessRisk = freezed,
    Object? remediationSteps = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            stixId: null == stixId
                ? _value.stixId
                : stixId // ignore: cast_nullable_to_non_nullable
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
            tacticIds: null == tacticIds
                ? _value.tacticIds
                : tacticIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            platforms: null == platforms
                ? _value.platforms
                : platforms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            dataSources: null == dataSources
                ? _value.dataSources
                : dataSources // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mitigationIds: null == mitigationIds
                ? _value.mitigationIds
                : mitigationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            detectionIds: null == detectionIds
                ? _value.detectionIds
                : detectionIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            relatedTechniqueIds: null == relatedTechniqueIds
                ? _value.relatedTechniqueIds
                : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isSubTechnique: null == isSubTechnique
                ? _value.isSubTechnique
                : isSubTechnique // ignore: cast_nullable_to_non_nullable
                      as bool,
            parentTechniqueId: freezed == parentTechniqueId
                ? _value.parentTechniqueId
                : parentTechniqueId // ignore: cast_nullable_to_non_nullable
                      as String?,
            subTechniqueIds: null == subTechniqueIds
                ? _value.subTechniqueIds
                : subTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            created: freezed == created
                ? _value.created
                : created // ignore: cast_nullable_to_non_nullable
                      as String?,
            modified: freezed == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as String?,
            plainTitle: freezed == plainTitle
                ? _value.plainTitle
                : plainTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            plainSummary: freezed == plainSummary
                ? _value.plainSummary
                : plainSummary // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessRisk: freezed == businessRisk
                ? _value.businessRisk
                : businessRisk // ignore: cast_nullable_to_non_nullable
                      as String?,
            remediationSteps: null == remediationSteps
                ? _value.remediationSteps
                : remediationSteps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
    String stixId,
    String name,
    String description,
    List<String> tactics,
    List<String> tacticIds,
    List<String> platforms,
    List<String> dataSources,
    List<String> mitigationIds,
    List<String> detectionIds,
    List<String> relatedTechniqueIds,
    bool isSubTechnique,
    String? parentTechniqueId,
    List<String> subTechniqueIds,
    double riskScore,
    String? url,
    String? created,
    String? modified,
    String? plainTitle,
    String? plainSummary,
    String? businessRisk,
    List<String> remediationSteps,
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
    Object? stixId = null,
    Object? name = null,
    Object? description = null,
    Object? tactics = null,
    Object? tacticIds = null,
    Object? platforms = null,
    Object? dataSources = null,
    Object? mitigationIds = null,
    Object? detectionIds = null,
    Object? relatedTechniqueIds = null,
    Object? isSubTechnique = null,
    Object? parentTechniqueId = freezed,
    Object? subTechniqueIds = null,
    Object? riskScore = null,
    Object? url = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? plainTitle = freezed,
    Object? plainSummary = freezed,
    Object? businessRisk = freezed,
    Object? remediationSteps = null,
  }) {
    return _then(
      _$AttackTechniqueImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        stixId: null == stixId
            ? _value.stixId
            : stixId // ignore: cast_nullable_to_non_nullable
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
        tacticIds: null == tacticIds
            ? _value._tacticIds
            : tacticIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        platforms: null == platforms
            ? _value._platforms
            : platforms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        dataSources: null == dataSources
            ? _value._dataSources
            : dataSources // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mitigationIds: null == mitigationIds
            ? _value._mitigationIds
            : mitigationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        detectionIds: null == detectionIds
            ? _value._detectionIds
            : detectionIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        relatedTechniqueIds: null == relatedTechniqueIds
            ? _value._relatedTechniqueIds
            : relatedTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isSubTechnique: null == isSubTechnique
            ? _value.isSubTechnique
            : isSubTechnique // ignore: cast_nullable_to_non_nullable
                  as bool,
        parentTechniqueId: freezed == parentTechniqueId
            ? _value.parentTechniqueId
            : parentTechniqueId // ignore: cast_nullable_to_non_nullable
                  as String?,
        subTechniqueIds: null == subTechniqueIds
            ? _value._subTechniqueIds
            : subTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        created: freezed == created
            ? _value.created
            : created // ignore: cast_nullable_to_non_nullable
                  as String?,
        modified: freezed == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as String?,
        plainTitle: freezed == plainTitle
            ? _value.plainTitle
            : plainTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        plainSummary: freezed == plainSummary
            ? _value.plainSummary
            : plainSummary // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessRisk: freezed == businessRisk
            ? _value.businessRisk
            : businessRisk // ignore: cast_nullable_to_non_nullable
                  as String?,
        remediationSteps: null == remediationSteps
            ? _value._remediationSteps
            : remediationSteps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackTechniqueImpl implements _AttackTechnique {
  const _$AttackTechniqueImpl({
    required this.id,
    required this.stixId,
    required this.name,
    required this.description,
    final List<String> tactics = const [],
    final List<String> tacticIds = const [],
    final List<String> platforms = const [],
    final List<String> dataSources = const [],
    final List<String> mitigationIds = const [],
    final List<String> detectionIds = const [],
    final List<String> relatedTechniqueIds = const [],
    this.isSubTechnique = false,
    this.parentTechniqueId,
    final List<String> subTechniqueIds = const [],
    this.riskScore = 5.0,
    this.url,
    this.created,
    this.modified,
    this.plainTitle,
    this.plainSummary,
    this.businessRisk,
    final List<String> remediationSteps = const [],
  }) : _tactics = tactics,
       _tacticIds = tacticIds,
       _platforms = platforms,
       _dataSources = dataSources,
       _mitigationIds = mitigationIds,
       _detectionIds = detectionIds,
       _relatedTechniqueIds = relatedTechniqueIds,
       _subTechniqueIds = subTechniqueIds,
       _remediationSteps = remediationSteps;

  factory _$AttackTechniqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTechniqueImplFromJson(json);

  // Core identifiers
  @override
  final String id;
  // "T1566"
  @override
  final String stixId;
  // "attack-pattern--xxx" (internal STIX UUID)
  @override
  final String name;
  // "Phishing"
  @override
  final String description;
  // Full STIX description
  // Classification
  final List<String> _tactics;
  // Full STIX description
  // Classification
  @override
  @JsonKey()
  List<String> get tactics {
    if (_tactics is EqualUnmodifiableListView) return _tactics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tactics);
  }

  // tactic shortNames e.g. ["initial-access"]
  final List<String> _tacticIds;
  // tactic shortNames e.g. ["initial-access"]
  @override
  @JsonKey()
  List<String> get tacticIds {
    if (_tacticIds is EqualUnmodifiableListView) return _tacticIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tacticIds);
  }

  // TA numbers e.g. ["TA0001"]
  final List<String> _platforms;
  // TA numbers e.g. ["TA0001"]
  @override
  @JsonKey()
  List<String> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  // ["Windows", "macOS", ...]
  final List<String> _dataSources;
  // ["Windows", "macOS", ...]
  @override
  @JsonKey()
  List<String> get dataSources {
    if (_dataSources is EqualUnmodifiableListView) return _dataSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataSources);
  }

  // from x_mitre_data_sources
  // References to related objects (resolved by repo)
  final List<String> _mitigationIds;
  // from x_mitre_data_sources
  // References to related objects (resolved by repo)
  @override
  @JsonKey()
  List<String> get mitigationIds {
    if (_mitigationIds is EqualUnmodifiableListView) return _mitigationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mitigationIds);
  }

  // T-IDs or names of mitigations
  final List<String> _detectionIds;
  // T-IDs or names of mitigations
  @override
  @JsonKey()
  List<String> get detectionIds {
    if (_detectionIds is EqualUnmodifiableListView) return _detectionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectionIds);
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

  // Sub-technique support
  @override
  @JsonKey()
  final bool isSubTechnique;
  @override
  final String? parentTechniqueId;
  // "T1566" if this is T1566.001
  final List<String> _subTechniqueIds;
  // "T1566" if this is T1566.001
  @override
  @JsonKey()
  List<String> get subTechniqueIds {
    if (_subTechniqueIds is EqualUnmodifiableListView) return _subTechniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subTechniqueIds);
  }

  // IDs of children
  // Risk
  @override
  @JsonKey()
  final double riskScore;
  // 0–10, computed from STIX metadata
  // Metadata
  @override
  final String? url;
  // MITRE ATT&CK URL
  @override
  final String? created;
  @override
  final String? modified;
  // Plain-language enrichment (populated by PlainLanguageService)
  @override
  final String? plainTitle;
  @override
  final String? plainSummary;
  @override
  final String? businessRisk;
  final List<String> _remediationSteps;
  @override
  @JsonKey()
  List<String> get remediationSteps {
    if (_remediationSteps is EqualUnmodifiableListView)
      return _remediationSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remediationSteps);
  }

  @override
  String toString() {
    return 'AttackTechnique(id: $id, stixId: $stixId, name: $name, description: $description, tactics: $tactics, tacticIds: $tacticIds, platforms: $platforms, dataSources: $dataSources, mitigationIds: $mitigationIds, detectionIds: $detectionIds, relatedTechniqueIds: $relatedTechniqueIds, isSubTechnique: $isSubTechnique, parentTechniqueId: $parentTechniqueId, subTechniqueIds: $subTechniqueIds, riskScore: $riskScore, url: $url, created: $created, modified: $modified, plainTitle: $plainTitle, plainSummary: $plainSummary, businessRisk: $businessRisk, remediationSteps: $remediationSteps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackTechniqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stixId, stixId) || other.stixId == stixId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tactics, _tactics) &&
            const DeepCollectionEquality().equals(
              other._tacticIds,
              _tacticIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._platforms,
              _platforms,
            ) &&
            const DeepCollectionEquality().equals(
              other._dataSources,
              _dataSources,
            ) &&
            const DeepCollectionEquality().equals(
              other._mitigationIds,
              _mitigationIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._detectionIds,
              _detectionIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._relatedTechniqueIds,
              _relatedTechniqueIds,
            ) &&
            (identical(other.isSubTechnique, isSubTechnique) ||
                other.isSubTechnique == isSubTechnique) &&
            (identical(other.parentTechniqueId, parentTechniqueId) ||
                other.parentTechniqueId == parentTechniqueId) &&
            const DeepCollectionEquality().equals(
              other._subTechniqueIds,
              _subTechniqueIds,
            ) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.plainTitle, plainTitle) ||
                other.plainTitle == plainTitle) &&
            (identical(other.plainSummary, plainSummary) ||
                other.plainSummary == plainSummary) &&
            (identical(other.businessRisk, businessRisk) ||
                other.businessRisk == businessRisk) &&
            const DeepCollectionEquality().equals(
              other._remediationSteps,
              _remediationSteps,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    stixId,
    name,
    description,
    const DeepCollectionEquality().hash(_tactics),
    const DeepCollectionEquality().hash(_tacticIds),
    const DeepCollectionEquality().hash(_platforms),
    const DeepCollectionEquality().hash(_dataSources),
    const DeepCollectionEquality().hash(_mitigationIds),
    const DeepCollectionEquality().hash(_detectionIds),
    const DeepCollectionEquality().hash(_relatedTechniqueIds),
    isSubTechnique,
    parentTechniqueId,
    const DeepCollectionEquality().hash(_subTechniqueIds),
    riskScore,
    url,
    created,
    modified,
    plainTitle,
    plainSummary,
    businessRisk,
    const DeepCollectionEquality().hash(_remediationSteps),
  ]);

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
    required final String stixId,
    required final String name,
    required final String description,
    final List<String> tactics,
    final List<String> tacticIds,
    final List<String> platforms,
    final List<String> dataSources,
    final List<String> mitigationIds,
    final List<String> detectionIds,
    final List<String> relatedTechniqueIds,
    final bool isSubTechnique,
    final String? parentTechniqueId,
    final List<String> subTechniqueIds,
    final double riskScore,
    final String? url,
    final String? created,
    final String? modified,
    final String? plainTitle,
    final String? plainSummary,
    final String? businessRisk,
    final List<String> remediationSteps,
  }) = _$AttackTechniqueImpl;

  factory _AttackTechnique.fromJson(Map<String, dynamic> json) =
      _$AttackTechniqueImpl.fromJson;

  // Core identifiers
  @override
  String get id; // "T1566"
  @override
  String get stixId; // "attack-pattern--xxx" (internal STIX UUID)
  @override
  String get name; // "Phishing"
  @override
  String get description; // Full STIX description
  // Classification
  @override
  List<String> get tactics; // tactic shortNames e.g. ["initial-access"]
  @override
  List<String> get tacticIds; // TA numbers e.g. ["TA0001"]
  @override
  List<String> get platforms; // ["Windows", "macOS", ...]
  @override
  List<String> get dataSources; // from x_mitre_data_sources
  // References to related objects (resolved by repo)
  @override
  List<String> get mitigationIds; // T-IDs or names of mitigations
  @override
  List<String> get detectionIds;
  @override
  List<String> get relatedTechniqueIds; // Sub-technique support
  @override
  bool get isSubTechnique;
  @override
  String? get parentTechniqueId; // "T1566" if this is T1566.001
  @override
  List<String> get subTechniqueIds; // IDs of children
  // Risk
  @override
  double get riskScore; // 0–10, computed from STIX metadata
  // Metadata
  @override
  String? get url; // MITRE ATT&CK URL
  @override
  String? get created;
  @override
  String? get modified; // Plain-language enrichment (populated by PlainLanguageService)
  @override
  String? get plainTitle;
  @override
  String? get plainSummary;
  @override
  String? get businessRisk;
  @override
  List<String> get remediationSteps;

  /// Create a copy of AttackTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackTechniqueImplCopyWith<_$AttackTechniqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
