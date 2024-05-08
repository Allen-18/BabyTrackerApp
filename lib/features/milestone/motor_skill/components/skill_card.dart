import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

class SkillCard extends StatelessWidget {
  final String skill;
  final bool isSelected;
  final Function(bool isSelected) onSelected;
  const SkillCard(
      {super.key,
      required this.skill,
      required this.onSelected,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.lightPrimary,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(skill,
                style: getMediumStyle(color: Colors.blueGrey, fontSize: 18)),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                if (value != null) {
                  onSelected(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
