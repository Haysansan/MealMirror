import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SelectionPill extends StatelessWidget {
  const SelectionPill({
    super.key,
    required this.label,
    this.fillColor = AppColors.categoryPillFill,
    this.textColor = AppColors.categoryPillText,
  });

  final String? label;
  final Color fillColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final String text = (label == null || label!.trim().isEmpty)
        ? 'Selection'
        : label!;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 349),
      child: Container(
        height: 28.59,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          color: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }
}
