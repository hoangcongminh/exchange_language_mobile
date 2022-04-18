import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
