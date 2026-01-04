import 'package:flutter/material.dart';

class AppColors {
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
}
