// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motor_kid_skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MotorKidSkillsImpl _$$MotorKidSkillsImplFromJson(Map<String, dynamic> json) =>
    _$MotorKidSkillsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      monthIndex: (json['monthIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$MotorKidSkillsImplToJson(
        _$MotorKidSkillsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'skills': instance.skills,
      'monthIndex': instance.monthIndex,
    };
