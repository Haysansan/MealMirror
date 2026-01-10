import 'package:flutter/material.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(radius: 36, backgroundColor: AppColors.primary),
        SizedBox(height: 12),
        Text(
          'Ronan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4),
        Text('ronan@example.com', style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
