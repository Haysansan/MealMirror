import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
<<<<<<< HEAD
      onPrimary: AppColors.onDark,
      onBackground: AppColors.onLight,
      onSurface: AppColors.onLight,
=======
      onPrimary: AppColors.textDarkTheme,
      onSecondary: AppColors.textDarkTheme,
      onSurface: AppColors.textWhiteTheme,
      onError: AppColors.textDarkTheme,
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
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
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
<<<<<<< HEAD
      onPrimary: AppColors.onDark,
      onBackground: AppColors.onDark,
      onSurface: AppColors.onDark,
=======
      onPrimary: AppColors.textDarkTheme,
      onSecondary: AppColors.textDarkTheme,
      onSurface: AppColors.textDarkTheme,
      onError: AppColors.textDarkTheme,
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
    ),
    scaffoldBackgroundColor: AppColors.surfaceDark,
    cardColor: AppColors.surfaceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.onDark,
    ),

    // dark theme reuse (adjust if you want different sizes/colors)
    textTheme: AppTextStyles.textTheme,
  );
}
