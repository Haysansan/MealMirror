import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../data/local/meal_store.dart';
import '../../domain/models/history_range.dart';
import '../../domain/services/history_service.dart';
import '../widgets/reusable/app_scaffold.dart';
import '../widgets/history_screen/history_filter_tabs.dart';
import '../widgets/history_screen/history_stat_card.dart';
import '../widgets/history_screen/meal_log_list.dart';
import '../../domain/models/history_range.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<MealEntry>> _futureMeals;
  HistoryRange _range = HistoryRange.daily;

  void _onMealsChanged() {
    if (!mounted) return;
    _refresh();
  }

  @override
  void initState() {
    super.initState();
    _futureMeals = MealStore.loadCurrentUserMeals();
    MealStore.mealsRevision.addListener(_onMealsChanged);
  }

  @override
  void dispose() {
    MealStore.mealsRevision.removeListener(_onMealsChanged);
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureMeals = MealStore.loadCurrentUserMeals();
    });
    await _futureMeals;
  }

  void _setRange(HistoryRange range) {
    if (_range == range) return;
    setState(() {
      _range = range;
    });
  }

  List<MealEntry> _filterMealsForRange(List<MealEntry> meals, DateTime now) {
    return HistoryService.filterMealsForRange<MealEntry>(
      meals,
      now,
      _range,
      getDate: (m) => m.date,
      getCreatedAt: (m) => m.createdAt,
    );
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

          return RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
            ),
          );
        },
      ),
    );
  }
}
