import 'package:freezed_annotation/freezed_annotation.dart';

part 'linguistic_kid_skills.freezed.dart';
part 'linguistic_kid_skills.g.dart';

@freezed
class LinguisticKidSkills with _$LinguisticKidSkills {
  const factory LinguisticKidSkills(
      {required DateTime timestamp,
      List<String>? skills,
      required int monthIndex,
      required double progress}) = _LinguisticKidSkills;

  factory LinguisticKidSkills.fromJson(Map<String, dynamic> json) =>
      _$LinguisticKidSkillsFromJson(json);

  factory LinguisticKidSkills.fromNewAction(int monthNumber, DateTime? when,
      List<String> selectedSkills, double progress) {
    var timestamp = when ?? DateTime.now().toUtc();
    return LinguisticKidSkills(
        timestamp: timestamp,
        monthIndex: monthNumber,
        skills: selectedSkills,
        progress: progress);
  }
}
