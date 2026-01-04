import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'widgets/nutrition_selector.dart';

class PortionSizeScreen extends StatefulWidget {
  const PortionSizeScreen({super.key, required this.selectedCategories});

  final List<String> selectedCategories;

  @override
  State<PortionSizeScreen> createState() => _PortionSizeScreenState();
}

class _PortionSizeScreenState extends State<PortionSizeScreen> {
  String? _selectedPortion;

  void _togglePortion(String value) {
    setState(() {
      _selectedPortion = (_selectedPortion == value) ? null : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue = _selectedPortion != null;

    return Scaffold(
      backgroundColor: AppColors.logMealBackground,
      body: SafeArea(
        child: Center(
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
                            'Portion Size',
                            style: TextStyle(
                              color: AppColors.logMealTitle,
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
                            onTap: () => Navigator.of(context).pop(),
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
                      'Select a food category',
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
                    padding: const EdgeInsets.only(left: 26, right: 26, top: 8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final category in widget.selectedCategories)
                          _CategoryPill(label: category),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 26, right: 26, top: 20),
                    child: Text(
                      'How much did you eat?',
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
                      'Choose the portion that best matches your meal.',
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
                    padding: EdgeInsets.only(left: 17, right: 17, top: 18),
                    child: Column(
                      children: [
                        PortionSizeSelectionCard(
                          title: 'Small',
                          description: 'Just a taste or small side.',
                          icon: Icon(
                            Icons.ramen_dining,
                            color: AppColors.darkMatcha,
                          ),
                          selected: _selectedPortion == 'Small',
                          onTap: () => _togglePortion('Small'),
                        ),
                        SizedBox(height: 15.30),
                        PortionSizeSelectionCard(
                          title: 'Normal',
                          description: 'A typical balanced meal size.',
                          icon: Icon(
                            Icons.lunch_dining,
                            color: AppColors.darkMatcha,
                          ),
                          selected: _selectedPortion == 'Normal',
                          onTap: () => _togglePortion('Normal'),
                        ),
                        SizedBox(height: 15.30),
                        PortionSizeSelectionCard(
                          title: 'Large',
                          description: 'A substantial or oversized portion.',
                          icon: Icon(
                            Icons.restaurant,
                            color: AppColors.darkMatcha,
                          ),
                          selected: _selectedPortion == 'Large',
                          onTap: () => _togglePortion('Large'),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 26, right: 26, top: 20),
                    child: Text(
                      "💡  Portion size helps us understand your eating patterns.\nThere's no judgment just learning about your habits.",
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
                        opacity: canContinue ? 1 : 0.55,
                        child: Material(
                          color: AppColors.actionSurface,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: canContinue
                                ? () => Navigator.of(context).pop()
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
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final String text = (label == null || label!.trim().isEmpty)
        ? 'Category'
        : label!;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 349),
      child: Container(
        height: 28.59,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          color: AppColors.categoryPillFill,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.categoryPillText,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }
}
