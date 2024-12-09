import 'package:flutter/material.dart';
import '../models/birth_details.dart';
import 'dateOfBirth.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  late BirthDetails birthDetails;
  @override
  void initState() {
    super.initState();

    //Initializing the birth details object
    birthDetails = BirthDetails(
      birthDate: DateTime.now(),
      birthTime: TimeOfDay(hour: 0, minute: 0),
      latitude: 0.0,
      longitude: 0.0,
      timezone: '',
      userId: '',
    );
  }

  // Track the state of each checkbox
  final List<bool> _checkboxValues = [false, false, false, false, false, false];
  final List<String> _checkboxLabels = [
    "Receive personalized daily horoscope update.",
    "Create and explore my detailed birth chart.",
    "Check relationship compatibility based on astrology.",
    "Get insights into career, health, and personal growth.",
    "Learn about strengths, weaknesses, and personality.",
    //"Stay updated on significant planetary movements.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Form"),
        backgroundColor: Color(0xFF071223),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF1A2C5B),
                Color(0xFF071223),
              ],
              stops: [0.0, 1.0],
              center: Alignment.center,
              radius: 0.1,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'What Brings You Here?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: 25,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Select your areas of interest to personalize your astrology experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Add Checkboxes inside individual boxes
                  ...List.generate(
                    _checkboxLabels.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(12.0),
                      // decoration: BoxDecoration(
                      //   color: const Color.fromARGB(255, 12, 16, 34)
                      //       .withOpacity(0.8), // Box background color
                      //   borderRadius: BorderRadius.circular(15.0),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: const Color.fromARGB(255, 246, 201, 201)
                      //           .withOpacity(0.3),
                      //       blurRadius: 8,
                      //       offset: const Offset(0, 4),
                      //     ),
                      //   ],
                      // ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 12, 16, 34)
                            .withOpacity(0.8), // Box background color
                        borderRadius: BorderRadius.circular(10.0),
                        border: const Border(
                          top: BorderSide(
                            color: Color(
                                0xFFBCC4FF), // Light blue color for the top border
                            width: 1, // Thin top border
                          ),
                          left: BorderSide(
                            color: Color(
                                0xFFBCC4FF), // Light blue color for the left border
                            width: 1, // Thin left border
                          ),
                          right: BorderSide(
                            color: Color(
                                0xFFBCC4FF), // Light blue color for the right border
                            width: 1, // Thin right border
                          ),
                          bottom: BorderSide(
                            color: Color(
                                0xFFBCC4FF), // Light blue color for the bottom border
                            width: 4, // Thicker bottom border
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFBCC4FF)
                                // .fromARGB(255, 201, 220, 246)
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: CheckboxListTile(
                        value: _checkboxValues[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _checkboxValues[index] = value ?? false;
                          });
                        },
                        title: Text(
                          _checkboxLabels[index],
                          style: const TextStyle(
                            fontFamily: 'ShantellSans',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Next button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DateBirth(birthDetails: birthDetails)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 25, 57, 82), // Button color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
