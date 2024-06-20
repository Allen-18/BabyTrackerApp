import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/weight/show_add_weight_dialog.dart';
import 'package:tracker/features/growth/weight/widget_weight_table.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/features/children/kids.dart';

class GrowthWeight extends ConsumerWidget {
  const GrowthWeight({super.key, required this.currentKid});
  final Kid currentKid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialWeight = currentKid.childWeight;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            'Greutate la naștere: ${initialWeight.toStringAsFixed(1)} kg',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 6,
          child: weightTable(context, ref, currentKid),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showAddWeightDialog(context, ref, currentKid),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary)),
              child: const Text(
                "Adaugă o nouă măsurătoare",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
