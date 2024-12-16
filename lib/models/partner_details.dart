// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class PartnerDetails {
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final double latitude;
  final double longitude;
  final String timezone;
  PartnerDetails({
    // required this.userId,
    required this.birthDate,
    required this.birthTime,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  PartnerDetails copyWith({
    // String? userId,
    DateTime? birthDate,
    TimeOfDay? birthTime,
    double? latitude,
    double? longitude,
    String? timezone,
  }) {
    return PartnerDetails(
      // userId: userId ?? this.userId,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezone: timezone ?? this.timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'userId': userId,
      'birthDate': birthDate.toIso8601String().split('T')[0],
      'birthTime':
          '${birthTime.hour.toString().padLeft(2, '0')}:${birthTime.minute.toString().padLeft(2, '0')}',
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
    };
  }

  factory PartnerDetails.fromMap(Map<String, dynamic> map) {
    // Parse time string into TimeOfDay
    final birthTimeString = map['birthTime'] as String;
    final birthTimeParts = birthTimeString.split(':');

    if (birthTimeParts.length != 2) {
      throw FormatException('Invalid time format for birthTime');
    }

    return PartnerDetails(
      birthDate: DateTime.parse(map['birthDate'] as String), // Parse birthDate
      birthTime: TimeOfDay(
        hour: int.parse(birthTimeParts[0]),
        minute: int.parse(birthTimeParts[1]),
      ),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timezone: map['timezone'] as String,
    );
  }
}

//   String toJson() => json.encode(toMap());

//   factory PartnerDetails.fromJson(String source) => PartnerDetails.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'PartnerDetails(userId: $userId, birthDate: $birthDate, birthTime: $birthTime, latitude: $latitude, longitude: $longitude, timezone: $timezone)';
//   }

//   @override
//   bool operator ==(covariant PartnerDetails other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.userId == userId &&
//       other.birthDate == birthDate &&
//       other.birthTime == birthTime &&
//       other.latitude == latitude &&
//       other.longitude == longitude &&
//       other.timezone == timezone;
//   }

//   @override
//   int get hashCode {
//     return userId.hashCode ^
//       birthDate.hashCode ^
//       birthTime.hashCode ^
//       latitude.hashCode ^
//       longitude.hashCode ^
//       timezone.hashCode;
//   }
// }
