import 'package:flutter/material.dart';

class AstroGuidePage extends StatelessWidget {
  const AstroGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
            center: Alignment.center,
            radius: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Heading
              const Text(
                'AstroGuide',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Astrology Image
              Image.asset(
                'assets/images/guide.jpg', // Add your image asset here
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),

              // Kundali Box
              GestureDetector(
                onTap: () {
                  // Navigate to Kundali page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KundaliPage()),
                  );
                },
                child: _buildInfoBox(
                  title: 'Kundali',
                  description: 'Explore your detailed Kundali insights.',
                ),
              ),
              const SizedBox(height: 20),

              // Horoscope Box
              GestureDetector(
                onTap: () {
                  // Navigate to Horoscope page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HoroscopePage()),
                  );
                },
                child: _buildInfoBox(
                  title: 'Horoscope',
                  description: 'Get your daily, weekly, or yearly horoscope.',
                ),
              ),
              const SizedBox(height: 20),

              // Compatibility Box
              GestureDetector(
                onTap: () {
                  // Navigate to Compatibility page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompatibilityPage()),
                  );
                },
                child: _buildInfoBox(
                  title: 'Compatibility',
                  description: 'Check compatibility with your loved ones.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each clickable info box
  Widget _buildInfoBox({required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder pages for navigation
class KundaliPage extends StatelessWidget {
  const KundaliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kundali')),
      body: const Center(child: Text('Kundali Page Content')),
    );
  }
}

class HoroscopePage extends StatelessWidget {
  const HoroscopePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horoscope')),
      body: const Center(child: Text('Horoscope Page Content')),
    );
  }
}

class CompatibilityPage extends StatelessWidget {
  const CompatibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compatibility')),
      body: const Center(child: Text('Compatibility Page Content')),
    );
  }
}
