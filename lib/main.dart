import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmdb_application/constant/style.dart';
import 'Models/Movie/hive_movie_model.dart';
import 'Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase/authWrapper.dart';
import 'firebase/authprovider.dart';
import 'firebase_options.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'dart:math';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveMovieModelAdapter());
  await Hive.openBox<HiveMovieModel>('movie_lists');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Color _backgroundColor = Style.primaryColor;
  StreamSubscription<UserAccelerometerEvent>? _accelerometerSubscription;

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
    _accelerometerSubscription = userAccelerometerEvents.listen((event) {
      final double shakeThreshold = 15;
      if (event.x.abs() > shakeThreshold ||
          event.y.abs() > shakeThreshold ||
          event.z.abs() > shakeThreshold) {
        _changeBackgroundColor();
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color(Random().nextInt(0xFFFFFFFF));
    });
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
            ? Center(child: CircularProgressIndicator())
            : userFound
                ? const HomeScreen()
                : AuthWrapper(),
      ),
    );
  }
}