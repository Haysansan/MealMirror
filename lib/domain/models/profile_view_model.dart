import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';
import 'package:mealmirror/domain/services/summary_service.dart';

class ProfileViewModel {
  final List<MealEntry> meals;
  final MealSummary last30Summary;
  final int last30TrackedDays;
  final int last30AvgPoints;
  final int allTimeTrackedDays;
  final int allTimeSpanDays;

  ProfileViewModel({
    required this.meals,
    required this.last30Summary,
    required this.last30TrackedDays,
    required this.last30AvgPoints,
    required this.allTimeTrackedDays,
    required this.allTimeSpanDays,
  });

  factory ProfileViewModel.fromMeals(List<MealEntry> meals, {DateTime? now}) {
    final nowResolved = now ?? DateTime.now();
    final todayStart = DateTime(
      nowResolved.year,
      nowResolved.month,
      nowResolved.day,
    );
    final last30Start = todayStart.subtract(const Duration(days: 29));
    final last30EndExclusive = todayStart.add(const Duration(days: 1));

    final last30Summary = SummaryService.summarizeForRange<MealEntry>(
      meals: meals,
      startInclusive: last30Start,
      endExclusive: last30EndExclusive,
      getCreatedAt: (m) => m.createdAt,
      getPoints: (m) => m.points,
    );

    final last30TrackedDays = SummaryService.uniqueTrackedDays<MealEntry>(
      meals: meals.where(
        (m) =>
            !m.createdAt.isBefore(last30Start) &&
            m.createdAt.isBefore(last30EndExclusive),
      ),
      getDate: (m) => m.createdAt,
    );

    final last30AvgPoints = (last30Summary.totalPoints / 30).round();

    final allTimeTrackedDays = SummaryService.uniqueTrackedDays<MealEntry>(
      meals: meals,
      getDate: (m) => m.createdAt,
    );

    final allTimeSpanDays = SummaryService.allTimeSpanDays<MealEntry>(
      meals: meals,
      getCreatedAt: (m) => m.createdAt,
    );

    return ProfileViewModel(
      meals: meals,
      last30Summary: MealSummary(
        mealCount: last30Summary.mealCount,
        totalPoints: last30Summary.totalPoints,
      ),
      last30TrackedDays: last30TrackedDays,
      last30AvgPoints: last30AvgPoints,
      allTimeTrackedDays: allTimeTrackedDays,
      allTimeSpanDays: allTimeSpanDays,
    );
  }
}
