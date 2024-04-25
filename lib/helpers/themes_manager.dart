import 'package:flutter/material.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'colors_manager.dart';
import 'dimen_manager.dart';
import 'fonts_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.lightPrimary,
    primaryColorDark: AppColors.primary,
    disabledColor: AppColors.grey,
    splashColor: AppColors.lightPrimary,
    // ripple effect color
    // cardView theme
    cardTheme: CardTheme(
        color: AppColors.darkGrey,
        shadowColor: AppColors.grey,
        elevation: AppSize.s4),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColors.primary,
        elevation: AppSize.s4,
        shadowColor: AppColors.lightPrimary,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s16, color: AppColors.darkGrey)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: AppColors.grey,
        buttonColor: AppColors.primary,
        splashColor: AppColors.lightPrimary),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle:
                getRegularStyle(color: AppColors.darkGrey, fontSize: FontSize.s18),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textTheme: TextTheme(
        displayLarge:
            getLightStyle(color: AppColors.darkGrey, fontSize: FontSize.s22),
        headlineLarge:
            getSemiBoldStyle(color: AppColors.darkGrey, fontSize: FontSize.s16),
        titleMedium:
            getMediumStyle(color: AppColors.lightGrey, fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: AppColors.grey),
        bodySmall: getRegularStyle(color: AppColors.grey),
        labelLarge: getRegularStyle(color: AppColors.grey),
        labelMedium:  getRegularStyle(color: AppColors.grey),
        labelSmall:  getRegularStyle(color: AppColors.grey),

    ),
    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: AppColors.darkGrey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: AppColors.darkGrey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: AppColors.error),


        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
