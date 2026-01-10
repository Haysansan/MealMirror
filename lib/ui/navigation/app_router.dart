import 'package:go_router/go_router.dart';

import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/screens/welcome_screens/signup_screen.dart';
import 'package:mealmirror/ui/screens/home_screens/home_screen.dart';
import 'package:mealmirror/domain/models/log_meal_flow_args.dart';
import 'package:mealmirror/ui/screens/logmeal_screens/log_meal_screen.dart';
import 'package:mealmirror/ui/screens/logmeal_screens/portion_size_screen.dart';
import 'package:mealmirror/ui/screens/logmeal_screens/processing_level_screen.dart';
import 'package:mealmirror/ui/screens/welcome_screens/instruction_screen.dart';
import 'package:mealmirror/domain/models/instruction_steps.dart';
import 'package:mealmirror/ui/screens/welcome_screens/welcome_screen.dart';
import 'package:mealmirror/ui/screens/profile_screens/profile_screen.dart';
import 'package:mealmirror/ui/screens/history_screens/history_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.instruction,
        builder: (context, state) => InstructionScreen(steps: instructionSteps),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.logMeal,
        builder: (context, state) => const LogMealScreen(),
      ),

      GoRoute(
        path: AppRoutes.portionSize,
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
        path: AppRoutes.processingLevel,
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
        path: AppRoutes.history,
        builder: (context, state) => const HistoryScreen(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
