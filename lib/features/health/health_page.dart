import 'package:flutter/material.dart';
import 'package:tracker/features/Health/temperature_page.dart';
import 'package:tracker/features/Health/vaccination_page.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'medication_page.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => HealthMainState();
}

class HealthMainState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Health',
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(
                text: "TEMPERATURE",
              ),
              Tab(
                text: "MEDICATION",
              ),
              Tab(
                text: "VACCINATION",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HealthTemperature(),
            HealthMedication(),
            HealthVaccination(),
          ],
        ),
      ),
    );
  }
}
