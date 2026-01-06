import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// categories used throughout the Log Meal flow.
///
/// IMPORTANT:
/// - [key] is the value stored/passed through the flow
class LogMealCategoryInfo {
  const LogMealCategoryInfo({
    required this.key,
    required this.displayName,
    required this.shortName,
    required this.iconAssetPath,
    required this.color,
  });

  final String key;
  final String displayName;
  final String shortName;
  final String iconAssetPath;
  final Color color;
}

class LogMealCategories {
  const LogMealCategories._();

  static const String veggiesFruitsKey = 'Veggie & Fruits';
  static const String grainsStarchesKey = 'Grain & Starches';
  static const String meatSeafoodKey = 'Meat & Seafood';
  static const String plantProteinKey = 'Plant Protein';
  static const String dairyEggsKey = 'Dairy & Eggs';
  static const String oilsFatsKey = 'Oils & Fats';
  static const String snacksKey = 'Snacks';
  static const String beveragesKey = 'Beverages';

  static const List<LogMealCategoryInfo> all = [
    LogMealCategoryInfo(
      key: veggiesFruitsKey,
      displayName: veggiesFruitsKey,
      shortName: 'Veggies',
      iconAssetPath: 'assets/images/Vegies.png',
      color: AppColors.veggieFruits,
    ),
    LogMealCategoryInfo(
      key: grainsStarchesKey,
      displayName: grainsStarchesKey,
      shortName: 'Grains',
      iconAssetPath: 'assets/images/Bread.png',
      color: AppColors.grainStarches,
    ),
    LogMealCategoryInfo(
      key: meatSeafoodKey,
      displayName: meatSeafoodKey,
      shortName: 'Meat',
      iconAssetPath: 'assets/images/meat.png',
      color: AppColors.meatSeafood,
    ),
    LogMealCategoryInfo(
      key: plantProteinKey,
      displayName: plantProteinKey,
      shortName: 'Plant',
      iconAssetPath: 'assets/images/Tomato.png',
      color: AppColors.plantProtein,
    ),
    LogMealCategoryInfo(
      key: dairyEggsKey,
      displayName: dairyEggsKey,
      shortName: 'Dairy',
      iconAssetPath: 'assets/images/Egg.png',
      color: AppColors.dairyEggs,
    ),
    LogMealCategoryInfo(
      key: oilsFatsKey,
      displayName: oilsFatsKey,
      shortName: 'Oils',
      iconAssetPath: 'assets/images/cheese.png',
      color: AppColors.oilsFats,
    ),
    LogMealCategoryInfo(
      key: snacksKey,
      displayName: snacksKey,
      shortName: snacksKey,
      iconAssetPath: 'assets/images/cookie.png',
      color: AppColors.snacks,
    ),
    LogMealCategoryInfo(
      key: beveragesKey,
      displayName: beveragesKey,
      shortName: 'Drinks',
      iconAssetPath: 'assets/images/beverages.png',
      color: AppColors.beverages,
    ),
  ];

  static LogMealCategoryInfo? tryGet(String key) {
    for (final category in all) {
      if (category.key == key) return category;
    }
    return null;
  }
}
