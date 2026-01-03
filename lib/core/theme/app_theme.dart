import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onDark,
      onBackground: AppColors.onLight,
      onSurface: AppColors.onLight,
    ),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      foregroundColor: AppColors.onDark,
    ),

    // <-- use centralized styles
    textTheme: AppTextStyles.textTheme,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onDark,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.section,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.onDark,
      onBackground: AppColors.onDark,
      onSurface: AppColors.onDark,
    ),
    scaffoldBackgroundColor: AppColors.section,
    cardColor: AppColors.surfaceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.onDark,
    ),

    // dark theme reuse (adjust if you want different sizes/colors)
    textTheme: AppTextStyles.textTheme,
  );
}
