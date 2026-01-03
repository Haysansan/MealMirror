import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PortionSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const PortionSelector({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = ['Small', 'Normal', 'Large'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How much did you eat?', style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        ...options.map((opt) {
          final selected = opt == value;
          return GestureDetector(
            onTap: () => onChanged(opt),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.surfaceDark.withOpacity(0.18)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: selected
                    ? Border.all(color: AppColors.primary, width: 2)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    opt,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.onLight,
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle, color: AppColors.primary)
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class ProcessingSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const ProcessingSelector({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = [
      {'label': 'Whole', 'desc': 'Unrefined, close to natural state.'},
      {
        'label': 'Processed',
        'desc': 'Ingredients altered, simple preparation.',
      },
      {'label': 'Ultra-Processed', 'desc': 'Highly industrial and additives.'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How processed is this meal?', style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        ...options.map((o) {
          final label = o['label']! as String;
          final desc = o['desc']! as String;
          final selected = label == value;
          return GestureDetector(
            onTap: () => onChanged(label),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selected ? AppColors.section : AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: selected
                    ? Border.all(color: AppColors.primary, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppTextStyles.titleLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.onLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          desc,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle, color: AppColors.primary)
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
