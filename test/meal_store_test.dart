import 'package:flutter_test/flutter_test.dart';
import 'package:mealmirror/data/meal_store.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/services/summary_service.dart';

void main() {
  test('summarizeNutritionForToday supports category variants', () {
    final meal = MealEntry(
      id: 'm1',
      createdAt: DateTime.now(),
      date: DateTime.now(),
      categories: const ['Vegies & Fruits', 'Grains and Starches'],
      portion: 'Normal',
      processing: 'Whole',
      points: 0,
    );

    final totals = MealStore.summarizeNutritionForToday([meal], DateTime.now());

    expect(totals.fiber, greaterThan(0));
    expect(totals.energy, greaterThan(0));
  });

  test('nutritionAdvice returns guidance for computed totals', () {
    final meal = MealEntry(
      id: 'm2',
      createdAt: DateTime.now(),
      date: DateTime.now(),
      categories: const ['Vegies & Fruits'],
      portion: 'Normal',
      processing: 'Processed',
      points: 0,
    );

    final totals = MealStore.summarizeNutritionForToday([meal], DateTime.now());

    final advice = SummaryService.nutritionAdvice(
      energy: totals.energy,
      sugar: totals.sugar,
      fat: totals.fat,
      protein: totals.protein,
      fiber: totals.fiber,
    );

    expect(advice, isNotEmpty);
  });
}
