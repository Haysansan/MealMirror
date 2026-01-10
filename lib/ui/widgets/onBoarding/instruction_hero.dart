import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/instruction_step.dart';
import 'package:mealmirror/domain/models/instruction_view.dart';
import 'conversation_step.dart';
import 'start_cta_step.dart';
import 'standard_step.dart';

class InstructionHero extends StatelessWidget {
  const InstructionHero({
    super.key,
    required this.viewportWidth,
    required this.viewportHeight,
    required this.viewModel,
    required this.onDotTap,
  });

  final double viewportWidth;
  final double viewportHeight;
  final InstructionViewModel viewModel;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final step = viewModel.currentStep;
    final isStartCta = step.layout == InstructionStepLayout.startCta;
    final isConversation = step.layout == InstructionStepLayout.conversation;

    return SizedBox(
      width: viewportWidth,
      height: viewportHeight,
      child: isStartCta
          ? StartCtaStep(
              viewportWidth: viewportWidth,
              viewportHeight: viewportHeight,
              step: step,
              index: viewModel.currentIndex,
              total: viewModel.steps.length,
              onDotTap: onDotTap,
            )
          : isConversation
          ? ConversationStep(
              viewportWidth: viewportWidth,
              viewportHeight: viewportHeight,
              step: step,
              visibleCount: viewModel.conversationVisibleCount,
              index: viewModel.currentIndex,
              total: viewModel.steps.length,
              onDotTap: onDotTap,
            )
          : StandardStep(
              viewportWidth: viewportWidth,
              viewportHeight: viewportHeight,
              step: step,
              index: viewModel.currentIndex,
              total: viewModel.steps.length,
              onDotTap: onDotTap,
            ),
    );
  }
}
