import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/cognitive/kid_data_cognitive_progress.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/progress/components/cognitive_widget.dart';
import 'package:tracker/features/progress/components/linguistic_widget.dart';
import 'package:tracker/features/progress/components/motor_widget.dart';
import 'package:tracker/features/progress/components/social_widget.dart';
import 'package:tracker/features/progress/linguistic/kid_data_linguistic_progress.dart';
import 'package:tracker/features/progress/social/kid_data_social_progress.dart';

class ProgressPage extends ConsumerWidget {
  final Kid currentKid;

  const ProgressPage({super.key, required this.currentKid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    KidDataCognitiveSkills kidDataCognitive =
        KidDataCognitiveSkills(currentKid);
    KidDataSocialSkills kidDataSocial = KidDataSocialSkills(currentKid);
    KidDataLinguisticSkills kidDataLinguistic =
        KidDataLinguisticSkills(currentKid);
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Dezvoltare  ${currentKid.name}",
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cognitiv'),
              Tab(text: 'Motor'),
              Tab(text: 'Social'),
              Tab(text: 'Lingvistic'),
            ],
            isScrollable: true,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          width: size.width,
          height: size.height,
          child: TabBarView(
            children: [
              cognitiveWidget(context, kidDataCognitive), // cognitive progress
              motorWidget(
                context,
                currentKid,
              ), // motor progress
              socialWidget(context, kidDataSocial), // social progress
              linguisticWidget(
                  context, kidDataLinguistic), // linguistic progress
            ],
          ),
        ),
      ),
    );
  }
}
