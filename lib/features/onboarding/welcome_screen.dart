// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../shared/widgets/app_scaffold.dart';
// import '../../shared/widgets/pet_avatar.dart';
// import '../../shared/widgets/primary_button.dart';
// import '../../data/local/preferences/app_preferences.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       body: Column(
//         children: [
//           const Spacer(),
//           const PetAvatar(),
//           const Text('Welcome to MealMirror'),
//           const Text('Track your pet\'s nutrition'),
//           PrimaryButton(
//             text: 'Get Started',
//             onPressed: () async {
//               await AppPreferences.setBool('seenOnboarding', true);
//               context.go('/instruction');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
