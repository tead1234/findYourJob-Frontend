import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double waveHeight;
  final double waveLength;
  final double phase;

  WavePainter({required this.waveHeight, required this.waveLength, required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      final y = waveHeight * sin((x / waveLength * 2 * pi) + phase) + size.height / 2;
      path.lineTo(x, y+(x*0.5)-200);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}