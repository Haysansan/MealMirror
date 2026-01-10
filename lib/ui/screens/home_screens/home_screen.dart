import 'package:flutter/material.dart';

import 'package:mealmirror/data/meal_repository.dart';
import 'package:mealmirror/data/user_repository.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/entities/home_view_model.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/ui/widgets/home_screen/home_header.dart';
import 'package:mealmirror/ui/widgets/home_screen/pet_card.dart';
import 'package:mealmirror/ui/widgets/home_screen/quick_action_row.dart';
import 'package:mealmirror/ui/widgets/home_screen/daily_balance_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late Future<HomeViewModel> _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _loadViewModel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {
        _future = _loadViewModel();
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _loadViewModel();
    });
    await _future;
  }

  Future<HomeViewModel> _loadViewModel() async {
    final nickname = UserRepository.getNickname();
    final meals = await MealRepository.getAllMeals();
    final now = DateTime.now();

    // Summarize meals for today and this week
    final today = _summarizeForToday(meals, now);
    final week = _summarizeForThisWeek(meals, now);
    final todayNutrition = _summarizeNutritionForToday(meals, now);

    return HomeViewModel(
      nickname: nickname,
      today: today,
      week: week,
      todayNutrition: todayNutrition,
      isLoading: false,
    );
  }

  MealSummary _summarizeForToday(List<dynamic> meals, DateTime now) {
    int count = 0;
    int totalPoints = 0;
    for (final meal in meals) {
      if (meal.date.year == now.year &&
          meal.date.month == now.month &&
          meal.date.day == now.day) {
        count++;
        totalPoints += (meal.points as int);
      }
    }
    return MealSummary(mealCount: count, totalPoints: totalPoints);
  }

  MealSummary _summarizeForThisWeek(List<dynamic> meals, DateTime now) {
    int count = 0;
    int totalPoints = 0;
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    for (final meal in meals) {
      if (meal.date.isAfter(weekStart) &&
          meal.date.isBefore(now.add(const Duration(days: 1)))) {
        count++;
        totalPoints += (meal.points as int);
      }
    }
    return MealSummary(mealCount: count, totalPoints: totalPoints);
  }

  NutritionTotals _summarizeNutritionForToday(
    List<dynamic> meals,
    DateTime now,
  ) {
    int energy = 0, sugar = 0, fat = 0, protein = 0, fiber = 0;
    for (final meal in meals) {
      if (meal.date.year == now.year &&
          meal.date.month == now.month &&
          meal.date.day == now.day) {
        energy += (meal.energy as int);
        sugar += (meal.sugar as int);
        fat += (meal.fat as int);
        protein += (meal.protein as int);
        fiber += (meal.fiber as int);
      }
    }
    return NutritionTotals(
      energy: energy,
      sugar: sugar,
      fat: fat,
      protein: protein,
      fiber: fiber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: FutureBuilder<HomeViewModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final viewModel =
              snapshot.data ??
              HomeViewModel(
                nickname: '',
                today: MealSummary(mealCount: 0, totalPoints: 0),
                week: MealSummary(mealCount: 0, totalPoints: 0),
                todayNutrition: NutritionTotals.zero(),
                isLoading: true,
              );

          return RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 16),
                  PetCard(viewModel: viewModel),
                  const SizedBox(height: 16),
                  QuickActionRow(
                    todayValue: _formatSigned(viewModel.todayPoints),
                    weekAvgValue: _formatSigned(viewModel.weekAverage),
                  ),
                  const SizedBox(height: 16),
                  DailyBalanceCard(totals: viewModel.todayNutrition),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatSigned(int value) {
    if (value == 0) return '+0';
    return value > 0 ? '+$value' : value.toString();
  }
}
