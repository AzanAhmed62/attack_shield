// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technique_detection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TechniqueDetection _$TechniqueDetectionFromJson(Map<String, dynamic> json) {
  return _TechniqueDetection.fromJson(json);
}

/// @nodoc
mixin _$TechniqueDetection {
  String get id => throw _privateConstructorUsedError;
  String get techniqueId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get datasource => throw _privateConstructorUsedError;

  /// Serializes this TechniqueDetection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TechniqueDetectionCopyWith<TechniqueDetection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechniqueDetectionCopyWith<$Res> {
  factory $TechniqueDetectionCopyWith(
    TechniqueDetection value,
    $Res Function(TechniqueDetection) then,
  ) = _$TechniqueDetectionCopyWithImpl<$Res, TechniqueDetection>;
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String description,
    String? source,
    String? datasource,
  });
}

/// @nodoc
class _$TechniqueDetectionCopyWithImpl<$Res, $Val extends TechniqueDetection>
    implements $TechniqueDetectionCopyWith<$Res> {
  _$TechniqueDetectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? description = null,
    Object? source = freezed,
    Object? datasource = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            datasource: freezed == datasource
                ? _value.datasource
                : datasource // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TechniqueDetectionImplCopyWith<$Res>
    implements $TechniqueDetectionCopyWith<$Res> {
  factory _$$TechniqueDetectionImplCopyWith(
    _$TechniqueDetectionImpl value,
    $Res Function(_$TechniqueDetectionImpl) then,
  ) = __$$TechniqueDetectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String techniqueId,
    String description,
    String? source,
    String? datasource,
  });
}

/// @nodoc
class __$$TechniqueDetectionImplCopyWithImpl<$Res>
    extends _$TechniqueDetectionCopyWithImpl<$Res, _$TechniqueDetectionImpl>
    implements _$$TechniqueDetectionImplCopyWith<$Res> {
  __$$TechniqueDetectionImplCopyWithImpl(
    _$TechniqueDetectionImpl _value,
    $Res Function(_$TechniqueDetectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? techniqueId = null,
    Object? description = null,
    Object? source = freezed,
    Object? datasource = freezed,
  }) {
    return _then(
      _$TechniqueDetectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        datasource: freezed == datasource
            ? _value.datasource
            : datasource // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TechniqueDetectionImpl implements _TechniqueDetection {
  const _$TechniqueDetectionImpl({
    required this.id,
    required this.techniqueId,
    required this.description,
    this.source,
    this.datasource,
  });

  factory _$TechniqueDetectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechniqueDetectionImplFromJson(json);

  @override
  final String id;
  @override
  final String techniqueId;
  @override
  final String description;
  @override
  final String? source;
  @override
  final String? datasource;

  @override
  String toString() {
    return 'TechniqueDetection(id: $id, techniqueId: $techniqueId, description: $description, source: $source, datasource: $datasource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechniqueDetectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.datasource, datasource) ||
                other.datasource == datasource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    techniqueId,
    description,
    source,
    datasource,
  );

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TechniqueDetectionImplCopyWith<_$TechniqueDetectionImpl> get copyWith =>
      __$$TechniqueDetectionImplCopyWithImpl<_$TechniqueDetectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TechniqueDetectionImplToJson(this);
  }
}

abstract class _TechniqueDetection implements TechniqueDetection {
  const factory _TechniqueDetection({
    required final String id,
    required final String techniqueId,
    required final String description,
    final String? source,
    final String? datasource,
  }) = _$TechniqueDetectionImpl;

  factory _TechniqueDetection.fromJson(Map<String, dynamic> json) =
      _$TechniqueDetectionImpl.fromJson;

  @override
  String get id;
  @override
  String get techniqueId;
  @override
  String get description;
  @override
  String? get source;
  @override
  String? get datasource;

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TechniqueDetectionImplCopyWith<_$TechniqueDetectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
