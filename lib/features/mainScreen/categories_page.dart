import 'package:flutter/material.dart';
import 'package:tracker/features/milestone/cognitive_skill/track_cognitive_skill.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/growth/growth_page.dart';
import 'package:tracker/features/health/health_page.dart';
import 'package:tracker/features/milestone/motor_skill/track_motor_skill.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final List data = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Baby",
          style: getMediumStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MotorSkillTracker(),
                          )),
                      child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Image.asset(
                                    AppAssets.physical,
                                    scale: 1,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Motor Milestone",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25 ),textAlign: TextAlign.center,
                              )
                            ],
                          ))),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CognitiveSkillTracker(),
                          )),
                      child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Image.asset(
                                    AppAssets.cognitive,
                                    scale: 1,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Cognitive Milestone",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25 ), textAlign: TextAlign.center,
                              )
                            ],
                          ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Health(),
                          )),
                      child: categoryCard(
                          widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Image.asset(
                            AppAssets.health,
                            scale: 1,
                          )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "health",
                            style: getMediumStyle(
                                color: AppColors.grey, fontSize: 25),
                          )
                        ],
                      ))),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Growth(),
                          )),
                      child: categoryCard(
                          widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Image.asset(
                            AppAssets.growth,
                            scale: 1,
                          )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "growth",
                            style: getMediumStyle(
                                color: AppColors.grey, fontSize: 25),
                          )
                        ],
                      )))
                ],
              ),
            ],
          )),
    );
  }
}
