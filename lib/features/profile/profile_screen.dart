import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stat_row.dart';
import '../../core/theme/app_colors.dart';
import '../../data/local/auth_service.dart';
import '../../data/local/meal_store.dart';
import '../../shared/widgets/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static String _habitStabilityLabel({
    required int trackedDays,
    required int spanDays,
  }) {
    if (spanDays <= 0) return 'Low';
    final ratio = trackedDays / spanDays;
    if (ratio >= 0.7) return 'High';
    if (ratio >= 0.4) return 'Medium';
    return 'Low';
  }

  static int _uniqueTrackedDays(Iterable<MealEntry> meals) {
    return meals.map((m) => m.date).toSet().length;
  }

  static int _allTimeSpanDays(Iterable<MealEntry> meals) {
    if (meals.isEmpty) return 0;

    DateTime oldest = meals.first.createdAt;
    DateTime newest = meals.first.createdAt;
    for (final meal in meals) {
      if (meal.createdAt.isBefore(oldest)) oldest = meal.createdAt;
      if (meal.createdAt.isAfter(newest)) newest = meal.createdAt;
    }

    final start = DateTime(oldest.year, oldest.month, oldest.day);
    final end = DateTime(newest.year, newest.month, newest.day);
    return end.difference(start).inDays + 1;
  }

  static MealSummary _summarizeForRange(
    List<MealEntry> meals, {
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    final rangeMeals = meals
        .where(
          (m) =>
              !m.createdAt.isBefore(startInclusive) &&
              m.createdAt.isBefore(endExclusive),
        )
        .toList();
    final total = rangeMeals.fold<int>(0, (sum, m) => sum + m.points);
    return MealSummary(mealCount: rangeMeals.length, totalPoints: total);
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
        context.go('/signup');
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
        onPressed: () => context.go('/home'),
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

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
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
