import 'package:flutter/material.dart';
<<<<<<< HEAD
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
    final List<Map<String, String>> options = [
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
          final label = o['label']!;
          final desc = o['desc']!;
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
=======

import '../../../core/theme/app_colors.dart';

class PortionSizeSelectionCard extends StatelessWidget {
  const PortionSizeSelectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.selected = false,
    this.onTap,
    this.width = 368,
    this.opacity = 0.75,
  });

  final String title;
  final String description;
  final Widget icon;
  final bool selected;
  final VoidCallback? onTap;
  final double width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(12.75);

    const Color baseFill = AppColors.portionCardBaseFill;
    const Color baseBorder = AppColors.portionCardBaseBorder;
    const Color selectedBorder = AppColors.portionCardSelectedBorder;

    final Color fillColor = selected
        ? Color.lerp(baseFill, Colors.white, 0.18)!
        : baseFill;

    final BorderSide borderSide = BorderSide(
      width: 1,
      color: selected ? selectedBorder : baseBorder,
    );

    final Color iconFillColor = selected
        ? Color.lerp(selectedBorder, Colors.white, 0.82)!
        : Colors.white;

    final List<BoxShadow> shadows = [
      const BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 2,
        offset: Offset(0, 1),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: const Color(0x0A000000),
        blurRadius: selected ? 10 : 8,
        offset: const Offset(0, 2),
        spreadRadius: 0,
      ),
    ];

    const Color titleColor = AppColors.ink;
    const Color descriptionColor = AppColors.inkMuted;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: AnimatedScale(
          scale: selected ? 1.03 : 1,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: Opacity(
            opacity: opacity,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              curve: Curves.easeOut,
              width: width,
              padding: const EdgeInsets.all(17),
              decoration: ShapeDecoration(
                color: fillColor,
                shape: RoundedRectangleBorder(
                  side: borderSide,
                  borderRadius: borderRadius,
                ),
                shadows: shadows,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: iconFillColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Center(child: icon),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: titleColor,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                        const SizedBox(height: 4.25),
                        Text(
                          description,
                          style: const TextStyle(
                            color: descriptionColor,
                            fontSize: 14.4,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.48,
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
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
=======
                ],
              ),
            ),
          ),
        ),
      ),
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
    );
  }
}
