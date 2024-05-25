// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_kid_skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialKidSkillsImpl _$$SocialKidSkillsImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialKidSkillsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      monthIndex: (json['monthIndex'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$SocialKidSkillsImplToJson(
        _$SocialKidSkillsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'skills': instance.skills,
      'monthIndex': instance.monthIndex,
      'progress': instance.progress,
    };
