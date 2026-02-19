# Integration Test Example

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:homebox/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomeBox Integration Tests', () {
    testWidgets('Complete box creation flow', (tester) async {
      await tester.pumpWidget(const HomeBoxApp());
      
      // Wait for app to load
      await tester.pumpAndSettle();
      
      // Find and tap the add box button
      final addBoxButton = find.byIcon(Icons.add);
      if (addBoxButton.evaluate().isNotEmpty) {
        await tester.tap(addBoxButton);
        await tester.pumpAndSettle();
      }
      
      // Verify we're on the add box page
      expect(find.text('添加箱子'), findsWidgets);
    });

    testWidgets('Navigation between tabs', (tester) async {
      await tester.pumpWidget(const HomeBoxApp());
      await tester.pumpAndSettle();
      
      // Find navigation bar
      final navBar = find.byType(NavigationBar);
      expect(navBar, findsOneWidget);
      
      // Tap on chat tab
      final chatIcon = find.descendant(
        of: navBar,
        matching: find.byIcon(Icons.chat_bubble_outline),
      );
      
      if (chatIcon.evaluate().isNotEmpty) {
        await tester.tap(chatIcon.first);
        await tester.pumpAndSettle();
      }
    });
  });
}
