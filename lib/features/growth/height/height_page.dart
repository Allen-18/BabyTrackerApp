import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/growth/height/show_add_height_dialog.dart';
import 'package:tracker/features/growth/height/widget_height_table.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/children/kids.dart';

class GrowthHeight extends ConsumerWidget {
  const GrowthHeight({super.key, required this.currentKid});
  final Kid currentKid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialHeight = currentKid.childHeight;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            'Înălțimea la naștere: ${initialHeight.toStringAsFixed(1)} cm',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 6,
          child: heightTable(context, ref, currentKid),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showAddHeightDialog(context, ref, currentKid),
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
