import 'package:flutter_riverpod/flutter_riverpod.dart';

final medicationProvider = StateNotifierProvider<MedicationNotifier, List<Medication>>((ref) {
  return MedicationNotifier();
});

class Medication {
  final String name;
  final String dosage;
  final DateTime timestamp;

  Medication({required this.name, required this.dosage, required this.timestamp});
}

class MedicationNotifier extends StateNotifier<List<Medication>> {
  MedicationNotifier() : super([]);

  void addMedication(String name, String dosage, DateTime timestamp) {
    state = [
      ...state,
      Medication(name: name, dosage: dosage, timestamp: timestamp)
    ];
  }
}
