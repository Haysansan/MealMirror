import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/entities/instruction_step.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/common_widgets.dart';

class StandardStep extends StatelessWidget {
  const StandardStep({
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

    final double headlineTop = (viewportHeight * 0.18).clamp(64, 150);
    const double headlineFontSize = 34;
    const double headlineLineHeight = 1.18;
    const int headlineLines = 3;
    final double headlineBlockHeight =
        headlineFontSize * headlineLineHeight * headlineLines;

    final double petWidth = (viewportWidth * 0.34).clamp(112, 152);
    final double petHeight = (petWidth * 1.12).clamp(126, 184);
    final double petTop =
        (headlineTop + (headlineBlockHeight / 2) - (petHeight / 2)).clamp(
          80,
          viewportHeight * 0.30,
        );

    final double messageTop = (viewportHeight * 0.54).clamp(350, 520);
    final double dotsTop = (viewportHeight * 0.78).clamp(520, 640);
    final double logoTop = (viewportHeight * 0.84).clamp(560, 700);

    final bool isMeet = step.layout == InstructionStepLayout.meetCompanion;
    final bool isIllustration =
        step.layout == InstructionStepLayout.illustrationPrompt;

    final double meetPetSize = (viewportWidth * 0.38).clamp(130, 170);
    final double meetPetTop =
        (viewportHeight * 0.53).clamp(330, 520) - (meetPetSize / 2);
    final double meetTitleTop = meetPetTop - 54;
    final double meetSubtitleTop = meetPetTop + meetPetSize + 10;

    final double illoLogoTop = (viewportHeight * 0.24).clamp(170, 220);
    final double illoPetSize = (viewportWidth * 0.62).clamp(220, 290);
    final double illoPetTop = (viewportHeight * 0.46).clamp(250, 360);
    final double illoPromptTop = (viewportHeight * 0.63).clamp(430, 580);
    final double illoTaglineTop = dotsTop + 26;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (!isIllustration)
          Positioned(
            left: circleLeft,
            top: circleTop,
            child: SoftCircle(
              diameter: diameter,
              noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
            ),
          ),
        if (!isIllustration)
          Positioned(
            left: 26,
            top: headlineTop,
            child: Hero(
              tag: 'onboarding_headline',
              child: Material(
                color: Colors.transparent,
                child: Opacity(
                  opacity: 0.72,
                  child: Text(
                    'your\nhabits,\nreflected',
                    style: TextStyle(
                      color: AppColors.matcha,
                      fontSize: 34,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      height: 1.18,
                      letterSpacing: 8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (isIllustration)
          Positioned(
            top: illoLogoTop,
            left: 0,
            right: 0,
            child: LogoText(fontSize: (viewportWidth * 0.050).clamp(16, 20)),
          ),
        Positioned(
          top: isMeet ? meetPetTop : (isIllustration ? illoPetTop : petTop),
          left: (isMeet || isIllustration)
              ? (viewportWidth - (isIllustration ? illoPetSize : meetPetSize)) /
                    2
              : null,
          right: (isMeet || isIllustration) ? null : 22,
          child: Hero(
            tag: 'onboarding_pet',
            child: PetImage(
              size: isIllustration
                  ? illoPetSize
                  : (isMeet ? meetPetSize : petWidth),
              height: isIllustration
                  ? illoPetSize
                  : (isMeet ? meetPetSize : petHeight),
            ),
          ),
        ),
        if (isIllustration)
          Positioned(
            top: illoPromptTop,
            left: 24,
            right: 24,
            child: PromptText(prompt: step.prompt ?? ''),
          ),
        if (isMeet)
          Positioned(
            top: meetTitleTop,
            left: 0,
            right: 0,
            child: MeetTitle(name: step.name ?? ''),
          ),
        if (isMeet)
          Positioned(
            top: meetSubtitleTop,
            left: 24,
            right: 24,
            child: CompanionLine(line: step.companionLine ?? ''),
          ),
        if (!isMeet)
          Positioned(
            top: messageTop,
            left: 24,
            right: 24,
            child: MessageText(message: step.message ?? ''),
          ),
        if (isIllustration)
          Positioned(
            top: illoTaglineTop,
            left: 0,
            right: 0,
            child: const TaglineText(),
          ),
        Positioned(
          top: dotsTop,
          left: 0,
          right: 0,
          child: DotsIndicator(
            activeIndex: index,
            count: total,
            onDotTap: onDotTap,
          ),
        ),
        if (!isIllustration)
          Positioned(
            top: logoTop,
            left: 0,
            right: 0,
            child: LogoText(fontSize: (viewportWidth * 0.050).clamp(16, 20)),
          ),
      ],
    );
  }
}
