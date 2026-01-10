import 'package:flutter/material.dart';
import '../../../domain/models/meal_entry.dart';
import '../../theme/app_colors.dart';

class MealLogList extends StatelessWidget {
  const MealLogList({super.key, required this.meals, required this.now});

  final List<MealEntry> meals;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              meal.portion,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.mealMirrorTitle,
              ),
            ),
            subtitle: Text(
              meal.categories.join(', '),
              style: const TextStyle(color: AppColors.mealMirrorMutedText),
            ),
            trailing: Text(
              _formatTime(meal.createdAt),
              style: const TextStyle(
                color: AppColors.mealMirrorMutedText,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
