import 'package:chakravyuh/services/api_Services.dart';
import 'package:flutter/material.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({Key? key}) : super(key: key);

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen> {
  final ApiService _apiService = ApiService();
  String? _horoscope;
  bool _isLoading = false;

  final List<Map<String, String>> _zodiacSigns = [
    {'name': 'Aries', 'image': 'assets/aries.jpeg'},
    {'name': 'Taurus', 'image': 'assets/taurus.jpeg'},
    {'name': 'Gemini', 'image': 'assets/gemini.jpeg'},
    {'name': 'Cancer', 'image': 'assets/cancer.jpeg'},
    {'name': 'Leo', 'image': 'assets/leo.jpeg'},
    {'name': 'Virgo', 'image': 'assets/virgo.jpeg'},
    {'name': 'Libra', 'image': 'assets/libra.jpeg'},
    {'name': 'Scorpio', 'image': 'assets/scorpio.jpeg'},
    {'name': 'Sagittarius', 'image': 'assets/sagittarius.jpeg'},
    {'name': 'Capricorn', 'image': 'assets/capricorn.jpeg'},
    {'name': 'Aquarius', 'image': 'assets/aquarius.jpeg'},
    {'name': 'Pisces', 'image': 'assets/pisces.jpeg'},
  ];

  Future<void> _fetchHoroscope(String sign) async {
    setState(() {
      _isLoading = true;
    });

    final fetchedHoroscope = await _apiService.fetchDailyHoroscope(sign);

    setState(() {
      _horoscope = fetchedHoroscope;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Horoscope'),
      ),
      body: Column(
        children: [
          // Horizontal scrollable list of zodiac signs
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _zodiacSigns.length,
              itemBuilder: (context, index) {
                final sign = _zodiacSigns[index];
                return GestureDetector(
                  onTap: () => _fetchHoroscope(sign['name']!.toLowerCase()),
                  child: Column(
                    children: [
                      Image.asset(
                        sign['image']!,
                        height: 80,
                        width: 80,
                      ),
                      Text(sign['name']!)
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Display horoscope
          Expanded(
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _horoscope ?? 'Select a sign to see the horoscope',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
