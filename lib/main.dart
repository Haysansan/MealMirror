import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'ui/navigation/app_router.dart';
import 'ui/theme/app_theme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  assert(() {
    if (!kIsWeb) {
      getDatabasesPath().then((dbPath) {
        final authDb = p.join(dbPath, 'auth.db');
        final mealsDb = p.join(dbPath, 'meals.db');
        // ignore: avoid_print
        print('MealMirror auth DB: $authDb');
        // ignore: avoid_print
        print('MealMirror meals DB: $mealsDb');
      });
    }
    return true;
  }());

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
