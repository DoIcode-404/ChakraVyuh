// import 'package:chakravyuh/models/birth_details.dart';
// import 'package:chakravyuh/models/partner_details.dart';
// import 'package:chakravyuh/pages/compatibility/compatibility_result.dart';
// import 'package:chakravyuh/pages/compatibility/dob.dart';
// import 'package:chakravyuh/services/compatibility_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../auth/login.dart';

// class CompatibilityPage extends StatefulWidget {
//   final PartnerDetails partnerDetails;
//   const CompatibilityPage({
//     super.key,
//     required this.partnerDetails,
//     // required BirthDetails userDetails,
//   });

//   @override
//   State<CompatibilityPage> createState() => _CompatibilityPageState();
// }

// class _CompatibilityPageState extends State<CompatibilityPage> {
//   // final CompatibilityService _service = CompatibilityService();
//   late PartnerDetails partnerDetails;
//   late BirthDetails birthDetails;
//   @override
//   void initState() {
//     super.initState();

//     //Initializing the birth details object
//     partnerDetails = widget.partnerDetails;
//     birthDetails = BirthDetails(
//       birthDate: DateTime.now(),
//       birthTime: TimeOfDay(hour: 0, minute: 0),
//       latitude: 0.0,
//       longitude: 0.0,
//       timezone: '',
//       userId: '',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0A1A32),
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: Color(0xFFBCC4FF), // Light blue color
//           ),
//         ),
//         title: const Text(
//           "Test Your Compatibility",
//           style: TextStyle(
//             color: Color(0xFFBCC4FF), // Light blue color
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage(
//                 'assets/images/profile.png',
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF071223),
//               Color(0xFF071223),
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _buildTitleSection(),
//                 const SizedBox(height: 24),
//                 _buildUserCard(context),
//                 const SizedBox(height: 16),
//                 _buildConnectorIcon(),
//                 const SizedBox(height: 16),
//                 _buildPartnerCard(context),
//                 const SizedBox(height: 24),
//                 _buildCheckCompatibilityButton(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleSection() {
//     return const Center(
//       child: Column(
//         children: [
//           Text(
//             'Add your partner & Discover your astrological connection!',
//             style: TextStyle(
//               color: Color(0xFFBCC4FF), // Celestial Pink
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserCard(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 4,
//       color: const Color(0xFF142850),
//       child: const Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage:
//                   AssetImage('assets/images/profile.png'), // Placeholder image
//             ),
//             SizedBox(height: 8),
//             Text(
//               'You',
//               style: TextStyle(
//                 color: Color(0xFFBCC4FF), // Moonlight White
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConnectorIcon() {
//     return const Column(
//       children: [
//         Icon(
//           Icons.favorite,
//           color: Color(0xFFBCC4FF), // Starry Gold
//           size: 40,
//         ),
//       ],
//     );
//   }

//   Widget _buildPartnerCard(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BirthDateCompatibility(
//                       partnerDetails: partnerDetails,
//                     )));
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 4,
//         color: const Color(0xFF142850),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor:
//                     const Color(0xFF20B2AA).withOpacity(0.3), // Nebula Teal
//                 child: const Icon(
//                   Icons.add,
//                   color: Color(0xFFFFFFFF), // Moonlight White
//                   size: 40,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Add Partner',
//                 style: TextStyle(
//                   color: Color(0xFFBCC4FF), // Moonlight White
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckCompatibilityButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         try {
//           // Get the current user's ID
//           final userId = FirebaseAuth.instance.currentUser?.uid;

//           // Check if user is logged in
//           if (userId == null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('User not logged in. Please log in to proceed.'),
//               ),
//             );
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         LoginPage())); // Navigate to login page
//             return;
//           }
//           // Check if necessary details are filled
//           if (partnerDetails.birthDate == null ||
//               partnerDetails.birthDate == DateTime.now()) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                     'Incomplete details. Please fill your partner details first.'),
//               ),
//             );

//             // Redirect to a details form page or handle missing data here
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => BirthDateCompatibility(
//                         partnerDetails: partnerDetails)));
//             return;
//           }

//           // Proceed with the POST request
//           final response = await postDetails(
//             userId: userId, // Pass the retrieved userId
//             context: context,
//           );

//           // Check if the response is valid
//           if (response['status'] == 'success') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Compatibility check successful!')),
//             );

//             // Navigate to the CompatibilityResultPage
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const CompatibilityResultPage(
//                   result: {}, // Pass response data to the result page
//                 ),
//               ),
//             );
//           } else {
//             throw Exception('Failed to get a valid response.');
//           }
//         } catch (e) {
//           print('Error: $e');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('An error occurred: ${e.toString()}')),
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 25, 57, 82), // Starry Gold
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
//       ),
//       child: const Text(
//         'Check Compatibility',
//         style: TextStyle(
//           color: Color(0xFFBCC4FF), // Moonlight White
//           fontSize: 18,
//         ),
//       ),
//     );
//   }
// }

// import 'package:chakravyuh/models/birth_details.dart';
// import 'package:chakravyuh/models/partner_details.dart';
// import 'package:chakravyuh/pages/compatibility/compatibility_result.dart';
// import 'package:chakravyuh/pages/compatibility/dob.dart';
// import 'package:chakravyuh/services/compatibility_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../auth/login.dart';

// class CompatibilityPage extends StatefulWidget {
//   final PartnerDetails partnerDetails;
//   const CompatibilityPage({
//     super.key,
//     required this.partnerDetails,
//   });

//   @override
//   State<CompatibilityPage> createState() => _CompatibilityPageState();
// }

// class _CompatibilityPageState extends State<CompatibilityPage> {
//   late PartnerDetails partnerDetails;
//   late BirthDetails birthDetails;
//   final CompatibilityService _service = CompatibilityService();

//   @override
//   void initState() {
//     super.initState();
//     partnerDetails = widget.partnerDetails;
//     birthDetails = BirthDetails(
//       birthDate: DateTime.now(),
//       birthTime: TimeOfDay(hour: 0, minute: 0),
//       latitude: 0.0,
//       longitude: 0.0,
//       timezone: '',
//       userId: '',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0A1A32),
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: Color(0xFFBCC4FF), // Light blue color
//           ),
//         ),
//         title: const Text(
//           "Test Your Compatibility",
//           style: TextStyle(
//             color: Color(0xFFBCC4FF), // Light blue color
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage(
//                 'assets/images/profile.png',
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF071223),
//               Color(0xFF071223),
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _buildTitleSection(),
//                 const SizedBox(height: 24),
//                 _buildUserCard(context),
//                 const SizedBox(height: 16),
//                 _buildConnectorIcon(),
//                 const SizedBox(height: 16),
//                 _buildPartnerCard(context),
//                 const SizedBox(height: 24),
//                 _buildCheckCompatibilityButton(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleSection() {
//     return const Center(
//       child: Column(
//         children: [
//           Text(
//             'Add your partner & Discover your astrological connection!',
//             style: TextStyle(
//               color: Color(0xFFBCC4FF), // Celestial Pink
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserCard(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 4,
//       color: const Color(0xFF142850),
//       child: const Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage:
//                   AssetImage('assets/images/profile.png'), // Placeholder image
//             ),
//             SizedBox(height: 8),
//             Text(
//               'You',
//               style: TextStyle(
//                 color: Color(0xFFBCC4FF), // Moonlight White
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConnectorIcon() {
//     return const Column(
//       children: [
//         Icon(
//           Icons.favorite,
//           color: Color(0xFFBCC4FF), // Starry Gold
//           size: 40,
//         ),
//       ],
//     );
//   }

//   Widget _buildPartnerCard(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BirthDateCompatibility(
//                       partnerDetails: partnerDetails,
//                     )));
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 4,
//         color: const Color(0xFF142850),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor:
//                     const Color(0xFF20B2AA).withOpacity(0.3), // Nebula Teal
//                 child: const Icon(
//                   Icons.add,
//                   color: Color(0xFFFFFFFF), // Moonlight White
//                   size: 40,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Add Partner',
//                 style: TextStyle(
//                   color: Color(0xFFBCC4FF), // Moonlight White
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckCompatibilityButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         try {
//           // Get the current user's ID
//           final userId = FirebaseAuth.instance.currentUser?.uid;

//           // Check if user is logged in
//           if (userId == null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('User not logged in. Please log in to proceed.'),
//               ),
//             );
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         LoginPage())); // Navigate to login page
//             return;
//           }

//           // Check if necessary details are filled
//           if (partnerDetails.birthDate == null ||
//               partnerDetails.birthDate == DateTime.now()) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                     'Incomplete details. Please fill your partner details first.'),
//               ),
//             );

//             // Redirect to a details form page or handle missing data here
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => BirthDateCompatibility(
//                         partnerDetails: partnerDetails)));
//             return;
//           }

//           // Proceed with the POST request
//           final response = await _service.postDetails(
//             userId: userId, // Pass the retrieved userId
//             context: context,
//           );

//           // Check if the response is valid
//           if (response.isNotEmpty && response['status'] == 'success') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Compatibility check successful!')),
//             );

//             // Navigate to the CompatibilityResultPage with the response data
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CompatibilityResultPage(
//                   result: response, // Pass the response data to the result page
//                 ),
//               ),
//             );
//           } else {
//             throw Exception('Failed to get a valid response.');
//           }
//         } catch (e) {
//           print('Error: $e');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('An error occurred: ${e.toString()}')),
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 25, 57, 82), // Starry Gold
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
//       ),
//       child: const Text(
//         'Check Compatibility',
//         style: TextStyle(
//           color: Color(0xFFBCC4FF), // Moonlight White
//           fontSize: 18,
//         ),
//       ),
//     );
//   }
// }

// Widget _buildCheckCompatibilityButton(BuildContext context) {
// return ElevatedButton(
//   onPressed: () async {
//     try {
//       // Get the current user's ID
//       final userId = FirebaseAuth.instance.currentUser?.uid;

//       // Check if user is logged in
//       if (userId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('User not logged in. Please log in to proceed.'),
//           ),
//         );
//         await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     LoginPage())); // Navigate to login page
//         return;
//       }

//       // Check if necessary details are filled
//       if (partnerDetails.birthDate == null ||
//           partnerDetails.birthDate == DateTime.now()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//                 'Incomplete details. Please fill your partner details first.'),
//           ),
//         );

//         // Redirect to a details form page or handle missing data here
//         await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BirthDateCompatibility(
//                     partnerDetails: partnerDetails)));
//         return;
//       }

//       // Proceed with the POST request
//       final response = await _service.postDetails(
//         userId: userId, // Pass the retrieved userId
//         context: context,
//       );

//       // Check if the response is valid
//       if (response['status'] == 'success') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Compatibility check successful!')),
//         );

//         // Navigate to the CompatibilityResultPage
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CompatibilityResultPage(
//               result: response, // Pass the API response data
//             ),
//           ),
//         );
//       } else {
//         throw Exception('Failed to get a valid response.');
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: ${e.toString()}')),
//       );
//     }
//   },
//   style: ElevatedButton.styleFrom(
//     backgroundColor: const Color.fromARGB(255, 25, 57, 82), // Starry Gold
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20.0),
//     ),
//     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
//   ),
//   child: const Text(
//     'Check Compatibility',
//     style: TextStyle(
//       color: Color(0xFFBCC4FF), // Moonlight White
//       fontSize: 18,
//     ),
//   ),
// );

import 'package:chakravyuh/models/partner_details.dart';
import 'package:chakravyuh/pages/compatibility/compatibility_result.dart';
import 'package:chakravyuh/pages/compatibility/dob.dart';
import 'package:chakravyuh/services/compatibility_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';

class CompatibilityPage extends StatefulWidget {
  final PartnerDetails partnerDetails;
  const CompatibilityPage({
    super.key,
    required this.partnerDetails,
  });

  @override
  State<CompatibilityPage> createState() => _CompatibilityPageState();
}

class _CompatibilityPageState extends State<CompatibilityPage> {
  late PartnerDetails partnerDetails;
  final CompatibilityService _service = CompatibilityService();

  @override
  void initState() {
    super.initState();
    partnerDetails = widget.partnerDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1A32),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFFBCC4FF),
          ),
        ),
        title: const Text(
          "Test Your Compatibility",
          style: TextStyle(
            color: Color(0xFFBCC4FF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF071223),
              Color(0xFF071223),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitleSection(),
                const SizedBox(height: 24),
                _buildUserCard(),
                const SizedBox(height: 16),
                _buildConnectorIcon(),
                const SizedBox(height: 16),
                _buildPartnerCard(context),
                const SizedBox(height: 24),
                _buildCheckCompatibilityButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return const Center(
      child: Text(
        'Add your partner & Discover your astrological connection!',
        style: TextStyle(
          color: Color(0xFFBCC4FF),
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: const Color(0xFF142850),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 8),
            Text(
              'You',
              style: TextStyle(
                color: Color(0xFFBCC4FF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectorIcon() {
    return const Icon(
      Icons.favorite,
      color: Color(0xFFBCC4FF),
      size: 40,
    );
  }

  Widget _buildPartnerCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BirthDateCompatibility(
              partnerDetails: partnerDetails,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        color: const Color(0xFF142850),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFF20B2AA).withOpacity(0.3),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFFFFFFF),
                  size: 40,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add Partner',
                style: TextStyle(
                  color: Color(0xFFBCC4FF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckCompatibilityButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please log in to proceed.')),
            );
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
            return;
          }

          if (partnerDetails.birthDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Please add partner details first.')),
            );
            return;
          }

          final response = await _service.postDetails(
            userId: userId,
            context: context,
            partnerDetails: {},
          );

          if (response['status'] == 'success') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompatibilityResultPage(
                  result: {},
                  // partnerDetails: partnerDetails,
                ),
              ),
            );
          } else {
            throw Exception('Compatibility check failed.');
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 25, 57, 82),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
      ),
      child: const Text(
        'Check Compatibility',
        style: TextStyle(
          color: Color(0xFFBCC4FF),
          fontSize: 18,
        ),
      ),
    );
  }
}
