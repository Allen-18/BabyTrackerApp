import 'package:flutter/material.dart';

class MonthContentCognitiveSkill extends StatelessWidget {
  final int month;

  const MonthContentCognitiveSkill({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Detailed content for Month $month'),
    );
  }
}
