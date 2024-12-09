import 'package:chakravyuh/pages/login.dart';
import 'package:flutter/material.dart';
import 'astroGuide.dart';
import 'check_box_page.dart';
import 'birthChart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 4, 41, 68),
              Color(0xFF071223),

              //Color.fromARGB(255, 2, 34, 59),
            ],
            stops: [0.0, 1.0],
            center: Alignment.center,
            radius: 0.3,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
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
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/Theme-img.png', // Add your image to assets and update path
                    height: 285,
                    width: 283,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 15),

                // Get Started button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AstroGuidePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 25, 57, 82), // Button color
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
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Login prompt text
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: 19,
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
