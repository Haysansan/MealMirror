import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'auth_service.dart';
import 'local_json_store.dart';

class MealEntry {
  const MealEntry({
    required this.id,
    required this.date,
    required this.createdAt,
    required this.categories,
    required this.portion,
    required this.processing,
    required this.points,
    this.nutriScore,
    this.scoreVersion = 1,
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

  /// Estimated Nutri-Score letter (A–E) based on in-app categories.
  /// This is a lightweight proxy, not the official algorithm.
  final String? nutriScore;

  /// Scoring system version used to compute [points]/[nutriScore].
  final int scoreVersion;

  MealEntry copyWith({
    List<String>? categories,
    String? portion,
    String? processing,
    int? points,
    String? nutriScore,
    int? scoreVersion,
  }) {
    return MealEntry(
      id: id,
      date: date,
      createdAt: createdAt,
      categories: categories ?? this.categories,
      portion: portion ?? this.portion,
      processing: processing ?? this.processing,
      points: points ?? this.points,
      nutriScore: nutriScore ?? this.nutriScore,
      scoreVersion: scoreVersion ?? this.scoreVersion,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'date': date,
      'createdAt': createdAt.toIso8601String(),
      'categories': categories,
      'portion': portion,
      'processing': processing,
      'points': points,
      'nutriScore': nutriScore,
      'scoreVersion': scoreVersion,
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
      nutriScore: json['nutriScore'] as String?,
      scoreVersion: (json['scoreVersion'] as num?)?.toInt() ?? 1,
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
  /// Bumps whenever meals are added/updated for the current user.
  /// UI can listen to this to auto-refresh cached futures.
  static final ValueNotifier<int> mealsRevision = ValueNotifier<int>(0);

  // 3 steps = 100%. Each +1 step -> ~33%.
  // This keeps progress visible even with a single category selection.
  static const int maxBarSteps = 3;

  // Bump this when changing point logic to migrate existing stored meals.
  static const int _scoreSystemVersion = 2;

  static String _userMealsKey(String username) => 'meals_$username';

  static String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static String _normalizeCategoryKey(String raw) {
    final lower = raw.trim().toLowerCase();
    if (lower.isEmpty) return '';

    // Normalize separators/whitespace and common "and" variants.
    final normalized = lower
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\s*&\s*'), ' & ')
        .replaceAll(RegExp(r'\s+and\s+'), ' & ')
        .trim();

    // Map common typos/variants to canonical keys used in the switch logic.
    return switch (normalized) {
      'veggies & fruits' => 'veggie & fruits',
      'vegies & fruits' => 'veggie & fruits',
      'veggie & fruit' => 'veggie & fruits',
      'vegetables & fruits' => 'veggie & fruits',

      'grains & starches' => 'grain & starches',
      'grain & starch' => 'grain & starches',
      'grains & starch' => 'grain & starches',

      'meats & seafood' => 'meat & seafood',
      'meat & sea food' => 'meat & seafood',
      'meat and seafood' => 'meat & seafood',

      'plant proteins' => 'plant protein',
      'plant-based protein' => 'plant protein',
      'plant based protein' => 'plant protein',

      'dairy & egg' => 'dairy & eggs',
      'dairy and eggs' => 'dairy & eggs',
      'dairy & eggs' => 'dairy & eggs',

      'oils & fat' => 'oils & fats',
      'oil & fats' => 'oils & fats',
      'oils and fats' => 'oils & fats',

      // Keep canonical keys as-is.
      'veggie & fruits' => 'veggie & fruits',
      'grain & starches' => 'grain & starches',
      'meat & seafood' => 'meat & seafood',
      'plant protein' => 'plant protein',
      'snacks' => 'snacks',
      'beverages' => 'beverages',
      _ => normalized,
    };
  }

  static String _canonicalCategoryLabel(String raw) {
    final key = _normalizeCategoryKey(raw);
    return switch (key) {
      'veggie & fruits' => 'Veggie & Fruits',
      'grain & starches' => 'Grain & Starches',
      'meat & seafood' => 'Meat & Seafood',
      'plant protein' => 'Plant Protein',
      'dairy & eggs' => 'Dairy & Eggs',
      'oils & fats' => 'Oils & Fats',
      'snacks' => 'Snacks',
      'beverages' => 'Beverages',
      _ => raw.trim(),
    };
  }

  static bool _sameStringList(List<String> a, List<String> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
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

  static DateTime _endOfTodayExclusive(DateTime now) {
    return DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
  }

  static Iterable<MealEntry> _mealsInRange(
    List<MealEntry> meals, {
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    return meals.where(
      (m) =>
          !m.createdAt.isBefore(startInclusive) &&
          m.createdAt.isBefore(endExclusive),
    );
  }

  static Future<List<MealEntry>> loadCurrentUserMeals() async {
    final username = await AuthService.getCurrentUsername();
    if (username == null || username.isEmpty) return const [];
    return loadMeals(username);
  }

  static Future<List<MealEntry>> loadMeals(String username) async {
    final stored = await LocalJsonStore.getJson(_userMealsKey(username));
    if (stored == null) return const [];

    try {
      // New format: store the meals as a JSON list directly.
      // Legacy format: store the meals as a JSON string.
      final Object? decoded = switch (stored) {
        List _ => stored,
        String s when s.trim().isNotEmpty => jsonDecode(s),
        _ => null,
      };
      if (decoded is! List) return const [];
      final entries = <MealEntry>[];
      var needsMigration = false;
      for (final item in decoded) {
        if (item is Map) {
          final map = item.map((k, v) => MapEntry(k.toString(), v));
          var entry = MealEntry.fromJson(map);

          // Canonicalize categories so nutrition mapping always works.
          final canonicalCategories = entry.categories
              .map(_canonicalCategoryLabel)
              .toList();
          if (!_sameStringList(entry.categories, canonicalCategories)) {
            entry = entry.copyWith(categories: canonicalCategories);
            needsMigration = true;
          }

          if (entry.scoreVersion != _scoreSystemVersion) {
            final estimated = estimateNutriScore(
              categories: entry.categories,
              processing: entry.processing,
            );
            final points = computeMealPoints(
              categories: entry.categories,
              portion: entry.portion,
              processing: entry.processing,
            );
            entry = entry.copyWith(
              nutriScore: estimated,
              points: points,
              scoreVersion: _scoreSystemVersion,
            );
            needsMigration = true;
          } else if (entry.nutriScore == null) {
            entry = entry.copyWith(
              nutriScore: estimateNutriScore(
                categories: entry.categories,
                processing: entry.processing,
              ),
            );
            needsMigration = true;
          }

          entries.add(entry);
        }
      }
      // Newest first
      entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      if (needsMigration) {
        await LocalJsonStore.setJson(
          _userMealsKey(username),
          entries.map((e) => e.toJson()).toList(),
        );
      }
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
    final canonicalCategories = categories
        .map(_canonicalCategoryLabel)
        .toList();

    final estimated = estimateNutriScore(
      categories: canonicalCategories,
      processing: processing,
    );

    final entry = MealEntry(
      id: now.microsecondsSinceEpoch.toString(),
      date: _dateKey(now),
      createdAt: now,
      categories: List<String>.from(canonicalCategories),
      portion: portion,
      processing: processing,
      points: computeMealPoints(
        categories: canonicalCategories,
        portion: portion,
        processing: processing,
      ),
      nutriScore: estimated,
      scoreVersion: _scoreSystemVersion,
    );

    final meals = (await loadMeals(username)).toList();
    meals.insert(0, entry);

    await LocalJsonStore.setJson(
      _userMealsKey(username),
      meals.map((e) => e.toJson()).toList(),
    );

    mealsRevision.value = mealsRevision.value + 1;
  }

  static MealSummary summarizeForToday(List<MealEntry> meals, DateTime now) {
    final todayKey = _dateKey(now);
    final todayMeals = meals.where((m) => m.date == todayKey).toList();
    final total = todayMeals.fold<int>(0, (sum, m) => sum + m.points);
    return MealSummary(mealCount: todayMeals.length, totalPoints: total);
  }

  static MealSummary summarizeForThisWeek(List<MealEntry> meals, DateTime now) {
    final start = _startOfWeek(now);

    final weekMeals = _mealsInRange(
      meals,
      startInclusive: start,
      endExclusive: _endOfTodayExclusive(now),
    ).toList();

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

    final weekMeals = _mealsInRange(
      meals,
      startInclusive: start,
      endExclusive: _endOfTodayExclusive(now),
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
  // Estimated Nutri-Score proxy (A–E) derived from in-app categories.
  // Then points are derived from the letter grade and scaled by portion.
  // This intentionally allows negative points for D/E meals.
  static int computeMealPoints({
    required List<String> categories,
    required String portion,
    required String processing,
  }) {
    final nutriScore = estimateNutriScore(
      categories: categories,
      processing: processing,
    );

    final int basePoints = switch (nutriScore) {
      'A' => 5,
      'B' => 3,
      'C' => 1,
      'D' => -1,
      'E' => -2,
      _ => 0,
    };

    final double portionMultiplier = switch (portion.trim().toLowerCase()) {
      'small' => 1.0,
      'normal' => 1.2,
      'large' => 1.5,
      _ => 1.0,
    };

    return (basePoints * portionMultiplier).round();
  }

  static String estimateNutriScore({
    required List<String> categories,
    required String processing,
  }) {
    // Start at C (0). Positive values move toward A, negative toward E.
    var score = 0;

    for (final category in categories) {
      final key = _normalizeCategoryKey(category);
      switch (key) {
        case 'veggie & fruits':
          score += 2;
          break;
        case 'plant protein':
          score += 2;
          break;
        case 'grain & starches':
          score += 1;
          break;
        case 'meat & seafood':
          score += 0;
          break;
        case 'dairy & eggs':
          score += 1;
          break;
        case 'oils & fats':
          score -= 2;
          break;
        case 'snacks':
          score -= 2;
          break;
        case 'beverages':
          score += 0;
          break;
        default:
          break;
      }
    }

    score += switch (processing.trim().toLowerCase()) {
      'whole' => 1,
      'processed' => 0,
      'ultra-processed' => -2,
      _ => 0,
    };

    if (score >= 3) return 'A';
    if (score >= 1) return 'B';
    if (score == 0) return 'C';
    if (score >= -2) return 'D';
    return 'E';
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
      final key = _normalizeCategoryKey(category);
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

    return NutritionTotals(
      energy: energy * portionMultiplier,
      sugar: sugar * portionMultiplier,
      fat: fat * portionMultiplier,
      protein: protein * portionMultiplier,
      fiber: fiber * portionMultiplier,
    );
  }

  static double barProgressFromSteps(int steps) {
    if (steps <= 0) return 0;
    return (steps / maxBarSteps).clamp(0.0, 1.0);
  }

  /// Inverted progress
  /// Example: sugar/fat can start full and go down
  static double barRemainingFromSteps(int steps) {
    if (steps <= 0) return 1.0;
    final double ratio = (steps / maxBarSteps).clamp(0.0, 1.0);
    return (1.0 - ratio).clamp(0.0, 1.0);
  }
}
