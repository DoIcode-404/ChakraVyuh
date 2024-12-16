import 'package:flutter/material.dart';

class KundaliPainter extends CustomPainter {
  final Map<String, dynamic> houses; // Data for the 12 houses
  final Map<String, dynamic>
      planets; // Data for the planets in respective houses

  KundaliPainter({required this.houses, required this.planets});

  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
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

    // Draw chart lines (to divide the 12 houses)
    canvas.drawLine(topLeft, bottomRight, borderPaint);
    canvas.drawLine(topRight, bottomLeft, borderPaint);
    canvas.drawLine(midTop, midRight, borderPaint);
    canvas.drawLine(midTop, midLeft, borderPaint);
    canvas.drawLine(midLeft, midBottom, borderPaint);
    canvas.drawLine(midBottom, midRight, borderPaint);

    final positions = [
      Offset(centerX, height / 4), // 1st house (Ascendant)
      Offset(3 * width / 11, height / 10), // 2nd house
      Offset(width / 8, height / 4), // 3rd house
      Offset(width / 4, centerY), // 4th house
      Offset(width / 15, 3 * height / 4), // 5th house
      Offset(width / 4, 3 * height / 3.3), // 6th house
      Offset(centerX, 3 * height / 4), // 7th house
      Offset(3 * width / 3.9, height / 1.1), // 8th house
      Offset(3 * width / 3.5, 3 * height / 4), // 9th house
      Offset(3 * width / 4, centerY), // 10th house
      Offset(3 * width / 3.6, height / 4), // 11th house
      Offset(3 * width / 3.9, height / 9), // 12th house
    ];

    // Add text to each box
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < positions.length; i++) {
      String houseNumber = (i + 1).toString();
      final houseInfo = houses[houseNumber];

      if (houseInfo != null) {
        String sign = "${houseInfo['sign']}";
        String planets = "${houseInfo['planets'].join(', ')}";

        // Combine house data into a single string
        String houseText = "\n$sign\n$planets";

        textPainter.text = TextSpan(
          text: houseText,
          style: const TextStyle(
            color: Color(0xFFBCC4FF),
            fontSize: 10,
            // fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();
        Offset position = positions[i] -
            Offset(
              textPainter.width / 2,
              textPainter.height / 2,
            );
        textPainter.paint(canvas, position);
      }
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) => false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
