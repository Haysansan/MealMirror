import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/auth_service.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(String?, String?)>(
      future: Future.wait([
        AuthService.getCurrentUsername(),
        AuthService.getCurrentNickname(),
      ]).then((values) => (values[0], values[1])),
      builder: (context, snapshot) {
        final (username, nickname) = snapshot.data ?? (null, null);
        final displayName = (username?.trim().isNotEmpty ?? false)
            ? username!.trim()
            : 'User';
        final displayHandle = (nickname?.trim().isNotEmpty ?? false)
            ? '@${nickname!.trim()}'
            : '@';

        return SizedBox(
          width: double.infinity,
          child: Card(
            color: AppColors.section,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/images/MealMirrorPet.png', height: 120),

                  const SizedBox(height: 14),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayHandle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
