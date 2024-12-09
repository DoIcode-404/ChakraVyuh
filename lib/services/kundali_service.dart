// import 'firestore_service.dart';
// import 'api_call_service.dart';

// Future<Map<String, dynamic>> getKundaliDetails(String userId) async {
//   try {
//     // Step 1: Fetch birth details from Firestore
//     final birthDetails = await fetchBirthDetails(userId);

//     // Step 2: Call the backend API
//     final kundali = await fetchKundali(birthDetails);

//     return kundali;
//   } catch (error) {
//     throw Exception("Error getting Kundali details: $error");
//   }
// }

import 'package:flutter/material.dart';

class KundaliProvider with ChangeNotifier {
  Map<String, dynamic>? _kundaliData;

  Map<String, dynamic>? get kundaliData => _kundaliData;

  void setKundaliData(Map<String, dynamic> data) {
    _kundaliData = data;
    notifyListeners();
  }
}
