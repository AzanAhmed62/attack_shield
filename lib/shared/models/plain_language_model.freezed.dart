// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plain_language_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlainLanguageMapping _$PlainLanguageMappingFromJson(Map<String, dynamic> json) {
  return _PlainLanguageMapping.fromJson(json);
}

/// @nodoc
mixin _$PlainLanguageMapping {
  /// Professional ATT&CK technique ID (e.g., "T1110", "T1566.001")
  String get techniqueId => throw _privateConstructorUsedError;

  /// Simple, non-technical name for the attack
  /// Examples:
  /// - "Someone Tries Many Passwords to Get In" (T1110)
  /// - "Fake Emails That Trick You Into Clicking" (T1566)
  /// - "Malware That Locks Your Files For Ransom" (T1486)
  String get plainName => throw _privateConstructorUsedError;

  /// Real-world scenario non-technical user can relate to
  /// Should be 1-2 sentences describing how this attack happens to regular people
  /// Example for T1110:
  /// "An attacker uses a list of stolen passwords or automatically tries millions
  /// of password combinations until they guess yours."
  String get realWorldScenario => throw _privateConstructorUsedError;

  /// How easy is this for attackers to do?
  /// Values: "Easy to Do", "Moderate", "Difficult", "Highly Difficult"
  String get dangerLevel => throw _privateConstructorUsedError;

  /// Who is typically targeted by this attack?
  /// Example: "All businesses, but especially banks and email users"
  String get targetedTypes => throw _privateConstructorUsedError;

  /// What signs would you notice if this happened to you?
  /// Should be 2-3 observable signs, in plain language
  /// Example for T1110: "Strange logins from new devices, account locked, emails sent from your account"
  String get howYouWouldKnow => throw _privateConstructorUsedError;

  /// The single most important action to take RIGHT NOW
  /// Should be actionable and understandable by non-technical person
  /// Example: "Turn on two-factor authentication (2FA) for your important accounts"
  String get singleActionToTake => throw _privateConstructorUsedError;

  /// Icon/emoji for visual recognition in plain language mode
  /// Examples: 🔒, 🔑, ⚠️, 🚨, 💻, 📧, 🔓, 🛡️
  String get icon => throw _privateConstructorUsedError;

  /// Hex color for this technique in plain language mode
  /// Examples: "#FF6B6B" (red/danger), "#FFA500" (orange/warning), "#4CAF50" (green/safe)
  String get color => throw _privateConstructorUsedError;

  /// Industry-specific notes (if this threat is particularly relevant to certain sectors)
  /// Example for T1486 in Healthcare: "Ransomware is the #1 threat to hospitals"
  String get industryNotes => throw _privateConstructorUsedError;

  /// Serializes this PlainLanguageMapping to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlainLanguageMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlainLanguageMappingCopyWith<PlainLanguageMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlainLanguageMappingCopyWith<$Res> {
  factory $PlainLanguageMappingCopyWith(
    PlainLanguageMapping value,
    $Res Function(PlainLanguageMapping) then,
  ) = _$PlainLanguageMappingCopyWithImpl<$Res, PlainLanguageMapping>;
  @useResult
  $Res call({
    String techniqueId,
    String plainName,
    String realWorldScenario,
    String dangerLevel,
    String targetedTypes,
    String howYouWouldKnow,
    String singleActionToTake,
    String icon,
    String color,
    String industryNotes,
  });
}

/// @nodoc
class _$PlainLanguageMappingCopyWithImpl<
  $Res,
  $Val extends PlainLanguageMapping
>
    implements $PlainLanguageMappingCopyWith<$Res> {
  _$PlainLanguageMappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlainLanguageMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? plainName = null,
    Object? realWorldScenario = null,
    Object? dangerLevel = null,
    Object? targetedTypes = null,
    Object? howYouWouldKnow = null,
    Object? singleActionToTake = null,
    Object? icon = null,
    Object? color = null,
    Object? industryNotes = null,
  }) {
    return _then(
      _value.copyWith(
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            plainName: null == plainName
                ? _value.plainName
                : plainName // ignore: cast_nullable_to_non_nullable
                      as String,
            realWorldScenario: null == realWorldScenario
                ? _value.realWorldScenario
                : realWorldScenario // ignore: cast_nullable_to_non_nullable
                      as String,
            dangerLevel: null == dangerLevel
                ? _value.dangerLevel
                : dangerLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            targetedTypes: null == targetedTypes
                ? _value.targetedTypes
                : targetedTypes // ignore: cast_nullable_to_non_nullable
                      as String,
            howYouWouldKnow: null == howYouWouldKnow
                ? _value.howYouWouldKnow
                : howYouWouldKnow // ignore: cast_nullable_to_non_nullable
                      as String,
            singleActionToTake: null == singleActionToTake
                ? _value.singleActionToTake
                : singleActionToTake // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            industryNotes: null == industryNotes
                ? _value.industryNotes
                : industryNotes // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlainLanguageMappingImplCopyWith<$Res>
    implements $PlainLanguageMappingCopyWith<$Res> {
  factory _$$PlainLanguageMappingImplCopyWith(
    _$PlainLanguageMappingImpl value,
    $Res Function(_$PlainLanguageMappingImpl) then,
  ) = __$$PlainLanguageMappingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String techniqueId,
    String plainName,
    String realWorldScenario,
    String dangerLevel,
    String targetedTypes,
    String howYouWouldKnow,
    String singleActionToTake,
    String icon,
    String color,
    String industryNotes,
  });
}

/// @nodoc
class __$$PlainLanguageMappingImplCopyWithImpl<$Res>
    extends _$PlainLanguageMappingCopyWithImpl<$Res, _$PlainLanguageMappingImpl>
    implements _$$PlainLanguageMappingImplCopyWith<$Res> {
  __$$PlainLanguageMappingImplCopyWithImpl(
    _$PlainLanguageMappingImpl _value,
    $Res Function(_$PlainLanguageMappingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlainLanguageMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? plainName = null,
    Object? realWorldScenario = null,
    Object? dangerLevel = null,
    Object? targetedTypes = null,
    Object? howYouWouldKnow = null,
    Object? singleActionToTake = null,
    Object? icon = null,
    Object? color = null,
    Object? industryNotes = null,
  }) {
    return _then(
      _$PlainLanguageMappingImpl(
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        plainName: null == plainName
            ? _value.plainName
            : plainName // ignore: cast_nullable_to_non_nullable
                  as String,
        realWorldScenario: null == realWorldScenario
            ? _value.realWorldScenario
            : realWorldScenario // ignore: cast_nullable_to_non_nullable
                  as String,
        dangerLevel: null == dangerLevel
            ? _value.dangerLevel
            : dangerLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        targetedTypes: null == targetedTypes
            ? _value.targetedTypes
            : targetedTypes // ignore: cast_nullable_to_non_nullable
                  as String,
        howYouWouldKnow: null == howYouWouldKnow
            ? _value.howYouWouldKnow
            : howYouWouldKnow // ignore: cast_nullable_to_non_nullable
                  as String,
        singleActionToTake: null == singleActionToTake
            ? _value.singleActionToTake
            : singleActionToTake // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        industryNotes: null == industryNotes
            ? _value.industryNotes
            : industryNotes // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlainLanguageMappingImpl implements _PlainLanguageMapping {
  const _$PlainLanguageMappingImpl({
    required this.techniqueId,
    required this.plainName,
    required this.realWorldScenario,
    required this.dangerLevel,
    required this.targetedTypes,
    required this.howYouWouldKnow,
    required this.singleActionToTake,
    required this.icon,
    required this.color,
    this.industryNotes = '',
  });

  factory _$PlainLanguageMappingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlainLanguageMappingImplFromJson(json);

  /// Professional ATT&CK technique ID (e.g., "T1110", "T1566.001")
  @override
  final String techniqueId;

  /// Simple, non-technical name for the attack
  /// Examples:
  /// - "Someone Tries Many Passwords to Get In" (T1110)
  /// - "Fake Emails That Trick You Into Clicking" (T1566)
  /// - "Malware That Locks Your Files For Ransom" (T1486)
  @override
  final String plainName;

  /// Real-world scenario non-technical user can relate to
  /// Should be 1-2 sentences describing how this attack happens to regular people
  /// Example for T1110:
  /// "An attacker uses a list of stolen passwords or automatically tries millions
  /// of password combinations until they guess yours."
  @override
  final String realWorldScenario;

  /// How easy is this for attackers to do?
  /// Values: "Easy to Do", "Moderate", "Difficult", "Highly Difficult"
  @override
  final String dangerLevel;

  /// Who is typically targeted by this attack?
  /// Example: "All businesses, but especially banks and email users"
  @override
  final String targetedTypes;

  /// What signs would you notice if this happened to you?
  /// Should be 2-3 observable signs, in plain language
  /// Example for T1110: "Strange logins from new devices, account locked, emails sent from your account"
  @override
  final String howYouWouldKnow;

  /// The single most important action to take RIGHT NOW
  /// Should be actionable and understandable by non-technical person
  /// Example: "Turn on two-factor authentication (2FA) for your important accounts"
  @override
  final String singleActionToTake;

  /// Icon/emoji for visual recognition in plain language mode
  /// Examples: 🔒, 🔑, ⚠️, 🚨, 💻, 📧, 🔓, 🛡️
  @override
  final String icon;

  /// Hex color for this technique in plain language mode
  /// Examples: "#FF6B6B" (red/danger), "#FFA500" (orange/warning), "#4CAF50" (green/safe)
  @override
  final String color;

  /// Industry-specific notes (if this threat is particularly relevant to certain sectors)
  /// Example for T1486 in Healthcare: "Ransomware is the #1 threat to hospitals"
  @override
  @JsonKey()
  final String industryNotes;

  @override
  String toString() {
    return 'PlainLanguageMapping(techniqueId: $techniqueId, plainName: $plainName, realWorldScenario: $realWorldScenario, dangerLevel: $dangerLevel, targetedTypes: $targetedTypes, howYouWouldKnow: $howYouWouldKnow, singleActionToTake: $singleActionToTake, icon: $icon, color: $color, industryNotes: $industryNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlainLanguageMappingImpl &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.plainName, plainName) ||
                other.plainName == plainName) &&
            (identical(other.realWorldScenario, realWorldScenario) ||
                other.realWorldScenario == realWorldScenario) &&
            (identical(other.dangerLevel, dangerLevel) ||
                other.dangerLevel == dangerLevel) &&
            (identical(other.targetedTypes, targetedTypes) ||
                other.targetedTypes == targetedTypes) &&
            (identical(other.howYouWouldKnow, howYouWouldKnow) ||
                other.howYouWouldKnow == howYouWouldKnow) &&
            (identical(other.singleActionToTake, singleActionToTake) ||
                other.singleActionToTake == singleActionToTake) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.industryNotes, industryNotes) ||
                other.industryNotes == industryNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    techniqueId,
    plainName,
    realWorldScenario,
    dangerLevel,
    targetedTypes,
    howYouWouldKnow,
    singleActionToTake,
    icon,
    color,
    industryNotes,
  );

  /// Create a copy of PlainLanguageMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlainLanguageMappingImplCopyWith<_$PlainLanguageMappingImpl>
  get copyWith =>
      __$$PlainLanguageMappingImplCopyWithImpl<_$PlainLanguageMappingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlainLanguageMappingImplToJson(this);
  }
}

abstract class _PlainLanguageMapping implements PlainLanguageMapping {
  const factory _PlainLanguageMapping({
    required final String techniqueId,
    required final String plainName,
    required final String realWorldScenario,
    required final String dangerLevel,
    required final String targetedTypes,
    required final String howYouWouldKnow,
    required final String singleActionToTake,
    required final String icon,
    required final String color,
    final String industryNotes,
  }) = _$PlainLanguageMappingImpl;

  factory _PlainLanguageMapping.fromJson(Map<String, dynamic> json) =
      _$PlainLanguageMappingImpl.fromJson;

  /// Professional ATT&CK technique ID (e.g., "T1110", "T1566.001")
  @override
  String get techniqueId;

  /// Simple, non-technical name for the attack
  /// Examples:
  /// - "Someone Tries Many Passwords to Get In" (T1110)
  /// - "Fake Emails That Trick You Into Clicking" (T1566)
  /// - "Malware That Locks Your Files For Ransom" (T1486)
  @override
  String get plainName;

  /// Real-world scenario non-technical user can relate to
  /// Should be 1-2 sentences describing how this attack happens to regular people
  /// Example for T1110:
  /// "An attacker uses a list of stolen passwords or automatically tries millions
  /// of password combinations until they guess yours."
  @override
  String get realWorldScenario;

  /// How easy is this for attackers to do?
  /// Values: "Easy to Do", "Moderate", "Difficult", "Highly Difficult"
  @override
  String get dangerLevel;

  /// Who is typically targeted by this attack?
  /// Example: "All businesses, but especially banks and email users"
  @override
  String get targetedTypes;

  /// What signs would you notice if this happened to you?
  /// Should be 2-3 observable signs, in plain language
  /// Example for T1110: "Strange logins from new devices, account locked, emails sent from your account"
  @override
  String get howYouWouldKnow;

  /// The single most important action to take RIGHT NOW
  /// Should be actionable and understandable by non-technical person
  /// Example: "Turn on two-factor authentication (2FA) for your important accounts"
  @override
  String get singleActionToTake;

  /// Icon/emoji for visual recognition in plain language mode
  /// Examples: 🔒, 🔑, ⚠️, 🚨, 💻, 📧, 🔓, 🛡️
  @override
  String get icon;

  /// Hex color for this technique in plain language mode
  /// Examples: "#FF6B6B" (red/danger), "#FFA500" (orange/warning), "#4CAF50" (green/safe)
  @override
  String get color;

  /// Industry-specific notes (if this threat is particularly relevant to certain sectors)
  /// Example for T1486 in Healthcare: "Ransomware is the #1 threat to hospitals"
  @override
  String get industryNotes;

  /// Create a copy of PlainLanguageMapping
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlainLanguageMappingImplCopyWith<_$PlainLanguageMappingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PlainCoverageStatus _$PlainCoverageStatusFromJson(Map<String, dynamic> json) {
  return _PlainCoverageStatus.fromJson(json);
}

/// @nodoc
mixin _$PlainCoverageStatus {
  /// Original technical coverage level
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  String get technicalStatus => throw _privateConstructorUsedError;

  /// Plain English translation
  /// Examples: "Not Protected", "Some Protection", "Well Protected"
  String get plainStatus => throw _privateConstructorUsedError;

  /// Status emoji for quick visual understanding
  /// ❌ = Not Protected, ⚠️ = Some Protection, ✅ = Well Protected
  String get statusEmoji => throw _privateConstructorUsedError;

  /// What this coverage status means in plain English (1-2 sentences)
  /// Example for NotCovered: "You have no defense against this attack type. Attackers can attempt this without being stopped."
  String get plainMeaning => throw _privateConstructorUsedError;

  /// What to do about it (2-3 actionable steps)
  /// Example: "1. Install antivirus software 2. Enable firewall 3. Update your systems"
  String get suggestion => throw _privateConstructorUsedError;

  /// Severity if NOT protected (0-100)
  /// Used to highlight which gaps matter most
  int get urgencyScore => throw _privateConstructorUsedError;

  /// Serializes this PlainCoverageStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlainCoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlainCoverageStatusCopyWith<PlainCoverageStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlainCoverageStatusCopyWith<$Res> {
  factory $PlainCoverageStatusCopyWith(
    PlainCoverageStatus value,
    $Res Function(PlainCoverageStatus) then,
  ) = _$PlainCoverageStatusCopyWithImpl<$Res, PlainCoverageStatus>;
  @useResult
  $Res call({
    String technicalStatus,
    String plainStatus,
    String statusEmoji,
    String plainMeaning,
    String suggestion,
    int urgencyScore,
  });
}

/// @nodoc
class _$PlainCoverageStatusCopyWithImpl<$Res, $Val extends PlainCoverageStatus>
    implements $PlainCoverageStatusCopyWith<$Res> {
  _$PlainCoverageStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlainCoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? technicalStatus = null,
    Object? plainStatus = null,
    Object? statusEmoji = null,
    Object? plainMeaning = null,
    Object? suggestion = null,
    Object? urgencyScore = null,
  }) {
    return _then(
      _value.copyWith(
            technicalStatus: null == technicalStatus
                ? _value.technicalStatus
                : technicalStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            plainStatus: null == plainStatus
                ? _value.plainStatus
                : plainStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            statusEmoji: null == statusEmoji
                ? _value.statusEmoji
                : statusEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            plainMeaning: null == plainMeaning
                ? _value.plainMeaning
                : plainMeaning // ignore: cast_nullable_to_non_nullable
                      as String,
            suggestion: null == suggestion
                ? _value.suggestion
                : suggestion // ignore: cast_nullable_to_non_nullable
                      as String,
            urgencyScore: null == urgencyScore
                ? _value.urgencyScore
                : urgencyScore // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlainCoverageStatusImplCopyWith<$Res>
    implements $PlainCoverageStatusCopyWith<$Res> {
  factory _$$PlainCoverageStatusImplCopyWith(
    _$PlainCoverageStatusImpl value,
    $Res Function(_$PlainCoverageStatusImpl) then,
  ) = __$$PlainCoverageStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String technicalStatus,
    String plainStatus,
    String statusEmoji,
    String plainMeaning,
    String suggestion,
    int urgencyScore,
  });
}

/// @nodoc
class __$$PlainCoverageStatusImplCopyWithImpl<$Res>
    extends _$PlainCoverageStatusCopyWithImpl<$Res, _$PlainCoverageStatusImpl>
    implements _$$PlainCoverageStatusImplCopyWith<$Res> {
  __$$PlainCoverageStatusImplCopyWithImpl(
    _$PlainCoverageStatusImpl _value,
    $Res Function(_$PlainCoverageStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlainCoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? technicalStatus = null,
    Object? plainStatus = null,
    Object? statusEmoji = null,
    Object? plainMeaning = null,
    Object? suggestion = null,
    Object? urgencyScore = null,
  }) {
    return _then(
      _$PlainCoverageStatusImpl(
        technicalStatus: null == technicalStatus
            ? _value.technicalStatus
            : technicalStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        plainStatus: null == plainStatus
            ? _value.plainStatus
            : plainStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        statusEmoji: null == statusEmoji
            ? _value.statusEmoji
            : statusEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        plainMeaning: null == plainMeaning
            ? _value.plainMeaning
            : plainMeaning // ignore: cast_nullable_to_non_nullable
                  as String,
        suggestion: null == suggestion
            ? _value.suggestion
            : suggestion // ignore: cast_nullable_to_non_nullable
                  as String,
        urgencyScore: null == urgencyScore
            ? _value.urgencyScore
            : urgencyScore // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlainCoverageStatusImpl implements _PlainCoverageStatus {
  const _$PlainCoverageStatusImpl({
    required this.technicalStatus,
    required this.plainStatus,
    required this.statusEmoji,
    required this.plainMeaning,
    required this.suggestion,
    required this.urgencyScore,
  });

  factory _$PlainCoverageStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlainCoverageStatusImplFromJson(json);

  /// Original technical coverage level
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  @override
  final String technicalStatus;

  /// Plain English translation
  /// Examples: "Not Protected", "Some Protection", "Well Protected"
  @override
  final String plainStatus;

  /// Status emoji for quick visual understanding
  /// ❌ = Not Protected, ⚠️ = Some Protection, ✅ = Well Protected
  @override
  final String statusEmoji;

  /// What this coverage status means in plain English (1-2 sentences)
  /// Example for NotCovered: "You have no defense against this attack type. Attackers can attempt this without being stopped."
  @override
  final String plainMeaning;

  /// What to do about it (2-3 actionable steps)
  /// Example: "1. Install antivirus software 2. Enable firewall 3. Update your systems"
  @override
  final String suggestion;

  /// Severity if NOT protected (0-100)
  /// Used to highlight which gaps matter most
  @override
  final int urgencyScore;

  @override
  String toString() {
    return 'PlainCoverageStatus(technicalStatus: $technicalStatus, plainStatus: $plainStatus, statusEmoji: $statusEmoji, plainMeaning: $plainMeaning, suggestion: $suggestion, urgencyScore: $urgencyScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlainCoverageStatusImpl &&
            (identical(other.technicalStatus, technicalStatus) ||
                other.technicalStatus == technicalStatus) &&
            (identical(other.plainStatus, plainStatus) ||
                other.plainStatus == plainStatus) &&
            (identical(other.statusEmoji, statusEmoji) ||
                other.statusEmoji == statusEmoji) &&
            (identical(other.plainMeaning, plainMeaning) ||
                other.plainMeaning == plainMeaning) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion) &&
            (identical(other.urgencyScore, urgencyScore) ||
                other.urgencyScore == urgencyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    technicalStatus,
    plainStatus,
    statusEmoji,
    plainMeaning,
    suggestion,
    urgencyScore,
  );

  /// Create a copy of PlainCoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlainCoverageStatusImplCopyWith<_$PlainCoverageStatusImpl> get copyWith =>
      __$$PlainCoverageStatusImplCopyWithImpl<_$PlainCoverageStatusImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlainCoverageStatusImplToJson(this);
  }
}

abstract class _PlainCoverageStatus implements PlainCoverageStatus {
  const factory _PlainCoverageStatus({
    required final String technicalStatus,
    required final String plainStatus,
    required final String statusEmoji,
    required final String plainMeaning,
    required final String suggestion,
    required final int urgencyScore,
  }) = _$PlainCoverageStatusImpl;

  factory _PlainCoverageStatus.fromJson(Map<String, dynamic> json) =
      _$PlainCoverageStatusImpl.fromJson;

  /// Original technical coverage level
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  @override
  String get technicalStatus;

  /// Plain English translation
  /// Examples: "Not Protected", "Some Protection", "Well Protected"
  @override
  String get plainStatus;

  /// Status emoji for quick visual understanding
  /// ❌ = Not Protected, ⚠️ = Some Protection, ✅ = Well Protected
  @override
  String get statusEmoji;

  /// What this coverage status means in plain English (1-2 sentences)
  /// Example for NotCovered: "You have no defense against this attack type. Attackers can attempt this without being stopped."
  @override
  String get plainMeaning;

  /// What to do about it (2-3 actionable steps)
  /// Example: "1. Install antivirus software 2. Enable firewall 3. Update your systems"
  @override
  String get suggestion;

  /// Severity if NOT protected (0-100)
  /// Used to highlight which gaps matter most
  @override
  int get urgencyScore;

  /// Create a copy of PlainCoverageStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlainCoverageStatusImplCopyWith<_$PlainCoverageStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationProfileV2 _$OrganizationProfileV2FromJson(
  Map<String, dynamic> json,
) {
  return _OrganizationProfileV2.fromJson(json);
}

/// @nodoc
mixin _$OrganizationProfileV2 {
  /// Unique identifier for organization
  String get id => throw _privateConstructorUsedError;

  /// Organization name (e.g., "Acme Healthcare Corp")
  String get name => throw _privateConstructorUsedError;

  /// What type of business/organization
  BusinessSector get sector => throw _privateConstructorUsedError;

  /// How many people in organization
  OrganizationSize get size => throw _privateConstructorUsedError;

  /// Primary technology stack
  PrimaryTechnology get technology => throw _privateConstructorUsedError;

  /// What security controls already exist
  List<ExistingDefenses> get currentDefenses =>
      throw _privateConstructorUsedError;

  /// User's technical knowledge level
  /// Used to determine when to show advanced explanations
  UserTechLevel get userTechLevel => throw _privateConstructorUsedError;

  /// Which UI mode: 'ExpertMode' or 'PlainLanguageMode'
  String get appMode => throw _privateConstructorUsedError;

  /// Calculated baseline risk (0-100) BEFORE considering coverage
  /// Based on sector, size, and technology stack
  /// Higher = more attacked by default
  double get baselineRiskScore => throw _privateConstructorUsedError;

  /// List of top 15 technique IDs most relevant to this organization
  /// Ranked by priority (relevance to this org type)
  /// Used for "My Threats" view and prioritization
  List<String> get prioritizedTechniqueIds =>
      throw _privateConstructorUsedError;

  /// Pre-calculated coverage suggestions
  /// Map of techniqueId → suggested coverage level
  /// Used to populate pre-filled checkboxes in setup
  /// Example: {'T1110': 'PartiallyCovered', 'T1566': 'Covered'}
  Map<String, String> get suggestedCoverageLevels =>
      throw _privateConstructorUsedError;

  /// Short description of this organization (user's own notes)
  /// Example: "Small family-owned dental clinic in California"
  String get description => throw _privateConstructorUsedError;

  /// When profile was created
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// When last updated
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OrganizationProfileV2 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationProfileV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationProfileV2CopyWith<OrganizationProfileV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationProfileV2CopyWith<$Res> {
  factory $OrganizationProfileV2CopyWith(
    OrganizationProfileV2 value,
    $Res Function(OrganizationProfileV2) then,
  ) = _$OrganizationProfileV2CopyWithImpl<$Res, OrganizationProfileV2>;
  @useResult
  $Res call({
    String id,
    String name,
    BusinessSector sector,
    OrganizationSize size,
    PrimaryTechnology technology,
    List<ExistingDefenses> currentDefenses,
    UserTechLevel userTechLevel,
    String appMode,
    double baselineRiskScore,
    List<String> prioritizedTechniqueIds,
    Map<String, String> suggestedCoverageLevels,
    String description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$OrganizationProfileV2CopyWithImpl<
  $Res,
  $Val extends OrganizationProfileV2
>
    implements $OrganizationProfileV2CopyWith<$Res> {
  _$OrganizationProfileV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationProfileV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sector = null,
    Object? size = null,
    Object? technology = null,
    Object? currentDefenses = null,
    Object? userTechLevel = null,
    Object? appMode = null,
    Object? baselineRiskScore = null,
    Object? prioritizedTechniqueIds = null,
    Object? suggestedCoverageLevels = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as BusinessSector,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as OrganizationSize,
            technology: null == technology
                ? _value.technology
                : technology // ignore: cast_nullable_to_non_nullable
                      as PrimaryTechnology,
            currentDefenses: null == currentDefenses
                ? _value.currentDefenses
                : currentDefenses // ignore: cast_nullable_to_non_nullable
                      as List<ExistingDefenses>,
            userTechLevel: null == userTechLevel
                ? _value.userTechLevel
                : userTechLevel // ignore: cast_nullable_to_non_nullable
                      as UserTechLevel,
            appMode: null == appMode
                ? _value.appMode
                : appMode // ignore: cast_nullable_to_non_nullable
                      as String,
            baselineRiskScore: null == baselineRiskScore
                ? _value.baselineRiskScore
                : baselineRiskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            prioritizedTechniqueIds: null == prioritizedTechniqueIds
                ? _value.prioritizedTechniqueIds
                : prioritizedTechniqueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            suggestedCoverageLevels: null == suggestedCoverageLevels
                ? _value.suggestedCoverageLevels
                : suggestedCoverageLevels // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationProfileV2ImplCopyWith<$Res>
    implements $OrganizationProfileV2CopyWith<$Res> {
  factory _$$OrganizationProfileV2ImplCopyWith(
    _$OrganizationProfileV2Impl value,
    $Res Function(_$OrganizationProfileV2Impl) then,
  ) = __$$OrganizationProfileV2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    BusinessSector sector,
    OrganizationSize size,
    PrimaryTechnology technology,
    List<ExistingDefenses> currentDefenses,
    UserTechLevel userTechLevel,
    String appMode,
    double baselineRiskScore,
    List<String> prioritizedTechniqueIds,
    Map<String, String> suggestedCoverageLevels,
    String description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$OrganizationProfileV2ImplCopyWithImpl<$Res>
    extends
        _$OrganizationProfileV2CopyWithImpl<$Res, _$OrganizationProfileV2Impl>
    implements _$$OrganizationProfileV2ImplCopyWith<$Res> {
  __$$OrganizationProfileV2ImplCopyWithImpl(
    _$OrganizationProfileV2Impl _value,
    $Res Function(_$OrganizationProfileV2Impl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrganizationProfileV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sector = null,
    Object? size = null,
    Object? technology = null,
    Object? currentDefenses = null,
    Object? userTechLevel = null,
    Object? appMode = null,
    Object? baselineRiskScore = null,
    Object? prioritizedTechniqueIds = null,
    Object? suggestedCoverageLevels = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$OrganizationProfileV2Impl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as BusinessSector,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as OrganizationSize,
        technology: null == technology
            ? _value.technology
            : technology // ignore: cast_nullable_to_non_nullable
                  as PrimaryTechnology,
        currentDefenses: null == currentDefenses
            ? _value._currentDefenses
            : currentDefenses // ignore: cast_nullable_to_non_nullable
                  as List<ExistingDefenses>,
        userTechLevel: null == userTechLevel
            ? _value.userTechLevel
            : userTechLevel // ignore: cast_nullable_to_non_nullable
                  as UserTechLevel,
        appMode: null == appMode
            ? _value.appMode
            : appMode // ignore: cast_nullable_to_non_nullable
                  as String,
        baselineRiskScore: null == baselineRiskScore
            ? _value.baselineRiskScore
            : baselineRiskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        prioritizedTechniqueIds: null == prioritizedTechniqueIds
            ? _value._prioritizedTechniqueIds
            : prioritizedTechniqueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        suggestedCoverageLevels: null == suggestedCoverageLevels
            ? _value._suggestedCoverageLevels
            : suggestedCoverageLevels // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationProfileV2Impl implements _OrganizationProfileV2 {
  const _$OrganizationProfileV2Impl({
    required this.id,
    required this.name,
    required this.sector,
    required this.size,
    required this.technology,
    required final List<ExistingDefenses> currentDefenses,
    required this.userTechLevel,
    required this.appMode,
    required this.baselineRiskScore,
    required final List<String> prioritizedTechniqueIds,
    required final Map<String, String> suggestedCoverageLevels,
    this.description = '',
    required this.createdAt,
    required this.updatedAt,
  }) : _currentDefenses = currentDefenses,
       _prioritizedTechniqueIds = prioritizedTechniqueIds,
       _suggestedCoverageLevels = suggestedCoverageLevels;

  factory _$OrganizationProfileV2Impl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationProfileV2ImplFromJson(json);

  /// Unique identifier for organization
  @override
  final String id;

  /// Organization name (e.g., "Acme Healthcare Corp")
  @override
  final String name;

  /// What type of business/organization
  @override
  final BusinessSector sector;

  /// How many people in organization
  @override
  final OrganizationSize size;

  /// Primary technology stack
  @override
  final PrimaryTechnology technology;

  /// What security controls already exist
  final List<ExistingDefenses> _currentDefenses;

  /// What security controls already exist
  @override
  List<ExistingDefenses> get currentDefenses {
    if (_currentDefenses is EqualUnmodifiableListView) return _currentDefenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentDefenses);
  }

  /// User's technical knowledge level
  /// Used to determine when to show advanced explanations
  @override
  final UserTechLevel userTechLevel;

  /// Which UI mode: 'ExpertMode' or 'PlainLanguageMode'
  @override
  final String appMode;

  /// Calculated baseline risk (0-100) BEFORE considering coverage
  /// Based on sector, size, and technology stack
  /// Higher = more attacked by default
  @override
  final double baselineRiskScore;

  /// List of top 15 technique IDs most relevant to this organization
  /// Ranked by priority (relevance to this org type)
  /// Used for "My Threats" view and prioritization
  final List<String> _prioritizedTechniqueIds;

  /// List of top 15 technique IDs most relevant to this organization
  /// Ranked by priority (relevance to this org type)
  /// Used for "My Threats" view and prioritization
  @override
  List<String> get prioritizedTechniqueIds {
    if (_prioritizedTechniqueIds is EqualUnmodifiableListView)
      return _prioritizedTechniqueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prioritizedTechniqueIds);
  }

  /// Pre-calculated coverage suggestions
  /// Map of techniqueId → suggested coverage level
  /// Used to populate pre-filled checkboxes in setup
  /// Example: {'T1110': 'PartiallyCovered', 'T1566': 'Covered'}
  final Map<String, String> _suggestedCoverageLevels;

  /// Pre-calculated coverage suggestions
  /// Map of techniqueId → suggested coverage level
  /// Used to populate pre-filled checkboxes in setup
  /// Example: {'T1110': 'PartiallyCovered', 'T1566': 'Covered'}
  @override
  Map<String, String> get suggestedCoverageLevels {
    if (_suggestedCoverageLevels is EqualUnmodifiableMapView)
      return _suggestedCoverageLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_suggestedCoverageLevels);
  }

  /// Short description of this organization (user's own notes)
  /// Example: "Small family-owned dental clinic in California"
  @override
  @JsonKey()
  final String description;

  /// When profile was created
  @override
  final DateTime createdAt;

  /// When last updated
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'OrganizationProfileV2(id: $id, name: $name, sector: $sector, size: $size, technology: $technology, currentDefenses: $currentDefenses, userTechLevel: $userTechLevel, appMode: $appMode, baselineRiskScore: $baselineRiskScore, prioritizedTechniqueIds: $prioritizedTechniqueIds, suggestedCoverageLevels: $suggestedCoverageLevels, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationProfileV2Impl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.technology, technology) ||
                other.technology == technology) &&
            const DeepCollectionEquality().equals(
              other._currentDefenses,
              _currentDefenses,
            ) &&
            (identical(other.userTechLevel, userTechLevel) ||
                other.userTechLevel == userTechLevel) &&
            (identical(other.appMode, appMode) || other.appMode == appMode) &&
            (identical(other.baselineRiskScore, baselineRiskScore) ||
                other.baselineRiskScore == baselineRiskScore) &&
            const DeepCollectionEquality().equals(
              other._prioritizedTechniqueIds,
              _prioritizedTechniqueIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._suggestedCoverageLevels,
              _suggestedCoverageLevels,
            ) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    sector,
    size,
    technology,
    const DeepCollectionEquality().hash(_currentDefenses),
    userTechLevel,
    appMode,
    baselineRiskScore,
    const DeepCollectionEquality().hash(_prioritizedTechniqueIds),
    const DeepCollectionEquality().hash(_suggestedCoverageLevels),
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of OrganizationProfileV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationProfileV2ImplCopyWith<_$OrganizationProfileV2Impl>
  get copyWith =>
      __$$OrganizationProfileV2ImplCopyWithImpl<_$OrganizationProfileV2Impl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationProfileV2ImplToJson(this);
  }
}

abstract class _OrganizationProfileV2 implements OrganizationProfileV2 {
  const factory _OrganizationProfileV2({
    required final String id,
    required final String name,
    required final BusinessSector sector,
    required final OrganizationSize size,
    required final PrimaryTechnology technology,
    required final List<ExistingDefenses> currentDefenses,
    required final UserTechLevel userTechLevel,
    required final String appMode,
    required final double baselineRiskScore,
    required final List<String> prioritizedTechniqueIds,
    required final Map<String, String> suggestedCoverageLevels,
    final String description,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$OrganizationProfileV2Impl;

  factory _OrganizationProfileV2.fromJson(Map<String, dynamic> json) =
      _$OrganizationProfileV2Impl.fromJson;

  /// Unique identifier for organization
  @override
  String get id;

  /// Organization name (e.g., "Acme Healthcare Corp")
  @override
  String get name;

  /// What type of business/organization
  @override
  BusinessSector get sector;

  /// How many people in organization
  @override
  OrganizationSize get size;

  /// Primary technology stack
  @override
  PrimaryTechnology get technology;

  /// What security controls already exist
  @override
  List<ExistingDefenses> get currentDefenses;

  /// User's technical knowledge level
  /// Used to determine when to show advanced explanations
  @override
  UserTechLevel get userTechLevel;

  /// Which UI mode: 'ExpertMode' or 'PlainLanguageMode'
  @override
  String get appMode;

  /// Calculated baseline risk (0-100) BEFORE considering coverage
  /// Based on sector, size, and technology stack
  /// Higher = more attacked by default
  @override
  double get baselineRiskScore;

  /// List of top 15 technique IDs most relevant to this organization
  /// Ranked by priority (relevance to this org type)
  /// Used for "My Threats" view and prioritization
  @override
  List<String> get prioritizedTechniqueIds;

  /// Pre-calculated coverage suggestions
  /// Map of techniqueId → suggested coverage level
  /// Used to populate pre-filled checkboxes in setup
  /// Example: {'T1110': 'PartiallyCovered', 'T1566': 'Covered'}
  @override
  Map<String, String> get suggestedCoverageLevels;

  /// Short description of this organization (user's own notes)
  /// Example: "Small family-owned dental clinic in California"
  @override
  String get description;

  /// When profile was created
  @override
  DateTime get createdAt;

  /// When last updated
  @override
  DateTime get updatedAt;

  /// Create a copy of OrganizationProfileV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationProfileV2ImplCopyWith<_$OrganizationProfileV2Impl>
  get copyWith => throw _privateConstructorUsedError;
}

GeneratedThreatProfile _$GeneratedThreatProfileFromJson(
  Map<String, dynamic> json,
) {
  return _GeneratedThreatProfile.fromJson(json);
}

/// @nodoc
mixin _$GeneratedThreatProfile {
  /// Plain-English summary of threats specific to this organization
  /// Example: "Healthcare organizations like yours are most targeted by phishing (fake emails)
  /// and ransomware (malware that locks your files). In the last year, 2 out of 3 healthcare
  /// organizations were hit by ransomware."
  String get threatSummary => throw _privateConstructorUsedError;

  /// Sector description (for context)
  /// Example: "You work in Healthcare - a high-value target for cybercriminals"
  String get sectorDescription => throw _privateConstructorUsedError;

  /// List of top threats prioritized for this org
  /// Ranked by: (a) how common in sector, (b) how damaging, (c) current coverage
  List<PrioritizedTechnique> get topThreats =>
      throw _privateConstructorUsedError;

  /// Common threat actors/groups that target this sector
  /// Example: ["Alphv Blackcat", "Change Titan", "Scattered Spider"]
  List<String> get typicalThreatActors => throw _privateConstructorUsedError;

  /// Common attack patterns in this industry (attack chains)
  /// Example: "Phishing → Credential theft → Malware installation → Ransomware"
  List<AttackChain> get commonAttackChains =>
      throw _privateConstructorUsedError;

  /// Recommended initial actions (top 5)
  /// Example: ["Enable MFA on all accounts", "Deploy antivirus", "Backup critical data daily"]
  List<String> get initialRecommendations => throw _privateConstructorUsedError;

  /// Industry-specific compliance notes
  /// Example for Healthcare: "HIPAA requires you to protect patient data"
  String get complianceNotes => throw _privateConstructorUsedError;

  /// When profile was generated
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this GeneratedThreatProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedThreatProfileCopyWith<GeneratedThreatProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedThreatProfileCopyWith<$Res> {
  factory $GeneratedThreatProfileCopyWith(
    GeneratedThreatProfile value,
    $Res Function(GeneratedThreatProfile) then,
  ) = _$GeneratedThreatProfileCopyWithImpl<$Res, GeneratedThreatProfile>;
  @useResult
  $Res call({
    String threatSummary,
    String sectorDescription,
    List<PrioritizedTechnique> topThreats,
    List<String> typicalThreatActors,
    List<AttackChain> commonAttackChains,
    List<String> initialRecommendations,
    String complianceNotes,
    DateTime generatedAt,
  });
}

/// @nodoc
class _$GeneratedThreatProfileCopyWithImpl<
  $Res,
  $Val extends GeneratedThreatProfile
>
    implements $GeneratedThreatProfileCopyWith<$Res> {
  _$GeneratedThreatProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threatSummary = null,
    Object? sectorDescription = null,
    Object? topThreats = null,
    Object? typicalThreatActors = null,
    Object? commonAttackChains = null,
    Object? initialRecommendations = null,
    Object? complianceNotes = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            threatSummary: null == threatSummary
                ? _value.threatSummary
                : threatSummary // ignore: cast_nullable_to_non_nullable
                      as String,
            sectorDescription: null == sectorDescription
                ? _value.sectorDescription
                : sectorDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            topThreats: null == topThreats
                ? _value.topThreats
                : topThreats // ignore: cast_nullable_to_non_nullable
                      as List<PrioritizedTechnique>,
            typicalThreatActors: null == typicalThreatActors
                ? _value.typicalThreatActors
                : typicalThreatActors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            commonAttackChains: null == commonAttackChains
                ? _value.commonAttackChains
                : commonAttackChains // ignore: cast_nullable_to_non_nullable
                      as List<AttackChain>,
            initialRecommendations: null == initialRecommendations
                ? _value.initialRecommendations
                : initialRecommendations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            complianceNotes: null == complianceNotes
                ? _value.complianceNotes
                : complianceNotes // ignore: cast_nullable_to_non_nullable
                      as String,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeneratedThreatProfileImplCopyWith<$Res>
    implements $GeneratedThreatProfileCopyWith<$Res> {
  factory _$$GeneratedThreatProfileImplCopyWith(
    _$GeneratedThreatProfileImpl value,
    $Res Function(_$GeneratedThreatProfileImpl) then,
  ) = __$$GeneratedThreatProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String threatSummary,
    String sectorDescription,
    List<PrioritizedTechnique> topThreats,
    List<String> typicalThreatActors,
    List<AttackChain> commonAttackChains,
    List<String> initialRecommendations,
    String complianceNotes,
    DateTime generatedAt,
  });
}

/// @nodoc
class __$$GeneratedThreatProfileImplCopyWithImpl<$Res>
    extends
        _$GeneratedThreatProfileCopyWithImpl<$Res, _$GeneratedThreatProfileImpl>
    implements _$$GeneratedThreatProfileImplCopyWith<$Res> {
  __$$GeneratedThreatProfileImplCopyWithImpl(
    _$GeneratedThreatProfileImpl _value,
    $Res Function(_$GeneratedThreatProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeneratedThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threatSummary = null,
    Object? sectorDescription = null,
    Object? topThreats = null,
    Object? typicalThreatActors = null,
    Object? commonAttackChains = null,
    Object? initialRecommendations = null,
    Object? complianceNotes = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$GeneratedThreatProfileImpl(
        threatSummary: null == threatSummary
            ? _value.threatSummary
            : threatSummary // ignore: cast_nullable_to_non_nullable
                  as String,
        sectorDescription: null == sectorDescription
            ? _value.sectorDescription
            : sectorDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        topThreats: null == topThreats
            ? _value._topThreats
            : topThreats // ignore: cast_nullable_to_non_nullable
                  as List<PrioritizedTechnique>,
        typicalThreatActors: null == typicalThreatActors
            ? _value._typicalThreatActors
            : typicalThreatActors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        commonAttackChains: null == commonAttackChains
            ? _value._commonAttackChains
            : commonAttackChains // ignore: cast_nullable_to_non_nullable
                  as List<AttackChain>,
        initialRecommendations: null == initialRecommendations
            ? _value._initialRecommendations
            : initialRecommendations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        complianceNotes: null == complianceNotes
            ? _value.complianceNotes
            : complianceNotes // ignore: cast_nullable_to_non_nullable
                  as String,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratedThreatProfileImpl implements _GeneratedThreatProfile {
  const _$GeneratedThreatProfileImpl({
    required this.threatSummary,
    required this.sectorDescription,
    required final List<PrioritizedTechnique> topThreats,
    required final List<String> typicalThreatActors,
    required final List<AttackChain> commonAttackChains,
    required final List<String> initialRecommendations,
    this.complianceNotes = '',
    required this.generatedAt,
  }) : _topThreats = topThreats,
       _typicalThreatActors = typicalThreatActors,
       _commonAttackChains = commonAttackChains,
       _initialRecommendations = initialRecommendations;

  factory _$GeneratedThreatProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratedThreatProfileImplFromJson(json);

  /// Plain-English summary of threats specific to this organization
  /// Example: "Healthcare organizations like yours are most targeted by phishing (fake emails)
  /// and ransomware (malware that locks your files). In the last year, 2 out of 3 healthcare
  /// organizations were hit by ransomware."
  @override
  final String threatSummary;

  /// Sector description (for context)
  /// Example: "You work in Healthcare - a high-value target for cybercriminals"
  @override
  final String sectorDescription;

  /// List of top threats prioritized for this org
  /// Ranked by: (a) how common in sector, (b) how damaging, (c) current coverage
  final List<PrioritizedTechnique> _topThreats;

  /// List of top threats prioritized for this org
  /// Ranked by: (a) how common in sector, (b) how damaging, (c) current coverage
  @override
  List<PrioritizedTechnique> get topThreats {
    if (_topThreats is EqualUnmodifiableListView) return _topThreats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topThreats);
  }

  /// Common threat actors/groups that target this sector
  /// Example: ["Alphv Blackcat", "Change Titan", "Scattered Spider"]
  final List<String> _typicalThreatActors;

  /// Common threat actors/groups that target this sector
  /// Example: ["Alphv Blackcat", "Change Titan", "Scattered Spider"]
  @override
  List<String> get typicalThreatActors {
    if (_typicalThreatActors is EqualUnmodifiableListView)
      return _typicalThreatActors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typicalThreatActors);
  }

  /// Common attack patterns in this industry (attack chains)
  /// Example: "Phishing → Credential theft → Malware installation → Ransomware"
  final List<AttackChain> _commonAttackChains;

  /// Common attack patterns in this industry (attack chains)
  /// Example: "Phishing → Credential theft → Malware installation → Ransomware"
  @override
  List<AttackChain> get commonAttackChains {
    if (_commonAttackChains is EqualUnmodifiableListView)
      return _commonAttackChains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonAttackChains);
  }

  /// Recommended initial actions (top 5)
  /// Example: ["Enable MFA on all accounts", "Deploy antivirus", "Backup critical data daily"]
  final List<String> _initialRecommendations;

  /// Recommended initial actions (top 5)
  /// Example: ["Enable MFA on all accounts", "Deploy antivirus", "Backup critical data daily"]
  @override
  List<String> get initialRecommendations {
    if (_initialRecommendations is EqualUnmodifiableListView)
      return _initialRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialRecommendations);
  }

  /// Industry-specific compliance notes
  /// Example for Healthcare: "HIPAA requires you to protect patient data"
  @override
  @JsonKey()
  final String complianceNotes;

  /// When profile was generated
  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'GeneratedThreatProfile(threatSummary: $threatSummary, sectorDescription: $sectorDescription, topThreats: $topThreats, typicalThreatActors: $typicalThreatActors, commonAttackChains: $commonAttackChains, initialRecommendations: $initialRecommendations, complianceNotes: $complianceNotes, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedThreatProfileImpl &&
            (identical(other.threatSummary, threatSummary) ||
                other.threatSummary == threatSummary) &&
            (identical(other.sectorDescription, sectorDescription) ||
                other.sectorDescription == sectorDescription) &&
            const DeepCollectionEquality().equals(
              other._topThreats,
              _topThreats,
            ) &&
            const DeepCollectionEquality().equals(
              other._typicalThreatActors,
              _typicalThreatActors,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonAttackChains,
              _commonAttackChains,
            ) &&
            const DeepCollectionEquality().equals(
              other._initialRecommendations,
              _initialRecommendations,
            ) &&
            (identical(other.complianceNotes, complianceNotes) ||
                other.complianceNotes == complianceNotes) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    threatSummary,
    sectorDescription,
    const DeepCollectionEquality().hash(_topThreats),
    const DeepCollectionEquality().hash(_typicalThreatActors),
    const DeepCollectionEquality().hash(_commonAttackChains),
    const DeepCollectionEquality().hash(_initialRecommendations),
    complianceNotes,
    generatedAt,
  );

  /// Create a copy of GeneratedThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedThreatProfileImplCopyWith<_$GeneratedThreatProfileImpl>
  get copyWith =>
      __$$GeneratedThreatProfileImplCopyWithImpl<_$GeneratedThreatProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratedThreatProfileImplToJson(this);
  }
}

abstract class _GeneratedThreatProfile implements GeneratedThreatProfile {
  const factory _GeneratedThreatProfile({
    required final String threatSummary,
    required final String sectorDescription,
    required final List<PrioritizedTechnique> topThreats,
    required final List<String> typicalThreatActors,
    required final List<AttackChain> commonAttackChains,
    required final List<String> initialRecommendations,
    final String complianceNotes,
    required final DateTime generatedAt,
  }) = _$GeneratedThreatProfileImpl;

  factory _GeneratedThreatProfile.fromJson(Map<String, dynamic> json) =
      _$GeneratedThreatProfileImpl.fromJson;

  /// Plain-English summary of threats specific to this organization
  /// Example: "Healthcare organizations like yours are most targeted by phishing (fake emails)
  /// and ransomware (malware that locks your files). In the last year, 2 out of 3 healthcare
  /// organizations were hit by ransomware."
  @override
  String get threatSummary;

  /// Sector description (for context)
  /// Example: "You work in Healthcare - a high-value target for cybercriminals"
  @override
  String get sectorDescription;

  /// List of top threats prioritized for this org
  /// Ranked by: (a) how common in sector, (b) how damaging, (c) current coverage
  @override
  List<PrioritizedTechnique> get topThreats;

  /// Common threat actors/groups that target this sector
  /// Example: ["Alphv Blackcat", "Change Titan", "Scattered Spider"]
  @override
  List<String> get typicalThreatActors;

  /// Common attack patterns in this industry (attack chains)
  /// Example: "Phishing → Credential theft → Malware installation → Ransomware"
  @override
  List<AttackChain> get commonAttackChains;

  /// Recommended initial actions (top 5)
  /// Example: ["Enable MFA on all accounts", "Deploy antivirus", "Backup critical data daily"]
  @override
  List<String> get initialRecommendations;

  /// Industry-specific compliance notes
  /// Example for Healthcare: "HIPAA requires you to protect patient data"
  @override
  String get complianceNotes;

  /// When profile was generated
  @override
  DateTime get generatedAt;

  /// Create a copy of GeneratedThreatProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedThreatProfileImplCopyWith<_$GeneratedThreatProfileImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PrioritizedTechnique _$PrioritizedTechniqueFromJson(Map<String, dynamic> json) {
  return _PrioritizedTechnique.fromJson(json);
}

/// @nodoc
mixin _$PrioritizedTechnique {
  /// Technique ID (e.g., "T1110")
  String get techniqueId => throw _privateConstructorUsedError;

  /// Professional technique name (e.g., "Brute Force")
  String get techniqueName => throw _privateConstructorUsedError;

  /// Plain language name (e.g., "Someone Tries Many Passwords to Get In")
  String get plainLanguageName => throw _privateConstructorUsedError;

  /// Priority score for this organization (0-100)
  /// Higher = more relevant to this organization type
  /// Calculated based on: sector frequency + severity + current coverage gap
  double get priorityScore => throw _privateConstructorUsedError;

  /// Why this technique is high priority for this org
  /// Example: "Ransomware is the #1 attack against healthcare organizations"
  String get whyMatters => throw _privateConstructorUsedError;

  /// Suggested coverage level for this organization
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  String get suggestedCoverage => throw _privateConstructorUsedError;

  /// How many organizations in this sector have been hit by this
  /// Example: "2 out of 3 healthcare organizations"
  String get prevalenceInSector => throw _privateConstructorUsedError;

  /// Average financial impact if compromised
  /// Example: "$200,000+ average cost"
  String get averageImpact => throw _privateConstructorUsedError;

  /// Serializes this PrioritizedTechnique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrioritizedTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrioritizedTechniqueCopyWith<PrioritizedTechnique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrioritizedTechniqueCopyWith<$Res> {
  factory $PrioritizedTechniqueCopyWith(
    PrioritizedTechnique value,
    $Res Function(PrioritizedTechnique) then,
  ) = _$PrioritizedTechniqueCopyWithImpl<$Res, PrioritizedTechnique>;
  @useResult
  $Res call({
    String techniqueId,
    String techniqueName,
    String plainLanguageName,
    double priorityScore,
    String whyMatters,
    String suggestedCoverage,
    String prevalenceInSector,
    String averageImpact,
  });
}

/// @nodoc
class _$PrioritizedTechniqueCopyWithImpl<
  $Res,
  $Val extends PrioritizedTechnique
>
    implements $PrioritizedTechniqueCopyWith<$Res> {
  _$PrioritizedTechniqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrioritizedTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? plainLanguageName = null,
    Object? priorityScore = null,
    Object? whyMatters = null,
    Object? suggestedCoverage = null,
    Object? prevalenceInSector = null,
    Object? averageImpact = null,
  }) {
    return _then(
      _value.copyWith(
            techniqueId: null == techniqueId
                ? _value.techniqueId
                : techniqueId // ignore: cast_nullable_to_non_nullable
                      as String,
            techniqueName: null == techniqueName
                ? _value.techniqueName
                : techniqueName // ignore: cast_nullable_to_non_nullable
                      as String,
            plainLanguageName: null == plainLanguageName
                ? _value.plainLanguageName
                : plainLanguageName // ignore: cast_nullable_to_non_nullable
                      as String,
            priorityScore: null == priorityScore
                ? _value.priorityScore
                : priorityScore // ignore: cast_nullable_to_non_nullable
                      as double,
            whyMatters: null == whyMatters
                ? _value.whyMatters
                : whyMatters // ignore: cast_nullable_to_non_nullable
                      as String,
            suggestedCoverage: null == suggestedCoverage
                ? _value.suggestedCoverage
                : suggestedCoverage // ignore: cast_nullable_to_non_nullable
                      as String,
            prevalenceInSector: null == prevalenceInSector
                ? _value.prevalenceInSector
                : prevalenceInSector // ignore: cast_nullable_to_non_nullable
                      as String,
            averageImpact: null == averageImpact
                ? _value.averageImpact
                : averageImpact // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrioritizedTechniqueImplCopyWith<$Res>
    implements $PrioritizedTechniqueCopyWith<$Res> {
  factory _$$PrioritizedTechniqueImplCopyWith(
    _$PrioritizedTechniqueImpl value,
    $Res Function(_$PrioritizedTechniqueImpl) then,
  ) = __$$PrioritizedTechniqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String techniqueId,
    String techniqueName,
    String plainLanguageName,
    double priorityScore,
    String whyMatters,
    String suggestedCoverage,
    String prevalenceInSector,
    String averageImpact,
  });
}

/// @nodoc
class __$$PrioritizedTechniqueImplCopyWithImpl<$Res>
    extends _$PrioritizedTechniqueCopyWithImpl<$Res, _$PrioritizedTechniqueImpl>
    implements _$$PrioritizedTechniqueImplCopyWith<$Res> {
  __$$PrioritizedTechniqueImplCopyWithImpl(
    _$PrioritizedTechniqueImpl _value,
    $Res Function(_$PrioritizedTechniqueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrioritizedTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? techniqueName = null,
    Object? plainLanguageName = null,
    Object? priorityScore = null,
    Object? whyMatters = null,
    Object? suggestedCoverage = null,
    Object? prevalenceInSector = null,
    Object? averageImpact = null,
  }) {
    return _then(
      _$PrioritizedTechniqueImpl(
        techniqueId: null == techniqueId
            ? _value.techniqueId
            : techniqueId // ignore: cast_nullable_to_non_nullable
                  as String,
        techniqueName: null == techniqueName
            ? _value.techniqueName
            : techniqueName // ignore: cast_nullable_to_non_nullable
                  as String,
        plainLanguageName: null == plainLanguageName
            ? _value.plainLanguageName
            : plainLanguageName // ignore: cast_nullable_to_non_nullable
                  as String,
        priorityScore: null == priorityScore
            ? _value.priorityScore
            : priorityScore // ignore: cast_nullable_to_non_nullable
                  as double,
        whyMatters: null == whyMatters
            ? _value.whyMatters
            : whyMatters // ignore: cast_nullable_to_non_nullable
                  as String,
        suggestedCoverage: null == suggestedCoverage
            ? _value.suggestedCoverage
            : suggestedCoverage // ignore: cast_nullable_to_non_nullable
                  as String,
        prevalenceInSector: null == prevalenceInSector
            ? _value.prevalenceInSector
            : prevalenceInSector // ignore: cast_nullable_to_non_nullable
                  as String,
        averageImpact: null == averageImpact
            ? _value.averageImpact
            : averageImpact // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrioritizedTechniqueImpl implements _PrioritizedTechnique {
  const _$PrioritizedTechniqueImpl({
    required this.techniqueId,
    required this.techniqueName,
    required this.plainLanguageName,
    required this.priorityScore,
    required this.whyMatters,
    required this.suggestedCoverage,
    this.prevalenceInSector = '',
    this.averageImpact = '',
  });

  factory _$PrioritizedTechniqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrioritizedTechniqueImplFromJson(json);

  /// Technique ID (e.g., "T1110")
  @override
  final String techniqueId;

  /// Professional technique name (e.g., "Brute Force")
  @override
  final String techniqueName;

  /// Plain language name (e.g., "Someone Tries Many Passwords to Get In")
  @override
  final String plainLanguageName;

  /// Priority score for this organization (0-100)
  /// Higher = more relevant to this organization type
  /// Calculated based on: sector frequency + severity + current coverage gap
  @override
  final double priorityScore;

  /// Why this technique is high priority for this org
  /// Example: "Ransomware is the #1 attack against healthcare organizations"
  @override
  final String whyMatters;

  /// Suggested coverage level for this organization
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  @override
  final String suggestedCoverage;

  /// How many organizations in this sector have been hit by this
  /// Example: "2 out of 3 healthcare organizations"
  @override
  @JsonKey()
  final String prevalenceInSector;

  /// Average financial impact if compromised
  /// Example: "$200,000+ average cost"
  @override
  @JsonKey()
  final String averageImpact;

  @override
  String toString() {
    return 'PrioritizedTechnique(techniqueId: $techniqueId, techniqueName: $techniqueName, plainLanguageName: $plainLanguageName, priorityScore: $priorityScore, whyMatters: $whyMatters, suggestedCoverage: $suggestedCoverage, prevalenceInSector: $prevalenceInSector, averageImpact: $averageImpact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrioritizedTechniqueImpl &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.techniqueName, techniqueName) ||
                other.techniqueName == techniqueName) &&
            (identical(other.plainLanguageName, plainLanguageName) ||
                other.plainLanguageName == plainLanguageName) &&
            (identical(other.priorityScore, priorityScore) ||
                other.priorityScore == priorityScore) &&
            (identical(other.whyMatters, whyMatters) ||
                other.whyMatters == whyMatters) &&
            (identical(other.suggestedCoverage, suggestedCoverage) ||
                other.suggestedCoverage == suggestedCoverage) &&
            (identical(other.prevalenceInSector, prevalenceInSector) ||
                other.prevalenceInSector == prevalenceInSector) &&
            (identical(other.averageImpact, averageImpact) ||
                other.averageImpact == averageImpact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    techniqueId,
    techniqueName,
    plainLanguageName,
    priorityScore,
    whyMatters,
    suggestedCoverage,
    prevalenceInSector,
    averageImpact,
  );

  /// Create a copy of PrioritizedTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrioritizedTechniqueImplCopyWith<_$PrioritizedTechniqueImpl>
  get copyWith =>
      __$$PrioritizedTechniqueImplCopyWithImpl<_$PrioritizedTechniqueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrioritizedTechniqueImplToJson(this);
  }
}

abstract class _PrioritizedTechnique implements PrioritizedTechnique {
  const factory _PrioritizedTechnique({
    required final String techniqueId,
    required final String techniqueName,
    required final String plainLanguageName,
    required final double priorityScore,
    required final String whyMatters,
    required final String suggestedCoverage,
    final String prevalenceInSector,
    final String averageImpact,
  }) = _$PrioritizedTechniqueImpl;

  factory _PrioritizedTechnique.fromJson(Map<String, dynamic> json) =
      _$PrioritizedTechniqueImpl.fromJson;

  /// Technique ID (e.g., "T1110")
  @override
  String get techniqueId;

  /// Professional technique name (e.g., "Brute Force")
  @override
  String get techniqueName;

  /// Plain language name (e.g., "Someone Tries Many Passwords to Get In")
  @override
  String get plainLanguageName;

  /// Priority score for this organization (0-100)
  /// Higher = more relevant to this organization type
  /// Calculated based on: sector frequency + severity + current coverage gap
  @override
  double get priorityScore;

  /// Why this technique is high priority for this org
  /// Example: "Ransomware is the #1 attack against healthcare organizations"
  @override
  String get whyMatters;

  /// Suggested coverage level for this organization
  /// Values: "NotCovered", "PartiallyCovered", "Covered"
  @override
  String get suggestedCoverage;

  /// How many organizations in this sector have been hit by this
  /// Example: "2 out of 3 healthcare organizations"
  @override
  String get prevalenceInSector;

  /// Average financial impact if compromised
  /// Example: "$200,000+ average cost"
  @override
  String get averageImpact;

  /// Create a copy of PrioritizedTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrioritizedTechniqueImplCopyWith<_$PrioritizedTechniqueImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AttackChain _$AttackChainFromJson(Map<String, dynamic> json) {
  return _AttackChain.fromJson(json);
}

/// @nodoc
mixin _$AttackChain {
  /// Human-readable name (e.g., "Typical Ransomware Attack")
  String get name => throw _privateConstructorUsedError;

  /// Sequence of technique IDs in order (e.g., ['T1566', 'T1204', '1059', 'T1486'])
  List<String> get techniques => throw _privateConstructorUsedError;

  /// Plain-English description of the flow
  /// Example: "Attacker sends phishing email → User clicks link → Malware downloads
  /// → Attacker runs commands → Files encrypted and locked"
  String get description => throw _privateConstructorUsedError;

  /// Real-world example of this attack chain
  /// Example: "This is how the JBS ransomware attack happened in 2021"
  String get realWorldExample => throw _privateConstructorUsedError;

  /// Time it typically takes from first access to impact
  /// Example: "24 hours to encryption"
  String get typicalTimeline => throw _privateConstructorUsedError;

  /// Average damage/cost from this chain
  /// Example: "$250,000"
  String get typicalCost => throw _privateConstructorUsedError;

  /// Serializes this AttackChain to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttackChain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttackChainCopyWith<AttackChain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttackChainCopyWith<$Res> {
  factory $AttackChainCopyWith(
    AttackChain value,
    $Res Function(AttackChain) then,
  ) = _$AttackChainCopyWithImpl<$Res, AttackChain>;
  @useResult
  $Res call({
    String name,
    List<String> techniques,
    String description,
    String realWorldExample,
    String typicalTimeline,
    String typicalCost,
  });
}

/// @nodoc
class _$AttackChainCopyWithImpl<$Res, $Val extends AttackChain>
    implements $AttackChainCopyWith<$Res> {
  _$AttackChainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttackChain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? techniques = null,
    Object? description = null,
    Object? realWorldExample = null,
    Object? typicalTimeline = null,
    Object? typicalCost = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            techniques: null == techniques
                ? _value.techniques
                : techniques // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            realWorldExample: null == realWorldExample
                ? _value.realWorldExample
                : realWorldExample // ignore: cast_nullable_to_non_nullable
                      as String,
            typicalTimeline: null == typicalTimeline
                ? _value.typicalTimeline
                : typicalTimeline // ignore: cast_nullable_to_non_nullable
                      as String,
            typicalCost: null == typicalCost
                ? _value.typicalCost
                : typicalCost // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttackChainImplCopyWith<$Res>
    implements $AttackChainCopyWith<$Res> {
  factory _$$AttackChainImplCopyWith(
    _$AttackChainImpl value,
    $Res Function(_$AttackChainImpl) then,
  ) = __$$AttackChainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    List<String> techniques,
    String description,
    String realWorldExample,
    String typicalTimeline,
    String typicalCost,
  });
}

/// @nodoc
class __$$AttackChainImplCopyWithImpl<$Res>
    extends _$AttackChainCopyWithImpl<$Res, _$AttackChainImpl>
    implements _$$AttackChainImplCopyWith<$Res> {
  __$$AttackChainImplCopyWithImpl(
    _$AttackChainImpl _value,
    $Res Function(_$AttackChainImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttackChain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? techniques = null,
    Object? description = null,
    Object? realWorldExample = null,
    Object? typicalTimeline = null,
    Object? typicalCost = null,
  }) {
    return _then(
      _$AttackChainImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        techniques: null == techniques
            ? _value._techniques
            : techniques // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        realWorldExample: null == realWorldExample
            ? _value.realWorldExample
            : realWorldExample // ignore: cast_nullable_to_non_nullable
                  as String,
        typicalTimeline: null == typicalTimeline
            ? _value.typicalTimeline
            : typicalTimeline // ignore: cast_nullable_to_non_nullable
                  as String,
        typicalCost: null == typicalCost
            ? _value.typicalCost
            : typicalCost // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackChainImpl implements _AttackChain {
  const _$AttackChainImpl({
    required this.name,
    required final List<String> techniques,
    required this.description,
    required this.realWorldExample,
    this.typicalTimeline = '',
    this.typicalCost = '',
  }) : _techniques = techniques;

  factory _$AttackChainImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackChainImplFromJson(json);

  /// Human-readable name (e.g., "Typical Ransomware Attack")
  @override
  final String name;

  /// Sequence of technique IDs in order (e.g., ['T1566', 'T1204', '1059', 'T1486'])
  final List<String> _techniques;

  /// Sequence of technique IDs in order (e.g., ['T1566', 'T1204', '1059', 'T1486'])
  @override
  List<String> get techniques {
    if (_techniques is EqualUnmodifiableListView) return _techniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniques);
  }

  /// Plain-English description of the flow
  /// Example: "Attacker sends phishing email → User clicks link → Malware downloads
  /// → Attacker runs commands → Files encrypted and locked"
  @override
  final String description;

  /// Real-world example of this attack chain
  /// Example: "This is how the JBS ransomware attack happened in 2021"
  @override
  final String realWorldExample;

  /// Time it typically takes from first access to impact
  /// Example: "24 hours to encryption"
  @override
  @JsonKey()
  final String typicalTimeline;

  /// Average damage/cost from this chain
  /// Example: "$250,000"
  @override
  @JsonKey()
  final String typicalCost;

  @override
  String toString() {
    return 'AttackChain(name: $name, techniques: $techniques, description: $description, realWorldExample: $realWorldExample, typicalTimeline: $typicalTimeline, typicalCost: $typicalCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackChainImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._techniques,
              _techniques,
            ) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.realWorldExample, realWorldExample) ||
                other.realWorldExample == realWorldExample) &&
            (identical(other.typicalTimeline, typicalTimeline) ||
                other.typicalTimeline == typicalTimeline) &&
            (identical(other.typicalCost, typicalCost) ||
                other.typicalCost == typicalCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_techniques),
    description,
    realWorldExample,
    typicalTimeline,
    typicalCost,
  );

  /// Create a copy of AttackChain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttackChainImplCopyWith<_$AttackChainImpl> get copyWith =>
      __$$AttackChainImplCopyWithImpl<_$AttackChainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttackChainImplToJson(this);
  }
}

abstract class _AttackChain implements AttackChain {
  const factory _AttackChain({
    required final String name,
    required final List<String> techniques,
    required final String description,
    required final String realWorldExample,
    final String typicalTimeline,
    final String typicalCost,
  }) = _$AttackChainImpl;

  factory _AttackChain.fromJson(Map<String, dynamic> json) =
      _$AttackChainImpl.fromJson;

  /// Human-readable name (e.g., "Typical Ransomware Attack")
  @override
  String get name;

  /// Sequence of technique IDs in order (e.g., ['T1566', 'T1204', '1059', 'T1486'])
  @override
  List<String> get techniques;

  /// Plain-English description of the flow
  /// Example: "Attacker sends phishing email → User clicks link → Malware downloads
  /// → Attacker runs commands → Files encrypted and locked"
  @override
  String get description;

  /// Real-world example of this attack chain
  /// Example: "This is how the JBS ransomware attack happened in 2021"
  @override
  String get realWorldExample;

  /// Time it typically takes from first access to impact
  /// Example: "24 hours to encryption"
  @override
  String get typicalTimeline;

  /// Average damage/cost from this chain
  /// Example: "$250,000"
  @override
  String get typicalCost;

  /// Create a copy of AttackChain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackChainImplCopyWith<_$AttackChainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SectorProfile _$SectorProfileFromJson(Map<String, dynamic> json) {
  return _SectorProfile.fromJson(json);
}

/// @nodoc
mixin _$SectorProfile {
  /// Business sector
  BusinessSector get sector => throw _privateConstructorUsedError;

  /// Human-readable description
  /// Example: "Healthcare organizations including hospitals, clinics, and practices"
  String get description => throw _privateConstructorUsedError;

  /// Icon/emoji representing sector
  String get icon => throw _privateConstructorUsedError;

  /// Top 5 threats in this sector (technique IDs)
  /// Ranked by frequency
  List<String> get topThreats => throw _privateConstructorUsedError;

  /// Common threat actors targeting this sector
  List<String> get commonThreatActors => throw _privateConstructorUsedError;

  /// Risk multipliers for techniques (applied during prioritization)
  /// Map of techniqueId → multiplier (e.g., {"T1486": 1.5, "T1566": 1.4})
  Map<String, double> get techniqueRiskMultipliers =>
      throw _privateConstructorUsedError;

  /// Typical compliance requirements
  /// Example for Healthcare: ["HIPAA", "HITECH"]
  List<String> get complianceRequirements => throw _privateConstructorUsedError;

  /// Average estimated annual cost of breach
  /// Example: "$500,000"
  String get averageBreachCost => throw _privateConstructorUsedError;

  /// Serializes this SectorProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectorProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectorProfileCopyWith<SectorProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectorProfileCopyWith<$Res> {
  factory $SectorProfileCopyWith(
    SectorProfile value,
    $Res Function(SectorProfile) then,
  ) = _$SectorProfileCopyWithImpl<$Res, SectorProfile>;
  @useResult
  $Res call({
    BusinessSector sector,
    String description,
    String icon,
    List<String> topThreats,
    List<String> commonThreatActors,
    Map<String, double> techniqueRiskMultipliers,
    List<String> complianceRequirements,
    String averageBreachCost,
  });
}

/// @nodoc
class _$SectorProfileCopyWithImpl<$Res, $Val extends SectorProfile>
    implements $SectorProfileCopyWith<$Res> {
  _$SectorProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectorProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sector = null,
    Object? description = null,
    Object? icon = null,
    Object? topThreats = null,
    Object? commonThreatActors = null,
    Object? techniqueRiskMultipliers = null,
    Object? complianceRequirements = null,
    Object? averageBreachCost = null,
  }) {
    return _then(
      _value.copyWith(
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as BusinessSector,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            topThreats: null == topThreats
                ? _value.topThreats
                : topThreats // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            commonThreatActors: null == commonThreatActors
                ? _value.commonThreatActors
                : commonThreatActors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            techniqueRiskMultipliers: null == techniqueRiskMultipliers
                ? _value.techniqueRiskMultipliers
                : techniqueRiskMultipliers // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            complianceRequirements: null == complianceRequirements
                ? _value.complianceRequirements
                : complianceRequirements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            averageBreachCost: null == averageBreachCost
                ? _value.averageBreachCost
                : averageBreachCost // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SectorProfileImplCopyWith<$Res>
    implements $SectorProfileCopyWith<$Res> {
  factory _$$SectorProfileImplCopyWith(
    _$SectorProfileImpl value,
    $Res Function(_$SectorProfileImpl) then,
  ) = __$$SectorProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    BusinessSector sector,
    String description,
    String icon,
    List<String> topThreats,
    List<String> commonThreatActors,
    Map<String, double> techniqueRiskMultipliers,
    List<String> complianceRequirements,
    String averageBreachCost,
  });
}

/// @nodoc
class __$$SectorProfileImplCopyWithImpl<$Res>
    extends _$SectorProfileCopyWithImpl<$Res, _$SectorProfileImpl>
    implements _$$SectorProfileImplCopyWith<$Res> {
  __$$SectorProfileImplCopyWithImpl(
    _$SectorProfileImpl _value,
    $Res Function(_$SectorProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SectorProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sector = null,
    Object? description = null,
    Object? icon = null,
    Object? topThreats = null,
    Object? commonThreatActors = null,
    Object? techniqueRiskMultipliers = null,
    Object? complianceRequirements = null,
    Object? averageBreachCost = null,
  }) {
    return _then(
      _$SectorProfileImpl(
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as BusinessSector,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        topThreats: null == topThreats
            ? _value._topThreats
            : topThreats // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        commonThreatActors: null == commonThreatActors
            ? _value._commonThreatActors
            : commonThreatActors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        techniqueRiskMultipliers: null == techniqueRiskMultipliers
            ? _value._techniqueRiskMultipliers
            : techniqueRiskMultipliers // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        complianceRequirements: null == complianceRequirements
            ? _value._complianceRequirements
            : complianceRequirements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        averageBreachCost: null == averageBreachCost
            ? _value.averageBreachCost
            : averageBreachCost // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SectorProfileImpl implements _SectorProfile {
  const _$SectorProfileImpl({
    required this.sector,
    required this.description,
    required this.icon,
    required final List<String> topThreats,
    required final List<String> commonThreatActors,
    required final Map<String, double> techniqueRiskMultipliers,
    required final List<String> complianceRequirements,
    required this.averageBreachCost,
  }) : _topThreats = topThreats,
       _commonThreatActors = commonThreatActors,
       _techniqueRiskMultipliers = techniqueRiskMultipliers,
       _complianceRequirements = complianceRequirements;

  factory _$SectorProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectorProfileImplFromJson(json);

  /// Business sector
  @override
  final BusinessSector sector;

  /// Human-readable description
  /// Example: "Healthcare organizations including hospitals, clinics, and practices"
  @override
  final String description;

  /// Icon/emoji representing sector
  @override
  final String icon;

  /// Top 5 threats in this sector (technique IDs)
  /// Ranked by frequency
  final List<String> _topThreats;

  /// Top 5 threats in this sector (technique IDs)
  /// Ranked by frequency
  @override
  List<String> get topThreats {
    if (_topThreats is EqualUnmodifiableListView) return _topThreats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topThreats);
  }

  /// Common threat actors targeting this sector
  final List<String> _commonThreatActors;

  /// Common threat actors targeting this sector
  @override
  List<String> get commonThreatActors {
    if (_commonThreatActors is EqualUnmodifiableListView)
      return _commonThreatActors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonThreatActors);
  }

  /// Risk multipliers for techniques (applied during prioritization)
  /// Map of techniqueId → multiplier (e.g., {"T1486": 1.5, "T1566": 1.4})
  final Map<String, double> _techniqueRiskMultipliers;

  /// Risk multipliers for techniques (applied during prioritization)
  /// Map of techniqueId → multiplier (e.g., {"T1486": 1.5, "T1566": 1.4})
  @override
  Map<String, double> get techniqueRiskMultipliers {
    if (_techniqueRiskMultipliers is EqualUnmodifiableMapView)
      return _techniqueRiskMultipliers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_techniqueRiskMultipliers);
  }

  /// Typical compliance requirements
  /// Example for Healthcare: ["HIPAA", "HITECH"]
  final List<String> _complianceRequirements;

  /// Typical compliance requirements
  /// Example for Healthcare: ["HIPAA", "HITECH"]
  @override
  List<String> get complianceRequirements {
    if (_complianceRequirements is EqualUnmodifiableListView)
      return _complianceRequirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceRequirements);
  }

  /// Average estimated annual cost of breach
  /// Example: "$500,000"
  @override
  final String averageBreachCost;

  @override
  String toString() {
    return 'SectorProfile(sector: $sector, description: $description, icon: $icon, topThreats: $topThreats, commonThreatActors: $commonThreatActors, techniqueRiskMultipliers: $techniqueRiskMultipliers, complianceRequirements: $complianceRequirements, averageBreachCost: $averageBreachCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectorProfileImpl &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(
              other._topThreats,
              _topThreats,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonThreatActors,
              _commonThreatActors,
            ) &&
            const DeepCollectionEquality().equals(
              other._techniqueRiskMultipliers,
              _techniqueRiskMultipliers,
            ) &&
            const DeepCollectionEquality().equals(
              other._complianceRequirements,
              _complianceRequirements,
            ) &&
            (identical(other.averageBreachCost, averageBreachCost) ||
                other.averageBreachCost == averageBreachCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sector,
    description,
    icon,
    const DeepCollectionEquality().hash(_topThreats),
    const DeepCollectionEquality().hash(_commonThreatActors),
    const DeepCollectionEquality().hash(_techniqueRiskMultipliers),
    const DeepCollectionEquality().hash(_complianceRequirements),
    averageBreachCost,
  );

  /// Create a copy of SectorProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectorProfileImplCopyWith<_$SectorProfileImpl> get copyWith =>
      __$$SectorProfileImplCopyWithImpl<_$SectorProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectorProfileImplToJson(this);
  }
}

abstract class _SectorProfile implements SectorProfile {
  const factory _SectorProfile({
    required final BusinessSector sector,
    required final String description,
    required final String icon,
    required final List<String> topThreats,
    required final List<String> commonThreatActors,
    required final Map<String, double> techniqueRiskMultipliers,
    required final List<String> complianceRequirements,
    required final String averageBreachCost,
  }) = _$SectorProfileImpl;

  factory _SectorProfile.fromJson(Map<String, dynamic> json) =
      _$SectorProfileImpl.fromJson;

  /// Business sector
  @override
  BusinessSector get sector;

  /// Human-readable description
  /// Example: "Healthcare organizations including hospitals, clinics, and practices"
  @override
  String get description;

  /// Icon/emoji representing sector
  @override
  String get icon;

  /// Top 5 threats in this sector (technique IDs)
  /// Ranked by frequency
  @override
  List<String> get topThreats;

  /// Common threat actors targeting this sector
  @override
  List<String> get commonThreatActors;

  /// Risk multipliers for techniques (applied during prioritization)
  /// Map of techniqueId → multiplier (e.g., {"T1486": 1.5, "T1566": 1.4})
  @override
  Map<String, double> get techniqueRiskMultipliers;

  /// Typical compliance requirements
  /// Example for Healthcare: ["HIPAA", "HITECH"]
  @override
  List<String> get complianceRequirements;

  /// Average estimated annual cost of breach
  /// Example: "$500,000"
  @override
  String get averageBreachCost;

  /// Create a copy of SectorProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectorProfileImplCopyWith<_$SectorProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
