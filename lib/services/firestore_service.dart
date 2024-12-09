import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getBirthDetails(String userId) async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('birthDetails')
      .doc('birthinfo')
      .get();

  if (docSnapshot.exists) {
    return docSnapshot.data()!;
  } else {
    throw Exception('BirthDetails not found');
  }
}
