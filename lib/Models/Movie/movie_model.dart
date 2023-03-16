class MovieModel {
  final List<Movie> movies;
  final String error;

  MovieModel({required this.movies, required this.error});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        movies: (json["results"] as List)
            .map((data) => Movie.fromJson(data as Map<String, dynamic>))
            .toList(),
        error: "",
      );

  factory MovieModel.withError(String error) => MovieModel(
        movies: [],
        error: error,
      );
}

class Movie {
  final int id;
  final double rating;
  final String title;
  final String backDrop;
  final String poster;
  final String overview;

  Movie({
    required this.id,
    required this.rating,
    required this.title,
    required this.backDrop,
    required this.poster,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] ?? 0,
        rating: (json['vote_average'] ?? 0.0).toDouble(),
        title: json['title'] ?? '',
        backDrop: json['backdrop_path'] ?? '',
        poster: json['poster_path'] ?? '',
        overview: json['overview'] ?? '',
      );
}
