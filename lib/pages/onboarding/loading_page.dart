import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Animation controller for loader
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Navigate to home after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A32), // Dark theme background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rotating Loader Around Chakravyuh Image
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value *
                          2 *
                          3.14159265359, // Full rotation
                      child: SizedBox(
                        width: 350,
                        height: 350,
                        child: CustomPaint(
                          painter: LoaderPainter(),
                        ),
                      ),
                    );
                  },
                ),
                // Chakravyuh Image
                Image.asset(
                  'assets/images/Theme-img.png', // Add your Chakravyuh image path here
                  width: 300,
                  height: 300,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'Charkavyuh',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.amberAccent;

    final radius = size.width / 2;

    for (double i = 0; i < 360; i += 30) {
      final angle = i * (3.14159265359 / 180);
      final x = radius + radius * 0.8 * cos(angle);
      final y = radius + radius * 0.8 * sin(angle);

      canvas.drawCircle(Offset(x, y), 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
