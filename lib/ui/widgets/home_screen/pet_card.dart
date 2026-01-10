import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mealmirror/ui/navigation/app_routes.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/domain/models/home_view_model.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.go(AppRoutes.profile),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.person,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Image.asset('assets/images/MealMirrorPet.png', height: 120),
            const SizedBox(height: 12),
            Text(
              '${viewModel.displayNickname}, your companion is ${viewModel.petMoodHeadline}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              viewModel.nutritionAdvice,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              'Meals today: ${viewModel.todayMeals}',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
