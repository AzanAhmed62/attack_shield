// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technique_mitigation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TechniqueMitigation _$TechniqueMitigationFromJson(Map<String, dynamic> json) {
  return _TechniqueMitigation.fromJson(json);
}

/// @nodoc
mixin _$TechniqueMitigation {
  String get id => throw _privateConstructorUsedError;
  String get techniqueId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get mitreId => throw _privateConstructorUsedError; // e.g. 'M1017'
  List<String> get controlFrameworks => throw _privateConstructorUsedError;

  /// Serializes this TechniqueMitigation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TechniqueMitigation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TechniqueMitigationCopyWith<TechniqueMitigation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechniqueMitigationCopyWith<$Res> {
  factory $TechniqueMitigationCopyWith(
    TechniqueMitigation value,
    $Res Function(TechniqueMitigation) then,
  ) = _$TechniqueMitigationCopyWithImpl<$Res, TechniqueMitigation>;
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String name,
    String description,
    String? mitreId,
    List<String> controlFrameworks,
  });
}

/// @nodoc
class _$TechniqueMitigationCopyWithImpl<$Res, $Val extends TechniqueMitigation>
    implements $TechniqueMitigationCopyWith<$Res> {
  _$TechniqueMitigationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TechniqueMitigation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? name = null,
    Object? description = null,
    Object? mitreId = freezed,
    Object? controlFrameworks = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            mitreId: freezed == mitreId
                ? _value.mitreId
                : mitreId // ignore: cast_nullable_to_non_nullable
                      as String?,
            controlFrameworks: null == controlFrameworks
                ? _value.controlFrameworks
                : controlFrameworks // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TechniqueMitigationImplCopyWith<$Res>
    implements $TechniqueMitigationCopyWith<$Res> {
  factory _$$TechniqueMitigationImplCopyWith(
    _$TechniqueMitigationImpl value,
    $Res Function(_$TechniqueMitigationImpl) then,
  ) = __$$TechniqueMitigationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String name,
    String description,
    String? mitreId,
    List<String> controlFrameworks,
  });
}

/// @nodoc
class __$$TechniqueMitigationImplCopyWithImpl<$Res>
    extends _$TechniqueMitigationCopyWithImpl<$Res, _$TechniqueMitigationImpl>
    implements _$$TechniqueMitigationImplCopyWith<$Res> {
  __$$TechniqueMitigationImplCopyWithImpl(
    _$TechniqueMitigationImpl _value,
    $Res Function(_$TechniqueMitigationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TechniqueMitigation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? name = null,
    Object? description = null,
    Object? mitreId = freezed,
    Object? controlFrameworks = null,
  }) {
    return _then(
      _$TechniqueMitigationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        mitreId: freezed == mitreId
            ? _value.mitreId
            : mitreId // ignore: cast_nullable_to_non_nullable
                  as String?,
        controlFrameworks: null == controlFrameworks
            ? _value._controlFrameworks
            : controlFrameworks // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TechniqueMitigationImpl implements _TechniqueMitigation {
  const _$TechniqueMitigationImpl({
    required this.id,
    required this.techniqueId,
    required this.name,
    this.description = '',
    this.mitreId,
    final List<String> controlFrameworks = const [],
  }) : _controlFrameworks = controlFrameworks;

  factory _$TechniqueMitigationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechniqueMitigationImplFromJson(json);

  @override
  final String id;
  @override
  final String techniqueId;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final String? mitreId;
  // e.g. 'M1017'
  final List<String> _controlFrameworks;
  // e.g. 'M1017'
  @override
  @JsonKey()
  List<String> get controlFrameworks {
    if (_controlFrameworks is EqualUnmodifiableListView)
      return _controlFrameworks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_controlFrameworks);
  }

  @override
  String toString() {
    return 'TechniqueMitigation(id: $id, techniqueId: $techniqueId, name: $name, description: $description, mitreId: $mitreId, controlFrameworks: $controlFrameworks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechniqueMitigationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.mitreId, mitreId) || other.mitreId == mitreId) &&
            const DeepCollectionEquality().equals(
              other._controlFrameworks,
              _controlFrameworks,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    techniqueId,
    name,
    description,
    mitreId,
    const DeepCollectionEquality().hash(_controlFrameworks),
  );

  /// Create a copy of TechniqueMitigation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TechniqueMitigationImplCopyWith<_$TechniqueMitigationImpl> get copyWith =>
      __$$TechniqueMitigationImplCopyWithImpl<_$TechniqueMitigationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TechniqueMitigationImplToJson(this);
  }
}

abstract class _TechniqueMitigation implements TechniqueMitigation {
  const factory _TechniqueMitigation({
    required final String id,
    required final String techniqueId,
    required final String name,
    final String description,
    final String? mitreId,
    final List<String> controlFrameworks,
  }) = _$TechniqueMitigationImpl;

  factory _TechniqueMitigation.fromJson(Map<String, dynamic> json) =
      _$TechniqueMitigationImpl.fromJson;

  @override
  String get id;
  @override
  String get techniqueId;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get mitreId; // e.g. 'M1017'
  @override
  List<String> get controlFrameworks;

  /// Create a copy of TechniqueMitigation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TechniqueMitigationImplCopyWith<_$TechniqueMitigationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
