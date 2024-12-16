import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0;
  int _currentMessageIndex = 0;
  int _currentImageIndex = 0;

  final List<String> _loadingMessages = [
    "Collecting data...",
    "Aligning planets to houses...",
    "Calculating compatibility...",
    "Generating Kundali...",
    "Loading insights...",
  ];

  final List<String> _imagePaths = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    // 'assets/image4.jpg',
    // 'assets/image5.jpg',
  ];

  late Timer _timer;
  late Timer _imageTimer;

  @override
  void initState() {
    super.initState();
    _startLoading();
    // _startImageCycling();
  }

  @override
  void dispose() {
    _timer.cancel();
    _imageTimer.cancel();
    super.dispose();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_progress < 100) {
        setState(() {
          _progress++;
          _currentMessageIndex = (_progress ~/ (100 / _loadingMessages.length))
              .clamp(0, _loadingMessages.length - 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  // void _startImageCycling() {
  //   _imageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF071223),
              Color(0xFF071223),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scrolling Images Above Loader
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      _imagePaths[
                          (index + _currentImageIndex) % _imagePaths.length],
                      width: 150,
                      height: 150,
                      // fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Percentage Loader
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: _progress / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.pink,
                  ),
                ),
                Text(
                  "${_progress.toInt()}%",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCC4FF)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Dynamic Text Below Loader
            Text(
              _loadingMessages[_currentMessageIndex],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFBCC4FF)),
            ),
          ],
        ),
      ),
    );
  }
}
