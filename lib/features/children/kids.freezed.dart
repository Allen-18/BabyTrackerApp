// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, duplicate_ignore
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Kid _$KidFromJson(Map<String, dynamic> json) {
  return _Kid.fromJson(json);
}

/// @nodoc
mixin _$Kid {
// ignore: invalid_annotation_target
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get dateOfBirth => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  bool get isPremature => throw _privateConstructorUsedError;
  bool get isHasTwin => throw _privateConstructorUsedError;
  double get childWeight => throw _privateConstructorUsedError;
  double get childHeight => throw _privateConstructorUsedError;
  double get childHeadCircumference => throw _privateConstructorUsedError;
  String? get profileImgUriChild => throw _privateConstructorUsedError;
  List<MotorKidSkills> get motorSkills => throw _privateConstructorUsedError;
  List<CognitiveKidSkills> get cognitiveSkills =>
      throw _privateConstructorUsedError;
  String? get assignedParentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KidCopyWith<Kid> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KidCopyWith<$Res> {
  factory $KidCopyWith(Kid value, $Res Function(Kid) then) =
      _$KidCopyWithImpl<$Res, Kid>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String name,
      String dateOfBirth,
      String gender,
      bool isPremature,
      bool isHasTwin,
      double childWeight,
      double childHeight,
      double childHeadCircumference,
      String? profileImgUriChild,
      List<MotorKidSkills> motorSkills,
      List<CognitiveKidSkills> cognitiveSkills,
      String? assignedParentId});
}

/// @nodoc
class _$KidCopyWithImpl<$Res, $Val extends Kid> implements $KidCopyWith<$Res> {
  _$KidCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? isPremature = null,
    Object? isHasTwin = null,
    Object? childWeight = null,
    Object? childHeight = null,
    Object? childHeadCircumference = null,
    Object? profileImgUriChild = freezed,
    Object? motorSkills = null,
    Object? cognitiveSkills = null,
    Object? assignedParentId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      isPremature: null == isPremature
          ? _value.isPremature
          : isPremature // ignore: cast_nullable_to_non_nullable
              as bool,
      isHasTwin: null == isHasTwin
          ? _value.isHasTwin
          : isHasTwin // ignore: cast_nullable_to_non_nullable
              as bool,
      childWeight: null == childWeight
          ? _value.childWeight
          : childWeight // ignore: cast_nullable_to_non_nullable
              as double,
      childHeight: null == childHeight
          ? _value.childHeight
          : childHeight // ignore: cast_nullable_to_non_nullable
              as double,
      childHeadCircumference: null == childHeadCircumference
          ? _value.childHeadCircumference
          : childHeadCircumference // ignore: cast_nullable_to_non_nullable
              as double,
      profileImgUriChild: freezed == profileImgUriChild
          ? _value.profileImgUriChild
          : profileImgUriChild // ignore: cast_nullable_to_non_nullable
              as String?,
      motorSkills: null == motorSkills
          ? _value.motorSkills
          : motorSkills // ignore: cast_nullable_to_non_nullable
              as List<MotorKidSkills>,
      cognitiveSkills: null == cognitiveSkills
          ? _value.cognitiveSkills
          : cognitiveSkills // ignore: cast_nullable_to_non_nullable
              as List<CognitiveKidSkills>,
      assignedParentId: freezed == assignedParentId
          ? _value.assignedParentId
          : assignedParentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KidImplCopyWith<$Res> implements $KidCopyWith<$Res> {
  factory _$$KidImplCopyWith(_$KidImpl value, $Res Function(_$KidImpl) then) =
      __$$KidImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String name,
      String dateOfBirth,
      String gender,
      bool isPremature,
      bool isHasTwin,
      double childWeight,
      double childHeight,
      double childHeadCircumference,
      String? profileImgUriChild,
      List<MotorKidSkills> motorSkills,
      List<CognitiveKidSkills> cognitiveSkills,
      String? assignedParentId});
}

/// @nodoc
class __$$KidImplCopyWithImpl<$Res> extends _$KidCopyWithImpl<$Res, _$KidImpl>
    implements _$$KidImplCopyWith<$Res> {
  __$$KidImplCopyWithImpl(_$KidImpl _value, $Res Function(_$KidImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? isPremature = null,
    Object? isHasTwin = null,
    Object? childWeight = null,
    Object? childHeight = null,
    Object? childHeadCircumference = null,
    Object? profileImgUriChild = freezed,
    Object? motorSkills = null,
    Object? cognitiveSkills = null,
    Object? assignedParentId = freezed,
  }) {
    return _then(_$KidImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      isPremature: null == isPremature
          ? _value.isPremature
          : isPremature // ignore: cast_nullable_to_non_nullable
              as bool,
      isHasTwin: null == isHasTwin
          ? _value.isHasTwin
          : isHasTwin // ignore: cast_nullable_to_non_nullable
              as bool,
      childWeight: null == childWeight
          ? _value.childWeight
          : childWeight // ignore: cast_nullable_to_non_nullable
              as double,
      childHeight: null == childHeight
          ? _value.childHeight
          : childHeight // ignore: cast_nullable_to_non_nullable
              as double,
      childHeadCircumference: null == childHeadCircumference
          ? _value.childHeadCircumference
          : childHeadCircumference // ignore: cast_nullable_to_non_nullable
              as double,
      profileImgUriChild: freezed == profileImgUriChild
          ? _value.profileImgUriChild
          : profileImgUriChild // ignore: cast_nullable_to_non_nullable
              as String?,
      motorSkills: null == motorSkills
          ? _value._motorSkills
          : motorSkills // ignore: cast_nullable_to_non_nullable
              as List<MotorKidSkills>,
      cognitiveSkills: null == cognitiveSkills
          ? _value._cognitiveSkills
          : cognitiveSkills // ignore: cast_nullable_to_non_nullable
              as List<CognitiveKidSkills>,
      assignedParentId: freezed == assignedParentId
          ? _value.assignedParentId
          : assignedParentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KidImpl extends _Kid {
  const _$KidImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.id,
      required this.name,
      required this.dateOfBirth,
      required this.gender,
      this.isPremature = false,
      this.isHasTwin = false,
      this.childWeight = 0.0,
      this.childHeight = 0.0,
      this.childHeadCircumference = 0.0,
      this.profileImgUriChild = null,
      final List<MotorKidSkills> motorSkills = const [],
      final List<CognitiveKidSkills> cognitiveSkills = const [],
      this.assignedParentId})
      : _motorSkills = motorSkills,
        _cognitiveSkills = cognitiveSkills,
        super._();

  factory _$KidImpl.fromJson(Map<String, dynamic> json) =>
      _$$KidImplFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  @override
  final String name;
  @override
  final String dateOfBirth;
  @override
  final String gender;
  @override
  @JsonKey()
  final bool isPremature;
  @override
  @JsonKey()
  final bool isHasTwin;
  @override
  @JsonKey()
  final double childWeight;
  @override
  @JsonKey()
  final double childHeight;
  @override
  @JsonKey()
  final double childHeadCircumference;
  @override
  @JsonKey()
  final String? profileImgUriChild;
  final List<MotorKidSkills> _motorSkills;
  @override
  @JsonKey()
  List<MotorKidSkills> get motorSkills {
    if (_motorSkills is EqualUnmodifiableListView) return _motorSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motorSkills);
  }

  final List<CognitiveKidSkills> _cognitiveSkills;
  @override
  @JsonKey()
  List<CognitiveKidSkills> get cognitiveSkills {
    if (_cognitiveSkills is EqualUnmodifiableListView) return _cognitiveSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cognitiveSkills);
  }

  @override
  final String? assignedParentId;

  @override
  String toString() {
    return 'Kid(id: $id, name: $name, dateOfBirth: $dateOfBirth, gender: $gender, isPremature: $isPremature, isHasTwin: $isHasTwin, childWeight: $childWeight, childHeight: $childHeight, childHeadCircumference: $childHeadCircumference, profileImgUriChild: $profileImgUriChild, motorSkills: $motorSkills, cognitiveSkills: $cognitiveSkills, assignedParentId: $assignedParentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KidImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.isPremature, isPremature) ||
                other.isPremature == isPremature) &&
            (identical(other.isHasTwin, isHasTwin) ||
                other.isHasTwin == isHasTwin) &&
            (identical(other.childWeight, childWeight) ||
                other.childWeight == childWeight) &&
            (identical(other.childHeight, childHeight) ||
                other.childHeight == childHeight) &&
            (identical(other.childHeadCircumference, childHeadCircumference) ||
                other.childHeadCircumference == childHeadCircumference) &&
            (identical(other.profileImgUriChild, profileImgUriChild) ||
                other.profileImgUriChild == profileImgUriChild) &&
            const DeepCollectionEquality()
                .equals(other._motorSkills, _motorSkills) &&
            const DeepCollectionEquality()
                .equals(other._cognitiveSkills, _cognitiveSkills) &&
            (identical(other.assignedParentId, assignedParentId) ||
                other.assignedParentId == assignedParentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dateOfBirth,
      gender,
      isPremature,
      isHasTwin,
      childWeight,
      childHeight,
      childHeadCircumference,
      profileImgUriChild,
      const DeepCollectionEquality().hash(_motorSkills),
      const DeepCollectionEquality().hash(_cognitiveSkills),
      assignedParentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KidImplCopyWith<_$KidImpl> get copyWith =>
      __$$KidImplCopyWithImpl<_$KidImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KidImplToJson(
      this,
    );
  }
}

abstract class _Kid extends Kid {
  const factory _Kid(
      {@JsonKey(includeFromJson: false, includeToJson: false) final String? id,
      required final String name,
      required final String dateOfBirth,
      required final String gender,
      final bool isPremature,
      final bool isHasTwin,
      final double childWeight,
      final double childHeight,
      final double childHeadCircumference,
      final String? profileImgUriChild,
      final List<MotorKidSkills> motorSkills,
      final List<CognitiveKidSkills> cognitiveSkills,
      final String? assignedParentId}) = _$KidImpl;
  const _Kid._() : super._();

  factory _Kid.fromJson(Map<String, dynamic> json) = _$KidImpl.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id;
  @override
  String get name;
  @override
  String get dateOfBirth;
  @override
  String get gender;
  @override
  bool get isPremature;
  @override
  bool get isHasTwin;
  @override
  double get childWeight;
  @override
  double get childHeight;
  @override
  double get childHeadCircumference;
  @override
  String? get profileImgUriChild;
  @override
  List<MotorKidSkills> get motorSkills;
  @override
  List<CognitiveKidSkills> get cognitiveSkills;
  @override
  String? get assignedParentId;
  @override
  @JsonKey(ignore: true)
  _$$KidImplCopyWith<_$KidImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
