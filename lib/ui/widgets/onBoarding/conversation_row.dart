import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/entities/instruction_step.dart';
import 'package:mealmirror/ui/widgets/reusable/common_widgets.dart';

class ConversationRow extends StatelessWidget {
  const ConversationRow({
    super.key,
    required this.block,
    required this.iconSize,
  });

  final ConversationBlock block;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bool alignLeft = block.side == ConversationSide.left;
    final Widget icon = alignLeft
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
            child: PetIcon(size: iconSize),
          )
        : PetIcon(size: iconSize);
    final Widget text = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: ConversationText(block: block, alignLeft: alignLeft),
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
