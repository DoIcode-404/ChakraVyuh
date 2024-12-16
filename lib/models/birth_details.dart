// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/material.dart';

// class BirthDetails {
//   final DateTime birthDate;
//   final TimeOfDay birthTime;
//   final double latitude;
//   final double longitude;
//   final String timezone;

//   BirthDetails({
//     required this.birthDate,
//     required this.birthTime,
//     required this.latitude,
//     required this.longitude,
//     required this.timezone,
//   });

//   BirthDetails copyWith({
//     DateTime? birthDate,
//     TimeOfDay? birthTime,
//     double? latitude,
//     double? longitude,
//     String? timezone,
//   }) {
//     return BirthDetails(
//       birthDate: birthDate ?? this.birthDate,
//       birthTime: birthTime ?? this.birthTime,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       timezone: timezone ?? this.timezone,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'birthDate': birthDate.toIso8601String(),
//       'birthTime':
//           '${birthTime.hour.toString().padLeft(2, '0')}:${birthTime.minute.toString().padLeft(2, '0')}',
//       'latitude': latitude,
//       'longitude': longitude,
//       'timezone': timezone,
//     };
//   }
// }

import 'package:flutter/material.dart';

class BirthDetails {
  final String userId; // Add this field
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final double latitude;
  final double longitude;
  final String timezone;

  BirthDetails({
    required this.userId, // Add this parameter
    required this.birthDate,
    required this.birthTime,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  BirthDetails copyWith({
    String? userId, // Include this in copyWith
    DateTime? birthDate,
    TimeOfDay? birthTime,
    double? latitude,
    double? longitude,
    String? timezone,
  }) {
    return BirthDetails(
      userId: userId ?? this.userId, // Update this
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezone: timezone ?? this.timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId, // Include userId
      'birthDate': birthDate.toIso8601String().split('T')[0],
      'birthTime':
          '${birthTime.hour.toString().padLeft(2, '0')}:${birthTime.minute.toString().padLeft(2, '0')}',
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
    };
  }

  factory BirthDetails.fromMap(Map<String, dynamic> map) {
    // Adding validation and error handling for missing fields
    if (map['userId'] == null ||
        map['birthDate'] == null ||
        map['birthTime'] == null) {
      throw ArgumentError('Missing required fields for BirthDetails');
    }

    final birthTimeString = map['birthTime'] as String;
    final birthTimeParts = birthTimeString.split(':');
    if (birthTimeParts.length != 2) {
      throw FormatException('Invalid time format');
    }
    return BirthDetails(
      userId: map['userId'] as String, // Parse userId
      birthDate: DateTime.parse(map['birthDate'] as String),
      birthTime: TimeOfDay(
        hour: int.parse(map['birthTime'].split(':')[0]),
        minute: int.parse(map['birthTime'].split(':')[1]),
      ),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timezone: map['timezone'] as String,
    );
  }
}
