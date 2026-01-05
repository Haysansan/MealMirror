import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/log_meal/log_meal_flow_args.dart';
import '../../features/log_meal/log_meal_screen.dart';
import '../../features/log_meal/portion_size_screen.dart';
import '../../features/log_meal/processing_level_screen.dart';
import '../../features/onboarding/instruction_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/onboarding/welcome_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
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
  );
}
