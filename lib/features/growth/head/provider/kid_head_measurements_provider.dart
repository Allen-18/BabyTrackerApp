import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/headMeasurements/head_measurements.dart';
import 'package:tracker/features/children/kids.dart';

final kidHeadMeasurementsProvider =
    StateNotifierProvider.family<KidHeadMeasurements, List<HeadData>, Kid>(
        (ref, kid) {
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
    var newMeasurements = [
      ...state,
      HeadData(measurement.measurements!, measurement.timestamp)
    ];
    newMeasurements.sort((a, b) => a.data.compareTo(b.data));
    updateMeasurementsToFirebase(newMeasurements, currentKid);
    state = newMeasurements; // Trigger widget to rebuild
  }

  void editHeadMeasurement(HeadData oldHeadData, String newValue) {
    final updatedHeadData = HeadData(newValue, oldHeadData.data);
    final updatedMeasurements = state.map((head) {
      if (head == oldHeadData) {
        return updatedHeadData;
      }
      return head;
    }).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void deleteHeadMeasurement(HeadData headData) {
    final updatedMeasurements =
        state.where((head) => head != headData).toList();
    updateMeasurementsToFirebase(updatedMeasurements, currentKid);
    state = updatedMeasurements;
  }

  void updateMeasurementsToFirebase(
      List<HeadData> measurements, Kid currentKid) {
    try {
      final List<Map<String, dynamic>> measurementsData =
          measurements.map((head) {
        return {
          'measurements': head.value,
          'timestamp': head.data.toString(),
        };
      }).toList();
      FirebaseFirestore.instance.collection('kids').doc(currentKid.id).update(
          {'headCircumferenceMeasurements': measurementsData}).then((_) {
        if (kDebugMode) {
          print('Head measurements updated successfully in Firebase!');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to update head measurements in Firebase: $error');
        }
      });
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error updating head measurements in Firebase: $e');
      }
      if (kDebugMode) {
        print('Stacktrace: $stacktrace');
      }
    }
  }
}

class HeadData {
  final String value;
  final DateTime data;

  HeadData(this.value, this.data);
}
