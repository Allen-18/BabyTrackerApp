import 'package:flutter/material.dart';

class MonthContentCognitiveSkill extends StatelessWidget {
  final int month;

  const MonthContentCognitiveSkill({Key? key, required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Detailed content for Month $month'),
    );
  }
}
