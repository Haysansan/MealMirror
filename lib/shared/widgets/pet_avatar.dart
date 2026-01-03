import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PetAvatar extends StatelessWidget {
  final double size;
  const PetAvatar({Key? key, this.size = 96}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.surface,
      child: Icon(Icons.pets, size: size * 0.5, color: AppColors.primary),
    );
  }
}
