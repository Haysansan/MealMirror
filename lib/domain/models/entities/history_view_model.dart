import 'package:mealmirror/domain/models/entities/history_range.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';

class HistoryViewModel {
  final List<MealEntry> meals;
  final HistoryRange selectedRange;
  final bool isLoading;
  final String? error;

  const HistoryViewModel({
    required this.meals,
    required this.selectedRange,
    required this.isLoading,
    this.error,
  });

  List<MealEntry> get filteredMeals {
    final now = DateTime.now();
    if (selectedRange == HistoryRange.daily) {
      return meals.where((m) {
        final date = m.date;
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      }).toList();
    } else {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return meals.where((m) {
        final date = m.date;
        return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            date.isBefore(now.add(const Duration(days: 1)));
      }).toList();
    }
  }

  NutritionTotals get nutritionTotals {
    final filtered = filteredMeals;

    int totalEnergy = 0;
    int totalSugar = 0;
    int totalFat = 0;
    int totalProtein = 0;
    int totalFiber = 0;

    for (final meal in filtered) {
      totalEnergy += meal.energy;
      totalSugar += meal.sugar;
      totalFat += meal.fat;
      totalProtein += meal.protein;
      totalFiber += meal.fiber;
    }

    return NutritionTotals(
      energy: totalEnergy,
      sugar: totalSugar,
      fat: totalFat,
      protein: totalProtein,
      fiber: totalFiber,
    );
  }

  String get statsTitle => selectedRange == HistoryRange.daily
      ? "Today's Nutrition"
      : "This Week's Nutrition";

  bool get isEmpty => meals.isEmpty;

  HistoryViewModel copyWith({
    List<MealEntry>? meals,
    HistoryRange? selectedRange,
    bool? isLoading,
    String? error,
  }) {
    return HistoryViewModel(
      meals: meals ?? this.meals,
      selectedRange: selectedRange ?? this.selectedRange,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
