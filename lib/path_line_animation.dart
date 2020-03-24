import 'dart:ui';

import 'package:flutter/material.dart';

class PathLineAnimation extends StatefulWidget {
  @override
  _PathLineAnimationState createState() => _PathLineAnimationState();
}

class _PathLineAnimationState extends State<PathLineAnimation> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;
  GlobalKey customPaintKey = GlobalKey();

  Path _path;
  double _fraction = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          constraints: BoxConstraints.expand(),
          child: CustomPaint(
            key: customPaintKey,
//            painter: PathPainter(_path, _fraction),
            painter: PathSegmentPainter(_path, _fraction),

          ),
        )),
        RaisedButton(onPressed: startPressMotion, child: Text('start'),)
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void startPressMotion() {
    _controller.reset();
    RenderBox renderBox = customPaintKey.currentContext.findRenderObject();
    Size size = renderBox.size;
    _path = getPath(size);
    PathMetrics pms = _path.computeMetrics();
    PathMetric pm = pms.elementAt(0);
    double len = pm.length;
    _animation = Tween(begin: 0.0, end: len).animate(_controller)
      ..addListener( (){setState(() => _fraction = _animation.value);} )
      ..addStatusListener((status){ if(status == AnimationStatus.completed){ _controller.stop(); } });
    _controller.forward();
  }

  Path getPath(Size size) {
    Path path = Path();
    path.moveTo(20, 20);
    path.cubicTo(size.width, size.height/ 4, size.width / 4 * 3, size.height / 2, size.width -20, size.height - 20);
    return path;
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


class PathSegmentPainter extends CustomPainter{
  double _fraction;
  Path _path;

  PathSegmentPainter(this._path, this._fraction);

  Paint _paint = Paint()
  ..color = Colors.green
  ..style = PaintingStyle.stroke
  ..strokeWidth = 5.0;

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
