import 'package:flutter/material.dart';
import 'package:tmdb_application/movie_widgets/get_genres.dart';
import 'package:tmdb_application/movie_widgets/movies_widget.dart';
import 'package:tmdb_application/movie_widgets/now_playing_widget.dart';


class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const NowPlaying(),
        const GetGenres(),
        const MoviesWidget(text: "UPCOMING", request: 'upcoming'),
        const MoviesWidget(text: "POPULAR", request: 'popular'),
        const MoviesWidget(text: "TOP RATED", request: 'top_rated'),
      ],
    );
  }
}
