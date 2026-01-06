import 'package:flutter/material.dart';

import '../../data/local/auth_service.dart';
import '../../data/local/meal_store.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/stat_bar.dart';
import 'widgets/quick_action_row.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<_HomeViewModel> _future;

  void _onMealsChanged() {
    // Auto-refresh when a meal is added/updated.
    if (!mounted) return;
    _refresh();
  }

  @override
  void initState() {
    super.initState();
    _future = _load();
    MealStore.mealsRevision.addListener(_onMealsChanged);
  }

  @override
  void dispose() {
    MealStore.mealsRevision.removeListener(_onMealsChanged);
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _load();
    });
    await _future;
  }

  Future<_HomeViewModel> _load() async {
    final nickname = await AuthService.getCurrentNickname();
    final meals = await MealStore.loadCurrentUserMeals();
    final now = DateTime.now();
    final today = MealStore.summarizeForToday(meals, now);
    final week = MealStore.summarizeForThisWeek(meals, now);
    final todayNutrition = MealStore.summarizeNutritionForToday(meals, now);
    return _HomeViewModel(
      nickname: nickname,
      today: today,
      week: week,
      todayNutrition: todayNutrition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: FutureBuilder<_HomeViewModel>(
        future: _future,
        builder: (context, snapshot) {
          final model = snapshot.data;
          final nickname = (model?.nickname?.trim().isNotEmpty ?? false)
              ? model!.nickname!.trim()
              : 'Ronan';
          final todayPoints = model?.today.totalPoints ?? 0;
          final todayMeals = model?.today.mealCount ?? 0;
          final weekAvg = _weekAverage(model?.week);
          final todayNutrition =
              model?.todayNutrition ?? const NutritionTotals.zero();

          return RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'your habits, reflected',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'mealmirror',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _petCard(
                    nickname: nickname,
                    todayMeals: todayMeals,
                    todayPoints: todayPoints,
                    todayNutrition: todayNutrition,
                    onRefresh: _refresh,
                  ),

                  const SizedBox(height: 16),

                  QuickActionRow(
                    todayValue: _formatSigned(todayPoints),
                    weekAvgValue: _formatSigned(weekAvg),
                  ),

                  const SizedBox(height: 16),

                  _dailyBalanceCard(totals: todayNutrition),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int _weekAverage(MealSummary? week) {
    if (week == null) return 0;
    if (week.mealCount == 0) return 0;
    return (week.totalPoints / week.mealCount).round();
  }

  String _formatSigned(int value) {
    if (value == 0) return '+0';
    return value > 0 ? '+$value' : value.toString();
  }

  Widget _petCard({
    required String nickname,
    required int todayMeals,
    required int todayPoints,
    required NutritionTotals todayNutrition,
    required Future<void> Function() onRefresh,
  }) {
    final mood = _petMoodFromTodayScore(
      todayPoints: todayPoints,
      todayMeals: todayMeals,
    );
    final moodText = _petMoodHeadline(mood);
    final adviceText = _nutritionAdvice(todayNutrition);
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: onRefresh,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.autorenew,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),

            Image.asset('assets/images/MealMirrorPet.png', height: 120),

            const SizedBox(height: 12),

            Text(
              '$nickname, your companion is $moodText',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(adviceText, style: TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              'Meals today: $todayMeals',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  _PetMood _petMoodFromTodayScore({
    required int todayPoints,
    required int todayMeals,
  }) {
    if (todayMeals == 0) return _PetMood.sleeping;
    if (todayPoints >= 8) return _PetMood.ecstatic;
    if (todayPoints >= 3) return _PetMood.happy;
    if (todayPoints >= 0) return _PetMood.okay;
    if (todayPoints >= -3) return _PetMood.worried;
    return _PetMood.upset;
  }

  String _petMoodHeadline(_PetMood mood) {
    return switch (mood) {
      _PetMood.sleeping => 'resting',
      _PetMood.ecstatic => 'thriving',
      _PetMood.happy => 'happy',
      _PetMood.okay => 'okay',
      _PetMood.worried => 'a bit worried',
      _PetMood.upset => 'not feeling great',
    };
  }

  String _nutritionAdvice(NutritionTotals totals) {
    final energy = MealStore.barProgressFromSteps(totals.energy);
    final sugar = MealStore.barProgressFromSteps(totals.sugar);
    final fat = MealStore.barProgressFromSteps(totals.fat);
    final protein = MealStore.barProgressFromSteps(totals.protein);
    final fiber = MealStore.barProgressFromSteps(totals.fiber);

    if ((energy + sugar + fat + protein + fiber) == 0) {
      return 'Log a meal to shape today\'s balance';
    }

    if (sugar >= 0.8 && fiber < 0.4) {
      return 'Ease up on sweets; add some fiber';
    }
    if (fat >= 0.8 && fiber < 0.4) {
      return 'Go lighter on fats; add veggies/fruit';
    }
    if (protein < 0.4 && fiber < 0.4) {
      return 'Try adding protein and fiber today';
    }
    if (protein < 0.4) {
      return 'Try adding more protein today';
    }
    if (fiber < 0.4) {
      return 'Try adding more fiber today';
    }
    if (energy < 0.25) {
      return 'Add a hearty, energizing meal';
    }

    return 'Nice balance today—keep it going';
  }

  Widget _dailyBalanceCard({required NutritionTotals totals}) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today’s Balance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Neutral Day', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),

            _balanceRow(
              'Daily Power (ENERGY)',
              MealStore.barProgressFromSteps(totals.energy),
              fillColor: AppColors.grainStarches,
            ),
            _balanceRow(
              'Sweet Level (SUGAR)',
              MealStore.barProgressFromSteps(totals.sugar),
              fillColor: AppColors.snacks,
            ),
            _balanceRow(
              'Fat Fuel (FAT)',
              MealStore.barProgressFromSteps(totals.fat),
              fillColor: AppColors.oilsFats,
            ),
            _balanceRow(
              'Grow Power (PROTEIN)',
              MealStore.barProgressFromSteps(totals.protein),
              fillColor: AppColors.meatSeafood,
            ),
            _balanceRow(
              'Gut Guard (FIBER)',
              MealStore.barProgressFromSteps(totals.fiber),
              fillColor: AppColors.veggieFruits,
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceRow(
    String label,
    double progress, {
    required Color fillColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          StatBar(progress: progress, fillColor: fillColor),
        ],
      ),
    );
  }
}

class _HomeViewModel {
  const _HomeViewModel({
    required this.nickname,
    required this.today,
    required this.week,
    required this.todayNutrition,
  });

  final String? nickname;
  final MealSummary today;
  final MealSummary week;
  final NutritionTotals todayNutrition;
}

enum _PetMood { sleeping, ecstatic, happy, okay, worried, upset }
