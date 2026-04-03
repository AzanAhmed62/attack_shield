// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_scenario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationScenario _$SimulationScenarioFromJson(Map<String, dynamic> json) {
  return _SimulationScenario.fromJson(json);
}

/// @nodoc
mixin _$SimulationScenario {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String>? get relatedTechniques => throw _privateConstructorUsedError;
  String? get objectives => throw _privateConstructorUsedError;
  String? get expectedOutcomes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SimulationScenario to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationScenarioCopyWith<SimulationScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationScenarioCopyWith<$Res> {
  factory $SimulationScenarioCopyWith(
    SimulationScenario value,
    $Res Function(SimulationScenario) then,
  ) = _$SimulationScenarioCopyWithImpl<$Res, SimulationScenario>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String>? relatedTechniques,
    String? objectives,
    String? expectedOutcomes,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$SimulationScenarioCopyWithImpl<$Res, $Val extends SimulationScenario>
    implements $SimulationScenarioCopyWith<$Res> {
  _$SimulationScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? relatedTechniques = freezed,
    Object? objectives = freezed,
    Object? expectedOutcomes = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedTechniques: freezed == relatedTechniques
                ? _value.relatedTechniques
                : relatedTechniques // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            objectives: freezed == objectives
                ? _value.objectives
                : objectives // ignore: cast_nullable_to_non_nullable
                      as String?,
            expectedOutcomes: freezed == expectedOutcomes
                ? _value.expectedOutcomes
                : expectedOutcomes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$SimulationScenarioImplCopyWith<$Res>
    implements $SimulationScenarioCopyWith<$Res> {
  factory _$$SimulationScenarioImplCopyWith(
    _$SimulationScenarioImpl value,
    $Res Function(_$SimulationScenarioImpl) then,
  ) = __$$SimulationScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    List<String>? relatedTechniques,
    String? objectives,
    String? expectedOutcomes,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$SimulationScenarioImplCopyWithImpl<$Res>
    extends _$SimulationScenarioCopyWithImpl<$Res, _$SimulationScenarioImpl>
    implements _$$SimulationScenarioImplCopyWith<$Res> {
  __$$SimulationScenarioImplCopyWithImpl(
    _$SimulationScenarioImpl _value,
    $Res Function(_$SimulationScenarioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? relatedTechniques = freezed,
    Object? objectives = freezed,
    Object? expectedOutcomes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SimulationScenarioImpl(
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
        relatedTechniques: freezed == relatedTechniques
            ? _value._relatedTechniques
            : relatedTechniques // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        objectives: freezed == objectives
            ? _value.objectives
            : objectives // ignore: cast_nullable_to_non_nullable
                  as String?,
        expectedOutcomes: freezed == expectedOutcomes
            ? _value.expectedOutcomes
            : expectedOutcomes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$SimulationScenarioImpl implements _SimulationScenario {
  const _$SimulationScenarioImpl({
    required this.id,
    required this.name,
    required this.description,
    final List<String>? relatedTechniques,
    this.objectives,
    this.expectedOutcomes,
    this.createdAt,
  }) : _relatedTechniques = relatedTechniques;

  factory _$SimulationScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationScenarioImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<String>? _relatedTechniques;
  @override
  List<String>? get relatedTechniques {
    final value = _relatedTechniques;
    if (value == null) return null;
    if (_relatedTechniques is EqualUnmodifiableListView)
      return _relatedTechniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? objectives;
  @override
  final String? expectedOutcomes;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SimulationScenario(id: $id, name: $name, description: $description, relatedTechniques: $relatedTechniques, objectives: $objectives, expectedOutcomes: $expectedOutcomes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationScenarioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._relatedTechniques,
              _relatedTechniques,
            ) &&
            (identical(other.objectives, objectives) ||
                other.objectives == objectives) &&
            (identical(other.expectedOutcomes, expectedOutcomes) ||
                other.expectedOutcomes == expectedOutcomes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_relatedTechniques),
    objectives,
    expectedOutcomes,
    createdAt,
  );

  /// Create a copy of SimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationScenarioImplCopyWith<_$SimulationScenarioImpl> get copyWith =>
      __$$SimulationScenarioImplCopyWithImpl<_$SimulationScenarioImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationScenarioImplToJson(this);
  }
}

abstract class _SimulationScenario implements SimulationScenario {
  const factory _SimulationScenario({
    required final String id,
    required final String name,
    required final String description,
    final List<String>? relatedTechniques,
    final String? objectives,
    final String? expectedOutcomes,
    final DateTime? createdAt,
  }) = _$SimulationScenarioImpl;

  factory _SimulationScenario.fromJson(Map<String, dynamic> json) =
      _$SimulationScenarioImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String>? get relatedTechniques;
  @override
  String? get objectives;
  @override
  String? get expectedOutcomes;
  @override
  DateTime? get createdAt;

  /// Create a copy of SimulationScenario
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationScenarioImplCopyWith<_$SimulationScenarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
