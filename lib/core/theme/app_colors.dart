import 'package:flutter/material.dart';

class AppColors {
<<<<<<< HEAD
  // Text contrast helpers
  static const Color onLight = Color(
    0xFF1F2D0C,
  ); // dark green — text on light backgrounds
  static const Color onDark = Color(
    0xFFFFFFFF,
  ); // white — text on dark backgrounds

  // Primary (Actions, Headings)
  static const Color primary = Color(0xFF5B6E3F); // olive green

  // Secondary (Cards, Icons)
  static const Color secondary = Color(0xFF8A9662); // soft olive

  // Sections / Containers
  static const Color section = Color(0xFFD6E4C3); // light green

  // Main Background / Cards
  static const Color background = Color(0xFFF7F0DC); // warm cream

  // Card surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2E3A2B);

  // Error
  static const Color error = Color(0xFFB00020);

  // Backwards-compatible aliases (keep these so other files don't break)
  static const Color textWhiteTheme = onLight;
  static const Color textDarkTheme = onDark;
=======
  // Core brand
  static const Color primary = Color(0xFF5B6E3F); // olive green
  static const Color secondary = Color(0xFF8A9662); // soft olive

  // Surfaces
  static const Color background = Color(0xFFF7F0DC); // warm cream
  static const Color section = Color(0xFFD6E4C3); // light green
  static const Color surface = Color(0xFFCADBB7); // card/button surface
  static const Color surfaceDark = Color(0xFF2E3B1F); // derived dark surface

  // Text
  static const Color textWhiteTheme = Color(0xFF1F2D0C); // dark green text
  static const Color textDarkTheme = Color(0xFFFFFFFF); // white text

  // Status
  static const Color error = Colors.red;

  // --- Log Meal / Portion Size specific palette (exact existing values) ---
  static const Color logMealBackground = Color(0xFFF7EFDA);
  static const Color logMealTitle = Color(0x590E1A00);
  static const Color matcha = Color(0xFF7B8551);
  static const Color darkMatcha = Color(0xFF485935);
  static const Color ink = Color(0xFF0E1A00);
  static const Color inkMuted = Color(0xA50E1A00);

  // Common button surface used in these screens
  static const Color actionSurface = Color(0xFFCADBB7);

  // Portion size category pill
  static const Color categoryPillFill = Color(0xFFDEFFBF);
  static const Color categoryPillText = Color(0xFF00AF51);

  // Portion size card styling
  static const Color portionCardBaseFill = Color(0xFFCADBB7);
  static const Color portionCardBaseBorder = Color(0xFFE1E7EF);
  static const Color portionCardSelectedBorder = Color(0xFF72B135);

  // Meal category colors (exact existing values)
  static const Color veggieFruits = Color(0xFF72B135);
  static const Color grainStarches = Color(0xFFF7C480);
  static const Color meatSeafood = Color(0xFFFF9A8F);
  static const Color plantProtein = Color(0xFFFFD8D2);
  static const Color dairyEggs = Color(0xFFFFDE64);
  static const Color oilsFats = Color(0xFFFFDFA1);
  static const Color snacks = Color(0xFFF39624);
  static const Color beverages = Color(0xFFD5FFFD);
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
}
