import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData defaultTheme() {
  return ThemeData(
    // useMaterial3: true,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xffFDFDFD),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff039FBC),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: AppColors.primaryColor)),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
