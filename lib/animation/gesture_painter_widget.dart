
import 'dart:ui';

import 'package:flutter/material.dart';

class GesturePainterWidget extends StatefulWidget{

  @override
  _GesturePainterWidgetState createState() => _GesturePainterWidgetState();

}

class _GesturePainterWidgetState extends State<GesturePainterWidget>{
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: CustomPaint(
          painter: GesturePaintPad(points),
        ),
      ),
      onPanUpdate: (pos){
          setState(() {
            points.add(Offset(pos.localPosition.dx, pos.localPosition.dy));
          });
      },
    );
  }

}

class GesturePaintPad extends CustomPainter{

  List<Offset> points;

  GesturePaintPad(this.points);

  Paint _paint = Paint()
  ..style = PaintingStyle.stroke
  ..color = Colors.green
  ..strokeWidth = 5.0
  ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
     canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
