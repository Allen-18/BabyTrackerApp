import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});
  @override
  State<Progress> createState() => ProgressState();
}

class ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Progress",
          style: getMediumStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "General",
              style: getMediumStyle(color: AppColors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
