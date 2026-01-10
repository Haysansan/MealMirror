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
