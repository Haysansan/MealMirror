import 'package:flutter/material.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'widgets/history_filter_tabs.dart';
import 'widgets/history_stat_card.dart';
import 'widgets/meal_log_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'History',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HistoryFilterTabs(),
            SizedBox(height: 16),

            HistoryStatCard(
              title: "This Week's Nutrition",
            ),

            SizedBox(height: 16),

            HistoryStatCard(
              title: "Today's Nutrition",
            ),

            SizedBox(height: 16),

            MealLogList(),
          ],
        ),
      ),
    );
  }
}
