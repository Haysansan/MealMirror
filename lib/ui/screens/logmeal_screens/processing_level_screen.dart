import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/data/meal_store.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/ui/widgets/logmeal_screen/nutrition_selector.dart';
import 'package:mealmirror/ui/widgets/logmeal_screen/meal_input_card.dart';
import 'package:mealmirror/ui/widgets/logmeal_screen/selection_pill.dart';
import 'package:mealmirror/domain/models/log_meal_categories.dart';

class ProcessingLevelScreen extends StatefulWidget {
  const ProcessingLevelScreen({
    super.key,
    required this.selectedCategories,
    required this.selectedPortion,
  });

  final List<String> selectedCategories;
  final String selectedPortion;

  @override
  State<ProcessingLevelScreen> createState() => _ProcessingLevelScreenState();
}

class _ProcessingLevelScreenState extends State<ProcessingLevelScreen> {
  String? _selectedProcessing;
  bool _isSaving = false;

  MealInputCard _categoryCard(String category) {
    final info = LogMealCategories.tryGet(category);
    if (info == null) {
      return MealInputCard(
        title: category,
        icon: const Icon(Icons.fastfood, color: AppColors.darkMatcha),
        color: AppColors.categoryPillFill,
        width: 74,
        height: 72,
        showTitle: true,
        selected: true,
      );
    }

    return MealInputCard(
      title: info.shortName,
      icon: Image.asset(info.iconAssetPath),
      color: info.color,
      width: 74,
      height: 72,
      showTitle: true,
      selected: true,
    );
  }

  void _toggleProcessing(String value) {
    setState(() {
      _selectedProcessing = (_selectedProcessing == value) ? null : value;
    });
  }

  Future<void> _addMeal() async {
    final processing = _selectedProcessing;
    if (processing == null || _isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await MealStore.addMealForCurrentUser(
        categories: widget.selectedCategories,
        portion: widget.selectedPortion.toLowerCase(),
        processing: processing.toLowerCase(),
      );

      if (!mounted) return;
      context.go(AppRoutes.home);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canAddMeal = _selectedProcessing != null && !_isSaving;

    return AppScaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 402),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        right: 18,
                        top: 46,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              'Processing Levels',
                              style: TextStyle(
                                color: AppColors.mealMirrorTitle,
                                fontSize: 32,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1.06,
                              ),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => context.pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                  color: AppColors.darkMatcha,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 16),
                      child: Text(
                        'Selected food categories',
                        style: TextStyle(
                          color: AppColors.matcha,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.52,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        right: 26,
                        top: 8,
                      ),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final category in widget.selectedCategories)
                            _categoryCard(category),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 20),
                      child: Text(
                        'Selected portion size',
                        style: TextStyle(
                          color: AppColors.matcha,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.52,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        right: 26,
                        top: 8,
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          SelectionPill(label: widget.selectedPortion),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 20),
                      child: Text(
                        'How processed is this meal?',
                        style: TextStyle(
                          color: AppColors.matcha,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.06,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 6),
                      child: Text(
                        'This helps us understand your eating patterns.',
                        style: TextStyle(
                          color: AppColors.matcha,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.52,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 17,
                        right: 17,
                        top: 18,
                      ),
                      child: Column(
                        children: [
                          PortionSizeSelectionCard(
                            title: 'Whole',
                            description: 'Unrefined, close to natural state.',
                            icon: const Icon(
                              Icons.eco,
                              color: AppColors.darkMatcha,
                            ),
                            selected: _selectedProcessing == 'Whole',
                            onTap: () => _toggleProcessing('Whole'),
                          ),
                          const SizedBox(height: 15.30),
                          PortionSizeSelectionCard(
                            title: 'Processed',
                            description:
                                'Ingredients altered, simple preparation.',
                            icon: const Icon(
                              Icons.soup_kitchen,
                              color: AppColors.darkMatcha,
                            ),
                            selected: _selectedProcessing == 'Processed',
                            onTap: () => _toggleProcessing('Processed'),
                          ),
                          const SizedBox(height: 15.30),
                          PortionSizeSelectionCard(
                            title: 'Ultra-Processed',
                            description: 'Highly industrial and additives.',
                            icon: const Icon(
                              Icons.science,
                              color: AppColors.darkMatcha,
                            ),
                            selected: _selectedProcessing == 'Ultra-Processed',
                            onTap: () => _toggleProcessing('Ultra-Processed'),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 20),
                      child: Text(
                        '💡 Your pet will react based on your choice. Whole foods\nmake them happier!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.matcha,
                          fontSize: 12.8,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        right: 26,
                        top: 20,
                      ),
                      child: SizedBox(
                        height: 60,
                        child: Opacity(
                          opacity: canAddMeal ? 1 : 0.55,
                          child: Material(
                            color: AppColors.actionSurface,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: canAddMeal ? _addMeal : null,
                              child: const Center(
                                child: Text(
                                  'Add Meal',
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
          ),
        ),
      ),
    );
  }
}
