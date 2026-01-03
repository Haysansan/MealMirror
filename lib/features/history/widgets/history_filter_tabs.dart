import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HistoryFilterTabs extends StatefulWidget {
  const HistoryFilterTabs({Key? key}) : super(key: key);

  @override
  State<HistoryFilterTabs> createState() => _HistoryFilterTabsState();
}

class _HistoryFilterTabsState extends State<HistoryFilterTabs> {
  int _selected = 0;
  final tabs = const ['All', 'Week', 'Month'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (i) {
        final selected = i == _selected;
        return GestureDetector(
          onTap: () => setState(() => _selected = i),
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.section : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              tabs[i],
              style: AppTextStyles.bodyMedium.copyWith(
                color: selected ? AppColors.primary : AppColors.secondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }
}
