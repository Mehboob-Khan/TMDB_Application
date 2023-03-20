import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_application/Screens/trailer_screen.dart';

void main() {
  group('TrailersScreen', () {
    testWidgets('should display loading widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TrailersScreen(shows: 'test', id: 1),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // Other test cases for TrailersScreen will go here
  });
}
