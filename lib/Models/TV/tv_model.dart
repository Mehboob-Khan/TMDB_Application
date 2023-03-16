class TVModel {
  final List<TVShows> tvShows;
  final String? error;

  TVModel({required this.tvShows, this.error});

  factory TVModel.fromJson(Map<String, dynamic> json) {
    return TVModel(
      tvShows: (json["results"] as List)
          .map((data) => TVShows.fromJson(data))
          .toList(),
      error: "",
    );
  }

  factory TVModel.withError(String error) {
    return TVModel(
      tvShows: [],
      error: error,
    );
  }
}

class TVShows {
  final int id;
  final double rating;
  final String name;
  final String backDrop;
  final String poster;
  final String overview;

  TVShows({
    required this.id,
    required this.rating,
    required this.name,
    required this.backDrop,
    required this.poster,
    required this.overview,
  });

  factory TVShows.fromJson(Map<String, dynamic> json) {
    return TVShows(
      id: json['id'],
      rating: json['vote_average'].toDouble(),
      name: json['name'],
      backDrop: json['backdrop_path'],
      poster: json['poster_path'],
      overview: json['overview'],
    );
  }
}
