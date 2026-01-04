import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MealMirror',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhiteTheme,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.go('/instruction'),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
