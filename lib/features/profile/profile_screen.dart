import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/primary_button.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stat_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const ProfileHeader(name: 'RONAN', handle: '@ronan_best'),
          const SizedBox(height: 16),
          ProfileStatSection(
            title: 'Last 30 Days',
            stats: const [
              StatItem(label: 'Total Meals Logged', value: '30'),
              StatItem(label: 'Daily Average Points', value: '8'),
              StatItem(label: 'Habit Stability', value: 'High'),
            ],
          ),
          const SizedBox(height: 12),
          ProfileStatSection(
            title: 'All Time',
            stats: const [
              StatItem(label: 'Total Meals Logged', value: '655'),
              StatItem(label: 'Daily Average Points', value: '7'),
              StatItem(label: 'Habit Stability', value: 'High'),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(text: 'Edit Profile', onPressed: () {}),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.onLight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text('Log out'),
              ),
            ],
          ),
        ],
=======
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(18),
        child: Text(
          'Profile prototype screen',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: AppColors.textWhiteTheme,
          ),
        ),
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
      ),
    );
  }
}
<<<<<<< HEAD
=======

// AppScaffold
// └─ Column
// ├─ ProfileHeader
// ├─ ProfileStatRow
// ├─ NutritionCard (Goals)
// └─ SettingsList
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
