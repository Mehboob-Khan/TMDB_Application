import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Place {
  final String id;
  final String name;
  final double lat;
  final double lng;

  Place({required this.id, required this.name, required this.lat, required this.lng});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }
}

class PlacesService {
  final String apiKey;

  PlacesService(this.apiKey);

  Future<List<Place>> getNearbyCinemas(Position position) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=5000&type=movie_theater&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];
      return results.map((result) => Place.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load nearby cinemas');
    }
  }
}
