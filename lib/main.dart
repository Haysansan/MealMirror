import 'package:flutter/material.dart';

import 'core/navigation/app_router.dart';
import 'data/local/app_database.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const MealMirrorApp());
}

class MealMirrorApp extends StatelessWidget {
  const MealMirrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
