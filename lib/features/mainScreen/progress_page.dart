import 'package:flutter/material.dart';
import 'package:tracker/features/progress/motor/kid_data_motor_progress.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/progress/cognitive/kid_data_cognitive_progress.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/progress/components/cognitive_widget.dart';
import 'package:tracker/features/progress/components/linguistic_widget.dart';
import 'package:tracker/features/progress/components/motor_widget.dart';
import 'package:tracker/features/progress/components/social_widget.dart';

class ProgressPage extends StatefulWidget {
  final Kid currentKid;

  const ProgressPage({super.key, required this.currentKid});

  @override
  State<ProgressPage> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    KidDataCognitiveSkills kidDataCognitive =
        KidDataCognitiveSkills(widget.currentKid);
    KidDataMotorSkills kidDataMotor = KidDataMotorSkills(widget.currentKid);
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Dezvoltare  ${widget.currentKid.name}",
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Motor'),
              Tab(text: 'Cognitiv'),
              Tab(text: 'Lingvistic'),
              Tab(text: 'Social'),
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
              motorWidget(context, kidDataMotor), // motor progress
              socialWidget(
                  context, kidDataMotor), // social progress - will be changed
              linguisticWidget(context,
                  kidDataMotor), // linguistic progress - will be changed
            ],
          ),
        ),
      ),
    );
  }
}
