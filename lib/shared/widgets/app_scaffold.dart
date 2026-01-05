import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? trailing;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.trailing,
  });

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/history')) return 2;
    if (location.startsWith('/log-meal')) return 1;
    return 0; // home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: trailing != null ? [trailing!] : null,
            )
          : null,
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/log-meal');
              break;
            case 2:
              context.go('/history');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Log Meal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
