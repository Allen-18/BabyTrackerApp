import 'package:flutter/material.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'colors_manager.dart';

Widget appButton({
  required String text,
  Color? background,
  Color? textColor,
  void Function()? onPressed,
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background ?? AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style:
            getRegularStyle(color: textColor ?? AppColors.white, fontSize: 20),
      ),
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
