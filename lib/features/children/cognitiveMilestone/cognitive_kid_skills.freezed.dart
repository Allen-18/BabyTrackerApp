// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cognitive_kid_skills.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CognitiveKidSkills _$CognitiveKidSkillsFromJson(Map<String, dynamic> json) {
  return _CognitiveKidSkills.fromJson(json);
}

/// @nodoc
mixin _$CognitiveKidSkills {
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  int get monthIndex => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CognitiveKidSkillsCopyWith<CognitiveKidSkills> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CognitiveKidSkillsCopyWith<$Res> {
  factory $CognitiveKidSkillsCopyWith(
          CognitiveKidSkills value, $Res Function(CognitiveKidSkills) then) =
      _$CognitiveKidSkillsCopyWithImpl<$Res, CognitiveKidSkills>;
  @useResult
  $Res call(
      {DateTime timestamp,
      List<String>? skills,
      int monthIndex,
      double progress});
}

/// @nodoc
class _$CognitiveKidSkillsCopyWithImpl<$Res, $Val extends CognitiveKidSkills>
    implements $CognitiveKidSkillsCopyWith<$Res> {
  _$CognitiveKidSkillsCopyWithImpl(this._value, this._then);

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
abstract class _$$CognitiveKidSkillsImplCopyWith<$Res>
    implements $CognitiveKidSkillsCopyWith<$Res> {
  factory _$$CognitiveKidSkillsImplCopyWith(_$CognitiveKidSkillsImpl value,
          $Res Function(_$CognitiveKidSkillsImpl) then) =
      __$$CognitiveKidSkillsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      List<String>? skills,
      int monthIndex,
      double progress});
}

/// @nodoc
class __$$CognitiveKidSkillsImplCopyWithImpl<$Res>
    extends _$CognitiveKidSkillsCopyWithImpl<$Res, _$CognitiveKidSkillsImpl>
    implements _$$CognitiveKidSkillsImplCopyWith<$Res> {
  __$$CognitiveKidSkillsImplCopyWithImpl(_$CognitiveKidSkillsImpl _value,
      $Res Function(_$CognitiveKidSkillsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? skills = freezed,
    Object? monthIndex = null,
    Object? progress = null,
  }) {
    return _then(_$CognitiveKidSkillsImpl(
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
class _$CognitiveKidSkillsImpl implements _CognitiveKidSkills {
  const _$CognitiveKidSkillsImpl(
      {required this.timestamp,
      final List<String>? skills,
      required this.monthIndex,
      required this.progress})
      : _skills = skills;

  factory _$CognitiveKidSkillsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CognitiveKidSkillsImplFromJson(json);

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
    return 'CognitiveKidSkills(timestamp: $timestamp, skills: $skills, monthIndex: $monthIndex, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CognitiveKidSkillsImpl &&
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
  _$$CognitiveKidSkillsImplCopyWith<_$CognitiveKidSkillsImpl> get copyWith =>
      __$$CognitiveKidSkillsImplCopyWithImpl<_$CognitiveKidSkillsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CognitiveKidSkillsImplToJson(
      this,
    );
  }
}

abstract class _CognitiveKidSkills implements CognitiveKidSkills {
  const factory _CognitiveKidSkills(
      {required final DateTime timestamp,
      final List<String>? skills,
      required final int monthIndex,
      required final double progress}) = _$CognitiveKidSkillsImpl;

  factory _CognitiveKidSkills.fromJson(Map<String, dynamic> json) =
      _$CognitiveKidSkillsImpl.fromJson;

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
  _$$CognitiveKidSkillsImplCopyWith<_$CognitiveKidSkillsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
