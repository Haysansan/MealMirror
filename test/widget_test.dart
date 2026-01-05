// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:mealmirror/main.dart';

void main() {
  testWidgets('App boots to Welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MealMirrorApp());
    await tester.pumpAndSettle();

    // AppRouter.initialLocation is '/welcome'
    expect(find.text('MEAL MIRROR'), findsWidgets);
  });

  testWidgets('Tap welcome navigates to instruction', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MealMirrorApp());
    await tester.pumpAndSettle();

    // WelcomeScreen is a full-screen GestureDetector.
    await tester.tapAt(const Offset(200, 200));
    await tester.pumpAndSettle();

    // First instruction step text.
    expect(find.text('ready to be healthier?'), findsOneWidget);
  });
}
