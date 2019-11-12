import 'package:flutter/material.dart';

class BarChart extends CustomPainter {
  final double value;
  final Color color;
  BarChart({this.value: 1, Color color}) : color = color ?? Colors.black45;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(0 + size.height / 2, size.height / 2),
        Offset(size.width - size.height / 2, size.height / 2),
        Paint()
          ..color = color.withAlpha(120)
          ..strokeWidth = size.height
          ..strokeCap = StrokeCap.round);
    canvas.drawLine(
        Offset(0 + size.height / 2, size.height / 2),
        Offset(size.width * value - size.height / 2, size.height / 2),
        Paint()
          ..color = color
          ..strokeWidth = size.height
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
