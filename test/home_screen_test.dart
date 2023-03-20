import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_application/Screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('HomeScreen widget is built correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Check if AppBar is present with correct title
    expect(find.text('Movie Shows'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);

    // Check if BottomNavigationBar is present with correct items
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Movie'), findsOneWidget);
    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Search Bar'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Check if the PageView is present
    expect(find.byType(PageView), findsOneWidget);
  });
}
