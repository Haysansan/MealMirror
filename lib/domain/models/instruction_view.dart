import 'instruction_step.dart';

class InstructionViewModel {
  final int currentIndex;
  final bool isTransitioning;
  final int conversationVisibleCount;
  final List<InstructionStep> steps;

  const InstructionViewModel({
    required this.currentIndex,
    required this.isTransitioning,
    required this.conversationVisibleCount,
    required this.steps,
  });

  bool get isLastStep => currentIndex >= steps.length - 1;

  bool get isLastConversationBlock {
    if (currentIndex >= steps.length) return true;
    final step = steps[currentIndex];
    final blocks = step.blocks ?? const [];
    return conversationVisibleCount >= blocks.length;
  }

  InstructionStep get currentStep => steps[currentIndex];

  InstructionViewModel copyWith({
    int? currentIndex,
    bool? isTransitioning,
    int? conversationVisibleCount,
  }) {
    return InstructionViewModel(
      currentIndex: currentIndex ?? this.currentIndex,
      isTransitioning: isTransitioning ?? this.isTransitioning,
      conversationVisibleCount:
          conversationVisibleCount ?? this.conversationVisibleCount,
      steps: steps,
    );
  }
}
