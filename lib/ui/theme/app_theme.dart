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
      foregroundColor: AppColors.textWhiteTheme,
    ),

    textTheme: ThemeData.light().textTheme,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textWhiteTheme,
    ),
  );

  // static final ThemeData darkTheme = ThemeData(
  //   fontFamily: 'Inter',
  //   colorScheme: const ColorScheme.dark(
  //     primary: AppColors.primary,
  //     secondary: AppColors.secondary,
  //     surface: AppColors.surfaceDark,
  //     error: AppColors.error,
  //     onPrimary: AppColors.textDarkTheme,
  //     onSecondary: AppColors.textDarkTheme,
  //     onSurface: AppColors.textDarkTheme,
  //     onError: AppColors.textDarkTheme,
  //   ),
  //   scaffoldBackgroundColor: AppColors.surfaceDark,
  //   cardColor: AppColors.surfaceDark,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: AppColors.surfaceDark,
  //     foregroundColor: AppColors.textWhiteTheme,
  //   ),

  //   // dark theme reuse (adjust if you want different sizes/colors)
  //   textTheme: ThemeData.dark().textTheme,
  // ); DarkTheme For Future Works
}
