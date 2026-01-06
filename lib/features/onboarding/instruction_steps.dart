enum InstructionStepLayout {
  message,
  meetCompanion,
  illustrationPrompt,
  conversation,
  startCta,
}

enum ConversationSide { left, right }

class ConversationBlock {
  const ConversationBlock.text({required this.side, required this.text})
    : spans = null;

  const ConversationBlock.rich({required this.side, required this.spans})
    : text = null;

  final ConversationSide side;
  final String? text;
  final List<ConversationSpan>? spans;
}

class ConversationSpan {
  const ConversationSpan(this.text, {this.bold = false});

  final String text;
  final bool bold;
}

class InstructionStep {
  const InstructionStep._({
    required this.layout,
    this.message,
    this.name,
    this.companionLine,
    this.prompt,
    this.title,
    this.subtitle,
    this.blocks,
    this.ctaHeadline,
    this.ctaAction,
    this.ctaTagline,
  });

  const InstructionStep.message({required String message})
    : this._(layout: InstructionStepLayout.message, message: message);

  const InstructionStep.meetCompanion({
    required String name,
    required String companionLine,
  }) : this._(
         layout: InstructionStepLayout.meetCompanion,
         name: name,
         companionLine: companionLine,
       );

  const InstructionStep.illustrationPrompt({required String prompt})
    : this._(layout: InstructionStepLayout.illustrationPrompt, prompt: prompt);

  const InstructionStep.conversation({
    required String title,
    required String subtitle,
    required List<ConversationBlock> blocks,
  }) : this._(
         layout: InstructionStepLayout.conversation,
         title: title,
         subtitle: subtitle,
         blocks: blocks,
       );

  const InstructionStep.startCta({
    required String ctaHeadline,
    required String ctaAction,
    required String ctaTagline,
  }) : this._(
         layout: InstructionStepLayout.startCta,
         ctaHeadline: ctaHeadline,
         ctaAction: ctaAction,
         ctaTagline: ctaTagline,
       );

  final InstructionStepLayout layout;
  final String? message;
  final String? name;
  final String? companionLine;
  final String? prompt;
  final String? title;
  final String? subtitle;
  final List<ConversationBlock>? blocks;

  final String? ctaHeadline;
  final String? ctaAction;
  final String? ctaTagline;
}

const List<InstructionStep> instructionSteps = [
  InstructionStep.message(message: 'ready to be healthier?'),
  InstructionStep.message(
    message: "you can eat it, doesn't mean you should eat it.",
  ),
  InstructionStep.message(message: 'small changes lead to big results.'),
  InstructionStep.message(message: 'so what to eat, what is not to eat.'),
  InstructionStep.meetCompanion(
    name: 'RONAN',
    companionLine: 'your healthy companion',
  ),
  InstructionStep.illustrationPrompt(
    prompt: 'so how can RONAN, inside your screen helps you?',
  ),
  InstructionStep.illustrationPrompt(
    prompt: 'RONAN moods will reflect your eating choices.',
  ),
  InstructionStep.conversation(
    title: 'MEAL MIRROR',
    subtitle: 'your habits, reflected',
    blocks: [
      ConversationBlock.text(
        side: ConversationSide.right,
        text:
            'instead of nutrients in grams, the app uses 5 abstract daily dimensions and 5C Nutri-Scores.',
      ),
      ConversationBlock.rich(
        side: ConversationSide.left,
        spans: [
          ConversationSpan('nutrition bars:\n'),
          ConversationSpan('energy, sugar, fat, protein, fiber.', bold: true),
        ],
      ),
      ConversationBlock.text(
        side: ConversationSide.right,
        text: 'how food input is processed?',
      ),
      ConversationBlock.rich(
        side: ConversationSide.left,
        spans: [
          ConversationSpan('step 1: user adds a meal\n', bold: true),
          ConversationSpan(
            'user selects: food category, portion size, processing level.',
          ),
        ],
      ),
      ConversationBlock.text(
        side: ConversationSide.right,
        text: 'what happens after a meal is added?',
      ),
      ConversationBlock.rich(
        side: ConversationSide.left,
        spans: [
          ConversationSpan(
            'we checks balance patterns, not totals:',
            bold: false,
          ),
          ConversationSpan(
            ' balanced meal, heavy meal, light meal.',
            bold: true,
          ),
        ],
      ),
      ConversationBlock.text(
        side: ConversationSide.right,
        text:
            'at the end of the day, the app compares totals against ideal zones.',
      ),
      ConversationBlock.rich(
        side: ConversationSide.left,
        spans: [
          ConversationSpan('HEALTHY DAY', bold: true),
          ConversationSpan(' → 4-5 dimensions in range\n'),
          ConversationSpan('NEUTRAL DAY', bold: true),
          ConversationSpan(' → 2-3 dimensions in range\n'),
          ConversationSpan('UNBALANCED DAY', bold: true),
          ConversationSpan(' → 0-1 dimension in range'),
        ],
      ),
    ],
  ),
  InstructionStep.startCta(
    ctaHeadline: 'START YOUR JOUNEY\nWITH RONAN NOW!',
    ctaAction: 'READY →',
    ctaTagline: 'your habits, reflected',
  ),
];
