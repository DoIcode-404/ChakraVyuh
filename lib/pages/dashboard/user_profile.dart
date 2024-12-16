import 'package:chakravyuh/models/user_profile_details.dart';
import 'package:chakravyuh/pages/features/horoscopeNoLogin.dart';
import 'package:chakravyuh/pages/onboarding/home_page.dart';
import 'package:chakravyuh/services/api_call_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../compatibility_page.dart';
// import '../../login.dart';

class UserProfile extends StatefulWidget {
  // final FirebaseUser user;
  // final BirthDetails birthDetails;
  final String userId;
  const UserProfile({
    super.key,
    required this.userId,
    // required this.birthDetails,
    // required this.user
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // // final KundaliService kundaliService = KundaliService();

  // // Map<String, dynamic>? profileData; // Store the fetched profile data
  // // bool isLoading = true; // To show a loading indicator
  // late Future<KundaliData> fetchProfileData;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchProfileData =
  //       KundaliService().fetchKundaliData(widget.userId).then((data) {
  //     return KundaliData.fromJson(data);
  //   });
  // }
  late Future<KundaliData> futureKundaliData; // Future to fetch profile data

  @override
  void initState() {
    super.initState();
    futureKundaliData = fetchProfileData(); // Initialize fetching of data
  }

  Future<KundaliData> fetchProfileData() async {
    try {
      final data = await KundaliService().fetchKundaliData(widget.userId);
      // Create the KundaliData instance using fetched data
      return KundaliData.fromJson({
        ...data,
        'username': data['username'], // Ensure username is included
        'dob': data['dob'], // Ensure dob is included
      });
    } catch (e) {
      throw Exception('Failed to fetch profile data: $e');
    }
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
                    MaterialPageRoute(builder: (context) => const HomePage()),
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
      body: FutureBuilder<KundaliData>(
        future: futureKundaliData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return _buildUserProfileContent(data);
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildUserProfileContent(KundaliData data) {
    return Container(
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
              _buildProfileCard(data),
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
    );
  }

  Widget _welcomeMessage() {
    return Center(
      child: Column(
        children: [
          Text(
            "Welcome, User",
            // "Welcome, ${profileData?['name'] ?? 'User'}!",
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

  Widget _buildProfileCard(KundaliData data) {
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
                  _buildProfileDetail(
                      "Zodiac Sign", data.planets['Moon']?.sign ?? '-'),
                  const SizedBox(
                    width: 120,
                  ),
                  _buildProfileDetail(
                      "Ruling Planet", data.ruling_planet ?? '-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail(
                      "Sun Sign", data.planets["Sun"]?.sign ?? '-'),
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
                  _buildProfileDetail("Ascendant", data.ascendant.sign ?? '-'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail("Strength", data.zodiac_quality ?? '-'),
                  const SizedBox(
                    width: 100,
                  ),
                  _buildProfileDetail("Weakness", data.zodiac_weakness ?? '-'),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "March 16, 2004",
                // data.dob ?? 'Date of Birth not available',
                style: const TextStyle(
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
                      'assets/images/time.png'), // Replace with your image asset
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
                        builder: (context) => HoroscopePage(
                              userId: '',
                            )),
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
}
