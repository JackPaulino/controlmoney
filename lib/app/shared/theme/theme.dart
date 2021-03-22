import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get defaultTheme => ThemeData(
      fontFamily: 'Open-sans',
      primaryColor: AppColors.primary,
      accentColor: AppColors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dataTableTheme: DataTableThemeData(),
      timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.primary,
          dialHandColor: AppColors.primary,
          dialTextColor: AppColors.primary,
          dayPeriodColor: AppColors.primary,
          hourMinuteColor: AppColors.primary,
          dayPeriodTextColor: AppColors.primary,
          entryModeIconColor: AppColors.primary,
          dialBackgroundColor: AppColors.primary,
          hourMinuteTextColor: AppColors.primary),
      buttonTheme: ButtonThemeData(
          height: 50,
          buttonColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0))),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(backgroundColor: Colors.transparent),
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        errorStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1)),
      ));
}
