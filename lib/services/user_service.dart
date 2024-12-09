// lib/services/user_service.dart

import 'package:chakravyuh/pages/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chakravyuh/models/user.dart';
import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/pages/login.dart';
import 'package:chakravyuh/pages/user_profile.dart';

class UserService {
  Future<void> saveToFirestore(
    BirthDetails updatedDetails,
    BuildContext context, {
    required String name,
    required String gender,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is not authenticated, handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User is not logged in. Please log in to continue.')),
      );
      return;
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    try {
      // Save user details to Firestore
      await userDocRef.set({
        'userId': user.uid,
        'name': name.isNotEmpty ? name : user.displayName ?? 'Unknown',
        'email': user.email ?? '',
        'gender': gender.isNotEmpty ? gender : 'Not specified',
      }, SetOptions(merge: true));

      // Save birth details under a sub-collection
      await userDocRef
          .collection('birthDetails')
          .doc('birthinfo')
          .set(updatedDetails.toMap(), SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Birth details saved successfully')),
      );

      // Redirect to the main navigation page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Method to save birth details to Firestore
  // Future<void> saveToFirestore(
  //   BirthDetails updatedDetails,
  //   BuildContext context, {
  //   required String name,
  //   required String gender,
  // }) async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user == null) {
  //     // Show snackbar and redirect to login if the user is not logged in
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text('User is not logged in. Please log in to continue.')),
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginPage()),
  //     );
  //     return;
  //   } else {
  //     print('Authenticated user UID: ${user.uid}');
  //   }

  //   final userDocRef =
  //       FirebaseFirestore.instance.collection('users').doc(user.uid);

  //   try {
  //     // Save user data to Firestore
  //     await userDocRef.set({
  //       'userId': user.uid,
  //       'name': name.isNotEmpty ? name : user.displayName ?? 'Unknown',
  //       'email': user.email ?? '',
  //       'gender': gender.isNotEmpty ? gender : 'Not specified',
  //     }, SetOptions(merge: true));

  //     // Save birth details
  //     await userDocRef
  //         .collection('birthDetails')
  //         .doc('birthinfo')
  //         .set(updatedDetails.toMap(), SetOptions(merge: true));

  //     // Show success snackbar and navigate to the user profile
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Birth details saved successfully')),
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Navigation()),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Error while saving your birth details')),
  //     );
  //   }
  // }

  // Method to handle success after login
  void onLoginSuccess(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }
}
