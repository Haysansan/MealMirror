import 'package:flutter/material.dart';
import 'package:mealmirror/domain/models/history_range.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';

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
      children: HistoryRange.values.map((range) {
        final isSelected = range == selectedRange;
        return Expanded(
          child: GestureDetector(
            onTap: () => onRangeSelected(range),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                range.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.mealMirrorTitle
                      : AppColors.mealMirrorMutedText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
