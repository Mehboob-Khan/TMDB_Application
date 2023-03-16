import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Models/Movie/movie_details_model.dart';
import '../Models/Movie/movie_model.dart';
import '../Models/genres_model.dart';

class HttpRequest {
  static final String? apiKey = dotenv.env['API_KEY'];
  static const String mainUrl = "https://api.themoviedb.org/3";
  static var getGenreUrl = "$mainUrl/genre";
  static var getDiscoverUrl = "$mainUrl/discover";
  static var getMoviesUrl = "$mainUrl/movie";

  static Future<GenreModel> getGenres(String shows) async {
    var params = {"api_key": apiKey, "language": "en-GB", "page": 1};
    final url = Uri.parse(getGenreUrl + "/$shows/list").replace(queryParameters: params);

    try {
      final response = await http.get(url);
      return GenreModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      return GenreModel.withError("$error");
    }
  }

  static Future<MovieModel> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey, "language": "en-GB", "page": 1};
    final url = Uri.parse(getMoviesUrl + "/$id/similar").replace(queryParameters: params);

    try {
      final response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  static Future<MovieModel> getDiscoverMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-GB",
      "page": 1,
      "with_genres": id,
    };
    final url = Uri.parse(getDiscoverUrl + "/movie").replace(queryParameters: params);

    try {
      final response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  static Future<MovieDetailsModel> getMoviesDetails(int id) async {
    var params = {"api_key": apiKey, "language": "en-GB"};
    final url = Uri.parse(getMoviesUrl + "/$id").replace(queryParameters: params);

    try {
      final response = await http.get(url);
      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      return MovieDetailsModel.withError("$error");
    }
  }

  static Future<MovieModel> getMovies(String request) async {
    var params = {"api_key": apiKey, "language": "en-GB"};
    final url = Uri.parse(getMoviesUrl + "/$request").replace(queryParameters: params);

    try {
      final response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }
}
