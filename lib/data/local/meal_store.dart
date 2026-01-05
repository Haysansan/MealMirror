import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

class MealEntry {
  const MealEntry({
    required this.id,
    required this.date,
    required this.createdAt,
    required this.categories,
    required this.portion,
    required this.processing,
    required this.points,
  });

  final String id;

  /// yyyy-MM-dd
  final String date;
  final DateTime createdAt;
  final List<String> categories;
  final String portion;
  final String processing;

  /// Total points for this meal.
  /// Note: nutrition bars are computed separately from category mapping.
  final int points;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'date': date,
      'createdAt': createdAt.toIso8601String(),
      'categories': categories,
      'portion': portion,
      'processing': processing,
      'points': points,
    };
  }

  static MealEntry fromJson(Map<String, Object?> json) {
    return MealEntry(
      id: (json['id'] as String?) ?? '',
      date: (json['date'] as String?) ?? '',
      createdAt: DateTime.parse((json['createdAt'] as String?) ?? ''),
      categories: ((json['categories'] as List?) ?? const [])
          .whereType<String>()
          .toList(),
      portion: (json['portion'] as String?) ?? 'Normal',
      processing: (json['processing'] as String?) ?? 'Processed',
      points: (json['points'] as num?)?.toInt() ?? 0,
    );
  }
}

class MealSummary {
  const MealSummary({required this.mealCount, required this.totalPoints});

  final int mealCount;
  final int totalPoints;
}

class NutritionTotals {
  const NutritionTotals({
    required this.energy,
    required this.sugar,
    required this.fat,
    required this.protein,
    required this.fiber,
  });

  const NutritionTotals.zero()
    : energy = 0,
      sugar = 0,
      fat = 0,
      protein = 0,
      fiber = 0;

  final int energy;
  final int sugar;
  final int fat;
  final int protein;
  final int fiber;

  NutritionTotals operator +(NutritionTotals other) {
    return NutritionTotals(
      energy: energy + other.energy,
      sugar: sugar + other.sugar,
      fat: fat + other.fat,
      protein: protein + other.protein,
      fiber: fiber + other.fiber,
    );
  }
}

class MealStore {
  // 5 steps = 100%. Each +1 step -> 20%.
  static const int maxBarSteps = 5;

  static String _userMealsKey(String username) => 'meals_$username';

  static String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static DateTime _startOfWeek(DateTime now) {
    // Monday as start of week.
    final int delta = now.weekday - DateTime.monday;
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: delta));
  }

  static Future<List<MealEntry>> loadCurrentUserMeals() async {
    final username = await AuthService.getCurrentUsername();
    if (username == null || username.isEmpty) return const [];
    return loadMeals(username);
  }

  static Future<List<MealEntry>> loadMeals(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userMealsKey(username));
    if (raw == null || raw.isEmpty) return const [];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      final entries = <MealEntry>[];
      for (final item in decoded) {
        if (item is Map) {
          final map = item.map((k, v) => MapEntry(k.toString(), v));
          entries.add(MealEntry.fromJson(map));
        }
      }
      // Newest first
      entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return entries;
    } catch (_) {
      return const [];
    }
  }

  static Future<void> addMealForCurrentUser({
    required List<String> categories,
    required String portion,
    required String processing,
  }) async {
    final username = await AuthService.getCurrentUsername();
    if (username == null || username.isEmpty) return;

    final now = DateTime.now();
    final entry = MealEntry(
      id: now.microsecondsSinceEpoch.toString(),
      date: _dateKey(now),
      createdAt: now,
      categories: List<String>.from(categories),
      portion: portion,
      processing: processing,
      points: computeMealPoints(
        categories: categories,
        portion: portion,
        processing: processing,
      ),
    );

    final meals = (await loadMeals(username)).toList();
    meals.insert(0, entry);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userMealsKey(username),
      jsonEncode(meals.map((e) => e.toJson()).toList()),
    );
  }

  static MealSummary summarizeForToday(List<MealEntry> meals, DateTime now) {
    final todayKey = _dateKey(now);
    final todayMeals = meals.where((m) => m.date == todayKey).toList();
    final total = todayMeals.fold<int>(0, (sum, m) => sum + m.points);
    return MealSummary(mealCount: todayMeals.length, totalPoints: total);
  }

  static MealSummary summarizeForThisWeek(List<MealEntry> meals, DateTime now) {
    final start = _startOfWeek(now);
    final endExclusive = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));

    final weekMeals = meals.where((m) {
      return !m.createdAt.isBefore(start) && m.createdAt.isBefore(endExclusive);
    }).toList();

    final total = weekMeals.fold<int>(0, (sum, m) => sum + m.points);
    return MealSummary(mealCount: weekMeals.length, totalPoints: total);
  }

  static NutritionTotals summarizeNutritionForToday(
    List<MealEntry> meals,
    DateTime now,
  ) {
    final todayKey = _dateKey(now);
    final todayMeals = meals.where((m) => m.date == todayKey);
    var totals = const NutritionTotals.zero();
    for (final meal in todayMeals) {
      totals += computeMealNutrition(
        categories: meal.categories,
        portion: meal.portion,
        processing: meal.processing,
      );
    }
    return totals;
  }

  static NutritionTotals summarizeNutritionForThisWeek(
    List<MealEntry> meals,
    DateTime now,
  ) {
    final start = _startOfWeek(now);
    final endExclusive = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));

    final weekMeals = meals.where(
      (m) => !m.createdAt.isBefore(start) && m.createdAt.isBefore(endExclusive),
    );

    var totals = const NutritionTotals.zero();
    for (final meal in weekMeals) {
      totals += computeMealNutrition(
        categories: meal.categories,
        portion: meal.portion,
        processing: meal.processing,
      );
    }
    return totals;
  }

  // ===================== POINT SYSTEM (EDIT HERE) =====================
  // Placeholder scoring:
  // - +1 per selected category
  // - except negative categories: Snacks, Oils & Fats => -1 each
  // - multiplied by portion: Small=1, Normal=2, Large=3
  // - multiplied by processing: Whole=+1, Processed=0, Ultra-Processed=-1
  // - applied equally to all 5 dimensions (we store a single total points value)
  static int computeMealPoints({
    required List<String> categories,
    required String portion,
    required String processing,
  }) {
    const negativeCategories = <String>{'snacks', 'oils & fats'};

    int base = 0;
    for (final category in categories) {
      final key = category.trim().toLowerCase();
      base += negativeCategories.contains(key) ? -1 : 1;
    }

    final int portionMultiplier = switch (portion.trim().toLowerCase()) {
      'small' => 1,
      'normal' => 2,
      'large' => 3,
      _ => 1,
    };

    final int processingMultiplier = switch (processing.trim().toLowerCase()) {
      'whole' => 1,
      'processed' => 0,
      'ultra-processed' => -1,
      'ultra processed' => -1,
      _ => 0,
    };

    return base * portionMultiplier * processingMultiplier;
  }

  // ===================== NUTRITION BAR SYSTEM (EDIT HERE) =====================
  // Bars follow user-picked categories per mapping:
  // - Veggie & Fruits => Fiber
  // - Meat & Seafood => Energy + Protein
  // - Grain & Starches => Energy
  // - Plant Protein => Protein + Fiber
  // - Dairy & Eggs => Protein + Energy
  // - Oils & Fats => Fat
  // - Snacks => Sugar + Energy + Fat
  // - Beverages => Energy
  // Each category contributes +1 step to its mapped bars.
  // Apply multipliers:
  // - Portion: Small=1, Normal=2, Large=3
  // - Processing: Whole=+1, Processed=0, Ultra-Processed=-1
  // Steps are later converted to percentages where 5 steps = 100%.
  // NOTE: Snacks/Oils are negative for points, but still grow bars by mapping.
  static NutritionTotals computeMealNutrition({
    required List<String> categories,
    required String portion,
    required String processing,
  }) {
    int energy = 0;
    int sugar = 0;
    int fat = 0;
    int protein = 0;
    int fiber = 0;

    for (final category in categories) {
      final key = category.trim().toLowerCase();
      switch (key) {
        case 'veggie & fruits':
          fiber += 1;
          break;
        case 'meat & seafood':
          energy += 1;
          protein += 1;
          break;
        case 'grain & starches':
          energy += 1;
          break;
        case 'plant protein':
          protein += 1;
          fiber += 1;
          break;
        case 'dairy & eggs':
          protein += 1;
          energy += 1;
          break;
        case 'oils & fats':
          fat += 1;
          break;
        case 'snacks':
          sugar += 1;
          energy += 1;
          fat += 1;
          break;
        case 'beverages':
          energy += 1;
          break;
        default:
          break;
      }
    }

    final int portionMultiplier = switch (portion.trim().toLowerCase()) {
      'small' => 1,
      'normal' => 2,
      'large' => 3,
      _ => 1,
    };

    final int processingMultiplier = switch (processing.trim().toLowerCase()) {
      'whole' => 1,
      'processed' => 0,
      'ultra-processed' => -1,
      'ultra processed' => -1,
      _ => 0,
    };

    return NutritionTotals(
      energy: energy * portionMultiplier * processingMultiplier,
      sugar: sugar * portionMultiplier * processingMultiplier,
      fat: fat * portionMultiplier * processingMultiplier,
      protein: protein * portionMultiplier * processingMultiplier,
      fiber: fiber * portionMultiplier * processingMultiplier,
    );
  }

  static double barProgressFromSteps(int steps) {
    if (steps <= 0) return 0;
    return (steps / maxBarSteps).clamp(0.0, 1.0);
  }
}
