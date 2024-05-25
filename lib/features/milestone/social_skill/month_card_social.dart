import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/features/common/utils/utils.dart';

class MonthCardSocialSkill extends StatelessWidget {
  final int month;

  const MonthCardSocialSkill({super.key, required this.month});

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
}
