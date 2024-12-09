// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<Map<String, dynamic>> fetchKundali(
//     Map<String, dynamic> birthDetails) async {
//   final url = Uri.parse('http://10.0.2.2:8000/generate_kundali');

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(birthDetails),
//   );

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception("Failed to fetch Kundali: ${response.body}");
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../models/birth_details.dart';

// Future<Map<String, dynamic>> fetchKundaliData(BirthDetails birthDetails) async {
//   final String apiUrl = 'http://10.0.2.2:8000/generate_kundali';

//   // Prepare the body of the request with birth details
//   final Map<String, dynamic> requestBody = {
//     'dob': birthDetails.birthDate.toString(), // Example: '2003-05-11'
//     'birthTime':
//         '${birthDetails.birthTime.hour}:${birthDetails.birthTime.minute}', // Example: '12:30'

//     'latitude': birthDetails.latitude,
//     'longitude': birthDetails.longitude,
//     'timezone': birthDetails.timezone
//   };

//   try {
//     // Make the HTTP POST request to your backend
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(requestBody),
//     );

//     // Check for a successful response
//     if (response.statusCode == 200) {
//       // Parse and return the Kundali data from the response
//       final Map<String, dynamic> kundaliData = json.decode(response.body);
//       return kundaliData; // Returning the Kundali data
//     } else {
//       throw Exception('Failed to generate Kundali');
//     }
//   } catch (e) {
//     throw Exception('Error fetching Kundali data: $e');
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';

class KundaliService {
  Future<List<String>> fetchKundaliData(
      Map<String, dynamic> birthDetails) async {
    const String apiUrl = 'http://10.0.2.2:8000/generate_kundali';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(birthDetails),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Ensure the response contains the required data
      if (data.containsKey('kundaliData') && data['kundaliData'] is List) {
        return List<String>.from(data['kundaliData']);
      } else {
        throw Exception('Invalid response format: ${response.body}');
      }
    } else {
      throw Exception('Failed to generate Kundali: ${response.body}');
    }
  }
}
