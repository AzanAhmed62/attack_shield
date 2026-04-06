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
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get dataSourcesRequired => throw _privateConstructorUsedError;
  List<String> get toolsRecommended => throw _privateConstructorUsedError;

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
    String name,
    String description,
    List<String> dataSourcesRequired,
    List<String> toolsRecommended,
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
    Object? name = null,
    Object? description = null,
    Object? dataSourcesRequired = null,
    Object? toolsRecommended = null,
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
            dataSourcesRequired: null == dataSourcesRequired
                ? _value.dataSourcesRequired
                : dataSourcesRequired // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            toolsRecommended: null == toolsRecommended
                ? _value.toolsRecommended
                : toolsRecommended // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
    String name,
    String description,
    List<String> dataSourcesRequired,
    List<String> toolsRecommended,
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
    Object? name = null,
    Object? description = null,
    Object? dataSourcesRequired = null,
    Object? toolsRecommended = null,
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
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        dataSourcesRequired: null == dataSourcesRequired
            ? _value._dataSourcesRequired
            : dataSourcesRequired // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        toolsRecommended: null == toolsRecommended
            ? _value._toolsRecommended
            : toolsRecommended // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
    required this.name,
    this.description = '',
    final List<String> dataSourcesRequired = const [],
    final List<String> toolsRecommended = const [],
  }) : _dataSourcesRequired = dataSourcesRequired,
       _toolsRecommended = toolsRecommended;

  factory _$TechniqueDetectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechniqueDetectionImplFromJson(json);

  @override
  final String id;
  @override
  final String techniqueId;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  final List<String> _dataSourcesRequired;
  @override
  @JsonKey()
  List<String> get dataSourcesRequired {
    if (_dataSourcesRequired is EqualUnmodifiableListView)
      return _dataSourcesRequired;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataSourcesRequired);
  }

  final List<String> _toolsRecommended;
  @override
  @JsonKey()
  List<String> get toolsRecommended {
    if (_toolsRecommended is EqualUnmodifiableListView)
      return _toolsRecommended;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toolsRecommended);
  }

  @override
  String toString() {
    return 'TechniqueDetection(id: $id, techniqueId: $techniqueId, name: $name, description: $description, dataSourcesRequired: $dataSourcesRequired, toolsRecommended: $toolsRecommended)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechniqueDetectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._dataSourcesRequired,
              _dataSourcesRequired,
            ) &&
            const DeepCollectionEquality().equals(
              other._toolsRecommended,
              _toolsRecommended,
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
    const DeepCollectionEquality().hash(_dataSourcesRequired),
    const DeepCollectionEquality().hash(_toolsRecommended),
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
    required final String name,
    final String description,
    final List<String> dataSourcesRequired,
    final List<String> toolsRecommended,
  }) = _$TechniqueDetectionImpl;

  factory _TechniqueDetection.fromJson(Map<String, dynamic> json) =
      _$TechniqueDetectionImpl.fromJson;

  @override
  String get id;
  @override
  String get techniqueId;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get dataSourcesRequired;
  @override
  List<String> get toolsRecommended;

  /// Create a copy of TechniqueDetection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TechniqueDetectionImplCopyWith<_$TechniqueDetectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
