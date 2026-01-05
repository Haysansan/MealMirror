import 'package:flutter/material.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MealMirrorApp());
}

class MealMirrorApp extends StatelessWidget {
  const MealMirrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
