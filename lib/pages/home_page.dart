import 'package:flutter/material.dart';

import 'check_box_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF1A2C5B),
              Color(0xFF071223),
            ],
            stops: [0.0, 1.0],
            center: Alignment.center,
            radius: 0.3,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'assets/images/Logo-Frame.png',
                    height: 80,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle/Description text
                const Text(
                  'Know you and your surroundings with the help of astrology',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ShantellSans',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/Theme-img.png', // Add your image to assets and update path
                    height: 285,
                    width: 283,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                // Get Started button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckBoxPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF14224A), // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 30),
                  ),
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Login prompt text
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                  },
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Terms and Privacy links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to Terms of Service
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontFamily: 'ShantellSans',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      '|',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Privacy Policy
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'ShantellSans',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
