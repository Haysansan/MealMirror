class NutritionCalculationService {
  /// Returns energy, sugar, fat, protein, fiber.
  static Map<String, int> calculateNutrition({
    required List<String> categories,
    required String portion,
  }) {
    final portionMultiplier = _getPortionMultiplier(portion);

    int energy = 0;
    int sugar = 0;
    int fat = 0;
    int protein = 0;
    int fiber = 0;

    for (final category in categories) {
      final nutrition = _getCategoryNutrition(category.toLowerCase());

      energy += nutrition['energy']!;
      sugar += nutrition['sugar']!;
      fat += nutrition['fat']!;
      protein += nutrition['protein']!;
      fiber += nutrition['fiber']!;
    }

    return {
      'energy': (energy * portionMultiplier).round(),
      'sugar': (sugar * portionMultiplier).round(),
      'fat': (fat * portionMultiplier).round(),
      'protein': (protein * portionMultiplier).round(),
      'fiber': (fiber * portionMultiplier).round(),
    };
  }

  static double _getPortionMultiplier(String portion) {
    return switch (portion.toLowerCase()) {
      'small' => 0.7,
      'medium' => 1.0,
      'large' => 1.5,
      _ => 1.0,
    };
  }

  static Map<String, int> _getCategoryNutrition(String category) {
    return switch (category) {
      'vegetables' => {
        'energy': 25,
        'sugar': 4,
        'fat': 0,
        'protein': 2,
        'fiber': 3,
      },
      'fruits' => {
        'energy': 60,
        'sugar': 12,
        'fat': 0,
        'protein': 1,
        'fiber': 2,
      },
      'grains' => {
        'energy': 130,
        'sugar': 2,
        'fat': 1,
        'protein': 4,
        'fiber': 3,
      },
      'dairy' => {
        'energy': 150,
        'sugar': 5,
        'fat': 8,
        'protein': 8,
        'fiber': 0,
      },
      'protein' => {
        'energy': 165,
        'sugar': 0,
        'fat': 9,
        'protein': 20,
        'fiber': 0,
      },
      'oils' => {
        'energy': 120,
        'sugar': 0,
        'fat': 14,
        'protein': 0,
        'fiber': 0,
      },
      'snacks' => {
        'energy': 150,
        'sugar': 15,
        'fat': 8,
        'protein': 2,
        'fiber': 1,
      },
      _ => {'energy': 100, 'sugar': 5, 'fat': 5, 'protein': 3, 'fiber': 2},
    };
  }
}
