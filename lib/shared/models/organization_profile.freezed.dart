// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrganizationProfile _$OrganizationProfileFromJson(Map<String, dynamic> json) {
  return _OrganizationProfile.fromJson(json);
}

/// @nodoc
mixin _$OrganizationProfile {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description =>
      throw _privateConstructorUsedError; // Use-case context from onboarding
  String get context =>
      throw _privateConstructorUsedError; // 'Personal Learning' | 'Lab' | 'Organization'
  // New: structured profile fields
  OrgSector get sector => throw _privateConstructorUsedError;
  OrgSize get orgSize => throw _privateConstructorUsedError;
  List<String> get techStack =>
      throw _privateConstructorUsedError; // TechStackItem.name values
  List<String> get currentControls =>
      throw _privateConstructorUsedError; // SecurityControl.name values
  // Legacy fields kept for compatibility
  List<String> get preferredSectors => throw _privateConstructorUsedError;
  List<String> get preferredPlatforms => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastModified => throw _privateConstructorUsedError;

  /// Serializes this OrganizationProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationProfileCopyWith<OrganizationProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationProfileCopyWith<$Res> {
  factory $OrganizationProfileCopyWith(
    OrganizationProfile value,
    $Res Function(OrganizationProfile) then,
  ) = _$OrganizationProfileCopyWithImpl<$Res, OrganizationProfile>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String context,
    OrgSector sector,
    OrgSize orgSize,
    List<String> techStack,
    List<String> currentControls,
    List<String> preferredSectors,
    List<String> preferredPlatforms,
    DateTime createdAt,
    DateTime lastModified,
  });
}

/// @nodoc
class _$OrganizationProfileCopyWithImpl<$Res, $Val extends OrganizationProfile>
    implements $OrganizationProfileCopyWith<$Res> {
  _$OrganizationProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? context = null,
    Object? sector = null,
    Object? orgSize = null,
    Object? techStack = null,
    Object? currentControls = null,
    Object? preferredSectors = null,
    Object? preferredPlatforms = null,
    Object? createdAt = null,
    Object? lastModified = null,
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
            context: null == context
                ? _value.context
                : context // ignore: cast_nullable_to_non_nullable
                      as String,
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as OrgSector,
            orgSize: null == orgSize
                ? _value.orgSize
                : orgSize // ignore: cast_nullable_to_non_nullable
                      as OrgSize,
            techStack: null == techStack
                ? _value.techStack
                : techStack // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            currentControls: null == currentControls
                ? _value.currentControls
                : currentControls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            preferredSectors: null == preferredSectors
                ? _value.preferredSectors
                : preferredSectors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            preferredPlatforms: null == preferredPlatforms
                ? _value.preferredPlatforms
                : preferredPlatforms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastModified: null == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationProfileImplCopyWith<$Res>
    implements $OrganizationProfileCopyWith<$Res> {
  factory _$$OrganizationProfileImplCopyWith(
    _$OrganizationProfileImpl value,
    $Res Function(_$OrganizationProfileImpl) then,
  ) = __$$OrganizationProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String context,
    OrgSector sector,
    OrgSize orgSize,
    List<String> techStack,
    List<String> currentControls,
    List<String> preferredSectors,
    List<String> preferredPlatforms,
    DateTime createdAt,
    DateTime lastModified,
  });
}

/// @nodoc
class __$$OrganizationProfileImplCopyWithImpl<$Res>
    extends _$OrganizationProfileCopyWithImpl<$Res, _$OrganizationProfileImpl>
    implements _$$OrganizationProfileImplCopyWith<$Res> {
  __$$OrganizationProfileImplCopyWithImpl(
    _$OrganizationProfileImpl _value,
    $Res Function(_$OrganizationProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrganizationProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? context = null,
    Object? sector = null,
    Object? orgSize = null,
    Object? techStack = null,
    Object? currentControls = null,
    Object? preferredSectors = null,
    Object? preferredPlatforms = null,
    Object? createdAt = null,
    Object? lastModified = null,
  }) {
    return _then(
      _$OrganizationProfileImpl(
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
        context: null == context
            ? _value.context
            : context // ignore: cast_nullable_to_non_nullable
                  as String,
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as OrgSector,
        orgSize: null == orgSize
            ? _value.orgSize
            : orgSize // ignore: cast_nullable_to_non_nullable
                  as OrgSize,
        techStack: null == techStack
            ? _value._techStack
            : techStack // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        currentControls: null == currentControls
            ? _value._currentControls
            : currentControls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        preferredSectors: null == preferredSectors
            ? _value._preferredSectors
            : preferredSectors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        preferredPlatforms: null == preferredPlatforms
            ? _value._preferredPlatforms
            : preferredPlatforms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastModified: null == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationProfileImpl implements _OrganizationProfile {
  const _$OrganizationProfileImpl({
    required this.id,
    required this.name,
    this.description = '',
    this.context = 'Organization',
    this.sector = OrgSector.sme,
    this.orgSize = OrgSize.small,
    final List<String> techStack = const [],
    final List<String> currentControls = const [],
    final List<String> preferredSectors = const [],
    final List<String> preferredPlatforms = const [],
    required this.createdAt,
    required this.lastModified,
  }) : _techStack = techStack,
       _currentControls = currentControls,
       _preferredSectors = preferredSectors,
       _preferredPlatforms = preferredPlatforms;

  factory _$OrganizationProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  // Use-case context from onboarding
  @override
  @JsonKey()
  final String context;
  // 'Personal Learning' | 'Lab' | 'Organization'
  // New: structured profile fields
  @override
  @JsonKey()
  final OrgSector sector;
  @override
  @JsonKey()
  final OrgSize orgSize;
  final List<String> _techStack;
  @override
  @JsonKey()
  List<String> get techStack {
    if (_techStack is EqualUnmodifiableListView) return _techStack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techStack);
  }

  // TechStackItem.name values
  final List<String> _currentControls;
  // TechStackItem.name values
  @override
  @JsonKey()
  List<String> get currentControls {
    if (_currentControls is EqualUnmodifiableListView) return _currentControls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentControls);
  }

  // SecurityControl.name values
  // Legacy fields kept for compatibility
  final List<String> _preferredSectors;
  // SecurityControl.name values
  // Legacy fields kept for compatibility
  @override
  @JsonKey()
  List<String> get preferredSectors {
    if (_preferredSectors is EqualUnmodifiableListView)
      return _preferredSectors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredSectors);
  }

  final List<String> _preferredPlatforms;
  @override
  @JsonKey()
  List<String> get preferredPlatforms {
    if (_preferredPlatforms is EqualUnmodifiableListView)
      return _preferredPlatforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredPlatforms);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime lastModified;

  @override
  String toString() {
    return 'OrganizationProfile(id: $id, name: $name, description: $description, context: $context, sector: $sector, orgSize: $orgSize, techStack: $techStack, currentControls: $currentControls, preferredSectors: $preferredSectors, preferredPlatforms: $preferredPlatforms, createdAt: $createdAt, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.orgSize, orgSize) || other.orgSize == orgSize) &&
            const DeepCollectionEquality().equals(
              other._techStack,
              _techStack,
            ) &&
            const DeepCollectionEquality().equals(
              other._currentControls,
              _currentControls,
            ) &&
            const DeepCollectionEquality().equals(
              other._preferredSectors,
              _preferredSectors,
            ) &&
            const DeepCollectionEquality().equals(
              other._preferredPlatforms,
              _preferredPlatforms,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    context,
    sector,
    orgSize,
    const DeepCollectionEquality().hash(_techStack),
    const DeepCollectionEquality().hash(_currentControls),
    const DeepCollectionEquality().hash(_preferredSectors),
    const DeepCollectionEquality().hash(_preferredPlatforms),
    createdAt,
    lastModified,
  );

  /// Create a copy of OrganizationProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationProfileImplCopyWith<_$OrganizationProfileImpl> get copyWith =>
      __$$OrganizationProfileImplCopyWithImpl<_$OrganizationProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationProfileImplToJson(this);
  }
}

abstract class _OrganizationProfile implements OrganizationProfile {
  const factory _OrganizationProfile({
    required final String id,
    required final String name,
    final String description,
    final String context,
    final OrgSector sector,
    final OrgSize orgSize,
    final List<String> techStack,
    final List<String> currentControls,
    final List<String> preferredSectors,
    final List<String> preferredPlatforms,
    required final DateTime createdAt,
    required final DateTime lastModified,
  }) = _$OrganizationProfileImpl;

  factory _OrganizationProfile.fromJson(Map<String, dynamic> json) =
      _$OrganizationProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description; // Use-case context from onboarding
  @override
  String get context; // 'Personal Learning' | 'Lab' | 'Organization'
  // New: structured profile fields
  @override
  OrgSector get sector;
  @override
  OrgSize get orgSize;
  @override
  List<String> get techStack; // TechStackItem.name values
  @override
  List<String> get currentControls; // SecurityControl.name values
  // Legacy fields kept for compatibility
  @override
  List<String> get preferredSectors;
  @override
  List<String> get preferredPlatforms;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastModified;

  /// Create a copy of OrganizationProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationProfileImplCopyWith<_$OrganizationProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
