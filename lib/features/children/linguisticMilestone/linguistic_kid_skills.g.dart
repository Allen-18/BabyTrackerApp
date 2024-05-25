// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linguistic_kid_skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinguisticKidSkillsImpl _$$LinguisticKidSkillsImplFromJson(
        Map<String, dynamic> json) =>
    _$LinguisticKidSkillsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      monthIndex: (json['monthIndex'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$LinguisticKidSkillsImplToJson(
        _$LinguisticKidSkillsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'skills': instance.skills,
      'monthIndex': instance.monthIndex,
      'progress': instance.progress,
    };
