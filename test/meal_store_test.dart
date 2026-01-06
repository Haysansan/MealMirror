import 'package:flutter_test/flutter_test.dart';

import 'package:mealmirror/data/local/meal_store.dart';

void main() {
  test('computeMealNutrition supports category variants', () {
    final totals = MealStore.computeMealNutrition(
      categories: const ['Vegies & Fruits', 'Grains and Starches'],
      portion: 'Normal',
      processing: 'Whole',
    );

    // Should contribute at least to fiber and energy (and be multiplied by portion).
    expect(totals.fiber, greaterThan(0));
    expect(totals.energy, greaterThan(0));
  });

  test('estimateNutriScore supports category variants', () {
    final score = MealStore.estimateNutriScore(
      categories: const ['Veggies & Fruits'],
      processing: 'Processed',
    );

    // Veggies/Fruits should push score upward (B or A depending on rules).
    expect(score, anyOf('A', 'B'));
  });
}
