import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/skill_data.dart';

final kidMotorProvider =
    StateNotifierProvider.family<KidDataMotorSkills, List<MotorData>, Kid>(
        (ref, kid) {
  return KidDataMotorSkills(kid);
});

class KidDataMotorSkills extends StateNotifier<List<MotorData>> {
  final Kid kid;
  KidDataMotorSkills(this.kid) : super([]) {
    fetchMotorSkillsProgress();
  }

  Future<List<SkillChartData>> fetchMotorSkillsProgress() async {
    var sortedSkills = kid.motorSkills.toList();
    sortedSkills.sort((a, b) => a.monthIndex.compareTo(b.monthIndex));

    return sortedSkills
        .map((data) => SkillChartData(
            " ${getTextForMonth(data.monthIndex)}", data.progress))
        .toList();
  }
}

class MotorData {
  final List<String> value;
  final DateTime data;
  final int index;
  final double progress;

  MotorData(this.value, this.data, this.progress, this.index);
}
