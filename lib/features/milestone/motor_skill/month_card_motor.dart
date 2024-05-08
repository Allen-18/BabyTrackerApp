import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';

class MonthCardMotorSkill extends StatelessWidget {
  final int month;

  const MonthCardMotorSkill({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
      ),
      child: Center(
        child: Text(
          getTextForMonth(month),
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  String getTextForMonth(int month) {
    switch (month) {
      case 1:
        return 'Prima lună';
      case 2:
        return 'A doua lună';
      default:
        return '$month luni';
    }
  }
}
