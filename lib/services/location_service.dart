import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';

  /// Fetches locations based on a search query.
  static Future<List<Map<String, dynamic>>> fetchLocations(String query) async {
    if (query.isEmpty) return [];

    final url =
        Uri.parse('$_baseUrl/search?q=$query&countrycodes=np&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map<Map<String, dynamic>>((place) {
        return {
          'display_name': place['display_name'], // Full place name
          'latitude': double.parse(place['lat']), // Latitude
          'longitude': double.parse(place['lon']), // Longitude
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch locations');
    }
  }

  /// Returns a default timezone for Nepal (Asia/Kathmandu).
  static Future<String> fetchTimeZone(double latitude, double longitude) async {
    // You can replace this logic with a dynamic timezone API if needed.
    return 'Asia/Kathmandu';
  }
}
