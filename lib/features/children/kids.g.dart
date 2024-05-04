// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KidImpl _$$KidImplFromJson(Map<String, dynamic> json) => _$KidImpl(
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      isPremature: json['isPremature'] as bool? ?? false,
      isHasTwin: json['isHasTwin'] as bool? ?? false,
      childWeight: (json['childWeight'] as num?)?.toDouble() ?? 0.0,
      childHeight: (json['childHeight'] as num?)?.toDouble() ?? 0.0,
      childHeadCircumference:
          (json['childHeadCircumference'] as num?)?.toDouble() ?? 0.0,
      // ignore: unnecessary_null_in_if_null_operators
      profileImgUriChild: json['profileImgUriChild'] as String? ?? null,
      assignedParentId: json['assignedParentId'] as String?,
    );

Map<String, dynamic> _$$KidImplToJson(_$KidImpl instance) => <String, dynamic>{
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'isPremature': instance.isPremature,
      'isHasTwin': instance.isHasTwin,
      'childWeight': instance.childWeight,
      'childHeight': instance.childHeight,
      'childHeadCircumference': instance.childHeadCircumference,
      'profileImgUriChild': instance.profileImgUriChild,
      'assignedParentId': instance.assignedParentId,
    };
