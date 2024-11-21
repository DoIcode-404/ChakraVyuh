import 'package:flutter/material.dart';
import 'signUp.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final List<String> districts = [
    'Kathmandu',
    'Bhaktapur',
    'Lalitpur',
    'Pokhara',
    'Biratnagar',
    'Janakpur',
    'Chitwan',
    'Dharan',
    'Hetauda',
    'Birgunj',
    'Nepalgunj',
    'Butwal',
    'Dhangadhi',
    'Mahendranagar',
  ];

  String searchQuery = '';
  String selectedDistrict = '';

  @override
  Widget build(BuildContext context) {
    final filteredDistricts = districts
        .where((district) =>
            district.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Container(
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
                  // Logo Image
                  Image.asset('assets/images/image.png', height: 200),
                  const SizedBox(height: 10),

                  // Page Title
                  const Text(
                    'Where Are You From?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 31,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Page Subtitle
                  const Text(
                    'Discover insights based on your location by selecting your district.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search bar and list of districts
                  Column(
                    children: [
                      // Search Bar
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        controller:
                            TextEditingController(text: selectedDistrict),
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          hintText: 'Search District',
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),

                      // List of districts
                      SizedBox(
                        height: 150, // Adjust the height as needed
                        child: ListView.builder(
                          itemCount: filteredDistricts.length,
                          itemBuilder: (context, index) {
                            final district = filteredDistricts[index];
                            return ListTile(
                              title: Text(
                                district,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedDistrict = district;
                                  searchQuery = district;
                                });
                              },
                              selected: district == selectedDistrict,
                              selectedTileColor: Colors.blue.withOpacity(0.2),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Selected District Display
                  const SizedBox(height: 15),
                  Text(
                    selectedDistrict.isNotEmpty
                        ? 'Selected District: $selectedDistrict'
                        : 'No district selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Next Button
                  ElevatedButton(
                    onPressed: selectedDistrict.isNotEmpty
                        ? () {
                            // Navigate to the next screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ),
                            );
                          }
                        : null, // Disable button if no district is selected
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 27, 61, 88), // Active background
                      disabledBackgroundColor: const Color.fromARGB(
                          255, 25, 52, 74), // Disabled background
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
