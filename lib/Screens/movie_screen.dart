import 'package:flutter/material.dart';
import 'package:tmdb_application/movie_widgets/now_playing_widget.dart';

import '../constant/style.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NowPlaying(),
        Text('Genre', style: TextStyle(color: Style.textColor)),
        Text('Upcoming', style: TextStyle(color: Style.textColor)),
        Text('Popular', style: TextStyle(color: Style.textColor)),
        Text('Top Rated', style: TextStyle(color: Style.textColor)),
      ],
    );
  }
}
