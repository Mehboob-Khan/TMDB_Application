import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_application/Screens/movie_screen.dart';
import 'package:tmdb_application/movie_widgets/get_genres.dart';
import 'package:tmdb_application/movie_widgets/movies_widget.dart';
import 'package:tmdb_application/movie_widgets/now_playing_widget.dart';

void main() {
  group('MovieScreen', () {
    testWidgets('should display widgets', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MovieScreen(),
      ));

      expect(find.byType(NowPlaying), findsOneWidget);
      expect(find.byType(GetGenres), findsOneWidget);
      expect(find.byType(MoviesWidget), findsNWidgets(3));
    });
  });
}
