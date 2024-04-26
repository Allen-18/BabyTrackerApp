import 'package:flutter/material.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'colors_manager.dart';

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

Widget appButton({required String text, Color? background, Color? textColor}) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: background ?? AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: getRegularStyle(color: textColor ?? AppColors.white, fontSize: 20),
    ),
  );
}

Widget categoryCard({required Widget widget}) {
  return Container(
      height: 170,
      width: 175,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ]),
      alignment: Alignment.center,
      child: widget);
}
