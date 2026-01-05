import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../../../data/local/meal_store.dart';

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
            ),
            _nutritionRow(
              'Sweet Level (Sugar)',
              MealStore.barProgressFromSteps(totals.sugar),
            ),
            _nutritionRow(
              'Fat Fuel (Fat)',
              MealStore.barProgressFromSteps(totals.fat),
            ),
            _nutritionRow(
              'Grow Power (Protein)',
              MealStore.barProgressFromSteps(totals.protein),
            ),
            _nutritionRow(
              'Gut Guard (Fiber)',
              MealStore.barProgressFromSteps(totals.fiber),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutritionRow(String label, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          _ProgressBar(progress: progress),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.white.withValues(alpha: 0.6)),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(color: AppColors.actionSurface),
            ),
          ],
        ),
      ),
    );
  }
}
