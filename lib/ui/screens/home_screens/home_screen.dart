import 'package:flutter/material.dart';

import 'package:mealmirror/data/auth_service.dart';
import 'package:mealmirror/data/meal_store.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/home_view_model.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomeViewModel> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadViewModel();
    MealStore.mealsRevision.addListener(_onMealsChanged);
  }

  @override
  void dispose() {
    MealStore.mealsRevision.removeListener(_onMealsChanged);
    super.dispose();
  }

  void _onMealsChanged() {
    if (!mounted) return;
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _loadViewModel();
    });
    await _future;
  }

  Future<HomeViewModel> _loadViewModel() async {
    final nickname = await AuthService.getCurrentNickname() ?? '';
    final meals = await MealStore.loadCurrentUserMeals();
    final now = DateTime.now();
    final today = MealStore.summarizeForToday(meals, now);
    final week = MealStore.summarizeForThisWeek(meals, now);
    final todayNutrition = MealStore.summarizeNutritionForToday(meals, now);

    return HomeViewModel(
      nickname: nickname,
      today: today,
      week: week,
      todayNutrition: todayNutrition,
      isLoading: false,
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
                todayNutrition: const NutritionTotals.zero(),
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
