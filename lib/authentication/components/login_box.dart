import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';

Widget loginBox(
    {required String text,
    required Widget child,
    required BuildContext context}) {
  return Container(
    height: 60,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: AppColors.grey, blurRadius: 4, offset: const Offset(1, 3)),
      ],
    ),
    alignment: Alignment.centerLeft,
    child: Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      )),
      child: child,
    ),
  );
}
