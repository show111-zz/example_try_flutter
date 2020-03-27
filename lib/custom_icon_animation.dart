import 'package:flutter/material.dart';

class CustomIconAnimationPage extends StatefulWidget {
  @override
  _CustomIconAnimationPageState createState() =>
      _CustomIconAnimationPageState();
}

class _CustomIconAnimationPageState extends State<CustomIconAnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
//    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
           controller.reverse();
        } else if(status == AnimationStatus.dismissed){
           controller.forward();
        }
      })
    ;
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
//    return AnimatedImage(animation: animation,);
//    return AnimatedBuilder(
//        animation: animation,
//        child: Image.asset('images/Bg-Red.png'),
//        builder: (BuildContext context, Widget child) {
//           return Center(
//              child: Container(
//                width: animation.value,
//                height: animation.value,
//                child: child,
//              ),
//           );
//        },
//    );
    return GrowTransition(
       child: Image.asset('images/Bg-Red.png'),
       animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        'images/Bg-Blue.png',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});
  final Widget child;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget child){
         return Container(
           width: animation.value,
           height: animation.value,
           child: child,
         );
      },child: child,),
    );
  }
}

