import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/local/preferences/app_preferences.dart';
import '../../features/history/history_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/log_meal/log_meal_flow_args.dart';
import '../../features/log_meal/log_meal_screen.dart';
import '../../features/log_meal/portion_size_screen.dart';
import '../../features/log_meal/processing_level_screen.dart';
import '../../features/onboarding/instruction_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/profile/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: WelcomeScreen()),
    ),
    GoRoute(
      path: '/instruction',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          child: const InstructionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curved),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/log-meal', builder: (context, state) => const LogMealScreen()),
    GoRoute(
      path: '/portion-size',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! PortionSizeArgs) return const HomeScreen();
        return PortionSizeScreen(selectedCategories: extra.selectedCategories);
      },
    ),
    GoRoute(
      path: '/processing-level',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! ProcessingLevelArgs) return const HomeScreen();
        return ProcessingLevelScreen(
          selectedCategories: extra.selectedCategories,
          selectedPortion: extra.selectedPortion,
        );
      },
    ),
    GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  ],
  redirect: (context, state) {
    final seenOnboarding = AppPreferences.getBool('seenOnboarding') ?? false;
    if (!seenOnboarding) {
      if (state.uri.path != '/' && state.uri.path != '/instruction') {
        return '/';
      }
    } else {
      if (state.uri.path == '/' || state.uri.path == '/instruction') {
        return '/home';
      }
    }
    return null;
  },
);
