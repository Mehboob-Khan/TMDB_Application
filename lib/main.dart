import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_application/constant/style.dart';
import 'package:tmdb_application/hive_handler.dart';
import 'package:tmdb_application/Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_application/firebase/authWrapper.dart';
import 'package:tmdb_application/firebase/authprovider.dart';
import 'package:tmdb_application/firebase_options.dart';

import 'accelerometer_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  await HiveHandler.initHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Color _backgroundColor = Style.primaryColor;
  AccelerometerHandler? _accelerometerHandler;

  void checkUser() {
    auth.authStateChanges().listen((User? user) {
      setState(() {
        checking = false;
      });
      if (user == null) {
        setState(() {
          userFound = false;
        });
      } else {
        setState(() {
          userFound = true;
        });
      }
    });
  }

  bool checking = true;
  bool userFound = false;

  @override
  void initState() {
    super.initState();
    checkUser();
    _accelerometerHandler = AccelerometerHandler(onShake: (color) {
      setState(() {
        _backgroundColor = color;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerHandler?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          scaffoldBackgroundColor: _backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Style.primaryColor,
            elevation: 0,
          ),
        ),
        home: checking
            ? const Center(child: CircularProgressIndicator())
            : userFound
                ? const HomeScreen()
                : AuthWrapper(),
      ),
    );
  }
}
