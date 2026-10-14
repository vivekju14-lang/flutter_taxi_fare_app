import 'package:flutter/material.dart';

/// Original vector illustration drawn with Flutter; no external image needed.
class TaxiIllustration extends StatelessWidget {
  const TaxiIllustration({super.key, this.size = 210});
  final double size;
  @override
  Widget build(BuildContext context) => Semantics(
      label: 'รถแท็กซี่สีเหลือง',
      image: true,
      child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: _TaxiPainter())));
}

class _TaxiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 240, size.height / 240);
    void box(double x, double y, double w, double h, Color color,
        [double radius = 3]) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y, w, h), Radius.circular(radius)),
          Paint()..color = color);
    }

    const yellow = Color(0xFFFFC107),
        dark = Color(0xFF29292F),
        blue = Color(0xFF99DBF0),
        grey = Color(0xFF90A4AE);
    box(28, 178, 31, 39, dark, 5);
    box(181, 178, 31, 39, dark, 5);
    box(80, 188, 80, 13, dark, 8);
    box(29, 96, 19, 40, yellow);
    box(192, 96, 19, 40, yellow);
    box(14, 94, 35, 19, yellow, 9);
    box(191, 94, 35, 19, yellow, 9);
    box(88, 45, 64, 31, yellow, 3);
    final roof = Path()
      ..moveTo(49, 125)
      ..lineTo(65, 79)
      ..quadraticBezierTo(69, 71, 80, 71)
      ..lineTo(160, 71)
      ..quadraticBezierTo(171, 71, 175, 79)
      ..lineTo(191, 125)
      ..close();
    canvas.drawPath(roof, Paint()..color = yellow);
    final window = Path()
      ..moveTo(61, 120)
      ..lineTo(75, 82)
      ..lineTo(165, 82)
      ..lineTo(179, 120)
      ..close();
    canvas.drawPath(window, Paint()..color = blue);
    box(27, 123, 186, 63, yellow, 10);
    box(38, 137, 33, 24, Colors.white, 2);
    box(169, 137, 33, 24, Colors.white, 2);
    for (int i = 0; i < 7; i++) {
      box(82 + i * 11.0, 139, 6, 16, grey, 1);
    }
    box(21, 174, 198, 22, grey, 3);
    final text = TextPainter(
        text: const TextSpan(
            text: 'TAXI',
            style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 21,
                color: dark,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr)
      ..layout();
    text.paint(canvas, Offset(120 - text.width / 2, 45));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
