import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/weightMeasurements/weight_measurements.dart';
import 'provider/kid_weight_measurements_provider.dart';

Future<void> showAddWeightDialog(
    BuildContext context, WidgetRef ref, Kid currentKid) async {
  TextEditingController weightController = TextEditingController();
  final notifier = ref.read(kidWeightMeasurementsProvider(currentKid).notifier);
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adaugă Greutatea'),
        content: TextField(
          controller: weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Adaugă Greutatea'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anulează'),
          ),
          TextButton(
            onPressed: () {
              String input = weightController.text.replaceAll(',', '.');
              final isValid = RegExp(r'^\d+(\.\d+)?$').hasMatch(input);
              double.tryParse(input);
              if (!isValid) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Valoarea introdusă nu este corectă.'),
                  ),
                );
              } else {
                notifier.addWeightMeasurement(
                  WeightMeasurements(
                    measurements: input,
                    timestamp: DateTime.now(),
                  ),
                );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Salvează'),
          )
        ],
      );
    },
  );
}
