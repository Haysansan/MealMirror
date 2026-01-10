import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/instruction_step.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/common_widgets.dart';

class StartCtaStep extends StatelessWidget {
  const StartCtaStep({
    super.key,
    required this.viewportWidth,
    required this.viewportHeight,
    required this.step,
    required this.index,
    required this.total,
    required this.onDotTap,
  });

  final double viewportWidth;
  final double viewportHeight;
  final InstructionStep step;
  final int index;
  final int total;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final double diameter = (viewportWidth * 3.0).clamp(720, 1280);
    final double circleLeft = (viewportWidth - diameter) / 2;
    final double circleTop = (viewportHeight * 0.60) - (diameter / 2);

    final double petSize = (viewportWidth * 0.64).clamp(220, 270);
    final double titleTop = (viewportHeight * 0.26).clamp(170, 220);
    final double petTop = (viewportHeight * 0.42).clamp(240, 320);
    final double headlineTop = (viewportHeight * 0.60).clamp(480, 560);
    final double actionTop = (viewportHeight * 0.69).clamp(560, 640);
    final double taglineTop = (viewportHeight * 0.80).clamp(650, 730);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: circleLeft,
          top: circleTop,
          child: SoftCircle(
            diameter: diameter,
            noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
          ),
        ),
        Positioned(
          top: titleTop,
          left: 0,
          right: 0,
          child: LogoText(fontSize: (viewportWidth * 0.050).clamp(18, 20)),
        ),
        Positioned(
          top: petTop,
          left: (viewportWidth - petSize) / 2,
          child: PetImage(size: petSize, height: petSize),
        ),
        Positioned(
          top: headlineTop,
          left: 0,
          right: 0,
          child: Text(
            step.ctaHeadline ?? 'START YOUR JOUNEY\nWITH RONAN NOW! ',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.petGreen,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              height: 1.15,
            ),
          ),
        ),
        Positioned(
          top: actionTop,
          left: 0,
          right: 0,
          child: Text(
            step.ctaAction ?? 'READY →',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.petGreen,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              letterSpacing: 2.4,
            ),
          ),
        ),
        Positioned(
          top: taglineTop,
          left: 0,
          right: 0,
          child: const TaglineText(),
        ),
        Positioned(
          bottom: 18,
          left: 0,
          right: 0,
          child: DotsIndicator(
            activeIndex: index,
            count: total,
            onDotTap: onDotTap,
          ),
        ),
      ],
    );
  }
}
