// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motor_kid_skills.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MotorKidSkills _$MotorKidSkillsFromJson(Map<String, dynamic> json) {
  return _MotorKidSkills.fromJson(json);
}

/// @nodoc
mixin _$MotorKidSkills {
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  int get monthIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MotorKidSkillsCopyWith<MotorKidSkills> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MotorKidSkillsCopyWith<$Res> {
  factory $MotorKidSkillsCopyWith(
          MotorKidSkills value, $Res Function(MotorKidSkills) then) =
      _$MotorKidSkillsCopyWithImpl<$Res, MotorKidSkills>;
  @useResult
  $Res call({DateTime timestamp, List<String>? skills, int monthIndex});
}

/// @nodoc
class _$MotorKidSkillsCopyWithImpl<$Res, $Val extends MotorKidSkills>
    implements $MotorKidSkillsCopyWith<$Res> {
  _$MotorKidSkillsCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MotorKidSkillsImplCopyWith<$Res>
    implements $MotorKidSkillsCopyWith<$Res> {
  factory _$$MotorKidSkillsImplCopyWith(_$MotorKidSkillsImpl value,
          $Res Function(_$MotorKidSkillsImpl) then) =
      __$$MotorKidSkillsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, List<String>? skills, int monthIndex});
}

/// @nodoc
class __$$MotorKidSkillsImplCopyWithImpl<$Res>
    extends _$MotorKidSkillsCopyWithImpl<$Res, _$MotorKidSkillsImpl>
    implements _$$MotorKidSkillsImplCopyWith<$Res> {
  __$$MotorKidSkillsImplCopyWithImpl(
      _$MotorKidSkillsImpl _value, $Res Function(_$MotorKidSkillsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? skills = freezed,
    Object? monthIndex = null,
  }) {
    return _then(_$MotorKidSkillsImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MotorKidSkillsImpl implements _MotorKidSkills {
  const _$MotorKidSkillsImpl(
      {required this.timestamp,
      final List<String>? skills,
      required this.monthIndex})
      : _skills = skills;

  factory _$MotorKidSkillsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MotorKidSkillsImplFromJson(json);

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
  String toString() {
    return 'MotorKidSkills(timestamp: $timestamp, skills: $skills, monthIndex: $monthIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MotorKidSkillsImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.monthIndex, monthIndex) ||
                other.monthIndex == monthIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp,
      const DeepCollectionEquality().hash(_skills), monthIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MotorKidSkillsImplCopyWith<_$MotorKidSkillsImpl> get copyWith =>
      __$$MotorKidSkillsImplCopyWithImpl<_$MotorKidSkillsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MotorKidSkillsImplToJson(
      this,
    );
  }
}

abstract class _MotorKidSkills implements MotorKidSkills {
  const factory _MotorKidSkills(
      {required final DateTime timestamp,
      final List<String>? skills,
      required final int monthIndex}) = _$MotorKidSkillsImpl;

  factory _MotorKidSkills.fromJson(Map<String, dynamic> json) =
      _$MotorKidSkillsImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  List<String>? get skills;
  @override
  int get monthIndex;
  @override
  @JsonKey(ignore: true)
  _$$MotorKidSkillsImplCopyWith<_$MotorKidSkillsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
