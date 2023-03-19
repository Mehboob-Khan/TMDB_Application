// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http_mock_adapter/http_mock_adapter.dart';
// import 'package:tmdb_application/Models/Movie/movie_details_model.dart';
// import 'package:tmdb_application/Models/Movie/movie_model.dart';
// import 'package:tmdb_application/Models/Movie/trailer_model.dart';
// import 'package:tmdb_application/Models/genres_model.dart';
// import 'package:tmdb_application/http/http_request.dart';

// void main() {
//   group('HttpRequest tests', () {
//     late Dio dio;
//     late DioAdapter dioAdapter;

//     setUp(() {
//       dio = Dio();
//       dioAdapter = DioAdapter();
//       dio.httpClientAdapter = dioAdapter;
//       HttpRequest.dio = dio; // Assign the created Dio instance to HttpRequest
//     });

//     test('getGenres', () async {
//       // Create a sample response for the getGenres API call.
//       const sampleResponse = {
//         "genres": [
//           {
//             "id": 28,
//             "name": "Action",
//           },
//         ],
//       };

//       dioAdapter.onGet(
//         HttpRequest.getGenreUrl + "/movie/list",
//         (request) => request.reply(200, sampleResponse),
//       );

//       final response = await HttpRequest.getGenres('movie');
//       expect(response.genres![0].id, 28);
//       expect(response.genres![0].name, 'Action');
//     });

//     // Write similar tests for other API calls like getTrailers, getSimilarMovies, getDiscoverMovies, getMoviesDetails, and getMovies.
//   });
// }
