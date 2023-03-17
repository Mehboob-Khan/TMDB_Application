import 'package:flutter/material.dart';
import 'package:tmdb_application/movie_widgets/movie_info.dart';

import '../Models/Movie/movie_model.dart';
import '../movie_widgets/similar_movie_widget.dart';

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
        title: Text(
          widget.movie.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag: "${widget.movie.id}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovies(id: widget.movie.id!),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Watch Trailers',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 4, 255, 0),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add To List',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w200/' + widget.movie.backDrop!),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildBackDrop() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/original/' +
                widget.movie.backDrop!),
            fit: BoxFit.cover,
          )),
    );
  }
}
