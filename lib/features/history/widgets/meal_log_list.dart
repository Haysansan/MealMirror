import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MealLogList extends StatelessWidget {
  const MealLogList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        _mealCard(meals: '1 meal', score: 4),

        const SizedBox(height: 12),

        const Text(
          'Mon, Dec 29',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        _mealCard(meals: '3 meals', score: 4),
      ],
    );
  }

  Widget _mealCard({required String meals, required int score}) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(meals)),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.eco,
                      size: 16,
                      color: index < score
                          ? AppColors.primary
                          : AppColors.secondary.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _foodIcon('assets/images/Vegies.png'),
                const SizedBox(width: 8),
                _foodIcon('assets/images/meat.png'),
                const SizedBox(width: 8),
                _foodIcon('assets/images/cookie.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _foodIcon(String assetPath) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}
