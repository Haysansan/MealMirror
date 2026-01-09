import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../../data/local/preferences/app_preferences.dart';
import '../../../models/instruction_steps.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({super.key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  int _index = 0;
  bool _isTransitioning = false;
  int _conversationVisibleCount = 0;

  int _initialConversationVisibleCount(int index) {
    final step = instructionSteps[index];
    if (step.layout != InstructionStepLayout.conversation) return 0;
    final int len = step.blocks?.length ?? 0;
    return len > 0 ? 1 : 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    await AppPreferences.setBool('seenOnboarding', true);
    if (context.mounted) {
      context.go(AppRoutes.signup);
    }
  }

  Future<void> _next(BuildContext context) async {
    if (_isTransitioning) return;

    final int lastIndex = instructionSteps.length - 1;
    if (_index >= lastIndex) {
      await _finishOnboarding(context);
      return;
    }

    setState(() {
      _isTransitioning = true;
      _index += 1;
      _conversationVisibleCount = _initialConversationVisibleCount(_index);
    });

    await Future<void>.delayed(const Duration(milliseconds: 260));
    if (!mounted) return;
    setState(() => _isTransitioning = false);
  }

  void _jumpTo(BuildContext context, int index) {
    if (_isTransitioning) return;
    if (index < 0 || index >= instructionSteps.length) return;
    if (index == _index) return;

    setState(() {
      _index = index;
      _conversationVisibleCount = _initialConversationVisibleCount(_index);
    });
  }

  void _handleTap(BuildContext context) {
    final step = instructionSteps[_index];
    if (step.layout == InstructionStepLayout.conversation) {
      final blocks = step.blocks ?? const [];
      if (_conversationVisibleCount < blocks.length) {
        setState(() => _conversationVisibleCount += 1);
        return;
      }
    }

    _next(context);
  }

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
                final double heroHeight = constraints.maxHeight;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _handleTap(context),
                  child: SizedBox(
                    height: heroHeight,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeOut,
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      transitionBuilder: (child, animation) {
                        final curved = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        );

                        return FadeTransition(
                          opacity: curved,
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.985,
                              end: 1.0,
                            ).animate(curved),
                            child: child,
                          ),
                        );
                      },
                      child: _InstructionHero(
                        key: ValueKey<int>(_index),
                        viewportWidth: constraints.maxWidth,
                        viewportHeight: heroHeight,
                        step: instructionSteps[_index],
                        index: _index,
                        total: instructionSteps.length,
                        onDotTap: (value) => _jumpTo(context, value),
                        conversationVisibleCount: _conversationVisibleCount,
                      ),
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

class _InstructionHero extends StatelessWidget {
  const _InstructionHero({
    super.key,
    required this.viewportWidth,
    required this.viewportHeight,
    required this.step,
    required this.index,
    required this.total,
    required this.onDotTap,
    required this.conversationVisibleCount,
  });

  final double viewportWidth;
  final double viewportHeight;
  final InstructionStep step;
  final int index;
  final int total;
  final ValueChanged<int> onDotTap;
  final int conversationVisibleCount;

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
    final bool isConversation =
        step.layout == InstructionStepLayout.conversation;
    final bool isStartCta = step.layout == InstructionStepLayout.startCta;

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

    return SizedBox(
      width: viewportWidth,
      height: viewportHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isStartCta)
            Positioned.fill(
              child: _StartCtaStep(
                width: viewportWidth,
                height: viewportHeight,
                diameter: diameter,
                circleLeft: circleLeft,
                circleTop: circleTop,
                headline:
                    step.ctaHeadline ?? 'START YOUR JOUNEY\nWITH RONAN NOW!',
                action: step.ctaAction ?? 'READY →',
                tagline: step.ctaTagline ?? 'your habits, reflected',
                activeIndex: index,
                total: total,
                onDotTap: onDotTap,
              ),
            ),
          if (isConversation)
            Positioned.fill(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                minWidth: 0,
                maxWidth: double.infinity,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: viewportHeight,
                  child: _ConversationStep(
                    width: viewportWidth,
                    height: viewportHeight,
                    diameter: diameter,
                    circleLeft: circleLeft,
                    circleTop: circleTop,
                    title: step.title ?? 'MEAL MIRROR',
                    subtitle: step.subtitle ?? 'your habits, reflected',
                    blocks: step.blocks ?? const [],
                    visibleCount: conversationVisibleCount,
                    dotsTop: dotsTop,
                    logoColor: AppColors.petGreen,
                    onDotTap: onDotTap,
                    activeIndex: index,
                    total: total,
                  ),
                ),
              ),
            ),
          if (!isConversation && !isStartCta)
            Positioned(
              left: circleLeft,
              top: circleTop,
              child: _SoftCircle(
                diameter: diameter,
                noiseColor: AppColors.actionSurface.withValues(alpha: 0.50),
              ),
            ),
          if (!isConversation && !isStartCta)
            Positioned(
              left: 26,
              top: headlineTop,
              child: isIllustration
                  ? const SizedBox.shrink()
                  : Hero(
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
          if (isIllustration)
            Positioned(
              top: illoLogoTop,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.90,
                child: Text(
                  'MEAL MIRROR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.petGreen,
                    fontSize: (viewportWidth * 0.050).clamp(16, 20),
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
              ),
            ),
          if (!isConversation && !isStartCta)
            Positioned(
              top: isIllustration ? illoPetTop : (isMeet ? meetPetTop : petTop),
              left: (isMeet || isIllustration)
                  ? (viewportWidth -
                            (isIllustration ? illoPetSize : meetPetSize)) /
                        2
                  : null,
              right: (isMeet || isIllustration) ? null : 22,
              child: Hero(
                tag: 'onboarding_pet',
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.98, end: 1.0),
                  duration: const Duration(milliseconds: 420),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: SizedBox(
                    width: isIllustration
                        ? illoPetSize
                        : (isMeet ? meetPetSize : petWidth),
                    height: isIllustration
                        ? illoPetSize
                        : (isMeet ? meetPetSize : petHeight),
                    child: Image.asset(
                      'assets/images/MealMirrorPet.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          if (isIllustration)
            Positioned(
              top: illoPromptTop,
              left: 24,
              right: 24,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Text(
                  step.prompt ?? '',
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
              ),
            ),
          if (isMeet)
            Positioned(
              top: meetTitleTop,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Text(
                  'meet ${step.name ?? ''}!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.petGreen,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          if (isMeet)
            Positioned(
              top: meetSubtitleTop,
              left: 24,
              right: 24,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 460),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Text(
                  step.companionLine ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.petGreen,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          if (!isMeet && !isStartCta)
            Positioned(
              top: messageTop,
              left: 24,
              right: 24,
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Text(
                    step.message ?? '',
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
              ),
            ),
          if (isIllustration)
            Positioned(
              top: illoTaglineTop,
              left: 0,
              right: 0,
              child: const Opacity(
                opacity: 0.90,
                child: Text(
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
              ),
            ),
          if (!isConversation && !isStartCta)
            Positioned(
              top: dotsTop,
              left: 0,
              right: 0,
              child: _DotsIndicator(
                activeIndex: index,
                count: total,
                onDotTap: onDotTap,
              ),
            ),
          if (!isConversation && !isStartCta)
            Positioned(
              top: logoTop,
              left: 0,
              right: 0,
              child: isIllustration
                  ? const SizedBox.shrink()
                  : Opacity(
                      opacity: 0.90,
                      child: Text(
                        'MEAL MIRROR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.petGreen,
                          fontSize: (viewportWidth * 0.050).clamp(16, 20),
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
                    ),
            ),
        ],
      ),
    );
  }
}

class _StartCtaStep extends StatelessWidget {
  const _StartCtaStep({
    required this.width,
    required this.height,
    required this.diameter,
    required this.circleLeft,
    required this.circleTop,
    required this.headline,
    required this.action,
    required this.tagline,
    required this.activeIndex,
    required this.total,
    required this.onDotTap,
  });

  final double width;
  final double height;
  final double diameter;
  final double circleLeft;
  final double circleTop;
  final String headline;
  final String action;
  final String tagline;
  final int activeIndex;
  final int total;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final double petSize = (width * 0.64).clamp(220, 270);
    final double titleTop = (height * 0.26).clamp(170, 220);
    final double petTop = (height * 0.42).clamp(240, 320);
    final double headlineTop = (height * 0.60).clamp(480, 560);
    final double actionTop = (height * 0.69).clamp(560, 640);
    final double taglineTop = (height * 0.80).clamp(650, 730);

    return Stack(
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
          top: titleTop,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: 0.90,
            child: Text(
              'MEAL MIRROR',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.petGreen,
                fontSize: (width * 0.050).clamp(18, 20),
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
          ),
        ),
        Positioned(
          top: petTop,
          left: (width - petSize) / 2,
          child: SizedBox(
            width: petSize,
            height: petSize,
            child: Image.asset(
              'assets/images/MealMirrorPet.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: headlineTop,
          left: 0,
          right: 0,
          child: Text(
            headline,
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
            action,
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
          child: Opacity(
            opacity: 0.90,
            child: Text(
              tagline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.petGreen,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                letterSpacing: 4.2,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 18,
          left: 0,
          right: 0,
          child: _DotsIndicator(
            activeIndex: activeIndex,
            count: total,
            onDotTap: onDotTap,
          ),
        ),
      ],
    );
  }
}

class _ConversationStep extends StatelessWidget {
  const _ConversationStep({
    required this.width,
    required this.height,
    required this.diameter,
    required this.circleLeft,
    required this.circleTop,
    required this.title,
    required this.subtitle,
    required this.blocks,
    required this.visibleCount,
    required this.dotsTop,
    required this.logoColor,
    required this.onDotTap,
    required this.activeIndex,
    required this.total,
  });

  final double width;
  final double height;
  final double diameter;
  final double circleLeft;
  final double circleTop;
  final String title;
  final String subtitle;
  final List<ConversationBlock> blocks;
  final int visibleCount;
  final double dotsTop;
  final Color logoColor;
  final ValueChanged<int> onDotTap;
  final int activeIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    final List<Widget> visible = [];
    final int count = visibleCount.clamp(0, blocks.length);
    final int lastVisibleIndex = count - 1;

    for (int i = 0; i < count; i++) {
      final block = blocks[i];
      final double iconSize = (width * 0.20).clamp(76, 92);
      final Widget row = _ConversationRow(block: block, iconSize: iconSize);

      if (i == lastVisibleIndex) {
        visible.add(_PopIn(key: ValueKey<int>(i), child: row));
      } else {
        visible.add(row);
      }
      visible.add(const SizedBox(height: 14));
    }

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double bgDiameter = (screenWidth * 3.0).clamp(720, 2000);
    final double bgLeft = (screenWidth - bgDiameter) / 2;
    final double bgTop = (height * 0.60) - (bgDiameter / 2);

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
                  child: _SoftCircle(
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
          child: _SoftCircle(
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
                title,
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
                  subtitle,
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
              _DotsIndicator(
                activeIndex: activeIndex,
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

class _ConversationRow extends StatelessWidget {
  const _ConversationRow({required this.block, required this.iconSize});

  final ConversationBlock block;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bool alignLeft = block.side == ConversationSide.left;
    // Asset faces left by default. Mirror on the left side so it faces right.
    final Widget icon = alignLeft
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
            child: _PetIcon(size: iconSize),
          )
        : _PetIcon(size: iconSize);
    final Widget text = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: _ConversationText(block: block, alignLeft: alignLeft),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alignLeft
          ? [icon, const SizedBox(width: 12), text]
          : [text, const SizedBox(width: 12), icon],
    );
  }
}

class _PetIcon extends StatelessWidget {
  const _PetIcon({required this.size});

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

class _ConversationText extends StatelessWidget {
  const _ConversationText({required this.block, required this.alignLeft});

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

class _PopIn extends StatelessWidget {
  const _PopIn({super.key, required this.child});

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

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
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
