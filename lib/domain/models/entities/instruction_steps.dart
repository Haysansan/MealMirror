import 'package:mealmirror/domain/models/entities/instruction_step.dart';

const List<InstructionStep> instructionSteps = [
  InstructionStep(
    id: 'm1',
    layout: InstructionStepLayout.message,
    message: 'ready to be healthier?',
  ),
  InstructionStep(
    id: 'm2',
    layout: InstructionStepLayout.message,
    message: "you can eat it, doesn't mean you should eat it.",
  ),
  InstructionStep(
    id: 'm3',
    layout: InstructionStepLayout.message,
    message: 'small changes lead to big results.',
  ),
  InstructionStep(
    id: 'm4',
    layout: InstructionStepLayout.message,
    message: 'so what to eat, what is not to eat.',
  ),
  InstructionStep(
    id: 'm5',
    layout: InstructionStepLayout.meetCompanion,
    name: 'RONAN',
    companionLine: 'your healthy companion',
  ),
  InstructionStep(
    id: 'm6',
    layout: InstructionStepLayout.illustrationPrompt,
    prompt: 'so how can RONAN, inside your screen helps you?',
  ),
  InstructionStep(
    id: 'm7',
    layout: InstructionStepLayout.illustrationPrompt,
    prompt: 'RONAN moods will reflect your eating choices.',
  ),
  InstructionStep(
    id: 'c1',
    layout: InstructionStepLayout.conversation,
    title: 'MEAL MIRROR',
    subtitle: 'your habits, reflected',
    blocks: [
      ConversationBlock(
        side: ConversationSide.right,
        text:
            'instead of nutrients in grams, the app uses 5 abstract daily dimensions and 5C Nutri-Scores.',
      ),
      ConversationBlock(
        side: ConversationSide.left,
        spans: [
          TextSpan(text: 'nutrition bars:\n'),
          TextSpan(text: 'energy, sugar, fat, protein, fiber.', bold: true),
        ],
      ),
      ConversationBlock(
        side: ConversationSide.right,
        text: 'how food input is processed?',
      ),
      ConversationBlock(
        side: ConversationSide.left,
        spans: [
          TextSpan(text: 'step 1: user adds a meal\n', bold: true),
          TextSpan(
            text:
                'user selects: food category, portion size, processing level.',
          ),
        ],
      ),
      ConversationBlock(
        side: ConversationSide.right,
        text: 'what happens after a meal is added?',
      ),
      ConversationBlock(
        side: ConversationSide.left,
        spans: [
          TextSpan(text: 'we checks balance patterns, not totals:'),
          TextSpan(text: ' balanced meal, heavy meal, light meal.', bold: true),
        ],
      ),
      ConversationBlock(
        side: ConversationSide.right,
        text:
            'at the end of the day, the app compares totals against ideal zones.',
      ),
      ConversationBlock(
        side: ConversationSide.left,
        spans: [
          TextSpan(text: 'HEALTHY DAY', bold: true),
          TextSpan(text: ' → 4-5 dimensions in range\n'),
          TextSpan(text: 'NEUTRAL DAY', bold: true),
          TextSpan(text: ' → 2-3 dimensions in range\n'),
          TextSpan(text: 'UNBALANCED DAY', bold: true),
          TextSpan(text: ' → 0-1 dimension in range'),
        ],
      ),
    ],
  ),
  InstructionStep(
    id: 's1',
    layout: InstructionStepLayout.startCta,
    ctaHeadline: 'START YOUR JOUNEY\nWITH RONAN NOW!',
    ctaAction: 'READY →',
    ctaTagline: 'your habits, reflected',
  ),
];
