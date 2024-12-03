import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For handling JSON response

class HoroscopePage extends StatefulWidget {
  const HoroscopePage({super.key});

  @override
  State<HoroscopePage> createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  final List<Map<String, String>> zodiacSigns = [
    {'name': 'Aries', 'image': 'assets/images/aeris.jpg'},
    {'name': 'Taurus', 'image': 'assets/images/taurus.jpg'},
    {'name': 'Gemini', 'image': 'assets/images/gemini.jpg'},
    {'name': 'Cancer', 'image': 'assets/images/cancer.jpg'},
    {'name': 'Leo', 'image': 'assets/images/leo.jpg'},
    {'name': 'Virgo', 'image': 'assets/images/virgo.jpg'},
    {'name': 'Libra', 'image': 'assets/images/libra.jpg'},
    {'name': 'Scorpio', 'image': 'assets/images/scorpio.jpg'},
    {'name': 'Sagittarius', 'image': 'assets/images/sagittarius.jpg'},
    {'name': 'Capricorn', 'image': 'assets/images/capricon.jpg'},
    {'name': 'Aquarius', 'image': 'assets/images/Aquarius.jpg'},
    {'name': 'Pisces', 'image': 'assets/images/Pisces.jpg'},
  ];

  String selectedSign = "Aries";
  String horoscope = "Today's horoscope will appear here!";

  // This function fetches the horoscope for the selected zodiac sign
  Future<String> fetchHoroscope(String zodiacSign) async {
    final url = Uri.parse(
        'https://aztro.sameerkumar.website?sign=$zodiacSign&day=today');

    // Sending the POST request to fetch the horoscope
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decode the JSON response
      return data['horoscope']; // Return the horoscope text
    } else {
      throw Exception('Failed to load horoscope');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 4, 41, 68),
              Color(0xFF071223),
            ],
            stops: [0.0, 1.0],
            center: Alignment.center,
            radius: 0.3,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              height: 130, // Adjust based on your design
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: zodiacSigns.length,
                itemBuilder: (context, index) {
                  final sign = zodiacSigns[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSign = sign['name']!;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(sign['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          sign['name']!,
                          style: const TextStyle(
                            fontFamily: 'ShantellSans',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<String>(
                future: fetchHoroscope(
                    selectedSign), // Call the fetchHoroscope function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 57, 82),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          snapshot.data ?? "No horoscope available",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'ShantellSans',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
