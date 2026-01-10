import 'package:flutter/material.dart';
import '../../../domain/models/meal_summary.dart';
import '../../theme/app_colors.dart';

class HistoryStatCard extends StatelessWidget {
  const HistoryStatCard({super.key, required this.title, required this.totals});

  final String title;
  final NutritionTotals totals;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.actionSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.mealMirrorTitle,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NutritionStat(
                  label: 'Energy',
                  value: totals.energy.toString(),
                ),
                _NutritionStat(
                  label: 'Protein',
                  value: totals.protein.toString(),
                ),
                _NutritionStat(label: 'Fat', value: totals.fat.toString()),
                _NutritionStat(label: 'Fiber', value: totals.fiber.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NutritionStat extends StatelessWidget {
  const _NutritionStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.mealMirrorMutedText,
          ),
        ),
      ],
    );
  }
}
