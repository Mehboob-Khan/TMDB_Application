import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/auth/sign_in.dart';
import 'package:tmdb_application/auth/sign_up.dart';

import 'auth_provider.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.isSigningIn == true) {
          return Signin();
        } else {
          return Signup();
        }
      },
    );
  }
}