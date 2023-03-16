class GenreModel {
  final List<Genre>? genres;
  final String? error;

  GenreModel({this.genres, this.error});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      genres: json['genres']
          .map<Genre>((genre) => Genre.fromJson(genre))
          .toList(),
      error: "",
    );
  }

  factory GenreModel.withError(String error) {
    return GenreModel(
      genres: [],
      error: error,
    );
  }
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
