import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompatibilityService {
  Future<Map<String, dynamic>> postDetails({
    required String userId,
    required Map<String, dynamic> partnerDetails,
    required BuildContext context,
  }) async {
    try {
      // Validate partner details
      if (partnerDetails['birthDate'] == null ||
          partnerDetails['birthTime'] == null ||
          partnerDetails['latitude'] == null ||
          partnerDetails['longitude'] == null ||
          partnerDetails['timezone'] == null) {
        throw Exception('Partner details are incomplete or invalid.');
      }
      // Fetch person1 details
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot<Map<String, dynamic>> person1Doc = await firestore
          .collection('users')
          .doc(userId)
          .collection('birthDetails')
          .doc('birthinfo')
          .get();

      if (!person1Doc.exists) {
        throw Exception('User birth details not found.');
      }

      final person1Data = person1Doc.data()!;
      final person1 = {
        'birthDate': person1Data['birthDate'].toString(),
        'birthTime': person1Data['birthTime'].toString(),
        'latitude': person1Data['latitude'],
        'longitude': person1Data['longitude'],
        'timezone': person1Data['timezone'],
      };
      print(person1);

      final person2 = {
        'birthDate': partnerDetails['birthDate'].toString(),
        'birthTime': partnerDetails['birthTime'].toString(),
        'latitude': partnerDetails['latitude'],
        'longitude': partnerDetails['longitude'],
        'timezone': partnerDetails['timezone'],
      };
      print(person2);

      // Build request payload
      final requestBody = {'person1': person1, 'person2': person2};
      print('Request Body: ${jsonEncode(requestBody)}');

      // Make POST request
      final url = Uri.parse('http://10.0.2.2:8001/guna_milan');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Check response
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
      return {};
    }
  }
}
