import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/head/provider/kid_head_measurements_provider.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/headMeasurements/head_measurements.dart';
import 'package:tracker/features/children/kids_repository.dart';

Future<void> showAddHeadCircumferenceDialog(BuildContext context, WidgetRef ref, Kid currentKid) async {
  TextEditingController headController = TextEditingController();

  Future<void> addHeadMeasurementAndUpdate(Kid kid, double head) async {
    HeadMeasurements newMeasurement = HeadMeasurements.fromNewAction(
        DateTime.now(),
        head.toString()
    );
    List<HeadMeasurements> updatedMeasurements = List.from(kid.headCircumferenceMeasurements)..add(newMeasurement);
    Kid updatedKid = kid.copyWith(headCircumferenceMeasurements: updatedMeasurements);
    // Update the kid in the database
    final repo = ref.read(kidsRepositoryProvider);
    await repo.updateHeadMeasurementsForKid(updatedKid);
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Head Circumference'),
        content: TextField(
          controller: headController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Add head circumference (cm)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              double? circumference = double.tryParse(headController.text);
              if (circumference != null) {
                addHeadMeasurementAndUpdate(currentKid, circumference).then((result) {
                  final notifier = ref.read(kidHeadMeasurementsProvider(currentKid).notifier);
                  notifier.addHeadMeasurement(HeadMeasurements(measurements: headController.text, timestamp: DateTime.now())); // Ensure the measurements field is a List<String>
                  Navigator.pop(context);
                });
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
