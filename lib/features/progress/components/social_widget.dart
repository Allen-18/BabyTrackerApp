import 'package:flutter/material.dart';
import 'package:tracker/features/progress/cognitive/cognitive_progress.dart';
import 'package:tracker/features/progress/motor/kid_data_motor_progress.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/skill_data.dart';

Widget socialWidget(BuildContext context, KidDataMotorSkills kidDataService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Expanded(
        child: FutureBuilder<List<SkillChartData>>(
          future: kidDataService.fetchMotorSkillsProgress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return CognitiveSkillSelectionChart(
                  chartData: snapshot.data!); // it will be changed
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
