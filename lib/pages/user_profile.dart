import 'package:chakravyuh/pages/home_page.dart';
import 'package:chakravyuh/pages/horoscopeNoLogin.dart';
import 'package:chakravyuh/pages/kundali_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'compatibility_page.dart';
import 'login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
        title: const Text(
          "User Dashboard",
          style: TextStyle(
            color: Color(0xFFBCC4FF), // Light blue color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Profile Image
          const Padding(
            padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
          // Popup Menu for Logout
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await FirebaseAuth.instance.signOut(); // Sign out user
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
                }
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFFBCC4FF), // Light blue color
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF071223),
              Color(0xFF071223),
              // Color(0xFF1A2C5B),
            ],
            // center: Alignment.center,
            // radius: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeMessage(),
                const SizedBox(height: 20),
                _buildProfileCard(),
                const SizedBox(height: 20),
                _buildDailyHighlights(),
                const SizedBox(height: 20),
                _buildHoroscopeSection(),
                const SizedBox(height: 20),
                _buildHoroscopeSection(),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _welcomeMessage() {
    return const Center(
      child: Column(
        children: [
          Text(
            "Welcome, Simrika!",
            style: TextStyle(
              color: Color(0xFFBCC4FF), // Starry Gold
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "The stars are ready to guide you!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF142850), // Box background color
        borderRadius: BorderRadius.circular(16.0),
        border: const Border(
          top: BorderSide(
            color: Color(0xFFBCC4FF), // Light blue color for the top border
            width: 1, // Thin top border
          ),
          left: BorderSide(
            color: Color(0xFFBCC4FF), // Light blue color for the left border
            width: 1, // Thin left border
          ),
          right: BorderSide(
            color: Color(0xFFBCC4FF), // Light blue color for the right border
            width: 1, // Thin right border
          ),
          bottom: BorderSide(
            color: Color(0xFFBCC4FF), // Light blue color for the bottom border
            width: 4, // Thicker bottom border
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBCC4FF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        color: const Color(0xFF142850), // Darker blue for the card background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Profile Card",
                style: TextStyle(
                  color: Color.fromARGB(255, 245, 246, 248),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail("Sun Sign", "Leo"),
                  const SizedBox(
                    width: 120,
                  ),
                  _buildProfileDetail("Moon Sign", "Capricorn"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail("Ruling Planet", "Saturn"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/profile.png'), // Replace with your image asset
                      ),
                      Text(
                        "You",
                        style: TextStyle(
                          color: Color(0xFFBCC4FF), // Starry Gold
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildProfileDetail("Ascendant", "Aries"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail("Ruling Planet", "Saturn"),
                  const SizedBox(
                    width: 100,
                  ),
                  _buildProfileDetail("Ascendant", "Aries"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "March 16, 2004",
                style: TextStyle(
                  color: Colors.white,
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

  Widget _buildProfileDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFBCC4FF), // Starry Gold
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildHoroscopeSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: const Color(0xFF142850), // Darker blue for the card background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Horoscope",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/capricon.png'), // Replace with your image asset
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "✨ General: Today brings clarity and focus to your long-term goals. Trust your instincts as they guide you toward the right decisions. Avoid unnecessary distractions and stay true to your purpose.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFED766), // Starry Gold
                  foregroundColor: const Color(0xFF0A1A32), // Midnight Blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HoroscopePage()),
                  ); // Handle "Know More" action
                },
                child: const Text("Know More"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyHighlights() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildHighlightCard(
            "Today's Horoscope",
            "Your day will be balanced.",
            Icons.star,
          ),
          _buildHighlightCard(
            "Astrological Event",
            "Venus Retrograde ends today.",
            Icons.calendar_today,
          ),
          _buildHighlightCard(
            "Lucky Insights",
            "Color: Green | No: 7",
            Icons.favorite,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(
    String description,
    String title,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF142850), // Box background color
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFFBCC4FF),
          width: 2,
        ),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBCC4FF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return ConvexAppBar(
  //     style: TabStyle.react,
  //     backgroundColor: const Color(0xFF071223), // Dark Blue
  //     activeColor: const Color(0xFF5D3FD3),
  //     color: const Color(0xFFBCC4FF),
  //     shadowColor: Colors.black26,
  //     items: const [
  //       TabItem(icon: Icons.home, title: "Home"),
  //       TabItem(icon: Icons.star, title: "Horoscope"),
  //       TabItem(icon: Icons.grid_view, title: "Kundali"),
  //       TabItem(icon: Icons.favorite, title: "Compatibility"),
  //       // TabItem(icon: Icons.person, title: "Profile"),
  //     ],
  //   );
  // }
}
