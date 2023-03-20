import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_application/Models/Movie/hive_movie_model.dart';

void main() {
  group('HiveMovieModel', () {
    test('should have valid properties', () {
      final hiveMovieModel = HiveMovieModel(
        id: 1,
        rating: 8.5,
        title: 'Test Movie',
        poster: '/testPoster.jpg',
        backDrop: '/testBackdrop.jpg',
        overview: 'Test overview.',
      );

      expect(hiveMovieModel.id, 1);
      expect(hiveMovieModel.rating, 8.5);
      expect(hiveMovieModel.title, 'Test Movie');
      expect(hiveMovieModel.poster, '/testPoster.jpg');
      expect(hiveMovieModel.backDrop, '/testBackdrop.jpg');
      expect(hiveMovieModel.overview, 'Test overview.');
    });
  });
}
