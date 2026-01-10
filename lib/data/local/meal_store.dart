import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/models/meal.dart';

class MealStore {
  static Database? _db;

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

  static Future<void> insertMeal(Meal meal) async {
    final db = await _openDb();

    await db.insert(
      'meals',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> addMealForCurrentUser({
    required List<String> categories,
    required String portion,
    required String processing,
  }) async {
    final meal = Meal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      categories: categories,
      portion: portion,
      processing: processing,
    );

    await insertMeal(meal);
  }

  // READ
  static Future<List<Meal>> getAllMeals() async {
    final db = await _openDb();
    final rows = await db.query('meals', orderBy: 'createdAt DESC');

    return rows.map(Meal.fromMap).toList();
  }

  // DELETE
  static Future<void> deleteMeal(String id) async {
    final db = await _openDb();
    await db.delete('meals', where: 'id = ?', whereArgs: [id]);
  }
}
