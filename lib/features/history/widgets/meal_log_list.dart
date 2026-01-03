import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class MealDay {
  final String title;
  final String subtitle;
  final int score;
  final int green;
  final int yellow;
  final int red;

  MealDay({
    required this.title,
    required this.subtitle,
    required this.score,
    required this.green,
    required this.yellow,
    required this.red,
  });
}

class MealLogList extends StatelessWidget {
  final List<MealDay> days;
  const MealLogList({Key? key, this.days = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return _emptyState(context);
    }

    return ListView.separated(
      itemCount: days.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final d = days[index];
        return _buildDayCard(context, d);
      },
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.calendar_today,
              size: 36,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No meals logged yet',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Start logging meals to see your history',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, MealDay day) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.section,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day.title,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.onLight,
                      ),
                    ),
                    Text(
                      '${day.score > 0 ? '+' : ''}${day.score}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  day.subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _pill(Icons.circle, AppColors.primary, '${day.green}'),
                    const SizedBox(width: 8),
                    _pill(Icons.circle, Colors.orange, '${day.yellow}'),
                    const SizedBox(width: 8),
                    _pill(Icons.circle, Colors.red, '${day.red}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(IconData icon, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.onLight),
          ),
        ],
      ),
    );
  }
}
