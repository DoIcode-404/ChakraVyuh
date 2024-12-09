// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class FirebaseUser {
//   final String userId; // Add this field
//   final String email;
//   final String name;
//   final String? gender;

//   const FirebaseUser({
//     required this.userId, // Add this parameter
//     required this.email,
//     required this.name,
//     this.gender,
//   });

//   FirebaseUser copyWith({
//     String? userId, // Include this in copyWith
//     String? email,
//     String? name,
//     String? gender,
//   }) {
//     return FirebaseUser(
//       userId: userId ?? this.userId, // Update this
//       email: email ?? this.email,
//       name: name ?? this.name,
//       gender: gender ?? this.gender,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'userId': userId, // Include userId
//       'email': email,
//       'name': name,
//       'gender': gender,
//     };
//   }

//   factory FirebaseUser.fromMap(Map<String, dynamic> map) {
//     return FirebaseUser(
//       userId: map['userId'] as String, // Parse userId
//       email: map['email'] as String,
//       name: map['name'] as String,
//       gender: map['gender'] as String?,
//     );
//   }
// }

//   // String toJson() => json.encode(toMap());

//   // factory FirebaseUser.fromJson(String source) =>
//   //     FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

//   // @override
//   // String toString() =>
//   //     'FirebaseUser(email: $email, name: $name, gender: $gender)';

//   // @override
//   // bool operator ==(covariant FirebaseUser other) {
//   //   if (identical(this, other)) return true;

//   //   return other.email == email && other.name == name && other.gender == gender;
//   // }

// //   @override
// //   int get hashCode => email.hashCode ^ name.hashCode ^ gender.hashCode;
// // }

// ignore_for_file: public_member_api_docs, sort_constructors_first

class FirebaseUser {
  final String userId; // Add this field
  final String email;
  final String name;
  final String? gender;

  const FirebaseUser({
    required this.userId, // Add this parameter
    required this.email,
    required this.name,
    this.gender,
  });

  // Getter for displayName
  String get displayName => name;

  FirebaseUser copyWith({
    String? userId, // Include this in copyWith
    String? email,
    String? name,
    String? gender,
  }) {
    return FirebaseUser(
      userId: userId ?? this.userId, // Update this
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId, // Include userId
      'email': email,
      'name': name,
      'gender': gender,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      userId: map['userId'] as String, // Parse userId
      email: map['email'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String?,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory FirebaseUser.fromJson(String source) =>
  //     FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() =>
  //     'FirebaseUser(email: $email, name: $name, gender: $gender)';

  // @override
  // bool operator ==(covariant FirebaseUser other) {
  //   if (identical(this, other)) return true;

  //   return other.email == email && other.name == name && other.gender == gender;
  // }

  // @override
  // int get hashCode => email.hashCode ^ name.hashCode ^ gender.hashCode;
}
