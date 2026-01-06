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
    this.showTitle = true,
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
  final bool showTitle;
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
            padding: EdgeInsets.symmetric(
              horizontal: widget.showTitle ? 10 : 8,
              vertical: widget.showTitle ? 12 : 8,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double shortestSide =
                    (constraints.maxWidth < constraints.maxHeight)
                    ? constraints.maxWidth
                    : constraints.maxHeight;

                // make icons more visible.
                final double iconScale = widget.showTitle ? 0.42 : 0.62;
                final double iconSize = (shortestSide * iconScale).clamp(
                  18.0,
                  widget.showTitle ? 36.0 : 32.0,
                );

                if (!widget.showTitle) {
                  return Center(
                    child: SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: FittedBox(fit: BoxFit.contain, child: widget.icon),
                    ),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: FittedBox(fit: BoxFit.contain, child: widget.icon),
                    ),
                    SizedBox(
                      height: (constraints.maxHeight * 0.12).clamp(6, 14),
                    ),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.darkMatcha,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
