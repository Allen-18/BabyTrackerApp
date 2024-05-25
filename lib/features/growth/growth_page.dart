import 'package:flutter/material.dart';
import 'package:tracker/features/growth/weight/weight_page.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/children/kids.dart';
import 'head/head_page.dart';
import 'height/height_page.dart';

class Growth extends StatelessWidget {
  const Growth({super.key, required this.currentKid});
  final Kid currentKid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Creșterea copilului',
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(
                text: "Greutate",
              ),
              Tab(
                text: "Înălțime",
              ),
              Tab(
                text: "Circumferința capului",
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            GrowthWeight(currentKid: currentKid,),
            GrowthHeight(currentKid: currentKid,),
            GrowthHead(currentKid: currentKid,),
          ],
        ),
      ),
    );
  }
}
