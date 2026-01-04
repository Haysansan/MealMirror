import 'package:flutter/material.dart';

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
    );
  }
}
