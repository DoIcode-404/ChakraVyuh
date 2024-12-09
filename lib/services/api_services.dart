import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      'http://10.0.2.2:5000/'; // Adjust to your backend's URL (e.g., localhost, emulator, or device)

  Future<String> fetchDailyHoroscope(String sign) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/daily_horoscope/$sign'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['horoscope'] ?? 'No horoscope available';
      } else {
        return 'Failed to load horoscope';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
