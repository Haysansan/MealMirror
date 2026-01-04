import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stat_row.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),

            _statCard(
              title: 'Last 30 Days',
              stats: const [
                ProfileStatRow(label: 'Total Meals Logged', value: '30'),
                ProfileStatRow(label: 'Daily Average Points', value: '-5'),
                ProfileStatRow(label: 'Habit Stability', value: 'High'),
              ],
            ),

            const SizedBox(height: 12),

            _statCard(
              title: 'All Time',
              stats: const [
                ProfileStatRow(label: 'Total Meals Logged', value: '65'),
                ProfileStatRow(label: 'Days Tracking', value: '70'),
                ProfileStatRow(label: 'Habit Stability', value: 'High'),
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
                    onPressed: () {},
                    child: const Text('Log out'),
                  ),
                ),
              ],
            ),
          ],
        ),
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
