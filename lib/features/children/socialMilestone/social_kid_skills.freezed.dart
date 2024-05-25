// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_kid_skills.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SocialKidSkills _$SocialKidSkillsFromJson(Map<String, dynamic> json) {
  return _SocialKidSkills.fromJson(json);
}

/// @nodoc
mixin _$SocialKidSkills {
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  int get monthIndex => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialKidSkillsCopyWith<SocialKidSkills> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialKidSkillsCopyWith<$Res> {
  factory $SocialKidSkillsCopyWith(
          SocialKidSkills value, $Res Function(SocialKidSkills) then) =
      _$SocialKidSkillsCopyWithImpl<$Res, SocialKidSkills>;
  @useResult
  $Res call(
      {DateTime timestamp,
      List<String>? skills,
      int monthIndex,
      double progress});
}

/// @nodoc
class _$SocialKidSkillsCopyWithImpl<$Res, $Val extends SocialKidSkills>
    implements $SocialKidSkillsCopyWith<$Res> {
  _$SocialKidSkillsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? skills = freezed,
    Object? monthIndex = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialKidSkillsImplCopyWith<$Res>
    implements $SocialKidSkillsCopyWith<$Res> {
  factory _$$SocialKidSkillsImplCopyWith(_$SocialKidSkillsImpl value,
          $Res Function(_$SocialKidSkillsImpl) then) =
      __$$SocialKidSkillsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      List<String>? skills,
      int monthIndex,
      double progress});
}

/// @nodoc
class __$$SocialKidSkillsImplCopyWithImpl<$Res>
    extends _$SocialKidSkillsCopyWithImpl<$Res, _$SocialKidSkillsImpl>
    implements _$$SocialKidSkillsImplCopyWith<$Res> {
  __$$SocialKidSkillsImplCopyWithImpl(
      _$SocialKidSkillsImpl _value, $Res Function(_$SocialKidSkillsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? skills = freezed,
    Object? monthIndex = null,
    Object? progress = null,
  }) {
    return _then(_$SocialKidSkillsImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialKidSkillsImpl implements _SocialKidSkills {
  const _$SocialKidSkillsImpl(
      {required this.timestamp,
      final List<String>? skills,
      required this.monthIndex,
      required this.progress})
      : _skills = skills;

  factory _$SocialKidSkillsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialKidSkillsImplFromJson(json);

  @override
  final DateTime timestamp;
  final List<String>? _skills;
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int monthIndex;
  @override
  final double progress;

  @override
  String toString() {
    return 'SocialKidSkills(timestamp: $timestamp, skills: $skills, monthIndex: $monthIndex, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialKidSkillsImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.monthIndex, monthIndex) ||
                other.monthIndex == monthIndex) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp,
      const DeepCollectionEquality().hash(_skills), monthIndex, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialKidSkillsImplCopyWith<_$SocialKidSkillsImpl> get copyWith =>
      __$$SocialKidSkillsImplCopyWithImpl<_$SocialKidSkillsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialKidSkillsImplToJson(
      this,
    );
  }
}

abstract class _SocialKidSkills implements SocialKidSkills {
  const factory _SocialKidSkills(
      {required final DateTime timestamp,
      final List<String>? skills,
      required final int monthIndex,
      required final double progress}) = _$SocialKidSkillsImpl;

  factory _SocialKidSkills.fromJson(Map<String, dynamic> json) =
      _$SocialKidSkillsImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  List<String>? get skills;
  @override
  int get monthIndex;
  @override
  double get progress;
  @override
  @JsonKey(ignore: true)
  _$$SocialKidSkillsImplCopyWith<_$SocialKidSkillsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
