import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 402),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double heroHeight = (constraints.maxHeight * 0.78).clamp(
                  520,
                  740,
                );

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.push(AppRoutes.instruction),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: heroHeight,
                          child: _WelcomeHero(
                            viewportWidth: constraints.maxWidth,
                            viewportHeight: heroHeight,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero({
    required this.viewportWidth,
    required this.viewportHeight,
  });

  final double viewportWidth;
  final double viewportHeight;

  @override
  Widget build(BuildContext context) {
    final double diameter = (viewportWidth * 3.0).clamp(720, 1280);
    final double circleLeft = (viewportWidth - diameter) / 2;
    final double circleTop = (viewportHeight * 0.52) - (diameter / 2);

    final double petSize = (viewportWidth * 0.72).clamp(220, 320);
    final double petTop = viewportHeight * 0.30;
    final double reflectionTop = petTop + (petSize * 0.70);
    final double logoTop = viewportHeight * 0.70;

    return SizedBox(
      width: viewportWidth,
      height: viewportHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: circleLeft,
            top: circleTop,
            child: _SoftCircle(
              diameter: diameter,
              noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
            ),
          ),
          Positioned(
            left: 26,
            top: (viewportHeight * 0.12).clamp(24, 92),
            child: Hero(
              tag: 'onboarding_headline',
              child: const Material(
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
          Positioned(
            top: petTop,
            left: (viewportWidth - petSize) / 2,
            child: Hero(
              tag: 'onboarding_pet',
              child: SizedBox(
                width: petSize,
                height: petSize,
                child: Image.asset(
                  'assets/images/MealMirrorPet.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: reflectionTop,
            left: (viewportWidth - petSize) / 2,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x55FFFFFF),
                    Color(0x10FFFFFF),
                    Color(0x00000000),
                  ],
                  stops: [0, 0.45, 1],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Opacity(
                opacity: 0.26,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateX(math.pi),
                  child: SizedBox(
                    width: petSize,
                    height: petSize,
                    child: Image.asset(
                      'assets/images/MealMirrorPet.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: logoTop,
            left: 0,
            right: 0,
            child: _ReflectedText(
              text: 'MEAL MIRROR',
              color: AppColors.petGreen,
              fontSize: (viewportWidth * 0.040).clamp(12, 16),
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCircle extends StatelessWidget {
  const _SoftCircle({required this.diameter, required this.noiseColor});

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

class _ReflectedText extends StatelessWidget {
  const _ReflectedText({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.letterSpacing,
  });

  final String text;
  final Color color;
  final double fontSize;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w800,
      letterSpacing: letterSpacing,
      height: 1.1,
      shadows: [
        Shadow(
          color: color.withValues(alpha: 0.22),
          blurRadius: 1.8,
          offset: const Offset(0, 0.4),
        ),
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text, textAlign: TextAlign.center, style: style),
        const SizedBox(height: 2),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x33FFFFFF), Color(0x10FFFFFF), Color(0x00000000)],
              stops: [0, 0.45, 1],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Opacity(
            opacity: 0.32,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateX(math.pi),
              child: Text(text, textAlign: TextAlign.center, style: style),
            ),
          ),
        ),
      ],
    );
  }
}
