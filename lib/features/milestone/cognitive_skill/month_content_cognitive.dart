import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/milestone/cognitive_skill/provider/cognitive_skills_provider.dart';
import 'package:tracker/features/milestone/cognitive_skill/provider/selected_cognitive_skills_provider.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/children/cognitiveMilestone/cognitive_kid_skills.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/milestone/components/skill_card.dart';


class MonthContentCognitiveSkill extends ConsumerWidget {
  final int month;
  final String kid;

  const MonthContentCognitiveSkill(
      {super.key, required this.month, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(cognitiveSkillsProvider.notifier).fetchCognitiveSkills(month);
    final skills = ref.watch(cognitiveSkillsProvider);
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
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final isSkillSelected =
                    selectedSkillsMap[month]?.contains(skills[index]) ?? false;
                return SkillCard(
                  skill: skills[index],
                  isSelected: isSkillSelected,
                  onSelected: (isSelected) => handleCognitiveSkillSelection(
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
  BuildContext context,
  WidgetRef ref,
  int month,
  String kidId,
) async {
  try {
    // Fetch current kid data
    final repo = ref.read(kidsRepositoryProvider);
    final currentKid = await repo.getKid(kidId);

    if (currentKid != null) {
      // Get selected skills from the provider
      Map<int, List<String>> monthSkills =
          ref.read(selectedCognitiveSkillsProvider);
      List<String> selectedSkills = List<String>.from(monthSkills[month] ?? []);

      List<CognitiveKidSkills> cognitiveSkills =
          List<CognitiveKidSkills>.from(currentKid.cognitiveSkills);

      // Get total skills from the provider
      List<String> skills = ref.read(cognitiveSkillsProvider);
      int totalSkills = skills.length;
      int selectedSkillsCount = selectedSkills.length;
      // Calculate the percentage of selected skills
      double selectedSkillsPercentage =
          (selectedSkillsCount / totalSkills) * 100;

      // Create a new entry or update the existing entry for the month
      CognitiveKidSkills newKidSkillEntry = CognitiveKidSkills.fromNewAction(
          month,
          DateTime.now().toUtc(),
          selectedSkills,
          selectedSkillsPercentage);
      int existingIndex =
          cognitiveSkills.indexWhere((skill) => skill.monthIndex == month);

      if (existingIndex != -1) {
        // Update existing entry
        cognitiveSkills[existingIndex] = newKidSkillEntry;
      } else {
        // Add new entry if not existing
        cognitiveSkills.add(newKidSkillEntry);
      }

      // Save the updated Kid object
      Kid updatedKid = currentKid.copyWith(cognitiveSkills: cognitiveSkills);
      await repo.updateCognitiveSkillsKid(updatedKid);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Skills updated successfully!')));
      }
    } else {
      // Kid not found error handling
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Kid not found')));
      }
    }
  } catch (e) {
    // Error handling
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving skills: $e')));
    }
  }
}
