import 'package:flutter/material.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

Widget heightNoRecords(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Image.asset(
          AppAssets.height,
          scale: 2,
        )),
        const SizedBox(height: 10),
        Text(
          "Nu sunt înregistrări",
          style: getRegularStyle(color: Colors.grey, fontSize: 20),
        ),
      ],
    ),
  );
}
