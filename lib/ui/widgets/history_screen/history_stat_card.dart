import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../../domain/models/meal_summary.dart';

import '../../../domain/services/nutrition_service.dart';
import '../reusable/stat_bar.dart';

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
              NutritionService.barProgressFromSteps(totals.energy),
              fillColor: AppColors.grainStarches,
            ),
            _nutritionRow(
              'Sweet Level (Sugar)',
              NutritionService.barProgressFromSteps(totals.sugar),
              fillColor: AppColors.snacks,
            ),
            _nutritionRow(
              'Fat Fuel (Fat)',
              NutritionService.barProgressFromSteps(totals.fat),
              fillColor: AppColors.oilsFats,
            ),
            _nutritionRow(
              'Grow Power (Protein)',
              NutritionService.barProgressFromSteps(totals.protein),
              fillColor: AppColors.meatSeafood,
            ),
            _nutritionRow(
              'Gut Guard (Fiber)',
              NutritionService.barProgressFromSteps(totals.fiber),
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
