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

class MonthIndices {
  static const int firstMonth = 1;
  static const int secondMonth = 2;
  static const int thirdMonth = 3;
  static const int fourthMonth = 4;
  static const int fifthMonth = 5;
  static const int sixthMonth = 6;
  static const int seventhMonth = 7;
  static const int eighthMonth = 8;
  static const int ninthMonth = 9;
  static const int tenthMonth = 10;
  static const int eleventhMonth = 11;
  static const int twelfthMonth = 12;
}
