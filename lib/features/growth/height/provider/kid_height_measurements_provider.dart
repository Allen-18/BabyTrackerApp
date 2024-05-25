import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/height_measurements/height_measurements.dart';

final kidHeightMeasurementsProvider = StateNotifierProvider.family<KidHeightMeasurements, List<HeightData>, Kid>((ref, kid) {
  return KidHeightMeasurements(kid);
});

class KidHeightMeasurements extends StateNotifier<List<HeightData>> {
  Kid currentKid;

  KidHeightMeasurements(this.currentKid) : super([]) {
    fetchHeights();
  }

  Future<void> fetchHeights() async {
    var sortedMeasurements = currentKid.heightMeasurements.toList();
    sortedMeasurements.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    var result = sortedMeasurements
        .map((data) => HeightData(data.measurements!, data.timestamp))
        .toList();
    state = result;
  }

  void addHeightMeasurement(HeightMeasurements measurement) {
    var newMeasurements = [...state, HeightData(measurement.measurements!, measurement.timestamp)];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    state = newMeasurements;  // trigger widget to rebuild
  }
}

class HeightData {
  final String value;
  final DateTime data;

  HeightData(this.value, this.data);
}
