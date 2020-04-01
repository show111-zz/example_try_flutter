import 'package:built_path/builder.dart';
import 'package:flutter/material.dart';

class LogoAnimation3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoAnimationWidget(),
    );
  }
}

class LogoAnimationWidget extends StatelessWidget {


//  @SvgPath('M106.25,21.8198 L106.25,62.1198 C106.25,72.6898 97.69,81.2498 87.12,81.2498 L19.38,81.2498 C9.7,81.2498 1.71,74.0698 0.43,64.7498 L75.75,64.7498 C79.34,64.7498 82.59,63.2898 84.94,60.9398 C87.29,58.5898 88.75,55.3398 88.75,51.7498 C88.75,44.5698 82.93,38.7498 75.75,38.7498 L31.25,38.7498 C27.11,38.7498 23.75,35.3898 23.75,31.2498 L23.75,29.3198 C23.75,25.1798 27.11,21.8198 31.25,21.8198 L106.25,21.8198 Z')
//  Path get path => _$logoPage_path;


  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
//          new CustomPaint(painter: new PathPainter(path)),
//          new CustomPaint(painter: new PathPainter(star, false)),
        ],
      );
  }

}

class PathPainter extends CustomPainter {
  PathPainter(this.path, [this.isStroke = true]);

  final Path path;
  final bool isStroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        path,
        new Paint()
          ..style = isStroke ? PaintingStyle.stroke : PaintingStyle.fill
          ..strokeWidth = 4.0);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PathPainter oldDelegate) => false;
}
