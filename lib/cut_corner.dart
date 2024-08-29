import 'package:flutter/material.dart';

class FlatCorneredBackgroundPainter extends CustomPainter {
  double topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius;
  double strokeWidth;
  Color strokeColor;
  Gradient strokeGradient;

  FlatCorneredBackgroundPainter({
    this.topLeftRadius = 10,
    this.topRightRadius = 20,
    this.bottomLeftRadius = 20,
    this.bottomRightRadius = 20,
    this.strokeWidth = 4,
    this.strokeColor = Colors.blue,
    required this.strokeGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..shader = strokeGradient.createShader(Rect.fromLTWH(0, 0, w, h));

    Path path = Path()
// Custom Radius for use
      ..moveTo(topLeftRadius, 0)
      ..lineTo(w - topRightRadius, 0)
      ..lineTo(w, topRightRadius)
      ..lineTo(w, h - bottomRightRadius)
      ..lineTo(w - bottomRightRadius, h)
      ..lineTo(bottomLeftRadius, h)
      ..lineTo(0, h - bottomLeftRadius)
      ..lineTo(0, topLeftRadius)
      ..close();

// All Radius for use
    // ..addPolygon([
    //   Offset(radius, 0),
    //   Offset(w - radius, 0),
    //   Offset(w, radius),
    //   Offset(w, h - radius),
    //   Offset(w - radius, h),
    //   Offset(radius, h),
    //   Offset(0, h - radius),
    //   Offset(0, radius),
    // ], true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TicketShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cutRadius = 20.0;
    double centerY = size.height / 2;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, centerY - cutRadius) // Left edge to the top of the cut
      ..arcToPoint(
        Offset(0, centerY + cutRadius),
        radius: Radius.circular(cutRadius),
        clockwise: false,
      ) // Left cut
      ..lineTo(0, size.height) // Left edge to the bottom left corner
      ..lineTo(
          size.width, size.height) // Bottom edge to the bottom right corner
      ..lineTo(size.width,
          centerY + cutRadius) // Right edge to the bottom of the cut
      ..arcToPoint(
        Offset(size.width, centerY - cutRadius),
        radius: Radius.circular(cutRadius),
        clockwise: false,
      ) // Right cut
      ..lineTo(size.width, 0) // Right edge to the top right corner
      ..close(); // Close the path to the starting point

    // Manually add cuts
    path.addOval(
        Rect.fromCircle(center: Offset(0, centerY), radius: cutRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, centerY), radius: cutRadius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
