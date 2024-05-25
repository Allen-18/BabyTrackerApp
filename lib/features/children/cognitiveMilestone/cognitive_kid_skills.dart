import 'package:freezed_annotation/freezed_annotation.dart';

part 'cognitive_kid_skills.freezed.dart';
part 'cognitive_kid_skills.g.dart';

@freezed
class CognitiveKidSkills with _$CognitiveKidSkills {
  const factory CognitiveKidSkills(
      {required DateTime timestamp,
      List<String>? skills,
      required int monthIndex,
      required double progress}) = _CognitiveKidSkills;

  factory CognitiveKidSkills.fromJson(Map<String, dynamic> json) =>
      _$CognitiveKidSkillsFromJson(json);

  factory CognitiveKidSkills.fromNewAction(int monthNumber, DateTime? when,
      List<String> selectedSkills, double progress) {
    var timestamp = when ?? DateTime.now().toUtc();
    return CognitiveKidSkills(
        timestamp: timestamp,
        monthIndex: monthNumber,
        skills: selectedSkills,
        progress: progress);
  }
}
