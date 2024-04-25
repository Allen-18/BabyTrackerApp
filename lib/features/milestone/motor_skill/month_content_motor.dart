import 'package:flutter/material.dart';

class MonthContentMotorSkill extends StatelessWidget {
  final int month;

  const MonthContentMotorSkill({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Detailed content for Month $month'),
    );
  }
}