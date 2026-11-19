import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTypography.workSans,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightBackground,
        onSurface: AppColors.lightText,
        primary: AppColors.lightButtonHigh,
        onPrimary: AppColors.white,
        secondary: AppColors.lightButtonMedium,
        onSecondary: AppColors.lightText,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTypography.workSans,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.darkBackground,
        onSurface: AppColors.darkText,
        primary: AppColors.darkButtonHigh,
        onPrimary: AppColors.white,
        secondary: AppColors.darkButtonMedium,
        onSecondary: AppColors.darkText,
      ),
    );
  }
}
