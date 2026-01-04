import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.textDarkTheme,
      onSecondary: AppColors.textDarkTheme,
      onSurface: AppColors.textWhiteTheme,
      onError: AppColors.textDarkTheme,
    ),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      foregroundColor: AppColors.textDarkTheme,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.textWhiteTheme),
      bodyMedium: TextStyle(color: AppColors.textWhiteTheme),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textDarkTheme,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.textDarkTheme,
      onSecondary: AppColors.textDarkTheme,
      onSurface: AppColors.textDarkTheme,
      onError: AppColors.textDarkTheme,
    ),
    scaffoldBackgroundColor: AppColors.surfaceDark,
    cardColor: AppColors.surfaceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textWhiteTheme,
    ),
  );
}
