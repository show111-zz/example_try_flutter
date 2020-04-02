import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_drawing/path_drawing.dart';

class LogoPathAnimation4Page extends StatefulWidget {
  @override
  _LogoPathAnimation4PageState createState() => _LogoPathAnimation4PageState();
}

class _LogoPathAnimation4PageState extends State<LogoPathAnimation4Page>
    with SingleTickerProviderStateMixin {
  Animation<double> animation1;
  Animation<double> animation2;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.7)));
    animation2 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.9)));

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: FractionalOffset(0.18, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LogoLeftIcon(animation1: animation1, path: path[0]),
                  LogoLeftIcon(animation1: animation2, path: path[1]),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              widthFactor: 2,
              heightFactor: 2,
              child: LogoRightText(controller),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class LogoRightText extends StatelessWidget {

  final AnimationController controller;

  LogoRightText(this.controller);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget){
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              colors: [Colors.grey, Colors.white, Colors.grey],
              stops: [controller.value - 0.3, controller.value, controller.value + 0.3],
            ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
          },
          child: SvgPicture.asset(
            'assets/logo_16.svg',
            fit: BoxFit.fill,
          ),

        );
      },

    );
  }
}

class LogoLeftIcon extends StatelessWidget {
  const LogoLeftIcon({Key key, @required this.animation1, @required this.path})
      : super(key: key);

  final Animation<double> animation1;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation1.value <= 0.3
          ? 2.5 * animation1.value
          : (animation1.value > 0.3 && animation1.value <= 0.7)
              ? 1.0
              : 2.5 - (2.5 * animation1.value),
      child: CustomPaint(painter: PathTestPainter(path)),
    );
  }
}

class PathTestPainter extends CustomPainter {
  PathTestPainter(String path) : p = parseSvgPathData(path);

  final Path p;

  final Paint blue = Paint()
    ..color = Colors.blue
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  @override
  bool shouldRepaint(PathTestPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(p, blue);
  }
}

const List<String> path = <String>[
  'M106.25,21.8198 L106.25,62.1198 C106.25,72.6898 97.69,81.2498 87.12,81.2498 L19.38,81.2498 C9.7,81.2498 1.71,74.0698 0.43,64.7498 L75.75,64.7498 C79.34,64.7498 82.59,63.2898 84.94,60.9398 C87.29,58.5898 88.75,55.3398 88.75,51.7498 C88.75,44.5698 82.93,38.7498 75.75,38.7498 L31.25,38.7498 C27.11,38.7498 23.75,35.3898 23.75,31.2498 L23.75,29.3198 C23.75,25.1798 27.11,21.8198 31.25,21.8198 L106.25,21.8198 Z',
  'M106.0698,16.75 L30.7498,16.75 C23.5698,16.75 17.7498,22.57 17.7498,29.75 L17.7498,31.75 C17.7498,38.93 23.5698,44.75 30.7498,44.75 L75.2498,44.75 C77.3198,44.75 79.1898,45.59 80.5498,46.95 C81.9098,48.31 82.7498,50.18 82.7498,52.25 C82.7498,56.39 79.3898,59.75 75.2498,59.75 L0.2498,59.75 L0.2498,19.38 C0.2498,8.81 8.8098,0.25 19.3798,0.25 L87.1198,0.25 C96.7998,0.25 104.7898,7.43 106.0698,16.75'
];
