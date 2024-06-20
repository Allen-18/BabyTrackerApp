import 'package:flutter/material.dart';
import 'package:tracker/features/progress/cognitive/kid_data_cognitive_progress.dart';
import 'package:tracker/features/progress/cognitive/cognitive_progress.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/skill_data.dart';

Widget cognitiveWidget(
    BuildContext context, KidDataCognitiveSkills kidDataCognitive) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Expanded(
        child: FutureBuilder<List<SkillChartData>>(
          future: kidDataCognitive.fetchCognitiveSkillsProgress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return CognitiveSkillSelectionChart(
                chartData: snapshot.data!,
                kid: kidDataCognitive.kid.id!,
              );
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
