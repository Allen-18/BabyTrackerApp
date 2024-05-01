// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, duplicate_ignore
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
// ignore: invalid_annotation_target
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get relationship => throw _privateConstructorUsedError;
  DateTime? get creationDate => throw _privateConstructorUsedError;
  bool get hasChild => throw _privateConstructorUsedError;
  String? get profileImgUri => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String? email,
      String? name,
      String? relationship,
      DateTime? creationDate,
      bool hasChild,
      String? profileImgUri,
      bool isActive});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? relationship = freezed,
    Object? creationDate = freezed,
    Object? hasChild = null,
    Object? profileImgUri = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: freezed == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasChild: null == hasChild
          ? _value.hasChild
          : hasChild // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImgUri: freezed == profileImgUri
          ? _value.profileImgUri
          : profileImgUri // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String? email,
      String? name,
      String? relationship,
      DateTime? creationDate,
      bool hasChild,
      String? profileImgUri,
      bool isActive});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? relationship = freezed,
    Object? creationDate = freezed,
    Object? hasChild = null,
    Object? profileImgUri = freezed,
    Object? isActive = null,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: freezed == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasChild: null == hasChild
          ? _value.hasChild
          : hasChild // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImgUri: freezed == profileImgUri
          ? _value.profileImgUri
          : profileImgUri // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.id,
      this.email = null,
      this.name = null,
      this.relationship = null,
      this.creationDate = null,
      this.hasChild = false,
      this.profileImgUri = null,
      this.isActive = false})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  @override
  @JsonKey()
  final String? email;
  @override
  @JsonKey()
  final String? name;
  @override
  @JsonKey()
  final String? relationship;
  @override
  @JsonKey()
  final DateTime? creationDate;
  @override
  @JsonKey()
  final bool hasChild;
  @override
  @JsonKey()
  final String? profileImgUri;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, relationship: $relationship, creationDate: $creationDate, hasChild: $hasChild, profileImgUri: $profileImgUri, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.hasChild, hasChild) ||
                other.hasChild == hasChild) &&
            (identical(other.profileImgUri, profileImgUri) ||
                other.profileImgUri == profileImgUri) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, name, relationship,
      creationDate, hasChild, profileImgUri, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {@JsonKey(includeFromJson: false, includeToJson: false) final String? id,
      final String? email,
      final String? name,
      final String? relationship,
      final DateTime? creationDate,
      final bool hasChild,
      final String? profileImgUri,
      final bool isActive}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id;
  @override
  String? get email;
  @override
  String? get name;
  @override
  String? get relationship;
  @override
  DateTime? get creationDate;
  @override
  bool get hasChild;
  @override
  String? get profileImgUri;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
