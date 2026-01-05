import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/local/meal_store.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'widgets/history_filter_tabs.dart';
import 'widgets/history_stat_card.dart';
import 'widgets/meal_log_list.dart';

enum HistoryRange { daily, weekly }

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final Future<List<MealEntry>> _futureMeals;
  HistoryRange _range = HistoryRange.daily;

  @override
  void initState() {
    super.initState();
    _futureMeals = MealStore.loadCurrentUserMeals();
  }

  void _setRange(HistoryRange range) {
    if (_range == range) return;
    setState(() {
      _range = range;
    });
  }

  String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  DateTime _startOfWeek(DateTime now) {
    final int delta = now.weekday - DateTime.monday;
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: delta));
  }

  List<MealEntry> _filterMealsForRange(List<MealEntry> meals, DateTime now) {
    if (_range == HistoryRange.daily) {
      final todayKey = _dateKey(now);
      return meals.where((m) => m.date == todayKey).toList();
    }

    final start = _startOfWeek(now);
    final endExclusive = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));
    return meals
        .where(
          (m) =>
              !m.createdAt.isBefore(start) &&
              m.createdAt.isBefore(endExclusive),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'History',
      appBarBackgroundColor: AppColors.background,
      titleTextStyle: const TextStyle(
        color: AppColors.mealMirrorTitle,
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        height: 1.06,
      ),
      centerTitle: false,
      body: FutureBuilder<List<MealEntry>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          final meals = snapshot.data ?? const <MealEntry>[];
          final now = DateTime.now();

          if (meals.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No history yet. Log your first meal to get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mealMirrorMutedText),
                ),
              ),
            );
          }

          final filteredMeals = _filterMealsForRange(meals, now);
          final nutritionTotals = _range == HistoryRange.daily
              ? MealStore.summarizeNutritionForToday(meals, now)
              : MealStore.summarizeNutritionForThisWeek(meals, now);

          final title = _range == HistoryRange.daily
              ? "Today's Nutrition"
              : "This Week's Nutrition";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HistoryFilterTabs(
                  selectedRange: _range,
                  onRangeSelected: _setRange,
                ),
                const SizedBox(height: 16),

                HistoryStatCard(title: title, totals: nutritionTotals),

                const SizedBox(height: 16),

                MealLogList(meals: filteredMeals, now: now),
              ],
            ),
          );
        },
      ),
    );
  }
}
