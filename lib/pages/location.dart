// // import 'dart:ffi';

// import 'package:chakravyuh/models/user.dart';
// import 'package:chakravyuh/pages/login.dart';
// import 'package:chakravyuh/pages/user_profile.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../services/location_service.dart';
// import '../models/birth_details.dart';

// class LocationPage extends StatefulWidget {
//   final BirthDetails birthDetails;

//   LocationPage({required this.birthDetails});

//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   late BirthDetails birthDetails;
//   late FirebaseUser userDetails;

//   final userId = FirebaseAuth.instance.currentUser?.uid;

//   final TextEditingController _latitudeController = TextEditingController();
//   final TextEditingController _longitudeController = TextEditingController();
//   final TextEditingController _timezoneController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   String searchQuery = '';
//   String selectedLocation = '';
//   List<Map<String, dynamic>> locations = [];
//   bool isLoading = false;
//   double? latitude;
//   double? longitude;
//   String? timezone;

//   @override
//   void dispose() {
//     _locationController.dispose();
//     _latitudeController.dispose();
//     _longitudeController.dispose();
//     _timezoneController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Copy the received birthDetails to update later
//     birthDetails = widget.birthDetails;
//   }

//   /// Search logic for fetching location results based on user query.
//   void _searchLocation(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         locations = [];
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final results = await LocationService.fetchLocations(query);
//       setState(() {
//         locations = results;
//       });
//     } catch (e) {
//       print('Error fetching locations: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   /// Fetches location details like latitude, longitude, and timezone.
//   Future<void> _fetchDetails(String location, double lat, double lng) async {
//     try {
//       setState(() {
//         selectedLocation = location;
//         latitude = lat;
//         longitude = lng;
//         locations = [];
//         _locationController.text = location;
//       });

//       final tz = await LocationService.fetchTimeZone(lat, lng);

//       setState(() {
//         timezone = tz;
//       });
//     } catch (e) {
//       print('Error fetching location details: $e');
//     }
//   }

//   /// Resets the location details and clears the search query.
//   void _resetLocation() {
//     setState(() {
//       selectedLocation = '';
//       latitude = null;
//       longitude = null;
//       timezone = null;
//       searchQuery = '';
//       locations = [];
//       _locationController.text = '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Enter Your Location"),
//         backgroundColor: const Color(0xFF071223),
//         foregroundColor: Colors.white,
//       ),
//       body: _buildBody(),
//     );
//   }

//   /// Main widget for constructing the body of the screen.
//   Widget _buildBody() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(
//           colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//           center: Alignment.center,
//           radius: 0.5,
//         ),
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 _buildSearchField(),
//                 _buildLoadingIndicator(),
//                 _buildLocationList(),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 _buildSelectedLocation(),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 _buildNextButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds the header with title and description.
//   Widget _buildHeader() {
//     return Column(
//       children: [
//         Image.asset('assets/images/location.png', height: 200),
//         const SizedBox(height: 10),
//         const Text(
//           'Where Are You From?',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 31,
//             color: Color.fromARGB(255, 126, 172, 196),
//           ),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           'Discover insights based on your location by selecting your district.',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   /// Builds the search field for location input.
//   Widget _buildSearchField() {
//     return TextField(
//       controller: _locationController,
//       onChanged: (value) {
//         setState(() {
//           searchQuery = value;
//         });
//         _searchLocation(value);
//       },
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.2),
//         hintText: 'Enter Your Birth Place',
//         hintStyle: const TextStyle(color: Colors.white70),
//         prefixIcon: const Icon(Icons.search, color: Colors.white),
//         suffixIcon: IconButton(
//           onPressed: _resetLocation,
//           icon: const Icon(Icons.clear, color: Colors.white),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   /// Displays loading indicator while fetching location data.
//   Widget _buildLoadingIndicator() {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           )
//         : const SizedBox.shrink();
//   }

//   /// Displays a list of location suggestions.
//   Widget _buildLocationList() {
//     return !isLoading && locations.isNotEmpty
//         ? ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: locations.length,
//             itemBuilder: (context, index) {
//               final location = locations[index];
//               return ListTile(
//                 title: Text(
//                   location['display_name'],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 onTap: () {
//                   _fetchDetails(
//                     location['display_name'],
//                     location['latitude'],
//                     location['longitude'],
//                   );
//                 },
//               );
//             },
//           )
//         : const SizedBox.shrink();
//   }

//   /// Displays selected location details after user selects a location.
//   Widget _buildSelectedLocation() {
//     if (latitude != null && longitude != null && timezone != null) {
//       _latitudeController.text =
//           latitude!.toStringAsFixed(6); // Convert to string
//       _longitudeController.text =
//           longitude!.toStringAsFixed(6); // Convert to string
//       _timezoneController.text = timezone!; // Timezone is already a string
//     }
//     return selectedLocation.isNotEmpty
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               Text(
//                 'Selected Location: $selectedLocation',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Display Latitude
//               if (latitude != null)
//                 Text(
//                   'Latitude: ${_latitudeController.text}',
//                   style: const TextStyle(color: Colors.white),
//                 ),

//               // Display Longitude
//               if (longitude != null)
//                 Text(
//                   'Longitude: ${_longitudeController.text}',
//                   style: const TextStyle(color: Colors.white),
//                 ),

//               // Display Timezone
//               if (timezone != null)
//                 Text(
//                   'Timezone: ${_timezoneController.text}',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//             ],
//           )
//         : const SizedBox.shrink();
//   }

//   /// Builds the next button to proceed to the next step.
//   Widget _buildNextButton() {
//     return ElevatedButton(
//       onPressed: selectedLocation.isNotEmpty
//           ? () {
//               final updatedDetails = birthDetails.copyWith(
//                   latitude: latitude,
//                   longitude: longitude,
//                   timezone: _timezoneController.text);
//               saveToFirestore(updatedDetails);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginPage()),
//               );
//               print('Selected Location: $selectedLocation');
//               print('Coordinates: $latitude, $longitude');
//               print('Timezone: $timezone');
//             }
//           : null,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 25, 57, 82), // Button color
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         minimumSize: const Size(double.infinity, 30),
//       ),
//       child: const Text(
//         'Next',
//         style: TextStyle(
//             color: Colors.white, fontSize: 23, fontFamily: 'ShantellSans'),
//       ),
//     );
//   }

//   void saveToFirestore(BirthDetails updatedDetails) async {
//     final user = FirebaseAuth.instance.currentUser;

//     // Check if the user is logged in
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('User is not logged in. Please log in to continue.')),
//       );
//       // Optionally navigate to login page if the user is not logged in
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//       return; // Stop further execution
//     }

//     final userDocRef =
//         FirebaseFirestore.instance.collection('users').doc(user.uid);
//     try {
//       await userDocRef.set({
//         'userId': user.uid,
//         'name': userDetails.name,
//         'email': userDetails.email,
//         'gender': userDetails.gender,
//       }, SetOptions(merge: true));

//       await userDocRef
//           .collection('birthDetails')
//           .doc('birthinfo')
//           .set(updatedDetails.toMap(), SetOptions(merge: true));
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Birth details saved successfully')),
//       );
//       // Redirect to the user dashboard
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const UserProfile()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error while saving your birth details')),
//       );
//     }

//     // try {
//     //   await FirebaseFirestore.instance
//     //       .collection('users')
//     //       .doc(userId)
//     //       .collection('birthDetails')
//     //       .add(updatedDetails.toMap());
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(content: Text('Birth details saved successfully')),
//     //   );
//     // } catch (e) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(content: Text('Error while saving your birth details')),
//     //   );
//     // }
//   }
// }

// lib/pages/location.dart

import 'package:flutter/material.dart';
import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/services/location_service.dart';
import 'package:chakravyuh/services/user_service.dart'; // Import the UserService
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'signup.dart'; // Import LoginPage
import 'user_profile.dart'; // Import UserProfile

class LocationPage extends StatefulWidget {
  final BirthDetails birthDetails;

  LocationPage({required this.birthDetails});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late BirthDetails birthDetails;
  late FirebaseUser userDetails;

  final userId = FirebaseAuth.instance.currentUser?.uid;

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _timezoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String searchQuery = '';
  String selectedLocation = '';
  List<Map<String, dynamic>> locations = [];
  bool isLoading = false;
  double? latitude;
  double? longitude;
  String? timezone;

  final userService = UserService(); // Initialize the UserService

  @override
  void dispose() {
    _locationController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _timezoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Copy the received birthDetails to update later
    birthDetails = widget.birthDetails;
  }

  /// Search logic for fetching location results based on user query.
  void _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        locations = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final results = await LocationService.fetchLocations(query);
      setState(() {
        locations = results;
      });
    } catch (e) {
      print('Error fetching locations: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Fetches location details like latitude, longitude, and timezone.
  Future<void> _fetchDetails(String location, double lat, double lng) async {
    try {
      setState(() {
        selectedLocation = location;
        latitude = lat;
        longitude = lng;
        locations = [];
        _locationController.text = location;
      });

      final tz = await LocationService.fetchTimeZone(lat, lng);

      setState(() {
        timezone = tz;
      });
    } catch (e) {
      print('Error fetching location details: $e');
    }
  }

  /// Resets the location details and clears the search query.
  void _resetLocation() {
    setState(() {
      selectedLocation = '';
      latitude = null;
      longitude = null;
      timezone = null;
      searchQuery = '';
      locations = [];
      _locationController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Location"),
        backgroundColor: const Color(0xFF071223),
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  /// Main widget for constructing the body of the screen.
  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
          center: Alignment.center,
          radius: 0.5,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(
                  height: 30,
                ),
                _buildSearchField(),
                _buildLoadingIndicator(),
                _buildLocationList(),
                const SizedBox(
                  height: 10,
                ),
                _buildSelectedLocation(),
                const SizedBox(
                  height: 40,
                ),
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header with title and description.
  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset('assets/images/location.png', height: 200),
        const SizedBox(height: 10),
        const Text(
          'Where Are You From?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 31,
            color: Color.fromARGB(255, 126, 172, 196),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Discover insights based on your location by selecting your district.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Builds the search field for location input.
  Widget _buildSearchField() {
    return TextField(
      controller: _locationController,
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
        _searchLocation(value);
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        hintText: 'Enter Your Birth Place',
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: _resetLocation,
          icon: const Icon(Icons.clear, color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Displays loading indicator while fetching location data.
  Widget _buildLoadingIndicator() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : const SizedBox.shrink();
  }

  /// Displays a list of location suggestions.
  Widget _buildLocationList() {
    return !isLoading && locations.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                title: Text(
                  location['display_name'],
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _fetchDetails(
                    location['display_name'],
                    location['latitude'],
                    location['longitude'],
                  );
                },
              );
            },
          )
        : const SizedBox.shrink();
  }

  /// Displays the selected location details.
  Widget _buildSelectedLocation() {
    if (latitude != null && longitude != null && timezone != null) {
      _latitudeController.text =
          latitude!.toStringAsFixed(6); // Convert to string
      _longitudeController.text =
          longitude!.toStringAsFixed(6); // Convert to string
      _timezoneController.text = timezone!; // Timezone is already a string
    }
    return selectedLocation.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Selected Location: $selectedLocation',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),

              // Display Latitude
              if (latitude != null)
                Text(
                  'Latitude: ${_latitudeController.text}',
                  style: const TextStyle(color: Colors.white),
                ),

              // Display Longitude
              if (longitude != null)
                Text(
                  'Longitude: ${_longitudeController.text}',
                  style: const TextStyle(color: Colors.white),
                ),

              // Display Timezone
              if (timezone != null)
                Text(
                  'Timezone: ${_timezoneController.text}',
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          )
        : const SizedBox.shrink();
  }

  /// Builds the next button.
  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (latitude != null && longitude != null && timezone != null) {
          // Update birth details and call save function
          final updatedDetails = birthDetails.copyWith(
            latitude: latitude!,
            longitude: longitude!,
            timezone: timezone!,
          );
          // Check if user is authenticated
          final user = FirebaseAuth.instance.currentUser;

          if (user == null) {
            // Redirect to signup page if not authenticated
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Signup(
                  updatedDetails: updatedDetails,
                ),
              ),
            );
          } else {
            // Save directly if authenticated
            userService.saveToFirestore(
              updatedDetails,
              context,
              name: '',
              gender: '',
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a valid location')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 25, 57, 82), // Button color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size(double.infinity, 30),
      ),
      child: const Text(
        'Next',
        style: TextStyle(
          fontFamily: 'ShantellSans',
          fontSize: 23,
          color: Colors.white,
        ),
      ),
    );
  }
}
