import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/skill_data.dart';
import 'package:tracker/features/progress/social/social_progress.dart';
import '../social/kid_data_social_progress.dart' show KidDataSocialSkills;

Widget socialWidget(BuildContext context, KidDataSocialSkills kidDataService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Expanded(
        child: FutureBuilder<List<SkillChartData>>(
          future: kidDataService.fetchSocialSkillsProgress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return SocialSkillSelectionChart(
                  chartData: snapshot.data!, kid: kidDataService.kid.id!,);
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
