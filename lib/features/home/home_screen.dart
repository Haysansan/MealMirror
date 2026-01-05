import 'package:flutter/material.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'widgets/daily_summary_card.dart';
import 'widgets/quick_action_row.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    'your habits, reflected',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'mealmirror',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _petCard(),

            const SizedBox(height: 16),

            const QuickActionRow(),

            const SizedBox(height: 16),

            _dailyBalanceCard(),
          ],
        ),
      ),
    );
  }

  Widget _petCard() {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.autorenew,
                size: 18,
                color: AppColors.primary,
              ),
            ),

            Image.asset(
              'assets/images/MealMirrorPet.png',
              height: 120,
            ),

            const SizedBox(height: 12),

            const Text(
              'Ronan, your companion is okay',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              'Try adding more nutritious meals',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            const Text(
              'Evolution Stage: 0/5',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dailyBalanceCard() {
    return Card(
      color: AppColors.section,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today’s Balance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Neutral Day',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),

            _balanceRow('Daily Power (ENERGY)'),
            _balanceRow('Sweet Level (SUGAR)'),
            _balanceRow('Fat Fuel (FAT)'),
            _balanceRow('Grow Power (PROTEIN)'),
            _balanceRow('Gut Guard (FIBER)'),
          ],
        ),
      ),
    );
  }

  Widget _balanceRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Container(
            width: 120,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
