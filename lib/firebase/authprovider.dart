import 'package:flutter/material.dart';

// This class acts as a notifier for managing the authentication state.
class AuthProvider extends ChangeNotifier {
  // signIn is true when the user is signing in, false when signing up.
  bool signIn = true;

  bool get isSigningIn => signIn;

  // Toggles the authentication state between sign-in and sign-up.
  void change() {
    signIn = !signIn;
    notifyListeners();
  }
}
