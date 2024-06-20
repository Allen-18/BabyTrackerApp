import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/head/provider/kid_head_measurements_provider.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/headMeasurements/head_measurements.dart';

Future<void> showAddHeadCircumferenceDialog(
    BuildContext context, WidgetRef ref, Kid currentKid) async {
  TextEditingController headController = TextEditingController();
  final notifier = ref.read(kidHeadMeasurementsProvider(currentKid).notifier);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Adaugă Circumferința Capului'),
        content: TextField(
          controller: headController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
              hintText: 'Adaugă Circumferința Capului (cm)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anulează'),
          ),
          TextButton(
            onPressed: () {
              String input = headController.text.replaceAll(',', '.');
              final isValid = RegExp(r'^\d+(\.\d+)?$').hasMatch(input);
              if (!isValid) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Valoarea introdusă nu este corectă.'),
                  ),
                );
              } else {
                notifier.addHeadMeasurement(
                  HeadMeasurements(
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
