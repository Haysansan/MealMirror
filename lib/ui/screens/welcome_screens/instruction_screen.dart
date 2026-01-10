import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmirror/domain/models/entities/instruction_step.dart';
import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/entities/instruction_view.dart';
import 'package:mealmirror/ui/widgets/onBoarding/instruction_hero.dart';

class InstructionScreen extends StatefulWidget {
  final List<InstructionStep> steps;

  const InstructionScreen({super.key, required this.steps});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  late InstructionViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _initializeViewModel();
  }

  void _initializeViewModel() {
    _viewModel = InstructionViewModel(
      currentIndex: 0,
      isTransitioning: false,
      conversationVisibleCount: _getInitialConversationCount(0),
      steps: widget.steps,
    );
  }

  int _getInitialConversationCount(int index) {
    final step = widget.steps[index];
    if (step.layout != InstructionStepLayout.conversation) return 0;
    final int len = step.blocks?.length ?? 0;
    return len > 0 ? 1 : 0;
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    if (context.mounted) {
      context.go(AppRoutes.signup);
    }
  }

  Future<void> _next(BuildContext context) async {
    if (_viewModel.isTransitioning) return;

    if (_viewModel.isLastStep) {
      await _finishOnboarding(context);
      return;
    }

    setState(() {
      _viewModel = _viewModel.copyWith(
        currentIndex: _viewModel.currentIndex + 1,
        isTransitioning: true,
        conversationVisibleCount: _getInitialConversationCount(
          _viewModel.currentIndex + 1,
        ),
      );
    });

    await Future<void>.delayed(const Duration(milliseconds: 260));
    if (!mounted) return;
    setState(() {
      _viewModel = _viewModel.copyWith(isTransitioning: false);
    });
  }

  void _jumpTo(BuildContext context, int index) {
    if (_viewModel.isTransitioning) return;
    if (index < 0 || index >= widget.steps.length) return;
    if (index == _viewModel.currentIndex) return;

    setState(() {
      _viewModel = _viewModel.copyWith(
        currentIndex: index,
        conversationVisibleCount: _getInitialConversationCount(index),
      );
    });
  }

  void _handleTap(BuildContext context) {
    final step = _viewModel.currentStep;
    if (step.layout == InstructionStepLayout.conversation) {
      final blocks = step.blocks ?? const [];
      if (_viewModel.conversationVisibleCount < blocks.length) {
        setState(() {
          _viewModel = _viewModel.copyWith(
            conversationVisibleCount: _viewModel.conversationVisibleCount + 1,
          );
        });
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
                      child: InstructionHero(
                        key: ValueKey<int>(_viewModel.currentIndex),
                        viewportWidth: constraints.maxWidth,
                        viewportHeight: heroHeight,
                        viewModel: _viewModel,
                        onDotTap: (value) => _jumpTo(context, value),
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
