import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/services/collections.dart';

final vaccinationProvider =
    StateNotifierProvider<VaccinationNotifier, List<Vaccination>>((ref) {
  return VaccinationNotifier();
});

class VaccinationNotifier extends StateNotifier<List<Vaccination>> {
  VaccinationNotifier() : super([]);

  Future<void> fetchVaccinations() async {
    try {
      var querySnapshot = await vaccinationCollection().get();
      List<Vaccination> vaccines = [];

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        int month;
        try {
          month = int.parse(data['index']);
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing index: $e");
          }
          continue;
        }

        for (var vaccine in data['vaccines']) {
          vaccines.add(Vaccination(name: vaccine, month: month));
        }
      }
      vaccines.sort((a, b) => a.month.compareTo(b.month));

      state = vaccines;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching vaccinations: $e");
      }
      state = [];
    }
  }
}

class Vaccination {
  final String name;
  final int month;

  Vaccination({required this.name, required this.month});

  factory Vaccination.fromMap(Map<String, dynamic> map, int month) {
    return Vaccination(
      name: map['name'] as String,
      month: month,
    );
  }
}
