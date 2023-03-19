import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_application/Models/Movie/hive_movie_model.dart';
import 'package:tmdb_application/Screens/trailer_screen.dart';
import 'package:tmdb_application/movie_widgets/movie_info.dart';
import '../../movie_widgets/similar_movie_widget.dart';
import '../Movie/movie_model.dart';

class SearchModel extends StatefulWidget {
  final int id;

  SearchModel({required this.id});

  @override
  _SearchModelState createState() => _SearchModelState();
}

class _SearchModelState extends State<SearchModel> {
  late Box<HiveMovieModel> _movieWatchLists;
  late Movie movie;
  bool loading = true;

  // Replace fetchData() with the following method
  Future<void> fetchData() async {
    String url =
        "https://api.themoviedb.org/3/movie/${widget.id}?api_key=6458ca648b70d6d3d574f8e0b2ce817d&language=en-US&append_to_response=credits";

    try {
      var response = await http.get(Uri.parse(url));
      var jsonResponse = jsonDecode(response.body);
      movie = Movie.fromJson(jsonResponse);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists');
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: loading
            ? Text("Loading...")
            : Text(
                movie.title ?? "N/A",
                overflow: TextOverflow.ellipsis,
              ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/original/' +
                                      (movie.backDrop ?? '')),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Positioned(
                        top: 150,
                        left: 30,
                        child: Hero(
                          tag: "${movie.id}",
                          child: Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w200/' +
                                          (movie.poster ??
                                              '')), // Use movie.poster here
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  MovieInfo(id: movie.id ?? 0),
                  SimilarMovies(id: movie.id ?? 0),
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TrailersScreen(shows: "movie", id: movie.id)));
                  },
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
                  onPressed: () {
                    HiveMovieModel hiveMovieModel = HiveMovieModel(
                      id: movie.id!,
                      rating: movie.rating!,
                      title: movie.title!,
                      poster: movie.poster!,
                      backDrop: movie.backDrop!,
                      overview: movie.overview!,
                    );
                    _movieWatchLists.add(hiveMovieModel);
                    print(
                        'Movie added to the watchlist: ${hiveMovieModel.title}');
                  },
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
}
