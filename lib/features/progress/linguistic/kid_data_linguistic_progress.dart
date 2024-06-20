import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/skill_data.dart';

class KidDataLinguisticSkills {
  final Kid kid;

  KidDataLinguisticSkills(this.kid);

  Future<List<SkillChartData>> fetchLinguisticSkillsProgress() async {
    var sortedSkills = kid.linguisticSkills.toList();
    sortedSkills.sort((a, b) => a.monthIndex.compareTo(b.monthIndex));

    return sortedSkills
        .map((data) => SkillChartData(
            " ${getTextForMonth(data.monthIndex)}", data.progress))
        .toList();
  }
}
