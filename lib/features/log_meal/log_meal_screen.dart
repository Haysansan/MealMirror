import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/primary_button.dart';
import 'widgets/meal_input_card.dart';
import 'widgets/nutrition_selector.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({Key? key}) : super(key: key);
=======

import '../../core/theme/app_colors.dart';
import 'widgets/meal_input_card.dart';
import 'portion_size_screen.dart';

void main() {
  runApp(const LogMealDemoApp());
}

class LogMealDemoApp extends StatelessWidget {
  const LogMealDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const LogMealScreen(),
    );
  }
}

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({super.key});
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
<<<<<<< HEAD
  int _step = 0; // 0=category,1=portion,2=processing
  String? _selectedCategory;
  String _portion = 'Normal';
  String _processing = 'Whole';

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      // Add meal (prototype) — show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Meal added: $_selectedCategory, $_portion, $_processing',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    }
  }

  void _back() {
    if (_step > 0) setState(() => _step--);
=======
  final Set<String> _selectedCategories = <String>{};

  void _setCategorySelected(String category, bool selected) {
    setState(() {
      if (selected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Widget content;
    String title;
    String actionText = 'Continue';

    switch (_step) {
      case 0:
        title = 'Log a Meal';
        content = MealInputCard(
          selected: _selectedCategory,
          onSelect: (cat) => setState(() => _selectedCategory = cat),
        );
        break;
      case 1:
        title = 'Portion Size';
        content = PortionSelector(
          value: _portion,
          onChanged: (v) => setState(() => _portion = v),
        );
        break;
      default:
        title = 'Processing Levels';
        content = ProcessingSelector(
          value: _processing,
          onChanged: (v) => setState(() => _processing = v),
        );
        actionText = 'Add Meal';
    }

    return AppScaffold(
      title: title,
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(child: content),
          const SizedBox(height: 8),
          Row(
            children: [
              if (_step > 0)
                TextButton(onPressed: _back, child: const Text('Back')),
              const Spacer(),
              PrimaryButton(
                text: actionText,
                onPressed: () {
                  if (_step == 0 && _selectedCategory == null) return;
                  _next();
                },
              ),
            ],
          ),
        ],
=======
    final bool canContinue = _selectedCategories.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.logMealBackground,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 402,
            height: 874,
            child: Stack(
              children: [
                const Positioned(
                  left: 26,
                  top: 50,
                  child: SizedBox(
                    width: 180,
                    height: 34,
                    child: Text(
                      'Log a Meal',
                      style: TextStyle(
                        color: AppColors.logMealTitle,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.06,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 26,
                  top: 98,
                  child: SizedBox(
                    width: 349,
                    height: 51,
                    child: Text(
                      'Select a food category',
                      style: TextStyle(
                        color: AppColors.matcha /* Matcha */,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.52,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 149,
                  child: SizedBox(
                    width: 349,
                    child: Wrap(
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
                              _setCategorySelected('Veggie & Fruits', value),
                        ),
                        MealInputCard(
                          title: 'Grain & Starches',
                          icon: Image.asset('assets/images/Bread.png'),
                          color: AppColors.grainStarches,
                          selected: _selectedCategories.contains(
                            'Grain & Starches',
                          ),
                          onSelectedChanged: (value) =>
                              _setCategorySelected('Grain & Starches', value),
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
                          selected: _selectedCategories.contains('Oils & Fats'),
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
                          selected: _selectedCategories.contains('Beverages'),
                          onSelectedChanged: (value) =>
                              _setCategorySelected('Beverages', value),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 672,
                  child: SizedBox(
                    width: 349.43,
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PortionSizeScreen(
                                        selectedCategories: _selectedCategories
                                            .toList(),
                                      ),
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
                ),
              ],
            ),
          ),
        ),
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
      ),
    );
  }
}
