import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/skill_data.dart';

class KidDataSocialSkills {
  final Kid kid;

  KidDataSocialSkills(this.kid);

  Future<List<SkillChartData>> fetchSocialSkillsProgress() async {
    var sortedSkills = kid.socialSkills.toList();
    sortedSkills.sort((a, b) => a.monthIndex.compareTo(b.monthIndex));

    return sortedSkills
        .map((data) => SkillChartData(
        " ${getTextForMonth(data.monthIndex)}", data.progress))
        .toList();
  }
}
