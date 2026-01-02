import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import '../features/onboarding/welcome_screen.dart';
import '../features/onboarding/instruction_screen.dart';
import '../features/home/home_screen.dart';
import '../features/log_meal/log_meal_screen.dart';
import '../features/history/history_screen.dart';
import '../features/profile/profile_screen.dart';

// Preferences
import '../data/local/preferences/app_preferences.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/instruction',
      builder: (context, state) => const InstructionScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/log-meal',
      builder: (context, state) => const LogMealScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
  // optional redirect example using AppPreferences
  redirect: (context, state) {
    final seenOnboarding = AppPreferences.getBool('seenOnboarding') ?? false;
    if (!seenOnboarding) {
      if (state.uri.path != '/' && state.uri.path != '/instruction') return '/';
    } else {
      if (state.uri.path == '/' || state.uri.path == '/instruction')
        return '/home';
    }
    return null;
  },
);
