import 'package:flutter/material.dart';

class InvertedCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const radius = 16.0;
    const curveWidth = 100.0;
    const curveHeight = 20.0;

    final centerX = size.width / 2;

    /// Start from top-left
    path.moveTo(radius, 0);

    /// Top-left radius
    path.quadraticBezierTo(0, 0, 0, radius);

    /// Left side
    path.lineTo(0, size.height - radius);

    /// Bottom-left radius
    path.quadraticBezierTo(0, size.height, radius, size.height);

    /// Bottom line before inward curve
    path.lineTo(centerX - curveWidth, size.height);

    /// Inward curve left side
    path.cubicTo(
      centerX - 60,
      size.height,

      centerX - 50,
      size.height - curveHeight,

      centerX,
      size.height - curveHeight,
    );

    /// Inward curve right side
    path.cubicTo(
      centerX + 50,
      size.height - curveHeight,

      centerX + 60,
      size.height,

      centerX + curveWidth,
      size.height,
    );

    /// Bottom line after curve
    path.lineTo(size.width - radius, size.height);

    /// Bottom-right radius
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );

    /// Right side
    path.lineTo(size.width, radius);

    /// Top-right radius
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    /// Top line
    path.lineTo(radius, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
