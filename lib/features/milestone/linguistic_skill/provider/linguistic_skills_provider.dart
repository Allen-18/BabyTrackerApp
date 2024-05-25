import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

// Provider for motor skills that watches changes in Firestore
final linguisticSkillsProvider =
StateNotifierProvider<LinguisticSkillsNotifier, List<String>>((ref) {
  return LinguisticSkillsNotifier();
});

class LinguisticSkillsNotifier extends StateNotifier<List<String>> {
  LinguisticSkillsNotifier() : super([]);

  Future<void> fetchSkills(int month) async {
    try {
      var document = await linguisticSkillsCollection().doc(month.toString()).get();

      if (document.exists) {
        state = List.from(document.data()?['skills'] ?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching skills: $e");
      }
      state = [];
    }
  }
}
