import '../services/nutrition_service.dart';

class SummaryService {
  static int weekAverage({required int totalPoints, required int mealCount}) {
    if (mealCount == 0) return 0;
    return (totalPoints / mealCount).round();
  }

  static String nutritionAdvice({
    required int energy,
    required int sugar,
    required int fat,
    required int protein,
    required int fiber,
  }) {
    final e = NutritionService.barProgressFromSteps(energy);
    final s = NutritionService.barProgressFromSteps(sugar);
    final f = NutritionService.barProgressFromSteps(fat);
    final p = NutritionService.barProgressFromSteps(protein);
    final b = NutritionService.barProgressFromSteps(fiber);

    if ((e + s + f + p + b) == 0) {
      return "Log a meal to shape today's balance";
    }
    if (s >= 0.8 && b < 0.4) return 'Ease up on sweets; add some fiber';
    if (f >= 0.8 && b < 0.4) return 'Go lighter on fats; add veggies/fruit';
    if (p < 0.4 && b < 0.4) return 'Try adding protein and fiber today';
    if (p < 0.4) return 'Try adding more protein today';
    if (b < 0.4) return 'Try adding more fiber today';
    if (e < 0.25) return 'Add a hearty, energizing meal';
    return 'Nice balance today—keep it going';
  }

  static String habitStabilityLabel({
    required int trackedDays,
    required int spanDays,
  }) {
    if (spanDays <= 0) return 'Low';
    final ratio = trackedDays / spanDays;
    if (ratio >= 0.7) return 'High';
    if (ratio >= 0.4) return 'Medium';
    return 'Low';
  }

  static int uniqueTrackedDays<T>({
    required Iterable<T> meals,
    required String? Function(T item) getDate,
  }) {
    return meals.map(getDate).whereType<String>().toSet().length;
  }

  static int allTimeSpanDays<T>({
    required Iterable<T> meals,
    required DateTime? Function(T item) getCreatedAt,
  }) {
    final list = meals.map(getCreatedAt).whereType<DateTime>().toList();
    if (list.isEmpty) return 0;
    list.sort();
    final oldest = list.first;
    final newest = list.last;
    final start = DateTime(oldest.year, oldest.month, oldest.day);
    final end = DateTime(newest.year, newest.month, newest.day);
    return end.difference(start).inDays + 1;
  }

  static ({int mealCount, int totalPoints}) summarizeForRange<T>({
    required List<T> meals,
    required DateTime startInclusive,
    required DateTime endExclusive,
    required DateTime? Function(T item) getCreatedAt,
    required int Function(T item) getPoints,
  }) {
    final rangeMeals = meals.where((m) {
      final created = getCreatedAt(m);
      return created != null &&
          !created.isBefore(startInclusive) &&
          created.isBefore(endExclusive);
    }).toList();
    final total = rangeMeals.fold<int>(0, (sum, m) => sum + getPoints(m));
    return (mealCount: rangeMeals.length, totalPoints: total);
  }
}
