import 'package:mealmirror/domain/models/meal_entry.dart';

class MealRepository {
  static final List<MealEntry> _meals = [];

  // Add a new meal.
  static Future<void> addMeal(MealEntry meal) async {
    _meals.add(meal);
  }

  // Get all meals.
  static Future<List<MealEntry>> getAllMeals() async {
    return List.from(_meals);
  }

  // Delete a meal by id.
  static Future<void> deleteMeal(String id) async {
    _meals.removeWhere((meal) => meal.id == id);
  }

  // Get a meal by id.
  static Future<MealEntry?> getMealById(String id) async {
    try {
      return _meals.firstWhere((meal) => meal.id == id);
    } catch (e) {
      return null;
    }
  }

  // Clear all meals (for testing/reset).
  static Future<void> clear() async {
    _meals.clear();
  }

  // Get number of meals.
  static Future<int> count() async {
    return _meals.length;
  }
}
