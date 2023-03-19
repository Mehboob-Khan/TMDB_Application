import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Models/Movie/movie_details_model.dart';
import '../Models/Movie/movie_model.dart';
import '../Models/Movie/trailer_model.dart';
import '../Models/genres_model.dart';
import '../Models/reviews_model.dart';

class HttpRequest {
  static final String? tmdbAccessToken = dotenv.env['TMDB_ACCESS_TOKEN'];
  static const String mainUrl = "https://api.themoviedb.org/3";
  static final Dio dio = Dio();
  static var getGenreUrl = "$mainUrl/genre";
  static var getDiscoverUrl = "$mainUrl/discover";
  static var getMoviesUrl = "$mainUrl/movie";

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

  static Future<ReviewsModel> getReviews(String shows, int id) async {
    try {
      Response response = await dio.get(
        mainUrl + "/$shows/$id/reviews",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tmdbAccessToken',
          },
        ),
      );
      return ReviewsModel.fromJson(response.data);
    } catch (error) {
      return ReviewsModel.withError("$error");
    }
  }

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