import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

import '../../../data/local/meal_store.dart';

class MealLogList extends StatelessWidget {
  const MealLogList({super.key, required this.meals, required this.now});

  final List<MealEntry> meals;
  final DateTime now;

  String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String _formatSigned(int value) {
    if (value == 0) return '+0';
    return value > 0 ? '+$value' : value.toString();
  }

  Map<String, List<MealEntry>> _groupByDate(List<MealEntry> input) {
    final map = <String, List<MealEntry>>{};
    for (final entry in input) {
      map.putIfAbsent(entry.date, () => <MealEntry>[]).add(entry);
    }
    return map;
  }

  String _iconForCategory(String category) {
    return switch (category.trim().toLowerCase()) {
      'veggie & fruits' => 'assets/images/Vegies.png',
      'grain & starches' => 'assets/images/Bread.png',
      'meat & seafood' => 'assets/images/meat.png',
      'plant protein' => 'assets/images/Tomato.png',
      'dairy & eggs' => 'assets/images/Egg.png',
      'oils & fats' => 'assets/images/cheese.png',
      'snacks' => 'assets/images/cookie.png',
      'beverages' => 'assets/images/beverages.png',
      _ => 'assets/images/Vegies.png',
    };
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          'No meals logged for this period yet.',
          style: TextStyle(color: AppColors.mealMirrorMutedText),
        ),
      );
    }

    final grouped = _groupByDate(meals);
    final keys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    final todayKey = _dateKey(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final key in keys) ...[
          Text(
            key == todayKey ? 'Today' : key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final entry in (grouped[key] ?? const <MealEntry>[])) ...[
            _mealCard(entry: entry),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _mealCard({required MealEntry entry}) {
    final icons = entry.categories.map(_iconForCategory).toSet().toList();

    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.categories.isEmpty
                        ? 'Meal'
                        : entry.categories.length == 1
                        ? '1 category'
                        : '${entry.categories.length} categories',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatSigned(entry.points),
                      style: const TextStyle(
                        color: AppColors.mealMirrorText,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    if (entry.nutriScore != null)
                      Text(
                        'Nutri-Score ${entry.nutriScore}',
                        style: const TextStyle(
                          color: AppColors.mealMirrorMutedText,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (icons.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (final icon in icons) _foodIcon(icon)],
              ),
          ],
        ),
      ),
    );
  }

  Widget _foodIcon(String assetPath) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}
