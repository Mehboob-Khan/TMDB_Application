import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_application/constant/style.dart';
import 'Screens/home_screen.dart';


Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          scaffoldBackgroundColor: Style.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Style.primaryColor,
            elevation: 0,
          ),
        ),
        home: const HomeScreen());
  }
}