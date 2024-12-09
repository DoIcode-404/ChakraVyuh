// import 'package:flutter/material.dart';
// import '../services/kundali_painter.dart';
// import '../services/kundali_service.dart';

// class KundaliPage extends StatelessWidget {
//   final String userId;
//   final List<String> kundaliData = [
//     "1st",
//     "2nd",
//     "3rd",
//     "4th",
//     "5th",
//     "6th",
//     "7th",
//     "8th",
//     "9th",
//     "10th",
//     "11th",
//     "12th"
//   ];

//   KundaliPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF0A1A32),
//           elevation: 0,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back,
//               color: Color(0xFFBCC4FF), // Light blue color
//             ),
//           ),
//           // title: const Text(
//           //   "Your Kundali",
//           //   style: TextStyle(
//           //     color: Color(0xFFBCC4FF), // Light blue color
//           //     fontSize: 20,
//           //     fontWeight: FontWeight.bold,
//           //   ),
//           // ),
//           actions: const [
//             Padding(
//               padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
//               child: CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage(
//                   'assets/images/profile.png',
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: RadialGradient(
//                 colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//                 center: Alignment.center,
//                 radius: 0.5,
//               ),
//             ),
//             child: Center(
//                 child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Text(
//                   "Kundali Chart",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFBCC4FF),
//                   ),
//                 ),
//                 CustomPaint(
//                   size: Size(300, 300), // Specify size as needed
//                   painter: KundaliPainter(kundaliData, kundaliData: null),
//                 ),
//               ]),
//             )),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import '../services/kundali_painter.dart';
import '../services/api_call_service.dart';

class KundaliPage extends StatefulWidget {
  final Map<String, dynamic> birthDetails;

  KundaliPage({Key? key, required this.birthDetails}) : super(key: key);

  @override
  _KundaliPageState createState() => _KundaliPageState();
}

class _KundaliPageState extends State<KundaliPage> {
  late Future<List<String>> kundaliFuture;

  @override
  void initState() {
    super.initState();
    kundaliFuture = KundaliService().fetchKundaliData(widget.birthDetails);
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
            color: Color(0xFFBCC4FF), // Light blue color
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
              center: Alignment.center,
              radius: 0.5,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Kundali Chart",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCC4FF),
                    ),
                  ),
                  FutureBuilder<List<String>>(
                    future: kundaliFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color(0xFFBCC4FF),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text(
                          "No data available.",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      return CustomPaint(
                        size: const Size(300, 300), // Specify size as needed
                        painter: KundaliPainter(kundaliData: snapshot.data!),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
