import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todog/todog_colors.dart';

class CircleChart extends CustomPainter {
  final double value;
  final Color color;
  final double width;
  CircleChart({this.value, Color color, this.width: 16})
      : color = color ?? ToDogColors.orange;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: min(size.height / 2, size.width) - width),
        -pi / 2,
        2 * pi * value,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
