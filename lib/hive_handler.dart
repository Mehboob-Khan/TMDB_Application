import 'package:hive_flutter/hive_flutter.dart';
import 'Models/Movie/hive_movie_model.dart';

class HiveHandler {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveMovieModelAdapter());
    await Hive.openBox<HiveMovieModel>('movie_lists');
  }
}
