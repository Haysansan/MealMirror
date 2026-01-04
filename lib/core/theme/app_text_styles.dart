import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'app_colors.dart';

class AppTextStyles {
  // Headlines (used for screen titles)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Titles and body
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onLight,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onLight,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onLight,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onLight,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onLight,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF6B6B6B),
  );

  static const TextTheme textTheme = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    titleLarge: titleLarge,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
=======

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.1,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.2,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textWhiteTheme,
    height: 1.4,
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
  );
}
