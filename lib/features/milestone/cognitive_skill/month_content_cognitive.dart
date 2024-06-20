import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/milestone/cognitive_skill/provider/cognitive_skills_provider.dart';
import 'package:tracker/features/milestone/cognitive_skill/provider/selected_cognitive_skills_provider.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/children/cognitiveMilestone/cognitive_kid_skills.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/milestone/components/skill_card.dart';

import '../../../helpers/colors_manager.dart';

class MonthContentCognitiveSkill extends ConsumerWidget {
  final int month;
  final String kid;

  const MonthContentCognitiveSkill(
      {super.key, required this.month, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(cognitiveSkillsProvider.notifier).fetchCognitiveSkills(month);
    final cognitiveData = ref.watch(cognitiveSkillsProvider);
    final skills = cognitiveData['skills'] ?? [];
    final guidance = cognitiveData['guidance'] ?? [];
    final selectedSkillsMap = ref.watch(selectedCognitiveSkillsProvider);

    void handleCognitiveSkillSelection(
        int month, String skill, bool isSelected) {
      ref.read(selectedCognitiveSkillsProvider.notifier).update((state) {
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
                      onSelected: (isSelected) => handleCognitiveSkillSelection(
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

void handleCognitiveSkillSelection(BuildContext context, WidgetRef ref,
    int month, String skill, bool isSelected) {
  ref.read(selectedCognitiveSkillsProvider.notifier).update((state) {
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

void saveSkills(
    BuildContext context, WidgetRef ref, int month, String kidId) async {
  try {
    final repo = ref.read(kidsRepositoryProvider);
    final currentKid = await repo.getKid(kidId);
    if (currentKid != null) {
      final monthSkills = ref.read(selectedCognitiveSkillsProvider);
      final selectedSkills = List<String>.from(monthSkills[month] ?? []);
      final cognitiveSkills =
          List<CognitiveKidSkills>.from(currentKid.cognitiveSkills);
      final cognitiveData = ref.read(cognitiveSkillsProvider);
      final skills = cognitiveData['skills'] ?? [];
      final totalSkills = skills.length;
      final selectedSkillsCount = selectedSkills.length;
      final selectedSkillsPercentage =
          (selectedSkillsCount / totalSkills) * 100;
      final newKidSkillEntry = CognitiveKidSkills.fromNewAction(month,
          DateTime.now().toUtc(), selectedSkills, selectedSkillsPercentage);
      final existingIndex =
          cognitiveSkills.indexWhere((skill) => skill.monthIndex == month);
      if (existingIndex != -1) {
        cognitiveSkills[existingIndex] = newKidSkillEntry;
      } else {
        cognitiveSkills.add(newKidSkillEntry);
      }
      final updatedKid = currentKid.copyWith(cognitiveSkills: cognitiveSkills);
      await repo.updateCognitiveSkillsKid(updatedKid);
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
