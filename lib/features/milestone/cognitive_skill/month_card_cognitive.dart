import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';

class MonthCardCognitiveSkill extends StatelessWidget {
  final int month;

  const MonthCardCognitiveSkill({super.key, required this.month});

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
          'Month $month',
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }
}
