import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Movie/movie_model.dart';
import '../http/http_request.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieModelProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Consumer<MovieModelProvider>(
        builder: (context, model, child) {
          if (model.movies != null) {
            return _buildContentWidget(model.movies!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildContentWidget(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
          leading: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w92${movie.poster}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
    );
  }
}

class MovieModelProvider extends ChangeNotifier {
  List<Movie>? _movies;

  MovieModelProvider() {
    _loadMovies();
  }

  List<Movie>? get movies => _movies;

  Future<void> _loadMovies() async {
    final response = await HttpRequest.getMovies("popular");
    _movies = response.movies;
    notifyListeners();
  }
}
