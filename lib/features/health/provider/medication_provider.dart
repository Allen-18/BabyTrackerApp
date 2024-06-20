import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final medicationProvider =
    StateNotifierProvider<MedicationNotifier, List<Medication>>((ref) {
  return MedicationNotifier();
});

class Medication {
  final String name;
  final String dosage;
  final DateTime timestamp;

  Medication(
      {required this.name, required this.dosage, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      dosage: map['dosage'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class MedicationNotifier extends StateNotifier<List<Medication>> {
  MedicationNotifier() : super([]) {
    _loadMedications();
  }

  Future<void> _loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? medicationsJson = prefs.getString('medications');
    if (medicationsJson != null) {
      final List<dynamic> medicationsList = json.decode(medicationsJson);
      state = medicationsList.map((item) => Medication.fromMap(item)).toList();
    }
  }

  Future<void> _saveMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final String medicationsJson =
        json.encode(state.map((item) => item.toMap()).toList());
    await prefs.setString('medications', medicationsJson);
  }

  void addMedication(String name, String dosage, DateTime timestamp) {
    state = [
      ...state,
      Medication(name: name, dosage: dosage, timestamp: timestamp)
    ];
    _saveMedications();
  }

  void editMedication(
      int index, String name, String dosage, DateTime timestamp) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Medication(name: name, dosage: dosage, timestamp: timestamp)
        else
          state[i]
    ];
    _saveMedications();
  }

  void deleteMedication(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
    _saveMedications();
  }
}
