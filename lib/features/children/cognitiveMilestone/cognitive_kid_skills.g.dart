// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cognitive_kid_skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CognitiveKidSkillsImpl _$$CognitiveKidSkillsImplFromJson(
        Map<String, dynamic> json) =>
    _$CognitiveKidSkillsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      monthIndex: (json['monthIndex'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$CognitiveKidSkillsImplToJson(
        _$CognitiveKidSkillsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'skills': instance.skills,
      'monthIndex': instance.monthIndex,
      'progress': instance.progress,
    };
