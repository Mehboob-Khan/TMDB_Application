import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/firebase/authprovider.dart';
import 'package:tmdb_application/firebase/signup.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  group('Signup tests', () {
    late MockAuthProvider mockAuthProvider;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('Signup form fields and buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(home: Signup()),
        ),
      );

      // Find text fields and buttons
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });




    // Additional test cases can be written to test other functionalities such as error dialogs and signUp function.
  });
}
