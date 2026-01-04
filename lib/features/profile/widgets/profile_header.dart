import 'package:flutter/material.dart';
import '../../../shared/widgets/pet_avatar.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String handle;
  final VoidCallback? onEdit;
  final VoidCallback? onLogout;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.handle,
    this.onEdit,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.section,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: PetAvatar(size: 96)),
          const SizedBox(height: 12),
          Text(
            name,
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.onLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            handle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
