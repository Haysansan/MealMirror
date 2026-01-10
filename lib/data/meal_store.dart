import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/models/meal_entry.dart';
import '../domain/models/meal_summary.dart';

class MealStore {
  static Database? _db;

  static final ValueNotifier<void> mealsRevision = ValueNotifier<void>(null);

  static Future<Database> _openDb() async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'meals.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE meals (
            id TEXT PRIMARY KEY,
            createdAt TEXT,
            categories TEXT,
            portion TEXT,
            processing TEXT
          )
        ''');
      },
    );

    return _db!;
  }

  static Future<void> insertMeal(MealEntry meal) async {
    final db = await _openDb();

    await db.insert(
      'meals',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    mealsRevision.notifyListeners();
  }

  static Future<void> addMealForCurrentUser({
    required List<String> categories,
    required String portion,
    required String processing,
  }) async {
    final meal = MealEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      date: DateTime.now(),
      categories: categories,
      portion: portion,
      processing: processing,
    );

    await insertMeal(meal);
  }

  static Future<List<MealEntry>> getAllMeals() async {
    final db = await _openDb();
    final rows = await db.query('meals', orderBy: 'createdAt DESC');

    return rows
        .map(
          (row) => MealEntry(
            id: row['id'] as String,
            createdAt: DateTime.parse(row['createdAt'] as String),
            date: DateTime.parse(row['createdAt'] as String),
            categories: (row['categories'] as String?)?.split(',') ?? [],
            portion: row['portion'] as String? ?? '',
            processing: row['processing'] as String? ?? '',
          ),
        )
        .toList();
  }

  static Future<List<MealEntry>> loadCurrentUserMeals() async {
    return getAllMeals();
  }

  static Future<void> deleteMeal(String id) async {
    final db = await _openDb();
    await db.delete('meals', where: 'id = ?', whereArgs: [id]);
    mealsRevision.notifyListeners();
  }

  static NutritionTotals summarizeNutritionForToday(
    List<MealEntry> meals,
    DateTime now,
  ) {
    final todayMeals = meals.where((m) {
      return m.date.year == now.year &&
          m.date.month == now.month &&
          m.date.day == now.day;
    }).toList();

    return _calculateNutrition(todayMeals);
  }

  static NutritionTotals summarizeNutritionForThisWeek(
    List<MealEntry> meals,
    DateTime now,
  ) {
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekMeals = meals.where((m) {
      return m.date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
          m.date.isBefore(now.add(const Duration(days: 1)));
    }).toList();

    return _calculateNutrition(weekMeals);
  }

  static NutritionTotals _calculateNutrition(List<MealEntry> meals) {
    int energy = 0;
    int sugar = 0;
    int fat = 0;
    int protein = 0;
    int fiber = 0;

    for (final meal in meals) {
      energy += _estimateEnergy(meal);
      sugar += _estimateSugar(meal);
      fat += _estimateFat(meal);
      protein += _estimateProtein(meal);
      fiber += _estimateFiber(meal);
    }

    return NutritionTotals(
      energy: energy,
      sugar: sugar,
      fat: fat,
      protein: protein,
      fiber: fiber,
    );
  }

  static int _estimateEnergy(MealEntry meal) {
    return meal.portion.contains('large') ? 800 : 500;
  }

  static int _estimateSugar(MealEntry meal) {
    return meal.portion.contains('large') ? 45 : 25;
  }

  static int _estimateFat(MealEntry meal) {
    return meal.portion.contains('large') ? 25 : 15;
  }

  static int _estimateProtein(MealEntry meal) {
    return meal.portion.contains('large') ? 35 : 20;
  }

  static int _estimateFiber(MealEntry meal) {
    return meal.portion.contains('large') ? 8 : 4;
  }

  static Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
