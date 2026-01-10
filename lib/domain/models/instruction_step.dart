enum InstructionStepLayout {
  meetCompanion,
  illustrationPrompt,
  conversation,
  startCta,
}

enum ConversationSide { left, right }

class InstructionStep {
  final String id;
  final InstructionStepLayout layout;
  final String? title;
  final String? subtitle;
  final String? message;
  final String? prompt;
  final String? name;
  final String? companionLine;
  final String? ctaHeadline;
  final String? ctaAction;
  final String? ctaTagline;
  final List<ConversationBlock>? blocks;

  const InstructionStep({
    required this.id,
    required this.layout,
    this.title,
    this.subtitle,
    this.message,
    this.prompt,
    this.name,
    this.companionLine,
    this.ctaHeadline,
    this.ctaAction,
    this.ctaTagline,
    this.blocks,
  });
}

class ConversationBlock {
  final String? text;
  final List<TextSpan>? spans;
  final ConversationSide side;

  const ConversationBlock({this.text, this.spans, required this.side});
}

class TextSpan {
  final String text;
  final bool bold;

  const TextSpan({required this.text, this.bold = false});
}
