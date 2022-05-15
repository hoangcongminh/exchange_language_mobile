import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData defaultTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    tabBarTheme: const TabBarTheme(
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
  );
}
