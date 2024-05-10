import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/skill_data.dart';

class KidDataCognitiveSkills {
  final Kid kid;

  KidDataCognitiveSkills(this.kid);

  Future<List<SkillChartData>> fetchCognitiveSkillsProgress() async {
    var sortedSkills = kid.cognitiveSkills.toList();
    sortedSkills.sort((a, b) => a.monthIndex.compareTo(b.monthIndex));

    return sortedSkills
        .map((data) => SkillChartData(
            " ${getTextForMonth(data.monthIndex)}", data.progress))
        .toList();
  }
}
