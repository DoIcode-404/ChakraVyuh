import 'package:flutter/material.dart';

class BirthChartPage extends StatelessWidget {
  const BirthChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define data for each box manually
    final birthChartData = [
      "hello", // Top-left
      "this", // Top-right
      "is", // Bottom-left
      "not", // Bottom-right
      "feeling", // Top-center
      "good", // Bottom-center
      "nowhere", // Middle-left
      "being", // Middle-right
      "good", // Center
      "k",
      "xa",
      "hehe",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Birth Chart"),
        backgroundColor: const Color(0xFF1A2C5B), // Matching AstroGuide theme
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF071223), // Darker background for immersive effect
              Color(0xFF1A2C5B), // Blends into the chart section
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: BirthChartCanvas(data: birthChartData),
        ),
      ),
    );
  }
}

class BirthChartCanvas extends StatelessWidget {
  final List<String> data; // Input data for the chart

  const BirthChartCanvas({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.5), // Move chart upward
      child: AspectRatio(
        aspectRatio: 1, // Ensures the chart is square
        child: Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _ChartPainter(data),
          ),
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<String> data; // Data for each box

  _ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double width = size.width;
    final double height = size.height;

    // Draw gradient background
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), gradientPaint);

    // Outer box border
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);

    // Points for chart lines
    final topLeft = Offset(0, 0);
    final topRight = Offset(width, 0);
    final bottomLeft = Offset(0, height);
    final bottomRight = Offset(width, height);
    final centerX = width / 2;
    final centerY = height / 2;

    // Intermediate points
    final midTop = Offset(centerX, 0);
    final midBottom = Offset(centerX, height);
    final midLeft = Offset(0, centerY);
    final midRight = Offset(width, centerY);

    // Draw chart lines
    canvas.drawLine(topLeft, bottomRight, borderPaint);
    canvas.drawLine(topRight, bottomLeft, borderPaint);
    canvas.drawLine(midTop, midBottom, borderPaint);
    canvas.drawLine(midLeft, midRight, borderPaint);

    // Positions for text inside boxes
    final positions = [
      Offset(width / 8, height / 4), // 1st house
      Offset(3 * width / 11, height / 10), // 2nd house
      Offset(width / 4, 3 * height / 3.3), // 3rd house
      Offset(3 * width / 3.5, 3 * height / 4), // 4th house
      Offset(centerX, height / 4), // 5th house
      Offset(centerX, 3 * height / 4), // 6th house
      Offset(width / 4, centerY), // 7th house
      Offset(width / 15, 3 * height / 4), // 9th house
      Offset(3 * width / 4, centerY), // 10th house
      Offset(3 * width / 3.9, height / 1.1), // 8th house
      Offset(3 * width / 3.6, height / 4), // 11th house
      Offset(3 * width / 3.9, height / 9), // 12th house
    ];

    // Add text to each box
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < positions.length; i++) {
      final text = data.length > i ? data[i] : "";
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          positions[i].dx - textPainter.width / 2,
          positions[i].dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
