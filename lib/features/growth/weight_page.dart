import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

class GrowthWeight extends StatelessWidget {
  const GrowthWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: SizedBox(
            child: Column(
              children: [
                Flexible(child: Image.asset(AppAssets.weight)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Nu sunt înregistrări",
                  style: getRegularStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primary)),
              child: Text(
                "Adaugă greutate",
                style: getRegularStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
