import 'package:flutter/material.dart';
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
      ),
    );
  }
}
