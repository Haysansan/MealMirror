import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class QuickActionRow extends StatelessWidget {
  const QuickActionRow({
    super.key,
    required this.todayValue,
    required this.weekAvgValue,
  });

  final String todayValue;
  final String weekAvgValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _actionCard('Today', todayValue),
        const SizedBox(width: 12),
        _actionCard('Week AVG', weekAvgValue),
      ],
    );
  }

  Widget _actionCard(String title, String value) {
    return Expanded(
      child: Card(
        color: AppColors.section,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
