import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/growth/head/show_add_head_circumference_dialog.dart';
import 'package:tracker/features/growth/head/widget_head_table.dart';
import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

class GrowthHead extends ConsumerWidget {
  const GrowthHead({super.key, required this.currentKid});
  final Kid currentKid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialHead = currentKid.childHeadCircumference;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            'Circumferința capului la naștere: ${initialHead.toStringAsFixed(1)} cm',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 6,
          child: headTable(context, ref, currentKid),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showAddHeadCircumferenceDialog(context, ref, currentKid),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary)),
              child: Text(
                "Adaugă o nouă măsurătoare",
                style: getRegularStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}