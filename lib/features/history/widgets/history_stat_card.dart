import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../../../data/local/meal_store.dart';
import '../../../shared/widgets/stat_bar.dart';

class HistoryStatCard extends StatelessWidget {
  final String title;
  final NutritionTotals totals;

  const HistoryStatCard({super.key, required this.title, required this.totals});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),

            _nutritionRow(
              'Daily Power (Energy)',
              MealStore.barProgressFromSteps(totals.energy),
              fillColor: AppColors.grainStarches,
            ),
            _nutritionRow(
              'Sweet Level (Sugar)',
              MealStore.barProgressFromSteps(totals.sugar),
              fillColor: AppColors.snacks,
            ),
            _nutritionRow(
              'Fat Fuel (Fat)',
              MealStore.barProgressFromSteps(totals.fat),
              fillColor: AppColors.oilsFats,
            ),
            _nutritionRow(
              'Grow Power (Protein)',
              MealStore.barProgressFromSteps(totals.protein),
              fillColor: AppColors.meatSeafood,
            ),
            _nutritionRow(
              'Gut Guard (Fiber)',
              MealStore.barProgressFromSteps(totals.fiber),
              fillColor: AppColors.veggieFruits,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutritionRow(
    String label,
    double progress, {
    required Color fillColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          StatBar(progress: progress, fillColor: fillColor, height: 10),
        ],
      ),
    );
  }
}
