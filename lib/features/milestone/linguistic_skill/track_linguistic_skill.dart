import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/children/kids.dart';
import 'month_card_linguistic.dart';
import 'month_content_linguistic.dart';


class LinguisticSkillTracker extends StatefulWidget {
  const LinguisticSkillTracker(
      {super.key, required this.currentUser, required this.kid});
  final User currentUser;
  final Kid kid;

  @override
  LinguisticSkillTrackerState createState() => LinguisticSkillTrackerState();
}

class LinguisticSkillTrackerState extends State<LinguisticSkillTracker>
    with SingleTickerProviderStateMixin {
  final List<int> months = List.generate(12, (index) => index + 1);
  final CarouselController carouselController = CarouselController();
  int currentMonthIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dezvoltare lingvistică',
            style: getMediumStyle(color: AppColors.black, fontSize: 20)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
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
                        return MonthCardLinguisticSkill(month: month);
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
            child: MonthContentLinguisticSkill(
                month: months[currentMonthIndex], kid: widget.kid.id!),
          ),
        ],
      ),
    );
  }
}
