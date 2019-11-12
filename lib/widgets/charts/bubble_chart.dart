import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BubbleChart extends CustomPainter {
  final List<double> values;
  final Color color;
  BubbleChart({@required this.values, Color color})
      : color = color ?? Colors.black;
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width / values.length) / 2;
    final gap =
        max((size.width - radius * 2 * values.length) / values.length, 2);
    final bubbles = List.generate(values.length, (index) {
      return Offset(radius * index * 2 + radius + gap * index, size.height / 2);
    });
    for (int i = 0; i < bubbles.length; i++) {
      canvas.drawCircle(bubbles[i], radius,
          Paint()..color = color.withAlpha((255 * values[i]).toInt()));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
