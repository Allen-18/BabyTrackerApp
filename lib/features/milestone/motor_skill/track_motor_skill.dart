import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'month_card_motor.dart';
import 'month_content_motor.dart';

class MotorSkillTracker extends StatefulWidget {
  const MotorSkillTracker({super.key});

  @override
  MotorSkillTrackerState createState() => MotorSkillTrackerState();
}

class MotorSkillTrackerState extends State<MotorSkillTracker> with SingleTickerProviderStateMixin {
  final List<int> months = List.generate(12, (index) => index + 1);
  final CarouselController carouselController = CarouselController();
  int currentMonthIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Motor Skill Tracker',style: getMediumStyle(color: AppColors.black, fontSize: 20)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 24),
                onPressed: () {
                  carouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 50,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.4,
                    aspectRatio: 4.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentMonthIndex = index;
                      });
                    },
                  ),
                  items: months.map((month) {
                    return Builder(
                      builder: (BuildContext context) {
                        return MonthCardMotorSkill(month: month);
                      },
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, size: 24),
                onPressed: () {
                  carouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: MonthContentMotorSkill(month: months[currentMonthIndex]),
          ),
        ],
      ),
    );
  }
}