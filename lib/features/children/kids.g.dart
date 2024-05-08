// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_in_if_null_operators

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
      profileImgUriChild: json['profileImgUriChild'] as String? ?? null,
      motorSkills: (json['motorSkills'] as List<dynamic>?)
              ?.map((e) => MotorKidSkills.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cognitiveSkills: (json['cognitiveSkills'] as List<dynamic>?)
              ?.map(
                  (e) => CognitiveKidSkills.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
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
      'motorSkills': instance.motorSkills,
      'cognitiveSkills': instance.cognitiveSkills,
      'assignedParentId': instance.assignedParentId,
    };
