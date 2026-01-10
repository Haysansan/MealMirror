import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/domain/models/entities/log_meal_flow_args.dart';
import 'package:mealmirror/domain/models/entities/log_meal_categories.dart';
import 'package:mealmirror/ui/widgets/logmeal_screen/meal_input_card.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({super.key});

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  final Set<String> _selectedCategories = <String>{};

  void _setCategorySelected(String category, bool selected) {
    setState(() {
      if (selected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue = _selectedCategories.isNotEmpty;

    return AppScaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 402),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Log a Meal',
                          style: TextStyle(
                            color: AppColors.mealMirrorTitle,
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.06,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Select a food category',
                          style: TextStyle(
                            color: AppColors.matcha,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.52,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 27,
                          runSpacing: 18,
                          children: [
                            for (final category in LogMealCategories.all)
                              MealInputCard(
                                title: category.displayName,
                                icon: Image.asset(category.iconAssetPath),
                                color: category.color,
                                selected: _selectedCategories.contains(
                                  category.key,
                                ),
                                onSelectedChanged: (value) =>
                                    _setCategorySelected(category.key, value),
                              ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Opacity(
                            opacity: canContinue ? 1 : 0.55,
                            child: Material(
                              color: AppColors.actionSurface,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: canContinue
                                    ? () {
                                        context.push(
                                          AppRoutes.portionSize,
                                          extra: PortionSizeArgs(
                                            selectedCategories:
                                                _selectedCategories.toList(),
                                          ),
                                        );
                                      }
                                    : null,
                                child: const Center(
                                  child: Text(
                                    'Continue',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.darkMatcha,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
