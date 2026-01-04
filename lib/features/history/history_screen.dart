import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'widgets/history_filter_tabs.dart';
import 'widgets/history_stat_card.dart';
import 'widgets/meal_log_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  // sample data for prototype
  List<MealDay> _sampleData() => [
    MealDay(
      title: 'Today',
      subtitle: '3 meals',
      score: 2,
      green: 2,
      yellow: 1,
      red: 0,
    ),
    MealDay(
      title: 'Mon, Dec 29',
      subtitle: '3 meals',
      score: -1,
      green: 1,
      yellow: 2,
      red: 0,
    ),
    MealDay(
      title: 'Sun, Dec 28',
      subtitle: '2 meals',
      score: 0,
      green: 1,
      yellow: 1,
      red: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _sampleData();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                'History',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 18),
              const HistoryFilterTabs(),
              const SizedBox(height: 12),
              const HistoryStatCard(),
              const SizedBox(height: 12),
              Expanded(child: MealLogList(days: items)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        color: AppColors.surface,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home_outlined, color: AppColors.primary),
              ),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.onDark),
                elevation: 0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.history, color: AppColors.primary),
              ),
            ],
=======
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: const Text(
          'History',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(18),
        child: Text(
          'History prototype screen',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: AppColors.textWhiteTheme,
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
          ),
        ),
      ),
    );
  }
}
