import 'package:flutter/material.dart';

class MonthContentMotorSkill extends StatelessWidget {
  final int month;

  const MonthContentMotorSkill({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Detailed content for Month $month'),
    );
  }
}
