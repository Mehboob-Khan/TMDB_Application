import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  void _signIn() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          _success = 2;
          _userEmail = user.email!;
        });
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        setState(() {
          _success = 3;
        });
      }
    } catch (e) {
      setState(() {
        _success = 3;
      });
    }
  }

  @override
  