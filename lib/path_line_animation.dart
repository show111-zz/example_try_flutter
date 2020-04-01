import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class PathLineAnimation extends StatefulWidget {
  @override
  _PathLineAnimationState createState() => _PathLineAnimationState();
}

class _PathLineAnimationState extends State<PathLineAnimation> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;
  GlobalKey customPaintKey1 = GlobalKey();
  GlobalKey customPaintKey2 = GlobalKey();
  GlobalKey customPaintKey3 = GlobalKey();

  String path2 = 'M106.25,21.8198 L106.25,62.1198 C106.25,72.6898 97.69,81.2498 87.12,81.2498 L19.38,81.2498 C9.7,81.2498 1.71,74.0698 0.43,64.7498 L75.75,64.7498 C79.34,64.7498 82.59,63.2898 84.94,60.9398 C87.29,58.5898 88.75,55.3398 88.75,51.7498 C88.75,44.5698 82.93,38.7498 75.75,38.7498 L31.25,38.7498 C27.11,38.7498 23.75,35.3898 23.75,31.2498 L23.75,29.3198 C23.75,25.1798 27.11,21.8198 31.25,21.8198 L106.25,21.8198 Z';
  String path1 = 'M106.0698,16.75 L30.7498,16.75 C23.5698,16.75 17.7498,22.57 17.7498,29.75 L17.7498,31.75 C17.7498,38.93 23.5698,44.75 30.7498,44.75 L75.2498,44.75 C77.3198,44.75 79.1898,45.59 80.5498,46.95 C81.9098,48.31 82.7498,50.18 82.7498,52.25 C82.7498,56.39 79.3898,59.75 75.2498,59.75 L0.2498,59.75 L0.2498,19.38 C0.2498,8.81 8.8098,0.25 19.3798,0.25 L87.1198,0.25 C96.7998,0.25 104.7898,7.43 106.0698,16.75';
  Path _path1;
  Path _path2;
  double _fraction = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 6));
    _path1 = startPressMotion(path1);
    _path2 = startPressMotion(path2);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomPaint(
            key: customPaintKey1,
            painter: PathSegmentPainter(_path1, _fraction),
          ),
          CustomPaint(
            key: customPaintKey2,
            painter: PathSegmentPainter(_path2, _fraction),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Path startPressMotion(String path) {
    _controller.reset();
    Path _path = parseSvgPathData(path);

    PathMetrics pms = _path.computeMetrics();
    PathMetric pm = pms.elementAt(0);
    double len = pm.length;
    _animation = Tween(begin: 0.0, end: len).animate(_controller)
      ..addListener( (){setState(() => _fraction = _animation.value);} )
      ..addStatusListener((status){ if(status == AnimationStatus.completed){ _controller.stop(); } });
    _controller.forward();

    return _path;
  }

}

const List<String> path = <String>[
  'M106.25,21.8198 L106.25,62.1198 C106.25,72.6898 97.69,81.2498 87.12,81.2498 L19.38,81.2498 C9.7,81.2498 1.71,74.0698 0.43,64.7498 L75.75,64.7498 C79.34,64.7498 82.59,63.2898 84.94,60.9398 C87.29,58.5898 88.75,55.3398 88.75,51.7498 C88.75,44.5698 82.93,38.7498 75.75,38.7498 L31.25,38.7498 C27.11,38.7498 23.75,35.3898 23.75,31.2498 L23.75,29.3198 C23.75,25.1798 27.11,21.8198 31.25,21.8198 L106.25,21.8198 Z',
  'M106.0698,16.75 L30.7498,16.75 C23.5698,16.75 17.7498,22.57 17.7498,29.75 L17.7498,31.75 C17.7498,38.93 23.5698,44.75 30.7498,44.75 L75.2498,44.75 C77.3198,44.75 79.1898,45.59 80.5498,46.95 C81.9098,48.31 82.7498,50.18 82.7498,52.25 C82.7498,56.39 79.3898,59.75 75.2498,59.75 L0.2498,59.75 L0.2498,19.38 C0.2498,8.81 8.8098,0.25 19.3798,0.25 L87.1198,0.25 C96.7998,0.25 104.7898,7.43 106.0698,16.75'
];

class PathSegmentPainter extends CustomPainter{
  double _fraction;
  Path _path;

  PathSegmentPainter(this._path, this._fraction);

  Paint _paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    if(_paint == null) return;
    Path segmentPath = Path();

    PathMetrics pms = _path.computeMetrics();
    PathMetric pm = pms.elementAt(0);

    var extractPath = pm.extractPath(0.0, _fraction);
    segmentPath.addPath(extractPath, Offset(0.0, 0.0));

    canvas.drawPath(segmentPath, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class PathPainter extends CustomPainter {
  double _fraction;
  Path _path;

  PathPainter(this._path, this._fraction);

  Paint _paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  Paint _paint2 = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    if (_path == null) return;

    PathMetrics pms = _path.computeMetrics();
    PathMetric pm = pms.elementAt(0);
    Tangent tangent = pm.getTangentForOffset(_fraction);
    canvas.drawPath(_path, _paint);
    canvas.drawCircle(tangent.position, 10, _paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



