import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HistoryFilterTabs extends StatelessWidget {
  const HistoryFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab('Daily', true),
        const SizedBox(width: 8),
        _tab('Weekly', false),
        const SizedBox(width: 8),
        _tab('Monthly', false),
      ],
    );
  }

  Widget _tab(String label, bool selected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.section,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textWhiteTheme,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
