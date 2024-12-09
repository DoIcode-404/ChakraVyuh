import 'package:chakravyuh/pages/birthChart.dart';
import 'package:chakravyuh/pages/horoscope.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'ShantellSans'),
      home: const HoroscopeScreen(),
    );
  }
}
