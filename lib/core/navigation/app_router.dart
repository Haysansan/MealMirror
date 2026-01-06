import 'package:go_router/go_router.dart';

import '../../features/auth/signup_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/log_meal/log_meal_flow_args.dart';
import '../../features/log_meal/log_meal_screen.dart';
import '../../features/log_meal/portion_size_screen.dart';
import '../../features/log_meal/processing_level_screen.dart';
import '../../features/onboarding/instruction_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/history/history_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),

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
        path: '/portion-size',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is PortionSizeArgs) {
            return PortionSizeScreen(
              selectedCategories: extra.selectedCategories,
            );
          }
          return const LogMealScreen();
        },
      ),

      GoRoute(
        path: '/processing-level',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is ProcessingLevelArgs) {
            return ProcessingLevelScreen(
              selectedCategories: extra.selectedCategories,
              selectedPortion: extra.selectedPortion,
            );
          }
          return const LogMealScreen();
        },
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
