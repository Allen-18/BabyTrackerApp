import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

// Provider for motor skills that watches changes in Firestore
final motorSkillsProvider =
    StateNotifierProvider<MotorSkillsNotifier, Map<String, List<String>>>(
        (ref) {
  return MotorSkillsNotifier();
});

class MotorSkillsNotifier extends StateNotifier<Map<String, List<String>>> {
  MotorSkillsNotifier() : super({'skills': [], 'guidance': []});

  Future<void> fetchSkills(int month) async {
    try {
      var document = await motorSkillsCollection().doc(month.toString()).get();

      if (document.exists) {
        state = {
          'skills': List.from(document.data()?['skills'] ?? []),
          'guidance': List.from(document.data()?['guidance'] ?? []),
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching skills: $e");
      }
      state = {'skills': [], 'guidance': []};
    }
  }
}
