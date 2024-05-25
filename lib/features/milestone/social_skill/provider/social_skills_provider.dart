import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

// Provider for motor skills that watches changes in Firestore
final socialSkillsProvider =
StateNotifierProvider<SocialSkillsNotifier, List<String>>((ref) {
  return SocialSkillsNotifier();
});

class SocialSkillsNotifier extends StateNotifier<List<String>> {
  SocialSkillsNotifier() : super([]);

  Future<void> fetchSkills(int month) async {
    try {
      var document = await socialSkillsCollection().doc(month.toString()).get();

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
