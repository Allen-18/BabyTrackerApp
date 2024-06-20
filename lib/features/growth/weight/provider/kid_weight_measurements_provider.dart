import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/weightMeasurements/weight_measurements.dart';

final kidWeightMeasurementsProvider =
    StateNotifierProvider.family<KidWeightMeasurements, List<WeightData>, Kid>(
        (ref, kid) {
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
    var newMeasurements = [
      ...state,
      WeightData(measurement.measurements!, measurement.timestamp)
    ];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    updateMeasurementsToFirebase(newMeasurements, currentKid);
    state = newMeasurements; // Trigger widget to rebuild
  }

  void editWeightMeasurement(WeightData oldWeightData, String newValue) {
    final updatedWeightData = WeightData(newValue, oldWeightData.data);
    final updatedMeasurements = state.map((weight) {
      if (weight == oldWeightData) {
        return updatedWeightData;
      }
      return weight;
    }).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void deleteWeightMeasurement(WeightData weightData) {
    final updatedMeasurements =
        state.where((weight) => weight != weightData).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void updateMeasurementsToFirebase(
      List<WeightData> measurements, Kid currentKid) {
    try {
      final List<Map<String, dynamic>> measurementsData =
          measurements.map((weight) {
        return {
          'measurements': weight.value,
          'timestamp': weight.data.toString(),
        };
      }).toList();
      FirebaseFirestore.instance
          .collection('kids')
          .doc(currentKid.id)
          .update({'weightMeasurements': measurementsData}).then((_) {
        if (kDebugMode) {
          print('Weight measurements updated successfully in Firebase!');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to update weight measurements in Firebase: $error');
        }
      });
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error updating weight measurements in Firebase: $e');
      }
      if (kDebugMode) {
        print('Stacktrace: $stacktrace');
      }
    }
  }
}

class WeightData {
  final String value;
  final DateTime data;

  WeightData(this.value, this.data);
}
