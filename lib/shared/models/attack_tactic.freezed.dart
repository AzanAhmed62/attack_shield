// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attack_tactic.dart';

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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
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
    required this.description,
    final List<String> techniqueIds = const [],
  }) : _techniqueIds = techniqueIds;

  factory _$AttackTacticImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackTacticImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
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
    return 'AttackTactic(id: $id, name: $name, description: $description, techniqueIds: $techniqueIds)';
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
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
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
    required final String description,
    final List<String> techniqueIds,
  }) = _$AttackTacticImpl;

  factory _AttackTactic.fromJson(Map<String, dynamic> json) =
      _$AttackTacticImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
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
