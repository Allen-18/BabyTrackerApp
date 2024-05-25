import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_kid_skills.freezed.dart';
part 'social_kid_skills.g.dart';

@freezed
class SocialKidSkills with _$SocialKidSkills {
  const factory SocialKidSkills(
      {required DateTime timestamp,
        List<String>? skills,
        required int monthIndex,
        required double progress}) = _SocialKidSkills;

  factory SocialKidSkills.fromJson(Map<String, dynamic> json) =>
      _$SocialKidSkillsFromJson(json);

  factory SocialKidSkills.fromNewAction(int monthNumber, DateTime? when,
      List<String> selectedSkills, double progress) {
    var timestamp = when ?? DateTime.now().toUtc();
    return SocialKidSkills(
        timestamp: timestamp,
        monthIndex: monthNumber,
        skills: selectedSkills,
        progress: progress);
  }
}
