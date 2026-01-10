import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/data/auth_service.dart';
import 'package:mealmirror/data/meal_store.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/ui/widgets/profile_screen/profile_header.dart';
import 'package:mealmirror/ui/widgets/profile_screen/profile_stat_row.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/profile_view_model.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/services/summary_service.dart';
import 'package:mealmirror/domain/models/meal_summary.dart';
import 'package:mealmirror/ui/navigation/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          final vm = ProfileViewModel.fromMeals(meals);

          final last30Summary = vm.last30Summary;
          final last30TrackedDays = vm.last30TrackedDays;
          final last30AvgPoints = vm.last30AvgPoints;
          final allTimeTrackedDays = vm.allTimeTrackedDays;
          final allTimeSpanDays = vm.allTimeSpanDays;

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
                      value: SummaryService.habitStabilityLabel(
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
                      value: SummaryService.habitStabilityLabel(
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
