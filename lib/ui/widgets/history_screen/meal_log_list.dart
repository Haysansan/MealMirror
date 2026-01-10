import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/models/log_meal_categories.dart';
import 'package:mealmirror/domain/services/nutri_score_service.dart';
import 'package:mealmirror/data/meal_repository.dart';

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
        final nutriScore = NutriScoreService.calculateNutriScore(
          energy: meal.energy,
          sugar: meal.sugar,
          fat: meal.fat,
          protein: meal.protein,
          fiber: meal.fiber,
        );
        final timeFormatted = _formatTime(meal.createdAt);

        return Dismissible(
          key: Key(meal.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Delete meal from repository
            MealRepository.deleteMeal(meal.id);
            // Show confirmation
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Meal deleted')));
          },
          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: ShapeDecoration(
              color: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.75),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: ShapeDecoration(
              color: const Color(0xFFCADBB7),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE1E7EF)),
                borderRadius: BorderRadius.circular(12.75),
              ),
              shadows: [
                const BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
                const BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row with time and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      meal.processing.isNotEmpty
                          ? _capitalizeFully(meal.processing)
                          : 'normal',
                      style: const TextStyle(
                        color: Color(0xFF0E1A00),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      timeFormatted,
                      style: const TextStyle(
                        color: Color(0xFF0E1A00),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Category icons instead of text
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: meal.categories.map((category) {
                    final categoryInfo = LogMealCategories.tryGet(category);
                    if (categoryInfo == null) {
                      return Tooltip(
                        message: category,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.category,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return Tooltip(
                      message: categoryInfo.displayName,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: categoryInfo.color.withValues(alpha: 0.2),
                          border: Border.all(
                            color: categoryInfo.color,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          categoryInfo.iconAssetPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                // Points and Nutri-Score row
                Row(
                  children: [
                    // Points badge (simplified: no background/shadow; larger icon and number)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            meal.points >= 0 ? Icons.add : Icons.remove,
                            size: 16,
                            color: const Color(0xFF0E1A00),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          meal.points.abs().toString(),
                          style: const TextStyle(
                            color: Color(0xFF0E1A00),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Nutri-Score badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(
                          int.parse(
                            '0xff${NutriScoreService.getColorCode(nutriScore).substring(1)}',
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x4C000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        nutriScore,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _capitalizeFully(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
