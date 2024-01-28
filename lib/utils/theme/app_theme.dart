import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.accenColor,
    appBarTheme: AppBarTheme(color: AppColors.primaryColor),
  );
}
