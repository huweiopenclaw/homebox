// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homebox/main.dart';

void main() {
  testWidgets('App should start', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeBoxApp());
    
    // Verify app starts
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
