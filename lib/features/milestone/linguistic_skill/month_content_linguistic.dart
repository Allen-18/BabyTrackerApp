import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/milestone/linguistic_skill/provider/linguistic_skills_provider.dart';
import 'package:tracker/features/milestone/linguistic_skill/provider/selected_linguistic_skills_provider.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/milestone/components/skill_card.dart';
import 'package:tracker/features/children/linguisticMilestone/linguistic_kid_skills.dart';


class MonthContentLinguisticSkill extends ConsumerWidget {
  final int month;
  final String kid;

  const MonthContentLinguisticSkill(
      {super.key, required this.month, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(linguisticSkillsProvider.notifier).fetchSkills(month);
    final skills = ref.watch(linguisticSkillsProvider);
    final selectedSkillsMap = ref.watch(selectedLinguisticSkillsProvider);

    void handleLinguisticSkillSelection(int month, String skill, bool isSelected) {
      ref.read(selectedLinguisticSkillsProvider.notifier).update((state) {
        final newSkills = List<String>.from(state[month] ?? []);
        if (isSelected && !newSkills.contains(skill)) {
          newSkills.add(skill);
        } else if (!isSelected) {
          newSkills.remove(skill);
        }
        state[month] = newSkills;
        return Map<int, List<String>>.from(state);
      });
    }

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final isSkillSelected =
                        selectedSkillsMap[month]?.contains(skills[index]) ?? false;
                    return SkillCard(
                      skill: skills[index],
                      isSelected: isSkillSelected,
                      onSelected: (isSelected) => handleLinguisticSkillSelection(
                          month, skills[index], isSelected),
                    );
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                      onTap: () => saveSkills(context, ref, month, kid),
                      child: appButton(text: "Save"))),
            ],
          ),
        ));
  }
}

void saveSkills(
    BuildContext context, WidgetRef ref, int month, String kidId) async {
  try {
    final repo = ref.read(kidsRepositoryProvider);
    final currentKid = await repo.getKid(kidId);

    if (currentKid != null) {
      Map<int, List<String>> monthSkills =
      ref.read(selectedLinguisticSkillsProvider);
      List<String> selectedSkills = List<String>.from(monthSkills[month] ?? []);

      // Get total skills from the provider
      List<String> skills = ref.read(linguisticSkillsProvider);
      int totalSkills = skills.length;
      int selectedSkillsCount = selectedSkills.length;
      // Calculate the percentage of selected skills
      double selectedSkillsPercentage =
          (selectedSkillsCount / totalSkills) * 100;
      List<LinguisticKidSkills> linguisticSkills =
      List<LinguisticKidSkills>.from(currentKid.linguisticSkills);
      LinguisticKidSkills newKidSkills = LinguisticKidSkills.fromNewAction(month,
          DateTime.now().toUtc(), selectedSkills, selectedSkillsPercentage);
      int existingIndex =
      linguisticSkills.indexWhere((skill) => skill.monthIndex == month);

      if (existingIndex != -1) {
        linguisticSkills[existingIndex] = newKidSkills;
      } else {
        linguisticSkills.add(newKidSkills);
      }

      Kid updatedKid = currentKid.copyWith(linguisticSkills: linguisticSkills);
      await repo.updateLinguisticSkillsKid(updatedKid);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Skills updated successfully!')));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Kid not found')));
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving skills: $e')));
    }
  }
}
