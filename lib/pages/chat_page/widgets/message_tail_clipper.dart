import 'package:flutter/material.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

class MessageBubbleTailPaint extends CustomPainter {
  const MessageBubbleTailPaint({this.color});
  final Color? color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = color ?? AppColors.color3CED78;
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, size.height * 0.89, size.width, size.height, size.width,
        size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, 0, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
