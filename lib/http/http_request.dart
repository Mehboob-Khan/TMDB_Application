import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Models/Movie/movie_details_model.dart';
import '../Models/Movie/movie_model.dart';
import '../Models/Movie/trailer_model.dart';
import '../Models/genres_model.dart';

class HttpRequest {
  // Access token and main URL
  static final String? tmdbAccessToken = dotenv.env['TMDB_ACCESS_TOKEN'];
  static const String mainUrl = "https://api.themoviedb.org/3";
  
  // Dio instance for making requests
  static final Dio dio = Dio();

  // URLs for different endpoints
  static var getGenreUrl = "$mainUrl/genre";
  static var getDiscoverUrl = "$mainUrl/discover";
  static var getMoviesUrl = "$mainUrl/movie";

  // Get genres for given type of shows
  static Future<GenreModel> getGenres(String shows) async {
    try {
      Response response = await dio.get(
        getGenreUrl + "/$shows/list",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return GenreModel.fromJson(response.data);
    } catch (error) {
      return GenreModel.withError("$error");
    }
  }

  // Get trailers for given type of shows and id
  static Future<TrailersModel> getTrailers(String shows, int id) async {
    try {
      Response response = await dio.get(
        mainUrl + "/$shows/$id/videos",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return TrailersModel.fromJson(response.data);
    } catch (error) {
      return TrailersModel.withError("$error");
    }
  }

  // Get similar movies for given id
  static Future<MovieModel> getSimilarMovies(int id) async {
    try {
      Response response = await dio.get(
        getMoviesUrl + "/$id/similar",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return MovieModel.fromJson(response.data);
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  // Get movies with specified genre id
  static Future<MovieModel> getDiscoverMovies(int id) async {
    var params = {
      "language": "en-us",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response = await dio.get(
        getDiscoverUrl + "/movie",
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return MovieModel.fromJson(response.data);
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  // Get movie details for given id
  static Future<MovieDetailsModel> getMoviesDetails(int id) async {
    try {
      Response response = await dio.get(
        getMoviesUrl + "/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return MovieDetailsModel.fromJson(response.data);
    } catch (error) {
      return MovieDetailsModel.withError("$error");
    }
  }

  // Get movies for given request

  static Future<MovieModel> getMovies(String request) async {
    try {
      Response response = await dio.get(
        getMoviesUrl + "/$request",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return MovieModel.fromJson(response.data);
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  
}