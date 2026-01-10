import 'package:flutter/material.dart';

import 'package:mealmirror/ui/theme/app_colors.dart';

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

    const Color baseFill = AppColors.actionSurface;
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

    const Color titleColor = AppColors.mealMirrorText;
    const Color descriptionColor = AppColors.mealMirrorMutedText;

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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
