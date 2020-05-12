import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SyntronicLogoAnimate2 extends StatefulWidget {
  @override
  _SyntronicLogoAnimate2State createState() => _SyntronicLogoAnimate2State();
}

class _SyntronicLogoAnimate2State extends State<SyntronicLogoAnimate2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation1;
  Animation<double> animation2;
  final animation3Size = Tween<double>(begin: 0, end: 100);
  AnimationController controller;

  bool run = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1.0, curve: Curves.easeIn),
      ),
    );
    animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1.0, curve: Curves.easeIn),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: animation1.value,
                child: SvgPicture.asset(
                  'assets/logo_0.svg',
                  width: animation3Size.evaluate(animation1),
                  height: animation3Size.evaluate(animation1),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Opacity(
                opacity: animation2.value,
                child: SvgPicture.asset(
                  'assets/logo_16.svg',
                  width: animation3Size.evaluate(animation2),
                  height: animation3Size.evaluate(animation2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
