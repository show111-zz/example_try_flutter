import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

const String path1 = 'M106.0698,16.75 L30.7498,16.75 C23.5698,16.75 17.7498,22.57 17.7498,29.75 L17.7498,31.75 C17.7498,38.93 23.5698,44.75 30.7498,44.75 L75.2498,44.75 C77.3198,44.75 79.1898,45.59 80.5498,46.95 C81.9098,48.31 82.7498,50.18 82.7498,52.25 C82.7498,56.39 79.3898,59.75 75.2498,59.75 L0.2498,59.75 L0.2498,19.38 C0.2498,8.81 8.8098,0.25 19.3798,0.25 L87.1198,0.25 C96.7998,0.25 104.7898,7.43 106.0698,16.75';
const String path2 = 'M106.25,21.8198 L106.25,62.1198 C106.25,72.6898 97.69,81.2498 87.12,81.2498 L19.38,81.2498 C9.7,81.2498 1.71,74.0698 0.43,64.7498 L75.75,64.7498 C79.34,64.7498 82.59,63.2898 84.94,60.9398 C87.29,58.5898 88.75,55.3398 88.75,51.7498 C88.75,44.5698 82.93,38.7498 75.75,38.7498 L31.25,38.7498 C27.11,38.7498 23.75,35.3898 23.75,31.2498 L23.75,29.3198 C23.75,25.1798 27.11,21.8198 31.25,21.8198 L106.25,21.8198 Z';

class AnimationSharing3 extends StatefulWidget {
  @override
  _AnimationSharing3State createState() => _AnimationSharing3State();
}

class _AnimationSharing3State extends State<AnimationSharing3> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Path path11;
  Path path22;
  Animation<double> animation;
  double end = 0.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this,duration: const Duration(seconds: 3));

    path11 = parseAndGetPath(path1);
    path22 = parseAndGetPath(path2);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            CustomPaint(
              painter: PathSegmentPainter(path: path11, end: end),
            ),
            CustomPaint(
              painter: PathSegmentPainter(path: path22, end: end),
            ),
          ],
        ),
      ),
    );
  }

  Path parseAndGetPath(String pathSvg) {
    Path pathNew = parseSvgPathData(pathSvg);
    PathMetrics metrics2 = pathNew.computeMetrics();
    PathMetric metric2 = metrics2.elementAt(0);
    double len2 = metric2.length;
    animation = Tween(begin: 0.0, end: len2).animate(controller)..addListener(() {setState(() {
      end = animation.value;
    });});
    return pathNew;
  }

}

class PathSegmentPainter extends CustomPainter {

  Path path;
  double end;

  PathSegmentPainter({@required this.path, @required this.end});

  Paint paintC = Paint()
    ..color = Color(0xFF1478C7)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {

    if(paint == null) return;
    Path segmentPath = Path();

    PathMetrics pms = path.computeMetrics();
    PathMetric pm = pms.elementAt(0);
    Path extraPath = pm.extractPath(0.0,end);
    segmentPath.addPath(extraPath, Offset(0.0, 0.0));

    canvas.drawPath(segmentPath, paintC);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
