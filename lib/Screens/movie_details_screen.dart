import 'package:flutter/material.dart';

import '../Models/Movie/movie_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
    );
  }
}