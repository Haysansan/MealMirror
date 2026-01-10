import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/entities/instruction_step.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/common_widgets.dart';
import 'conversation_row.dart';

class ConversationStep extends StatelessWidget {
  const ConversationStep({
    super.key,
    required this.viewportWidth,
    required this.viewportHeight,
    required this.step,
    required this.visibleCount,
    required this.index,
    required this.total,
    required this.onDotTap,
  });

  final double viewportWidth;
  final double viewportHeight;
  final InstructionStep step;
  final int visibleCount;
  final int index;
  final int total;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final double diameter = (viewportWidth * 3.0).clamp(720, 1280);
    final double circleLeft = (viewportWidth - diameter) / 2;
    final double circleTop = (viewportHeight * 0.60) - (diameter / 2);

    final List<Widget> visible = [];
    final int blocks = (step.blocks ?? const []).length;
    final int count = visibleCount.clamp(0, blocks);
    final int lastVisibleIndex = count - 1;

    for (int i = 0; i < count; i++) {
      final block = step.blocks![i];
      final double iconSize = (viewportWidth * 0.20).clamp(76, 92);
      final Widget row = ConversationRow(block: block, iconSize: iconSize);

      if (i == lastVisibleIndex) {
        visible.add(PopIn(key: ValueKey<int>(i), child: row));
      } else {
        visible.add(row);
      }
      visible.add(const SizedBox(height: 14));
    }

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double bgDiameter = (screenWidth * 3.0).clamp(720, 2000);
    final double bgLeft = (screenWidth - bgDiameter) / 2;
    final double bgTop = (viewportHeight * 0.60) - (bgDiameter / 2);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: OverflowBox(
            alignment: Alignment.topCenter,
            minWidth: screenWidth,
            maxWidth: screenWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.actionSurface.withValues(alpha: 0.18),
                    ),
                  ),
                ),
                Positioned(
                  left: bgLeft,
                  top: bgTop,
                  child: SoftCircle(
                    diameter: bgDiameter,
                    noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: circleLeft,
          top: circleTop,
          child: SoftCircle(
            diameter: diameter,
            noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 18),
              Text(
                step.title ?? 'MEAL MIRROR',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.petGreen,
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 6),
              Opacity(
                opacity: 0.90,
                child: Text(
                  step.subtitle ?? 'your habits, reflected',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.matcha,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w200,
                    letterSpacing: 4.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Column(children: visible),
                ),
              ),
              DotsIndicator(
                activeIndex: index,
                count: total,
                onDotTap: onDotTap,
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }
}
