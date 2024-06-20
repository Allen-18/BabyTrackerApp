import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/height/provider/kid_height_measurements_provider.dart';
import 'package:tracker/features/children/height_measurements/height_measurements.dart';
import 'package:tracker/features/children/kids.dart';

Future<void> showAddHeightDialog(
    BuildContext context, WidgetRef ref, Kid currentKid) async {
  TextEditingController heightController = TextEditingController();
  final notifier = ref.read(kidHeightMeasurementsProvider(currentKid).notifier);
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adaugă Înălțimea'),
        content: TextField(
          controller: heightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Adaugă Înălțimea'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anulează'),
          ),
          TextButton(
            onPressed: () async {
              String input = heightController.text.replaceAll(',', '.');
              final isValid = RegExp(r'^\d+(\.\d+)?$').hasMatch(input);
              if (!isValid) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Valoarea introdusă nu este corectă.'),
                  ),
                );
              } else {
                notifier.addHeightMeasurement(
                  HeightMeasurements(
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
          ),
        ],
      );
    },
  );
}
