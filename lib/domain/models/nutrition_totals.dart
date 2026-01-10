class NutritionTotals {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  const NutritionTotals({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory NutritionTotals.empty() {
    return const NutritionTotals(calories: 0, protein: 0, carbs: 0, fat: 0);
  }
}
