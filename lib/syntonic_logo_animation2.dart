import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/math.dart';
import 'package:flutter_svg/svg.dart';

class SyntronicLogoAnimate2 extends StatefulWidget {
  @override
  _SyntronicLogoAnimate2State createState() => _SyntronicLogoAnimate2State();
}

class _SyntronicLogoAnimate2State extends State<SyntronicLogoAnimate2> with SingleTickerProviderStateMixin {

  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  AnimationController controller;

  bool run = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation1 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.9, curve: Curves.easeInOut), ), );
//    animation2 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.5, curve: Curves.linear), ), );
//    animation3 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.9, curve: Curves.linear), ), );

    controller.addListener( (){ setState(() {

    }); } );

    controller.repeat();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedDrawing.svg('assets/logo_0.svg', controller: controller, ),

//            Expanded(
//            child: AnimatedDrawing.svg(
//            "assets/logo_0.svg",
//            run: this.run,
//            duration: new Duration(seconds: 50),
//            lineAnimation: LineAnimation.allAtOnce,
//            animationCurve: Curves.easeInOut,
//            onFinish: () => setState(() {
//            this.run = false;
//            }),

//          Expanded(
//              child: AnimatedDrawing.paths(
//                [
//                  (Path()
//                    ..addOval(Rect.fromCircle(center: Offset.zero, radius: 45.0)))
//                      .transform(Matrix4.rotationX(-pi)
//                      .storage), //A circle which is slightly rotated
//                ],
//                paints: [
//                  Paint()
//                    ..style = PaintingStyle.stroke
//                    ..color = Colors.teal
//                    ..strokeWidth = 5.0,
//                ],
//                run: this.run,
//                animationOrder: PathOrders.original,
//                duration: new Duration(seconds: 2),
//                lineAnimation: LineAnimation.oneByOne,
//                animationCurve: Curves.linear,
//                onFinish: () => setState(() {
//                  this.run = false;
//                }),
//              ),
//          )


//            Opacity(
//              opacity: animation1.value <= 0.3
//                  ? 2.5 * animation1.value
//                  : (animation1.value > 0.30 && animation1.value <= 0.70)
//                  ? 1.0
//                  : 2.5 - (2.5 * animation1.value),
//              child: Padding(
//                padding: const EdgeInsets.only(right: 5),
////                child: SvgPicture.asset('assets/logo_0.svg'),
//                child: AnimatedDrawing.svg('assets/logo_0.svg', controller: controller,),
//              ),
//            ),
//            Opacity(
//              opacity: animation2.value <= 0.3
//                  ? 2.5 * animation2.value
//                  : (animation2.value > 0.30 && animation2.value <= 0.70)
//                  ? 1.0
//                  : 2.5 - (2.5 * animation2.value),
//              child: Padding(
//                padding: const EdgeInsets.only(right: 8),
//                child: SvgPicture.asset('assets/logo_1.svg'),
//              ),
//            ),
//        Opacity(
//          opacity: animation3.value <= 0.3
//              ? 2.5 * animation3.value
//              : (animation3.value > 0.30 && animation3.value <= 0.70)
//              ? 1.0
//              : 2.5 - (2.5 * animation3.value),
//          child: Padding(
//            padding: const EdgeInsets.only(right: 8),
//            child: Container(
//              width: 30,
//              height: 30,
//              color: Colors.green,
//            ),
//          ),
//        ),
          ],
        ),
      ),
    );
  }


}
