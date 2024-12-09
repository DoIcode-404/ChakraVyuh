import 'package:flutter/material.dart';

class KundaliPainter extends CustomPainter {
  final List<String> kundaliData;

  KundaliPainter({required this.kundaliData});

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
    canvas.drawLine(midTop, midRight, borderPaint);
    canvas.drawLine(midTop, midLeft, borderPaint);
    canvas.drawLine(midLeft, midBottom, borderPaint);
    canvas.drawLine(midBottom, midRight, borderPaint);

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
      final text = kundaliData.length > i ? kundaliData[i] : "";
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
// import 'package:flutter/material.dart';

// class KundaliPainter extends CustomPainter {
//   final List<String> kundaliData;

//   // Constructor to accept the kundali data
//   KundaliPainter({required this.kundaliData});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final gradientPaint = Paint()
//       ..shader = LinearGradient(
//         colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..style = PaintingStyle.fill;

//     final borderPaint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;

//     final double width = size.width;
//     final double height = size.height;

//     // Draw gradient background
//     canvas.drawRect(Rect.fromLTWH(0, 0, width, height), gradientPaint);

//     // Outer box border
//     canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);

//     // Positions for text inside boxes
//     final positions = [
//       Offset(width / 8, height / 4), // 1st house
//       Offset(3 * width / 11, height / 10), // 2nd house
//       Offset(width / 4, 3 * height / 3.3), // 3rd house
//       Offset(3 * width / 3.5, 3 * height / 4), // 4th house
//       Offset(width / 2, height / 4), // 5th house
//       Offset(width / 2, 3 * height / 4), // 6th house
//       Offset(width / 4, height / 2), // 7th house
//       Offset(width / 15, 3 * height / 4), // 9th house
//       Offset(3 * width / 4, height / 2), // 10th house
//       Offset(3 * width / 3.9, height / 1.1), // 8th house
//       Offset(3 * width / 3.6, height / 4), // 11th house
//       Offset(3 * width / 3.9, height / 9), // 12th house
//     ];

//     // Add text to each box
//     final textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     for (int i = 0; i < positions.length; i++) {
//       final text = kundaliData.length > i ? kundaliData[i] : "";
//       textPainter.text = TextSpan(
//         text: text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//         ),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(
//           positions[i].dx - textPainter.width / 2,
//           positions[i].dy - textPainter.height / 2,
//         ),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
