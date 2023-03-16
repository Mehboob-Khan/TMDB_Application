import '../genres_model.dart';

class MovieDetailsModel {
  final MovieDetails? details;
  final String? error;

  MovieDetailsModel({required this.details, required this.error});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      details: MovieDetails.fromJson(json),
      error: "",
    );
  }

  factory MovieDetailsModel.withError(String error) {
    return MovieDetailsModel(
      details: null,
      error: error,
    );
  }
}

class MovieDetails {
  final int? id;
  final List<Genre>? genres;
  final String? releaseDate;
  final String? overview;
  final String? backDrop;
  final String? poster;
  final double? rating;
  final String? title;
  final int? runtime;

  MovieDetails({
    required this.id,
    required this.genres,
    required this.releaseDate,
    required this.overview,
    required this.backDrop,
    required this.poster,
    required this.rating,
    required this.title,
    required this.runtime,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      genres: (json['genres'] as List)
          .map((genre) => Genre.fromJson(genre))
          .toList(),
      rating: json['vote_average'].toDouble(),
      title: json['title'],
      backDrop: json['backdrop_path'],
      poster: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
    );
  }
}
