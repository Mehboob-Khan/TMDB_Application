import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/firebase/authprovider.dart';
import 'package:tmdb_application/firebase/signin.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  group('Signin tests', () {
    late MockAuthProvider mockAuthProvider;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('Signin form fields and buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(home: Signin()),
        ),
      );

      // Find text fields and buttons
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);

      final signUpFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is RichText && widget.text.toPlainText().contains('Sign up'),
      );
      expect(signUpFinder, findsOneWidget);
    });

    testWidgets('Email and password fields onChanged callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(home: Signin()),
        ),
      );

      await tester.enterText(
          find.widgetWithIcon(TextFormField, Icons.email), 'test@example.com');
      await tester.enterText(
          find.widgetWithIcon(TextFormField, Icons.code), 'password123');

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    
  });
}