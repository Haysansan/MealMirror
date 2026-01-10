import 'package:flutter_test/flutter_test.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/services/summary_service.dart';

void main() {
  test('MealEntry stores nutrition values correctly', () {
    final meal = MealEntry(
      id: 'm1',
      createdAt: DateTime.now(),
      date: DateTime.now(),
      categories: const ['Veggie & Fruits', 'Grain & Starches'],
      portion: 'medium',
      processing: 'whole',
      points: 3,
      energy: 500,
      sugar: 10,
      fat: 5,
      protein: 15,
      fiber: 8,
    );

    expect(meal.fiber, equals(8));
    expect(meal.energy, equals(500));
    expect(meal.points, equals(3));
  });

  test('nutritionAdvice returns guidance for computed totals', () {
    const energy = 1500;
    const sugar = 20;
    const fat = 15;
    const protein = 50;
    const fiber = 10;

    final advice = SummaryService.nutritionAdvice(
      energy: energy,
      sugar: sugar,
      fat: fat,
      protein: protein,
      fiber: fiber,
    );

    expect(advice, isNotEmpty);
  });
}
