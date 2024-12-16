import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/models/partner_details.dart';
import 'package:chakravyuh/pages/compatibility/compatibility_result.dart';
import 'package:chakravyuh/pages/features/compatibility_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/user.dart';
import '../../services/location_service.dart';
import '../../services/partner_service.dart';

class LocationCompatibility extends StatefulWidget {
  const LocationCompatibility({super.key, required this.partnerDetails});
  final PartnerDetails partnerDetails;

  @override
  State<LocationCompatibility> createState() => _LocationCompatibilityState();
}

class _LocationCompatibilityState extends State<LocationCompatibility> {
  late PartnerDetails partnerDetails;

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
    partnerDetails = widget.partnerDetails;
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

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset('assets/images/location.png', height: 200),
        const SizedBox(height: 10),
        const Text(
          'Add Your Partner Birth place',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 31,
            color: Color.fromARGB(255, 126, 172, 196),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Add your partners birth place and check whether you are destined or not!',
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
        hintText: 'Enter Your Partner Birth Place',
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
          final updatedDetails = partnerDetails.copyWith(
            latitude: latitude!,
            longitude: longitude!,
            timezone: timezone!,
          );

          // Save partner details to Firestore
          // savePartnerDetailsToFirestore(
          //   context,
          //   partnerDetails: updatedDetails,
          //   latitude: latitude!,
          //   longitude: longitude!,
          //   timezone: timezone!,
          // );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompatibilityResultPage(
                        // partnerDetails: updatedDetails,
                        result: {},
                      )));
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

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:chakravyuh/models/partner_details.dart';
// import 'package:chakravyuh/pages/features/compatibility_page.dart';
// import '../../services/location_service.dart';

// class LocationCompatibility extends StatefulWidget {
//   const LocationCompatibility({super.key, required this.partnerDetails});
//   final PartnerDetails partnerDetails;

//   @override
//   State<LocationCompatibility> createState() => _LocationCompatibilityState();
// }

// class _LocationCompatibilityState extends State<LocationCompatibility> {
//   late PartnerDetails partnerDetails;

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
//     partnerDetails = widget.partnerDetails;
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

//   // Method to make a POST request to the API
//   Future<void> _sendPartnerDetailsToApi() async {
//     if (latitude != null && longitude != null && timezone != null) {
//       final url = Uri.parse(
//           'https://your-api-endpoint.com'); // replace with your API endpoint
//       final headers = {'Content-Type': 'application/json'};

//       final body = json.encode({
//         'latitude': latitude,
//         'longitude': longitude,
//         'timezone': timezone,
//         // 'partner_name': partnerDetails.name,
//         'partner_birth_date':
//             partnerDetails.birthDate, // Add more fields as necessary
//       });

//       try {
//         final response = await http.post(url, headers: headers, body: body);

//         if (response.statusCode == 200) {
//           // Handle success
//           print('Data sent successfully!');
//         } else {
//           // Handle error
//           print('Failed to send data. Status code: ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Error making POST request: $e');
//       }
//     } else {
//       print('Invalid details provided.');
//     }
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
//                 const SizedBox(height: 30),
//                 _buildSearchField(),
//                 _buildLoadingIndicator(),
//                 _buildLocationList(),
//                 const SizedBox(height: 10),
//                 _buildSelectedLocation(),
//                 const SizedBox(height: 40),
//                 _buildNextButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       children: [
//         Image.asset('assets/images/location.png', height: 200),
//         const SizedBox(height: 10),
//         const Text(
//           'Add Your Partner Birth place',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 31,
//             color: Color.fromARGB(255, 126, 172, 196),
//           ),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           'Add your partners birth place and check whether you are destined or not!',
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
//         hintText: 'Enter Your Partner Birth Place',
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

//   Widget _buildLoadingIndicator() {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           )
//         : const SizedBox.shrink();
//   }

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

//   Widget _buildNextButton() {
//     return ElevatedButton(
//       onPressed: () {
//         if (latitude != null && longitude != null && timezone != null) {
//           // Update partner details and send to API
//           final updatedDetails = partnerDetails.copyWith(
//             latitude: latitude!,
//             longitude: longitude!,
//             timezone: timezone!,
//           );

//           // Send partner details to the API
//           _sendPartnerDetailsToApi();

//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CompatibilityPage(
//                         partnerDetails: updatedDetails,
//                       )));
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Please select a valid location')),
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 25, 57, 82),
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         minimumSize: const Size(double.infinity, 30),
//       ),
//       child: const Text(
//         'Next',
//         style: TextStyle(
//           fontFamily: 'ShantellSans',
//           fontSize: 23,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
