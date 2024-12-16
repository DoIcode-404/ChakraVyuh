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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class KundaliService {
//   Future<Map<String, dynamic>> fetchKundaliData(
//       Map<String, dynamic> birthDetails) async {
//     const String apiUrl = 'http://10.0.2.2:8000/generate_kundali';
//     // const String apiUrl = 'http://127.0.0.1:8000/generate_kundali';

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(birthDetails),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);

//       // Ensure the response contains the required data
//       if (data.containsKey('kundaliData') && data['kundaliData'] is List) {
//         return Map<String, dynamic>.from(data['kundaliData']);
//       } else {
//         throw Exception('Invalid response format: ${response.body}');
//         print(' ${response.body}');
//       }
//     } else {
//       throw Exception('Failed to generate Kundali: ${response.body}');
//       print(' ${response.body}');
//     }
//   }
// }

// Future<void> sendKundaliRequest(String userId) async {
//   // Reference to Firestore
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   try {
//     // Fetch birth details from Firestore
//     final QuerySnapshot<Map<String, dynamic>> birthDetailsSnapshot =
//         await firestore
//             .collection('users')
//             .doc(userId)
//             .collection('birthDetails')
//             .get();

//     if (birthDetailsSnapshot.docs.isNotEmpty) {
//       // Assuming there's only one document in the subcollection
//       final birthInfoDoc = birthDetailsSnapshot.docs.first;

//       // Extract birth details
//       final birthDetails = birthInfoDoc.data();

//       if (birthDetails.isNotEmpty) {
//         // Send POST request with birth details
//         KundaliService kundaliService = KundaliService();
//         Map<String, dynamic> kundaliData =
//             await kundaliService.fetchKundaliData(birthDetails);

//         print('Kundali Data: $kundaliData');
//       } else {
//         print('No birth details found in the document.');
//       }
//     } else {
//       print('No documents found in the birthDetails subcollection.');
//     }
//   } catch (e) {
//     print('Error fetching or sending data: $e');
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class KundaliService {
//   // Combined method to fetch Kundali data either from Firestore or an external API
//   Future<Map<String, dynamic>> fetchKundaliData(String userId) async {
//     const String apiUrl =
//         'http://10.0.2.2:8000/generate_kundali'; // For Android Emulator, update as needed for production.

//     try {
//       // Step 1: Fetch birth details from Firestore
//       final FirebaseFirestore firestore = FirebaseFirestore.instance;
//       final DocumentSnapshot<Map<String, dynamic>> birthDetailsSnapshot =
//           await firestore
//               .collection('users')
//               .doc(userId)
//               .collection('birthDetails')
//               .doc('birthinfo')
//               .get();

//       if (birthDetailsSnapshot.docs.isNotEmpty) {
//         final birthInfoDoc = birthDetailsSnapshot.docs.first;
//         final birthDetails = birthInfoDoc.data();

//         // Step 2: Make a POST request to the API with the birth details
//         final response = await http.post(
//           Uri.parse(apiUrl),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(birthDetails),
//         );

//         // Step 3: Handle the API response
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> data = jsonDecode(response.body);
//           if (data.containsKey('kundaliData')) {
//             return Map<String, dynamic>.from(data['kundaliData']);
//           } else {
//             throw Exception(
//                 'Missing kundaliData in response: ${response.body}');
//           }
//         } else {
//           throw Exception('Failed to generate Kundali: ${response.body}');
//         }
//       } else {
//         throw Exception('No birth details found for user $userId.');
//       }
//     } catch (e) {
//       throw Exception('Error fetching Kundali data: $e');
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class KundaliService {
//   // Combined method to fetch Kundali data either from Firestore or an external API
//   Future<Map<String, dynamic>> fetchKundaliData(String userId) async {
//     if (userId.isEmpty) {
//       throw Exception('User ID cannot be empty');
//     }

//     const String apiUrl =
//         'http://10.0.2.2:8000/generate_kundali'; // For Android Emulator, update as needed for production.

//     try {
//       // Step 1: Fetch birth details from Firestore (directly accessing 'birthinfo' document)
//       final FirebaseFirestore firestore = FirebaseFirestore.instance;
//       final DocumentSnapshot<Map<String, dynamic>> birthDetailsSnapshot =
//           await firestore
//               .collection('users')
//               .doc(userId)
//               .collection('birthDetails')
//               .doc('birthinfo') // Accessing the specific 'birthinfo' document
//               .get();

//       if (birthDetailsSnapshot.exists) {
//         final birthDetails = birthDetailsSnapshot.data();

//         // Step 2: Make a POST request to the API with the birth details
//         final response = await http.post(
//           Uri.parse(apiUrl),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(birthDetails),
//         );

//         // Step 3: Handle the API response
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> data = jsonDecode(response.body);
//           if (data.containsKey('kundaliData')) {
//             return Map<String, dynamic>.from(data['kundaliData']);
//           } else {
//             throw Exception(
//                 'Missing kundaliData in response: ${response.body}');
//           }
//         } else {
//           throw Exception('Failed to generate Kundali: ${response.body}');
//         }
//       } else {
//         throw Exception('No birth details found for user $userId.');
//       }
//     } catch (e) {
//       throw Exception('Error fetching Kundali data: $e');
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KundaliService {
  // Combined method to fetch Kundali data either from Firestore or an external API
  Future<Map<String, dynamic>> fetchKundaliData(String userId) async {
    if (userId.isEmpty) {
      // If userId is empty, retrieve the current user's ID
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not logged in.');
      }
      userId = user.uid; // Assign the authenticated user's ID
    }

    const String apiUrl =
        'http://10.0.2.2:8000/generate_kundali'; // For Android Emulator, update as needed for production.

    try {
      // Step 1: Fetch birth details from Firestore (directly accessing 'birthinfo' document)
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot<Map<String, dynamic>> birthDetailsSnapshot =
          await firestore
              .collection('users')
              .doc(userId)
              .collection('birthDetails')
              .doc('birthinfo') // Accessing the specific 'birthinfo' document
              .get();

      if (birthDetailsSnapshot.exists) {
        final birthDetails = birthDetailsSnapshot.data();
        print('Birth Details: $birthDetails');

        // Step 2: Make a POST request to the API with the birth details
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(birthDetails),
        );

        // Step 3: Handle the API response
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          if (data.containsKey('kundaliData')) {
            return Map<String, dynamic>.from(data['kundaliData']);
          } else {
            throw Exception(
                'Missing kundaliData in response: ${response.body}');
          }
        } else {
          throw Exception('Failed to generate Kundali: ${response.body}');
        }
      } else {
        throw Exception('No birth details found for user $userId.');
      }
    } catch (e) {
      throw Exception('Error fetching Kundali data: $e');
    }
  }
}

// Future<void> fetchUserKundaliData() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     String userId = user.uid; // Retrieve userId
//     try {
//       // Call the service to fetch Kundali data
//       Map<String, dynamic> kundaliData =
//           await KundaliService().fetchKundaliData(userId);

//       // You can handle the retrieved kundaliData here
//       print('Kundali Data: $kundaliData');
//       // For example, pass it to the UI or another service
//     } catch (e) {
//       // Handle errors if needed
//       print('Error fetching kundali data: $e');
//     }
//   } else {
//     throw Exception('User is not logged in');
//   }
// }
