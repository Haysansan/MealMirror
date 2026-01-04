import 'package:flutter/material.dart';
// Temporarily launch the History screen directly for quick iteration.
import 'core/theme/app_theme.dart';
import 'features/history/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMirror - History Prototype',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HistoryScreen(),
    );
  }
}
