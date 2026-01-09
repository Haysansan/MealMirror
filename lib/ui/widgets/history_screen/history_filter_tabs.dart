import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../history_screen.dart';

class HistoryFilterTabs extends StatelessWidget {
  const HistoryFilterTabs({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  final HistoryRange selectedRange;
  final ValueChanged<HistoryRange> onRangeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab(
          label: 'Daily',
          selected: selectedRange == HistoryRange.daily,
          onTap: () => onRangeSelected(HistoryRange.daily),
        ),
        const SizedBox(width: 8),
        _tab(
          label: 'Weekly',
          selected: selectedRange == HistoryRange.weekly,
          onTap: () => onRangeSelected(HistoryRange.weekly),
        ),
      ],
    );
  }

  Widget _tab({
    required String label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.actionSurface : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected
                    ? AppColors.mealMirrorText
                    : AppColors.mealMirrorMutedText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
