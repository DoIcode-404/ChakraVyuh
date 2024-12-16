// import 'package:flutter/material.dart';

// import '../../services/api_call_service.dart';

// class HoroscopePage extends StatefulWidget {
//   final String userId;
//   HoroscopePage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<HoroscopePage> createState() => _HoroscopePageState();
// }

// class _HoroscopePageState extends State<HoroscopePage> {
//   late Future<Map<String, dynamic>> kundaliFuture;
//   String selectedSign = "Aries";
//   String horoscope = "Today's horoscope will appear here!";

//   final List<Map<String, String>> zodiacSigns = [
//     {'name': 'Aries', 'image': 'assets/images/aeris.jpg'},
//     {'name': 'Taurus', 'image': 'assets/images/taurus.jpg'},
//     {'name': 'Gemini', 'image': 'assets/images/gemini.jpg'},
//     {'name': 'Cancer', 'image': 'assets/images/cancer.jpg'},
//     {'name': 'Leo', 'image': 'assets/images/leo.jpg'},
//     {'name': 'Virgo', 'image': 'assets/images/virgo.jpg'},
//     {'name': 'Libra', 'image': 'assets/images/libra.jpg'},
//     {'name': 'Scorpio', 'image': 'assets/images/scorpio.jpg'},
//     {'name': 'Sagittarius', 'image': 'assets/images/sagittarius.jpg'},
//     {'name': 'Capricorn', 'image': 'assets/images/capricon.jpg'},
//     {'name': 'Aquarius', 'image': 'assets/images/Aquarius.jpg'},
//     {'name': 'Pisces', 'image': 'assets/images/Pisces.jpg'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     kundaliFuture = KundaliService().fetchKundaliData(
//       widget.userId,
//     );
//   }

//   // This function is responsible for dynamically updating horoscope data based on selected zodiac sign.
//   Future<void> updateHoroscope(String zodiacSign) async {
//     setState(() {
//       selectedSign = zodiacSign;
//     });

//     // Update the horoscope based on the selected sign.
//     final newHoroscope = await KundaliService().fetchKundaliData(
//       widget.userId,
//     );
//     setState(() {
//       horoscope = newHoroscope as String;
//     });
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
//             color: Color(0xFFBCC4FF),
//           ),
//         ),
//         title: const Text(
//           "Your Horoscope",
//           style: TextStyle(
//             color: Color(0xFFBCC4FF),
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage('assets/images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: kundaliFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CircularProgressIndicator(color: Color(0xFFBCC4FF)));
//           } else if (snapshot.hasError) {
//             return Text("Error: ${snapshot.error}",
//                 style: const TextStyle(color: Colors.red));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//                 child: Text("No data available.",
//                     style: TextStyle(color: Colors.white)));
//           }

//           final kundaliData = snapshot.data!;
//           final horoscopeData =
//               kundaliData['horoscope'] as Map<String, dynamic>;

//           return Container(
//             decoration: const BoxDecoration(
//               gradient: RadialGradient(
//                 colors: [Color.fromARGB(255, 4, 41, 68), Color(0xFF071223)],
//                 stops: [0.0, 1.0],
//                 center: Alignment.center,
//                 radius: 0.3,
//               ),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 70),
//                 SizedBox(
//                   height: 130,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: zodiacSigns.length,
//                     itemBuilder: (context, index) {
//                       final sign = zodiacSigns[index];
//                       return GestureDetector(
//                         onTap: () {
//                           updateHoroscope(sign[
//                               'name']!); // Update horoscope based on selected sign.
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               height: 90,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   image: AssetImage(sign['image']!),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               sign['name']!,
//                               style: const TextStyle(
//                                 fontFamily: 'ShantellSans',
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 25, 57, 82),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                     child: Text(
//                       horoscopeData[
//                           'description'], // Display the horoscope description here.
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontFamily: 'ShantellSans',
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../services/api_call_service.dart';

// class HoroscopePage extends StatefulWidget {
//   final String userId;
//   HoroscopePage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<HoroscopePage> createState() => _HoroscopePageState();
// }

// class _HoroscopePageState extends State<HoroscopePage> {
//   late Future<Map<String, dynamic>> kundaliFuture;
//   @override
//   void initState() {
//     super.initState();
//     kundaliFuture = KundaliService().fetchKundaliData(
//       widget.userId,
//     );
//   }

//   String selectedSign = "Aries";
//   String horoscope = "Today's horoscope will appear here!";

//   final List<Map<String, String>> zodiacSigns = [
//     {'name': 'Aries', 'image': 'assets/images/aeris.jpg'},
//     {'name': 'Taurus', 'image': 'assets/images/taurus.jpg'},
//     {'name': 'Gemini', 'image': 'assets/images/gemini.jpg'},
//     {'name': 'Cancer', 'image': 'assets/images/cancer.jpg'},
//     {'name': 'Leo', 'image': 'assets/images/leo.jpg'},
//     {'name': 'Virgo', 'image': 'assets/images/virgo.jpg'},
//     {'name': 'Libra', 'image': 'assets/images/libra.jpg'},
//     {'name': 'Scorpio', 'image': 'assets/images/scorpio.jpg'},
//     {'name': 'Sagittarius', 'image': 'assets/images/sagittarius.jpg'},
//     {'name': 'Capricorn', 'image': 'assets/images/capricon.jpg'},
//     {'name': 'Aquarius', 'image': 'assets/images/Aquarius.jpg'},
//     {'name': 'Pisces', 'image': 'assets/images/Pisces.jpg'},
//   ];

//   // This function is responsible for dynamically updating horoscope data based on selected zodiac sign.
//   Future<void> updateHoroscope(String zodiacSign) async {
//     setState(() {
//       selectedSign = zodiacSign;
//     });

//     // Update the horoscope based on the selected sign.
//     final newHoroscope = await KundaliService().fetchKundaliData(
//       widget.userId,
//     );

//     // Assuming the horoscope data includes 'description' field for each zodiac sign
//     setState(() {
//       horoscope = newHoroscope['horoscope'][selectedSign]['description'] ??
//           "Horoscope data not available";
//     });
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
//             color: Color(0xFFBCC4FF),
//           ),
//         ),
//         title: const Text(
//           "Your Horoscope",
//           style: TextStyle(
//             color: Color(0xFFBCC4FF),
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage('assets/images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: kundaliFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CircularProgressIndicator(color: Color(0xFFBCC4FF)));
//           } else if (snapshot.hasError) {
//             return Text("Error: ${snapshot.error}",
//                 style: const TextStyle(color: Colors.red));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//                 child: Text("No data available.",
//                     style: TextStyle(color: Colors.white)));
//           }

//           final kundaliData = snapshot.data!;
//           final horoscopeData =
//               kundaliData['horoscope'] as Map<String, dynamic>;

//           return Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF071223), Color(0xFF071223)],
//                 stops: [0.0, 1.0],
//               ),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 70),
//                 SizedBox(
//                   height: 130,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: zodiacSigns.length,
//                     itemBuilder: (context, index) {
//                       final sign = zodiacSigns[index];
//                       return GestureDetector(
//                         onTap: () {
//                           updateHoroscope(sign[
//                               'name']!); // Update horoscope based on selected sign.
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               height: 90,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   image: AssetImage(sign['image']!),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               sign['name']!,
//                               style: const TextStyle(
//                                 fontFamily: 'ShantellSans',
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 25, 57, 82),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                     child: Text(
//                       horoscope, // Display the dynamically updated horoscope here.
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontFamily: 'ShantellSans',
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:chakravyuh/models/user_profile_details.dart';
import 'package:flutter/material.dart';
import '../../services/api_call_service.dart';

class HoroscopePage extends StatefulWidget {
  final String userId;
  HoroscopePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<HoroscopePage> createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  late Future<Map<String, dynamic>> kundaliFuture;

  @override
  void initState() {
    super.initState();
    kundaliFuture = KundaliService().fetchKundaliData(widget.userId);
  }

  String selectedSign = "";
  String horoscope = "Today's horoscope will appear here!";

  final List<Map<String, String>> zodiacSigns = [
    {'name': 'Aries', 'image': 'assets/images/aries.jpg'},
    {'name': 'Taurus', 'image': 'assets/images/taurus.jpg'},
    {'name': 'Gemini', 'image': 'assets/images/gemini.jpg'},
    {'name': 'Cancer', 'image': 'assets/images/cancer.jpg'},
    {'name': 'Leo', 'image': 'assets/images/leo.jpg'},
    {'name': 'Virgo', 'image': 'assets/images/virgo.jpg'},
    {'name': 'Libra', 'image': 'assets/images/libra.jpg'},
    {'name': 'Scorpio', 'image': 'assets/images/scorpio.jpg'},
    {'name': 'Sagittarius', 'image': 'assets/images/sagittarius.jpg'},
    {'name': 'Capricorn', 'image': 'assets/images/capricorn.jpg'},
    {'name': 'Aquarius', 'image': 'assets/images/aquarius.jpg'},
    {'name': 'Pisces', 'image': 'assets/images/pisces.jpg'},
  ];

  Future<void> updateHoroscope(KundaliData data) async {
    setState(() {
      selectedSign = data.zodiac_sign;
    });

    final newHoroscope = await KundaliService().fetchKundaliData(widget.userId);

    setState(() {
      horoscope = newHoroscope['horoscope'][selectedSign]['description'] ??
          "Horoscope data not available";
    });
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
          "Your Horoscope",
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
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: kundaliFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFBCC4FF)),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No data available.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final kundaliData = snapshot.data!;
          final horoscopeData =
              kundaliData['horoscope'] as Map<String, dynamic>;
          final rulingPlanet = kundaliData['rulingPlanet'] ?? "Unknown";
          final nakshatra = kundaliData['planets']['Moon']['nakshatra'];

          // Update the selectedSign dynamically
          if (selectedSign.isEmpty) {
            selectedSign = kundaliData['zodiac_sign'] ?? "Unknown";
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF071223), Color(0xFF071223)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.all(15),
                  color: const Color.fromARGB(255, 25, 57, 82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    zodiacSigns.firstWhere(
                                      (sign) =>
                                          sign['name']?.toLowerCase() ==
                                          selectedSign.toLowerCase(),
                                      orElse: () =>
                                          {'image': 'assets/images/time.jpg'},
                                    )['image']!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              selectedSign,
                              style: const TextStyle(
                                fontFamily: 'ShantellSans',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ruling Planet: ${kundaliData['ruling_planet']}",
                                style: const TextStyle(
                                  fontFamily: 'ShantellSans',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Nakshatra: $nakshatra",
                                style: const TextStyle(
                                  fontFamily: 'ShantellSans',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Personalized Horoscope Based on your planetary alignments!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCC4FF)),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: horoscopeData.length,
                    itemBuilder: (context, index) {
                      final topic = horoscopeData.keys.elementAt(index);
                      final description = horoscopeData[topic];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: const Color.fromARGB(255, 25, 57, 82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "$topic: $description",
                            style: const TextStyle(
                              fontFamily: 'ShantellSans',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
