import 'package:flutter/material.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/pet_avatar.dart';
import '../../shared/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const PetAvatar(),
          const SizedBox(height: 12),
          const Text(
            'Good morning!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text('Daily summary (prototype)'),
          const Spacer(),
          PrimaryButton(text: 'Log Meal', onPressed: () {}),
        ],
      ),
    );
  }
}
