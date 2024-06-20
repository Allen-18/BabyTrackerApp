import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/height_measurements/height_measurements.dart';

final kidHeightMeasurementsProvider =
    StateNotifierProvider.family<KidHeightMeasurements, List<HeightData>, Kid>(
        (ref, kid) {
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
    var newMeasurements = [
      ...state,
      HeightData(measurement.measurements!, measurement.timestamp)
    ];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    updateMeasurementsToFirebase(newMeasurements, currentKid);
    state = newMeasurements; // Trigger widget to rebuild
  }

  void editHeightMeasurement(HeightData oldHeightData, String newValue) {
    final updatedHeightData = HeightData(newValue, oldHeightData.data);
    final updatedMeasurements = state.map((height) {
      if (height == oldHeightData) {
        return updatedHeightData;
      }
      return height;
    }).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void deleteHeightMeasurement(HeightData heightData) {
    final updatedMeasurements =
        state.where((height) => height != heightData).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void updateMeasurementsToFirebase(
      List<HeightData> measurements, Kid currentKid) {
    try {
      final List<Map<String, dynamic>> measurementsData =
          measurements.map((height) {
        return {
          'measurements': height.value,
          'timestamp': height.data.toString(),
        };
      }).toList();
      FirebaseFirestore.instance
          .collection('kids')
          .doc(currentKid.id)
          .update({'heightMeasurements': measurementsData}).then((_) {
        if (kDebugMode) {
          print('Height measurements updated successfully in Firebase!');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to update height measurements in Firebase: $error');
        }
      });
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error updating height measurements in Firebase: $e');
      }
      if (kDebugMode) {
        print('Stacktrace: $stacktrace');
      }
    }
  }
}

class HeightData {
  final String value;
  final DateTime data;

  HeightData(this.value, this.data);
}
