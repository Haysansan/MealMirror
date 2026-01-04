import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

typedef CategoryCallback = void Function(String category);

class MealInputCard extends StatelessWidget {
  final String? selected;
  final CategoryCallback? onSelect;
  const MealInputCard({Key? key, this.selected, this.onSelect})
    : super(key: key);

  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'vegetables',
      'label': 'Vegetables',
      'image': 'assets/images/Vegies.png',
    },
    {'id': 'fruit', 'label': 'Fruit', 'image': 'assets/images/Tomato.png'},
    {'id': 'protein', 'label': 'Protein', 'image': 'assets/images/Egg.png'},
    {'id': 'carbs', 'label': 'Carbs', 'image': 'assets/images/Bread.png'},
    {
      'id': 'treats',
      'label': 'Treats',
      'image': 'assets/images/MealMirrorPet.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select a food category', style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: categories.map((c) {
              final label = c['label'] as String;
              final bg = Color(c['color'] as int);
              final isSelected = selected == label;
              return GestureDetector(
                onTap: () => onSelect?.call(label),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.12)
                        : bg,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.fastfood,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(label, style: AppTextStyles.bodyMedium),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
=======

import '../../../core/theme/app_colors.dart';

class MealInputCard extends StatefulWidget {
  const MealInputCard({
    super.key,
    required this.title,
    required this.icon,
    this.color = AppColors.veggieFruits,
    this.width = 161,
    this.height = 100.45,
    this.selected,
    this.initiallySelected = false,
    this.onSelectedChanged,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final Color color;
  final double width;
  final double height;
  final bool? selected;

  /// Used only when [selected] is null.
  final bool initiallySelected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;

  @override
  State<MealInputCard> createState() => _MealInputCardState();
}

class _MealInputCardState extends State<MealInputCard> {
  late bool _selected = widget.initiallySelected;

  bool get _isSelected => widget.selected ?? _selected;

  void _handleTap() {
    final bool nextSelected = !_isSelected;

    widget.onTap?.call();
    widget.onSelectedChanged?.call(nextSelected);

    if (widget.selected == null) {
      setState(() {
        _selected = nextSelected;
      });
    }
  }

  @override
  void didUpdateWidget(covariant MealInputCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected == null &&
        oldWidget.initiallySelected != widget.initiallySelected) {
      _selected = widget.initiallySelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Brighter default + more saturated selected.
    final Color fillColor = _isSelected
        ? (Color.lerp(widget.color, Colors.white, 0.15) ?? widget.color)
        : (Color.lerp(widget.color, Colors.white, 0.45) ?? widget.color);

    final Color borderColor = _isSelected
        ? (Color.lerp(widget.color, Colors.black, 0.55) ?? widget.color)
        : (Color.lerp(widget.color, Colors.black, 0.35) ?? widget.color);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: _handleTap,
          child: Container(
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: borderColor),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: 5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 26.64,
                  height: 23.69,
                  child: FittedBox(fit: BoxFit.contain, child: widget.icon),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 113,
                  height: 27,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.darkMatcha /* Dark-Matcha */,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
>>>>>>> 2037736839e5e043d1979343e157b93c3aa009e1
    );
  }
}
