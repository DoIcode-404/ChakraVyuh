import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/models/partner_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> savePartnerDetailsToFirestore(
  BuildContext context, {
  // required Map<String, dynamic> birthDetails,
  required PartnerDetails partnerDetails,
  required double latitude,
  required double longitude,
  required String timezone,
}) async {
  try {
    // Reference to the partnerDetails collection
    final CollectionReference partnerDetailsCollection =
        FirebaseFirestore.instance.collection('partnerDetails');

    // // Create a new document in the partnerDetails collection
    // await partnerDetailsCollection.add({
    //   'birthdate': partnerDetails.birthDate,
    //   'birthTime': partnerDetails.birthTime,
    //   'latitude': partnerDetails.latitude,
    //   'longitude': partnerDetails.longitude,
    //   'timezone': partnerDetails.timezone,
    //   // 'createdAt': FieldValue.serverTimestamp(), // Adds a timestamp
    // });
    // Serialize PartnerDetails to a map
    final partnerDetailsMap = partnerDetails.toMap();

    // Create a new document in the partnerDetails collection
    await partnerDetailsCollection.add(partnerDetailsMap);

    print('Partner details saved successfully!');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Partner details saved successfully')),
    );
  } catch (e) {
    print('Failed to save partner details: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
