import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

// Provider for cognitive skills that watches changes in Firestore
final cognitiveSkillsProvider =
    StateNotifierProvider<CognitiveSkillsNotifier, Map<String, List<String>>>(
        (ref) {
  return CognitiveSkillsNotifier();
});

class CognitiveSkillsNotifier extends StateNotifier<Map<String, List<String>>> {
  CognitiveSkillsNotifier() : super({'skills': [], 'guidance': []});

  Future<void> fetchCognitiveSkills(int month) async {
    try {
      var document =
          await cognitiveSkillsCollection().doc(month.toString()).get();

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
