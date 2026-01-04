import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';

class StatItem {
  final String label;
  final String value;
  const StatItem({required this.label, required this.value});
}

class ProfileStatSection extends StatelessWidget {
  final String title;
  final List<StatItem> stats;
  const ProfileStatSection({Key? key, required this.title, required this.stats})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleSmall.copyWith(color: AppColors.onLight),
        ),
        const SizedBox(height: 8),
        Row(
          children: stats
              .map((s) => Expanded(child: _StatCard(item: s)))
              .toList(),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final StatItem item;
  const _StatCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary),
          ),
          const SizedBox(height: 6),
          Text(
            item.value,
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.onLight,
            ),
          ),
        ],
      ),
    );
  }
}
