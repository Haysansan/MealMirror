import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/entities/instruction_step.dart'
    hide TextSpan;
import 'package:mealmirror/ui/theme/app_colors.dart';

class SoftCircle extends StatelessWidget {
  const SoftCircle({
    super.key,
    required this.diameter,
    required this.noiseColor,
  });

  final double diameter;
  final Color noiseColor;

  @override
  Widget build(BuildContext context) {
    final Color center = AppColors.actionSurface.withValues(alpha: 0.92);
    final Color mid = AppColors.actionSurface.withValues(alpha: 0.50);
    final Color edge = AppColors.actionSurface.withValues(alpha: 0.00);

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [center, mid, edge],
                stops: const [0.0, 0.66, 1.0],
              ),
            ),
            child: const SizedBox.expand(),
          ),
          IgnorePointer(child: CustomPaint(size: Size(diameter, diameter))),
        ],
      ),
    );
  }
}

class PetImage extends StatelessWidget {
  const PetImage({super.key, required this.size, required this.height});

  final double size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.98, end: 1.0),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: SizedBox(
        width: size,
        height: height,
        child: Image.asset(
          'assets/images/MealMirrorPet.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class PetIcon extends StatelessWidget {
  const PetIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/MealMirrorPet.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class LogoText extends StatelessWidget {
  const LogoText({super.key, required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.90,
      child: Text(
        'MEAL MIRROR',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.petGreen,
          fontSize: fontSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
          shadows: [
            Shadow(
              color: AppColors.petGreen.withValues(alpha: 0.20),
              blurRadius: 1.8,
              offset: const Offset(0, 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class TaglineText extends StatelessWidget {
  const TaglineText({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.90,
      child: const Text(
        'your habits, reflected',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.matcha,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w200,
          letterSpacing: 4.2,
        ),
      ),
    );
  }
}

class MessageText extends StatelessWidget {
  const MessageText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.petGreen.withValues(alpha: 0.92),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 1.2,
            letterSpacing: 1.4,
            shadows: [
              Shadow(
                color: AppColors.background.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PromptText extends StatelessWidget {
  const PromptText({super.key, required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Text(
        prompt,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.petGreen,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
          height: 1.25,
        ),
      ),
    );
  }
}

class MeetTitle extends StatelessWidget {
  const MeetTitle({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Text(
        'meet $name! ',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.petGreen,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class CompanionLine extends StatelessWidget {
  const CompanionLine({super.key, required this.line});

  final String line;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 460),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Text(
        line,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.petGreen,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class ConversationText extends StatelessWidget {
  const ConversationText({
    super.key,
    required this.block,
    required this.alignLeft,
  });

  final ConversationBlock block;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      color: AppColors.petGreen,
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      letterSpacing: 1.40,
      height: 1.25,
    );
    final spanSemi = base.copyWith(fontWeight: FontWeight.w600);

    if (block.spans != null) {
      return Text.rich(
        TextSpan(
          children: block.spans!.map((s) {
            return TextSpan(text: s.text, style: s.bold ? spanSemi : base);
          }).toList(),
        ),
        textAlign: alignLeft ? TextAlign.left : TextAlign.right,
      );
    }

    return Text(
      block.text ?? '',
      textAlign: alignLeft ? TextAlign.left : TextAlign.right,
      style: base,
    );
  }
}

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
    required this.onDotTap,
  });

  final int activeIndex;
  final int count;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool isActive = i == activeIndex;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onDotTap(i),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.white : const Color(0xFFDDDDDD),
            ),
          ),
        );
      }),
    );
  }
}

class PopIn extends StatelessWidget {
  const PopIn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: Transform.scale(scale: 0.98 + (0.02 * value), child: child),
          ),
        );
      },
      child: child,
    );
  }
}
