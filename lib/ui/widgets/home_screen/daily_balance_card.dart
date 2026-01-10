import 'package:flutter/material.dart';

import 'package:mealmirror/domain/services/nutrition_service.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/stat_bar.dart';

class DailyBalanceCard extends StatelessWidget {
  const DailyBalanceCard({super.key, required this.totals});

  final NutritionTotals totals;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Balance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Neutral Day', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            _BalanceRow(
              'Daily Power (ENERGY)',
              NutritionService.barProgressFromSteps(totals.energy),
              fillColor: AppColors.grainStarches,
            ),
            _BalanceRow(
              'Sweet Level (SUGAR)',
              NutritionService.barProgressFromSteps(totals.sugar),
              fillColor: AppColors.snacks,
            ),
            _BalanceRow(
              'Fat Fuel (FAT)',
              NutritionService.barProgressFromSteps(totals.fat),
              fillColor: AppColors.oilsFats,
            ),
            _BalanceRow(
              'Grow Power (PROTEIN)',
              NutritionService.barProgressFromSteps(totals.protein),
              fillColor: AppColors.meatSeafood,
            ),
            _BalanceRow(
              'Gut Guard (FIBER)',
              NutritionService.barProgressFromSteps(totals.fiber),
              fillColor: AppColors.veggieFruits,
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow(this.label, this.progress, {required this.fillColor});

  final String label;
  final double progress;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          StatBar(progress: progress, fillColor: fillColor),
        ],
      ),
    );
  }
}
