import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

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
              'Today’s Balance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Neutral Day', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),

            _balanceRow('Daily Power (ENERGY)'),
            _balanceRow('Sweet Level (SUGAR)'),
            _balanceRow('Fat Fuel (FAT)'),
            _balanceRow('Grow Power (PROTEIN)'),
            _balanceRow('Gut Guard (FIBER)'),
          ],
        ),
      ),
    );
  }
}

Widget _balanceRow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Container(
          width: 120,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );
}
