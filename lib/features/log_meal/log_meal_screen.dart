import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'log_meal_flow_args.dart';
import 'widgets/meal_input_card.dart';

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
                            MealInputCard(
                              title: 'Veggie & Fruits',
                              icon: Image.asset('assets/images/Vegies.png'),
                              color: AppColors.veggieFruits,
                              selected: _selectedCategories.contains(
                                'Veggie & Fruits',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected(
                                    'Veggie & Fruits',
                                    value,
                                  ),
                            ),
                            MealInputCard(
                              title: 'Grain & Starches',
                              icon: Image.asset('assets/images/Bread.png'),
                              color: AppColors.grainStarches,
                              selected: _selectedCategories.contains(
                                'Grain & Starches',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected(
                                    'Grain & Starches',
                                    value,
                                  ),
                            ),
                            MealInputCard(
                              title: 'Meat & Seafood',
                              icon: Image.asset('assets/images/meat.png'),
                              color: AppColors.meatSeafood,
                              selected: _selectedCategories.contains(
                                'Meat & Seafood',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Meat & Seafood', value),
                            ),
                            MealInputCard(
                              title: 'Plant Protein',
                              icon: Image.asset('assets/images/Tomato.png'),
                              color: AppColors.plantProtein,
                              selected: _selectedCategories.contains(
                                'Plant Protein',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Plant Protein', value),
                            ),
                            MealInputCard(
                              title: 'Dairy & Eggs',
                              icon: Image.asset('assets/images/Egg.png'),
                              color: AppColors.dairyEggs,
                              selected: _selectedCategories.contains(
                                'Dairy & Eggs',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Dairy & Eggs', value),
                            ),
                            MealInputCard(
                              title: 'Oils & Fats',
                              icon: Image.asset('assets/images/cheese.png'),
                              color: AppColors.oilsFats,
                              selected: _selectedCategories.contains(
                                'Oils & Fats',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Oils & Fats', value),
                            ),
                            MealInputCard(
                              title: 'Snacks',
                              icon: Image.asset('assets/images/cookie.png'),
                              color: AppColors.snacks,
                              selected: _selectedCategories.contains('Snacks'),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Snacks', value),
                            ),
                            MealInputCard(
                              title: 'Beverages',
                              icon: Image.asset('assets/images/beverages.png'),
                              color: AppColors.beverages,
                              selected: _selectedCategories.contains(
                                'Beverages',
                              ),
                              onSelectedChanged: (value) =>
                                  _setCategorySelected('Beverages', value),
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
                                          '/portion-size',
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
