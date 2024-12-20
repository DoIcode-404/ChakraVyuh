// import 'package:chakravyuh/pages/demo_kundali.dart';
import 'package:chakravyuh/pages/dashboard/user_profile.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../models/partner_details.dart';
import '../features/compatibility_page.dart';
import '../features/horoscopeNoLogin.dart';
import '../features/kundali_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0; // Track the selected tab

  // Define a list of pages for each tab
  final List<Widget> _pages = [
    UserProfile(
      userId: '',
    ),
    HoroscopePage(
      userId: '',
    ),
    KundaliPage(
      userId: '',
      // birthDetails: null,
    ),
    CompatibilityPage(
      partnerDetails: PartnerDetails(
        birthDate: DateTime.now(),
        birthTime: TimeOfDay(hour: 0, minute: 0),
        latitude: 0.0,
        longitude: 0.0,
        timezone: '',
        // userDetails: null,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0A1A32),
      //   elevation: 0,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(
      //       Icons.arrow_back,
      //       color: Color(0xFFBCC4FF), // Light blue color
      //     ),
      //   ),
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: const Color(0xFF071223), // Dark Blue
      activeColor: const Color(0xFF5D3FD3),
      color: const Color(0xFFBCC4FF),
      shadowColor: Colors.black26,
      items: const [
        TabItem(icon: Icons.home, title: "Home"),
        TabItem(icon: Icons.star, title: "Horoscope"),
        TabItem(icon: Icons.grid_view, title: "Kundali"),
        TabItem(icon: Icons.favorite, title: "Compatibility"),
        // TabItem(icon: Icons.person, title: "Profile"),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex =
              index; // Update the current index when a tab is tapped
        });
      },
    );
  }
}
