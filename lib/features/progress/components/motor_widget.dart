import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/skill_data.dart';
import 'package:tracker/features/progress/motor/kid_data_motor_progress.dart';
import 'package:tracker/features/progress/motor/motor_progress.dart';

Widget motorWidget(BuildContext context, KidDataMotorSkills kidData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Expanded(
        child: FutureBuilder<List<SkillChartData>>(
          future: kidData.fetchMotorSkillsProgress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return MotorSkillSelectionChart(chartData: snapshot.data!);
            } else {
              return Column(children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Flexible(child: Image.asset(AppAssets.noData)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nu sunt înregistrări",
                          style:
                              getRegularStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              ]);
            }
          },
        ),
      ),
    ],
  );
}