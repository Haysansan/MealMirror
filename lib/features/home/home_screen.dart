import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/pet_avatar.dart';
import '../../shared/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const PetAvatar(),
          const SizedBox(height: 12),
          const Text(
            'Good morning!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text('Daily summary (prototype)'),
          const Spacer(),
          PrimaryButton(text: 'Log Meal', onPressed: () {}),
        ],
=======
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: const Text(
          'Home',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Good morning!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textWhiteTheme,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => context.go('/log-meal'),
                child: const Text(
                  'Log Meal',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => context.go('/history'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'History',
                style: TextStyle(fontFamily: 'Inter'),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => context.go('/profile'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Profile',
                style: TextStyle(fontFamily: 'Inter'),
              ),
            ),
          ],
        ),
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
      ),
    );
  }
}
