import 'package:flutter/material.dart';

class BottomBorderDashLine extends CustomPainter {
  final Color color;
  final int gap;
  final int dashlen;
  final double width;
  BottomBorderDashLine(
      {this.gap: 2, this.dashlen: 6, Color color, this.width: 1})
      : this.color = color ?? Colors.grey[300];
  @override
  void paint(Canvas canvas, Size size) {
    List.generate((size.width ~/ (dashlen + gap)), (index) {
      return Offset(index.toDouble() * (dashlen + gap), size.height);
    }).forEach((line) {
      canvas.drawLine(
          line,
          Offset(line.dx - dashlen, line.dy),
          Paint()
            ..color = color
            ..strokeWidth = width);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
