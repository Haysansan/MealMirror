import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.progress,
    required this.fillColor,
    this.width = 120,
    this.height = 10,
    this.backgroundColor,
    this.borderRadius,
    this.showEndpoint = false,
    this.showStartPoint = false,
    this.endpointColor,
    this.endpointSize,
  });

  final double progress;
  final Color fillColor;
  final double width;
  final double height;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showEndpoint;
  final bool showStartPoint;
  final Color? endpointColor;
  final double? endpointSize;

  @override
  Widget build(BuildContext context) {
    final double clamped =
        (progress.isNaN || progress.isInfinite ? 0.0 : progress).clamp(
          0.0,
          1.0,
        );
    final BorderRadius radius =
        borderRadius ?? BorderRadius.circular((height / 2).clamp(4.0, 999.0));

    final double dotSize = (endpointSize ?? (height + 2)).clamp(
      6.0,
      (height * 2) + 10,
    );
    final double dotTop = (height - dotSize) / 2;
    final Color dotColor = endpointColor ?? fillColor;
    final double dotLeft = (width * clamped) - (dotSize / 2);

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor ?? AppColors.surface,
                  border: Border.all(
                    color: AppColors.darkMatcha.withValues(alpha: 0.28),
                    width: 1,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: clamped,
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: radius,
                    ),
                  ),
                ),
              ),
            ),

            if (showStartPoint)
              Positioned(
                left: 0,
                top: dotTop,
                width: dotSize,
                height: dotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

            if (showEndpoint)
              Positioned(
                left: dotLeft.clamp(0.0, width - dotSize),
                top: dotTop,
                width: dotSize,
                height: dotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
