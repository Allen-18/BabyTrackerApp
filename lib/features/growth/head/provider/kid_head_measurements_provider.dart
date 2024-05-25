import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/headMeasurements/head_measurements.dart';

final kidHeadMeasurementsProvider = StateNotifierProvider.family<KidHeadMeasurements, List<HeadData>, Kid>((ref, kid) {
  return KidHeadMeasurements(kid);
});

class KidHeadMeasurements extends StateNotifier<List<HeadData>> {
  Kid currentKid;

  KidHeadMeasurements(this.currentKid) : super([]) {
    fetchHead();
  }

  Future<void> fetchHead() async {
    var sortedMeasurements = currentKid.headCircumferenceMeasurements.toList();
    sortedMeasurements.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    var result = sortedMeasurements
        .map((data) => HeadData(data.measurements!, data.timestamp))
        .toList();
    state = result;
  }

  void addHeadMeasurement(HeadMeasurements measurement) {
    var newMeasurements = [...state, HeadData(measurement.measurements!, measurement.timestamp)];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    state = newMeasurements;  // trigger widget to rebuild
  }
}

class HeadData {
  final String value;
  final DateTime data;

  HeadData(this.value, this.data);
}
