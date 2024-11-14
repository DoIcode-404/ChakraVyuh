import 'package:flutter/material.dart';

class CheckBoxPage extends StatelessWidget {
  const CheckBoxPage({super.key});

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
    ));
  }
}
