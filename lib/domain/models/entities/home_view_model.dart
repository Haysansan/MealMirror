import '../meal_summary.dart';
import 'pet_mood.dart';
import 'package:mealmirror/domain/services/summary_service.dart';

class HomeViewModel {
  final String nickname;
  final MealSummary today;
  final MealSummary week;
  final NutritionTotals todayNutrition;
  final bool isLoading;
  final String? error;

  const HomeViewModel({
    required this.nickname,
    required this.today,
    required this.week,
    required this.todayNutrition,
    required this.isLoading,
    this.error,
  });

  int get weekAverage => SummaryService.weekAverage(
    totalPoints: week.totalPoints,
    mealCount: week.mealCount,
  );

  int get todayPoints => today.totalPoints;

  int get todayMeals => today.mealCount;

  PetMood get petMood => SummaryService.petMoodFromScore(
    todayPoints: todayPoints,
    todayMeals: todayMeals,
  );

  String get displayNickname {
    return (nickname.trim().isNotEmpty) ? nickname.trim() : 'Ronan';
  }

  String get petMoodHeadline => petMood.headline;

  String get nutritionAdvice => SummaryService.nutritionAdvice(
    energy: todayNutrition.energy,
    sugar: todayNutrition.sugar,
    fat: todayNutrition.fat,
    protein: todayNutrition.protein,
    fiber: todayNutrition.fiber,
  );

  HomeViewModel copyWith({
    String? nickname,
    MealSummary? today,
    MealSummary? week,
    NutritionTotals? todayNutrition,
    bool? isLoading,
    String? error,
  }) {
    return HomeViewModel(
      nickname: nickname ?? this.nickname,
      today: today ?? this.today,
      week: week ?? this.week,
      todayNutrition: todayNutrition ?? this.todayNutrition,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
