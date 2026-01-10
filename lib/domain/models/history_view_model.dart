import '../../data/local/meal_store.dart';
import 'history_range.dart';
import 'meal_entry.dart';
import 'meal_summary.dart';

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
    final now = DateTime.now();
    return selectedRange == HistoryRange.daily
        ? MealStore.summarizeNutritionForToday(meals, now)
        : MealStore.summarizeNutritionForThisWeek(meals, now);
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
