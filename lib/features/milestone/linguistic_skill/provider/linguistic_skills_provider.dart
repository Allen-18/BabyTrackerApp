import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

// Provider for linguistic skills that watches changes in Firestore
final linguisticSkillsProvider =
    StateNotifierProvider<LinguisticSkillsNotifier, Map<String, List<String>>>(
        (ref) {
  return LinguisticSkillsNotifier();
});

class LinguisticSkillsNotifier
    extends StateNotifier<Map<String, List<String>>> {
  LinguisticSkillsNotifier() : super({'skills': [], 'guidance': []});

  Future<void> fetchSkills(int month) async {
    try {
      var document =
          await linguisticSkillsCollection().doc(month.toString()).get();

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
