import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/skill_data.dart';

class KidDataMotorSkills {
  final Kid kid;

  KidDataMotorSkills(this.kid);

  Future<List<SkillChartData>> fetchMotorSkillsProgress() async {
    var sortedSkills = kid.motorSkills.toList();
    sortedSkills.sort((a, b) => a.monthIndex.compareTo(b.monthIndex));

    return sortedSkills
        .map((data) => SkillChartData(
            " ${getTextForMonth(data.monthIndex)}", data.progress))
        .toList();
  }
}
