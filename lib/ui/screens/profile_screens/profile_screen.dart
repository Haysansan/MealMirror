import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_routes.dart';
import '../../widgets/profile_screen/profile_header.dart';
import '../../widgets/profile_screen/profile_stat_row.dart';
import '../../theme/app_colors.dart';
import '../../../data/auth_service.dart';
import '../../../data/meal_store.dart';
import '../../../domain/services/summary_service.dart';
import '../../widgets/reusable/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static String _habitStabilityLabel({
    required int trackedDays,
    required int spanDays,
  }) {
    return SummaryService.habitStabilityLabel(
      trackedDays: trackedDays,
      spanDays: spanDays,
    );
  }

  static int _uniqueTrackedDays(Iterable<MealEntry> meals) {
    return SummaryService.uniqueTrackedDays<MealEntry>(
      meals: meals,
      getDate: (m) => m.date,
    );
  }

  static int _allTimeSpanDays(Iterable<MealEntry> meals) {
    return SummaryService.allTimeSpanDays<MealEntry>(
      meals: meals,
      getCreatedAt: (m) => m.createdAt,
    );
  }

  static MealSummary _summarizeForRange(
    List<MealEntry> meals, {
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    final s = SummaryService.summarizeForRange<MealEntry>(
      meals: meals,
      startInclusive: startInclusive,
      endExclusive: endExclusive,
      getCreatedAt: (m) => m.createdAt,
      getPoints: (m) => m.points,
    );
    return MealSummary(mealCount: s.mealCount, totalPoints: s.totalPoints);
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await AuthService.logout();
      if (context.mounted) {
        context.go(AppRoutes.signup);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealsFuture = MealStore.loadCurrentUserMeals();

    return AppScaffold(
      title: 'Profile',
      appBarBackgroundColor: AppColors.background,
      titleTextStyle: const TextStyle(
        color: AppColors.mealMirrorTitle,
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        height: 1.06,
      ),
      centerTitle: false,
      trailing: IconButton(
        icon: const Icon(Icons.close, color: AppColors.darkMatcha),
        onPressed: () => context.go(AppRoutes.home),
      ),
      body: FutureBuilder<List<MealEntry>>(
        future: mealsFuture,
        builder: (context, snapshot) {
          final meals = snapshot.data ?? const <MealEntry>[];
          final now = DateTime.now();
          final todayStart = DateTime(now.year, now.month, now.day);

          // Last 30 days includes today.
          final last30Start = todayStart.subtract(const Duration(days: 29));
          final last30EndExclusive = todayStart.add(const Duration(days: 1));

          final last30Summary = _summarizeForRange(
            meals,
            startInclusive: last30Start,
            endExclusive: last30EndExclusive,
          );
          final last30TrackedDays = _uniqueTrackedDays(
            meals.where(
              (m) =>
                  !m.createdAt.isBefore(last30Start) &&
                  m.createdAt.isBefore(last30EndExclusive),
            ),
          );
          final last30AvgPoints = (last30Summary.totalPoints / 30).round();

          final allTimeTrackedDays = _uniqueTrackedDays(meals);
          final allTimeSpanDays = _allTimeSpanDays(meals);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProfileHeader(),
                const SizedBox(height: 16),

                _statCard(
                  title: 'Last 30 Days',
                  stats: [
                    ProfileStatRow(
                      label: 'Total Meals Logged',
                      value: last30Summary.mealCount.toString(),
                    ),
                    ProfileStatRow(
                      label: 'Daily Average Points',
                      value: last30AvgPoints.toString(),
                    ),
                    ProfileStatRow(
                      label: 'Habit Stability',
                      value: _habitStabilityLabel(
                        trackedDays: last30TrackedDays,
                        spanDays: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _statCard(
                  title: 'All Time',
                  stats: [
                    ProfileStatRow(
                      label: 'Total Meals Logged',
                      value: meals.length.toString(),
                    ),
                    ProfileStatRow(
                      label: 'Days Tracking',
                      value: allTimeTrackedDays.toString(),
                    ),
                    ProfileStatRow(
                      label: 'Habit Stability',
                      value: _habitStabilityLabel(
                        trackedDays: allTimeTrackedDays,
                        spanDays: allTimeSpanDays,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _handleLogout(context),
                    child: const Text('Log out'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard({
    required String title,
    required List<ProfileStatRow> stats,
  }) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...stats,
          ],
        ),
      ),
    );
  }
}
