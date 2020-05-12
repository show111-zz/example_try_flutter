import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoAnimation3 extends StatefulWidget {
  @override
  _LogoAnimation3State createState() => _LogoAnimation3State();
}

class _LogoAnimation3State extends State<LogoAnimation3>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationTransition;
  Animation<double> animationOpacity;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animationOpacity = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animationTransition = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: GrowTransition(
                animation: animationTransition,
                child: SvgPicture.asset('assets/logo_0.svg', fit: BoxFit.contain,),
              ),
            ),
            Expanded(
              flex: 6,
              child: TextLiquidFill(
                text: 'Syntronic',
                waveColor: Color(0xFF1478C7),
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
//           AnimationLogo(animation: animation,),
//           GrowTransition(animation: animation, child: SvgPicture.asset('assets/logo_16.svg', color: animation2.value,),),
          ],
        ),
      ),
    );
  }
}

class AnimationLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0, end: 100);

  AnimationLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            child: SvgPicture.asset(
              'assets/logo_0.svg',
              fit: BoxFit.fill,
            ),
            width: _sizeTween.evaluate(animation),
            height: _sizeTween.evaluate(animation),
          ),
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
            child: child),
      );
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
