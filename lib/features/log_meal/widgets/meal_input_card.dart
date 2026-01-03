import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

typedef CategoryCallback = void Function(String category);

class MealInputCard extends StatelessWidget {
  final String? selected;
  final CategoryCallback? onSelect;
  const MealInputCard({Key? key, this.selected, this.onSelect})
    : super(key: key);

  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'vegetables',
      'label': 'Vegetables',
      'image': 'assets/images/Vegies.png',
    },
    {'id': 'fruit', 'label': 'Fruit', 'image': 'assets/images/Tomato.png'},
    {'id': 'protein', 'label': 'Protein', 'image': 'assets/images/Egg.png'},
    {'id': 'carbs', 'label': 'Carbs', 'image': 'assets/images/Bread.png'},
    {
      'id': 'treats',
      'label': 'Treats',
      'image': 'assets/images/MealMirrorPet.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select a food category', style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: categories.map((c) {
              final label = c['label'] as String;
              final bg = Color(c['color'] as int);
              final isSelected = selected == label;
              return GestureDetector(
                onTap: () => onSelect?.call(label),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.12)
                        : bg,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.fastfood,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(label, style: AppTextStyles.bodyMedium),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
