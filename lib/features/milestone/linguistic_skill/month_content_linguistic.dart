import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/milestone/linguistic_skill/provider/linguistic_skills_provider.dart';
import 'package:tracker/features/milestone/linguistic_skill/provider/selected_linguistic_skills_provider.dart';
import 'package:tracker/helpers/colors_manager.dart';
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
    final linguisticData = ref.watch(linguisticSkillsProvider);
    final skills = linguisticData['skills'] ?? [];
    final guidance = linguisticData['guidance'] ?? [];
    final selectedSkillsMap = ref.watch(selectedLinguisticSkillsProvider);

    void handleLinguisticSkillSelection(
        int month, String skill, bool isSelected) {
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
                itemCount: skills.length +
                    (guidance.isNotEmpty
                        ? 1
                        : 0),
                itemBuilder: (context, index) {
                  if (index < skills.length) {
                    final isSkillSelected =
                        selectedSkillsMap[month]?.contains(skills[index]) ??
                            false;
                    return SkillCard(
                      skill: skills[index],
                      isSelected: isSkillSelected,
                      onSelected: (isSelected) =>
                          handleLinguisticSkillSelection(
                              month, skills[index], isSelected),
                    );
                  } else if (guidance.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: AppColors.lightPrimary,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            guidance.join('\n'),
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox
                        .shrink();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => saveSkills(context, ref, month, kid),
                child: appButton(text: "Salvează"),
              ),
            ),
          ],
        ),
      ),
    );
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

      final linguisticData = ref.read(linguisticSkillsProvider);
      List<String> skills = linguisticData['skills'] ?? [];
      int totalSkills = skills.length;
      int selectedSkillsCount = selectedSkills.length;
      double selectedSkillsPercentage =
          (selectedSkillsCount / totalSkills) * 100;
      List<LinguisticKidSkills> linguisticSkills =
          List<LinguisticKidSkills>.from(currentKid.linguisticSkills);
      LinguisticKidSkills newKidSkills = LinguisticKidSkills.fromNewAction(
          month,
          DateTime.now().toUtc(),
          selectedSkills,
          selectedSkillsPercentage);
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Abilitățile au fost actualizate cu succes!')));
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Eroare la salvarea abilităților. Reîncercați')));
    }
  }
}
