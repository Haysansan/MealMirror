import 'package:flutter/material.dart';

class AppColors {
  // Text contrast helpers
  static const Color onLight = Color(0xFF1F2D0C);
  static const Color onDark = Color(0xFFFFFFFF);

  // Core brand
  static const Color primary = Color(0xFF5B6E3F); // olive green
  static const Color secondary = Color(0xFF8A9662); // soft olive

  // Surfaces
  static const Color background = Color(0xFFF7F0DC); // warm cream
  static const Color section = Color(0xFFD6E4C3); // light green
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2E3A2B);

  // Status
  static const Color error = Color(0xFFB00020);

  // Backwards-compatible aliases (keep these so other files don't break)
  static const Color textWhiteTheme = onLight;
  static const Color textDarkTheme = onDark;

  // --- Log Meal
  static const Color logMealBackground = Color(0xFFF7EFDA);
  static const Color logMealTitle = Color(0x590E1A00);
  static const Color matcha = Color(0xFF7B8551);
  static const Color darkMatcha = Color(0xFF485935);
  static const Color ink = Color(0xFF0E1A00);
  static const Color inkMuted = Color(0xA50E1A00);

  static const Color actionSurface = Color(0xFFCADBB7);

  // Portion size category pill
  static const Color categoryPillFill = Color(0xFFDEFFBF);
  static const Color categoryPillText = Color(0xFF00AF51);

  // Portion size card styling
  static const Color portionCardBaseFill = Color(0xFFCADBB7);
  static const Color portionCardBaseBorder = Color(0xFFE1E7EF);
  static const Color portionCardSelectedBorder = Color(0xFF72B135);

  // Meal category colors
  static const Color veggieFruits = Color(0xFF72B135);
  static const Color grainStarches = Color(0xFFF7C480);
  static const Color meatSeafood = Color(0xFFFF9A8F);
  static const Color plantProtein = Color(0xFFFFD8D2);
  static const Color dairyEggs = Color(0xFFFFDE64);
  static const Color oilsFats = Color(0xFFFFDFA1);
  static const Color snacks = Color(0xFFF39624);
  static const Color beverages = Color(0xFFD5FFFD);

  // Welcome pet accent
  static const Color petGreen = Color(0xFF6ABD7E);
}
