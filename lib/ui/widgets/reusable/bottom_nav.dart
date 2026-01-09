import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_routes.dart';
import '../../theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.history)) return 2;
    if (location.startsWith(AppRoutes.logMeal) ||
        location.startsWith(AppRoutes.portionSize) ||
        location.startsWith(AppRoutes.processingLevel)) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int index = _currentIndex(context);

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 110,
          child: LayoutBuilder(
            builder: (context, constraints) {
              const double centerWidth = 117;
              const double centerInnerInset = 6;
              const double topRadius = 30;
              const double highlightWidth = 106;
              const double highlightHeight = 83;
              final double centerLeft =
                  (constraints.maxWidth - centerWidth) / 2;

              // above the white bar.
              const double baseTop = 42;
              const double highlightTop = 32;

              // Align highlights to the centers
              const double sidePadding = 18;
              final double sideZoneWidth =
                  (constraints.maxWidth - (sidePadding * 2) - centerWidth) / 2;
              final double leftCenterX = sidePadding + (sideZoneWidth / 2);
              final double rightCenterX =
                  constraints.maxWidth - sidePadding - (sideZoneWidth / 2);
              final double leftHighlightLeft =
                  leftCenterX - (highlightWidth / 2);
              final double rightHighlightLeft =
                  rightCenterX - (highlightWidth / 2);

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: baseTop,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(topRadius),
                          topRight: Radius.circular(topRadius),
                        ),
                      ),
                    ),
                  ),

                  // Side highlight
                  if (index == 0)
                    Positioned(
                      left: leftHighlightLeft,
                      top: highlightTop,
                      width: highlightWidth,
                      height: highlightHeight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(topRadius),
                            topRight: Radius.circular(topRadius),
                          ),
                        ),
                      ),
                    ),
                  if (index == 2)
                    Positioned(
                      left: rightHighlightLeft,
                      top: highlightTop,
                      width: highlightWidth,
                      height: highlightHeight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(topRadius),
                            topRight: Radius.circular(topRadius),
                          ),
                        ),
                      ),
                    ),

                  // Center raised panel
                  Positioned(
                    left: centerLeft,
                    top: 0,
                    width: centerWidth,
                    height: 110,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(topRadius),
                          topRight: Radius.circular(topRadius),
                        ),
                      ),
                    ),
                  ),

                  // Center highlighted action
                  Positioned(
                    left: centerLeft + centerInnerInset,
                    top: 5,
                    width: centerWidth - (centerInnerInset * 2),
                    height: 105,
                    child: Material(
                      color: index == 1
                          ? AppColors.background
                          : AppColors.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(topRadius),
                        topRight: Radius.circular(topRadius),
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(topRadius),
                          topRight: Radius.circular(topRadius),
                        ),
                        onTap: () => context.go(AppRoutes.logMeal),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 42,
                              color: AppColors.darkMatcha,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Log Meal',
                              style: TextStyle(
                                color: index == 1
                                    ? AppColors.darkMatcha
                                    : AppColors.secondary,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Side items
                  Positioned(
                    left: 0,
                    right: 0,
                    top: baseTop,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: _NavItem(
                              label: 'Home',
                              icon: Icons.eco,
                              selected: index == 0,
                              onTap: () => context.go(AppRoutes.home),
                            ),
                          ),
                          const SizedBox(width: centerWidth),
                          Expanded(
                            child: _NavItem(
                              label: 'History',
                              icon: Icons.history,
                              selected: index == 2,
                              onTap: () => context.go(AppRoutes.history),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.darkMatcha : AppColors.secondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          height: 68,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
