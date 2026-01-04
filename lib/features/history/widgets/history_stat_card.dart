import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HistoryStatCard extends StatelessWidget {
  final String title;

  const HistoryStatCard({super.key, required this.title});

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

            _nutritionRow('Daily Power (Energy)'),
            _nutritionRow('Sweet Level (Sugar)'),
            _nutritionRow('Fat Fuel (Fat)'),
            _nutritionRow('Grow Power (Protein)'),
            _nutritionRow('Gut Guard (Fiber)'),
          ],
        ),
      ),
    );
  }

  Widget _nutritionRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Container(
            width: 120,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
