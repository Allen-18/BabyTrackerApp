import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/weightMeasurements/weight_measurements.dart';

final kidWeightMeasurementsProvider = StateNotifierProvider.family<KidWeightMeasurements, List<WeightData>, Kid>((ref, kid) {
  return KidWeightMeasurements(kid);
});

class KidWeightMeasurements extends StateNotifier<List<WeightData>> {
  Kid currentKid;

  KidWeightMeasurements(this.currentKid) : super([]) {
    fetchWeights();
  }
  Future<void> fetchWeights() async {
    var sortedMeasurements = currentKid.weightMeasurements.toList();
    sortedMeasurements.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    var result = sortedMeasurements
        .map((data) => WeightData(data.measurements!, data.timestamp))
        .toList();
    state = result;
  }
  void addWeightMeasurement(WeightMeasurements measurement) {
    var newMeasurements = [...state, WeightData(measurement.measurements!, measurement.timestamp)];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    state = newMeasurements;  // trigger widget to rebuild
  }
}

class WeightData {
  final String value;
  final DateTime data;

  WeightData(this.value, this.data);
}
