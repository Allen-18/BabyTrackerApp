import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/weightMeasurements/weight_measurements.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'kid_weight_measurements_provider.dart';


Future<void> showAddWeightDialog(BuildContext context, WidgetRef ref, Kid currentKid,) async {
  TextEditingController weightController = TextEditingController();

  Future<void> addWeightMeasurementAndUpdate(Kid kid, double weight) async {
    WeightMeasurements newMeasurement = WeightMeasurements.fromNewAction(
        DateTime.now(),
        weight.toString()
    );
    List<WeightMeasurements> updatedMeasurements = List.from(kid.weightMeasurements)..add(newMeasurement);
    Kid updatedKid = kid.copyWith(weightMeasurements: updatedMeasurements);
    // Update the kid in the database
    final repo = ref.read(kidsRepositoryProvider);
    await repo.updateWeightMeasurementsForKid(updatedKid);
  }
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adaugă greutatea'),
        content: TextField(
          controller: weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Adaugă greutatea'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              double? weight = double.tryParse(weightController.text);
              if (weight != null) {
                addWeightMeasurementAndUpdate(currentKid, weight).then((result) {
                  final notifier = ref.read(kidWeightMeasurementsProvider(currentKid).notifier);
                  notifier.addWeightMeasurement(WeightMeasurements(measurements: weightController.text, timestamp: DateTime.now()));
                  Navigator.pop(context);
                });
              }
            },
            child: const Text('Salvează'),
          ),
        ],
      );
    },
  );
}