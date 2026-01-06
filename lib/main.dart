import 'package:flutter/material.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/local/local_json_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prints the exact storage location in debug mode.
  assert(() {
    LocalJsonStore.debugLocation().then((p) {
      // ignore: avoid_print
      print('MealMirror local storage: $p');
    });
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
