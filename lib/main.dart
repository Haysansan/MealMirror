<<<<<<< HEAD
// import 'package:flutter/material.dart';
// import 'core/navigation/app_router.dart';
// import 'core/theme/app_theme.dart';
// import 'data/preferences/app_preferences.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppPreferences.init();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: appRouter,
//       title: 'MealMirror',
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
=======
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
>>>>>>> 4777f7c8b19bffbe00830695055fb8ed5bf137de
