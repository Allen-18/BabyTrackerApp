import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/height/provider/kid_height_measurements_provider.dart';
import 'package:tracker/features/children/height_measurements/height_measurements.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/kids_repository.dart';

Future<void> showAddHeightDialog(BuildContext context, WidgetRef ref, Kid currentKid) async {
  TextEditingController heightController = TextEditingController();

  Future<void> addHeightMeasurementAndUpdate(Kid kid, double height) async {
    HeightMeasurements newMeasurement = HeightMeasurements.fromNewAction(
        DateTime.now(),
        height.toString()
    );
    List<HeightMeasurements> updatedMeasurements = List.from(kid.heightMeasurements)..add(newMeasurement);
    Kid updatedKid = kid.copyWith(heightMeasurements: updatedMeasurements);
    // Update the kid in the database
    final repo = ref.read(kidsRepositoryProvider);
    await repo.updateHeightMeasurementsForKid(updatedKid);
  }

  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Height'),
        content: TextField(
          controller: heightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Add height'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              double? height = double.tryParse(heightController.text);
              if (height != null) {
                addHeightMeasurementAndUpdate(currentKid, height).then((result) {
                  final notifier = ref.read(kidHeightMeasurementsProvider(currentKid).notifier);
                  notifier.addHeightMeasurement(HeightMeasurements(measurements: heightController.text, timestamp: DateTime.now()));
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
