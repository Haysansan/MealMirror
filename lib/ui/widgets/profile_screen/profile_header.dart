import 'package:flutter/material.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/data/user_repository.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final nickname = UserRepository.getNickname();
    final username = UserRepository.getUsername();

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.petGreen,
          child: Image.asset(
            'assets/images/MealMirrorPet.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          nickname,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(username, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
