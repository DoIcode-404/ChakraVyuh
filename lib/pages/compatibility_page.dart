import 'package:flutter/material.dart';

class CompatibilityPage extends StatefulWidget {
  const CompatibilityPage({super.key});

  @override
  State<CompatibilityPage> createState() => _CompatibilityPageState();
}

class _CompatibilityPageState extends State<CompatibilityPage> {
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
          "Test Your Compatibility",
          style: TextStyle(
            color: Color(0xFFBCC4FF), // Light blue color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
