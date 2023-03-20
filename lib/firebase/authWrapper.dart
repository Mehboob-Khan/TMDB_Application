import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/firebase/signin.dart';
import 'package:tmdb_application/firebase/signup.dart';
import 'authprovider.dart';

// This widget acts as a wrapper to switch between SignIn and SignUp screens.
class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // Show SignIn screen if isSigningIn is true, else show SignUp screen.
        return auth.isSigningIn ? Signin() : Signup();
      },
    );
  }
}
