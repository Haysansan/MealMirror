import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HistoryStatCard extends StatelessWidget {
  const HistoryStatCard({Key? key}) : super(key: key);

  Widget _statRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onLight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _statBlock(title: "This Week's Nutrition"),
        const SizedBox(height: 10),
        _statBlock(title: "Today's Nutrition"),
      ],
    );
  }

  Widget _statBlock({required String title}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.section,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.onLight,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _statRow('Daily Power (ENERGY)'),
          _statRow('Sweet Level (SUGAR)'),
          _statRow('Fat Fuel (FAT)'),
          _statRow('Grow Power (PROTEIN)'),
          _statRow('Gut Guard (FIBER)'),
        ],
      ),
    );
  }
}
