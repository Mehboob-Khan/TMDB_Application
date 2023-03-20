import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/firebase/authprovider.dart';
import 'package:tmdb_application/firebase/signin.dart';

class MockAuthProvider extends ChangeNotifier implements AuthProvider {
  bool isChanged = false;

  @override
  void change() {
    isChanged = true;
    notifyListeners();
  }

  @override
  late bool signIn;

  @override
  bool get isSigningIn => throw UnimplementedError();
}

void main() {
testWidgets('Signin widget is built correctly', (WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => MockAuthProvider(),
      child: MaterialApp(home: Signin()),
    ),
  );

  expect(find.text('Welcome Back,'), findsOneWidget);
  expect(find.text('Log in to continue'), findsOneWidget);
  expect(find.byType(TextFormField), findsNWidgets(2));
  expect(find.byIcon(Icons.email), findsOneWidget);
  expect(find.byIcon(Icons.code), findsOneWidget);
  expect(
    find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          (widget.text.toPlainText().contains("Don't have an account? ")),
    ),
    findsOneWidget,
  );
  expect(
    find.byWidgetPredicate(
      (widget) =>
          widget is RichText && (widget.text.toPlainText().contains('Sign up')),
    ),
    findsOneWidget,
  );
});



  testWidgets('Sign up tap triggers AuthProvider.change()',
      (WidgetTester tester) async {
    final mockAuthProvider = MockAuthProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => mockAuthProvider,
        child: MaterialApp(home: Signin()),
      ),
    );

    expect(mockAuthProvider.isChanged, false);

    await tester.tap(find.byKey(Key('signup_tap')));
    await tester.pump();

    expect(mockAuthProvider.isChanged, true);
  });
}
