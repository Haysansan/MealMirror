import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/data/meal_repository.dart';
import 'package:mealmirror/data/user_repository.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/ui/widgets/profile_screen/profile_header.dart';
import 'package:mealmirror/ui/widgets/profile_screen/profile_stat_row.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/profile_view_model.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/services/summary_service.dart';
import 'package:mealmirror/ui/navigation/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late Future<List<MealEntry>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMeals();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _loadMeals() {
    _mealsFuture = MealRepository.getAllMeals();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh meals when app returns to foreground
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {
        _loadMeals();
      });
    }
  }

  Future<void> _handleEditNickname(BuildContext context) async {
    final controller = TextEditingController(
      text: UserRepository.getNickname(),
    );

    final newNickname = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Nickname'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter new nickname'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (newNickname != null && newNickname.isNotEmpty) {
      final success = await UserRepository.updateNickname(newNickname);
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(
            // ignore: use_build_context_synchronously
            context,
          ).showSnackBar(const SnackBar(content: Text('Nickname updated!')));
          // rebuild to show new nickname
          setState(() {});
        }
      }
    }
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        future: _mealsFuture,
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
                // Profile header (name and email from user)
                const ProfileHeader(),
                const SizedBox(height: 16),
                // Nickname section with edit button
                Card(
                  color: AppColors.section,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nickname',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              UserRepository.getNickname(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _handleEditNickname(context),
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                ),
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
