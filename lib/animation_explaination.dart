import 'package:flutter/material.dart';

import 'animation_sharing_p2.dart';

/// 1. opacity
/// 2. tween
/// 3. hero

class AnimationSharing extends StatefulWidget {
  @override
  _AnimationSharingState createState() => _AnimationSharingState();
}

class _AnimationSharingState extends State<AnimationSharing> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animationOpacity;
  Animation<double> animationSize;
  Animation<Color> animationColor;
  Animation animationCurve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this ,duration: const Duration(seconds: 3));

    animationCurve = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animationOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(animationCurve)..addListener(() {setState(() {
    });});

    animationSize = Tween<double>(begin: 1, end: 200).animate(animationCurve)..addListener(() {setState(() {
    });});

    animationColor = ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);

//    animationSize.addStatusListener((status) {
//      if(status == AnimationStatus.completed){
//         controller.reverse();
//      }else if(status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    });


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
      backgroundColor: animationColor.value,

      body: Column(
        children: <Widget>[
          Center(
//        child: Opacity(opacity: animation.value, child: Image.asset('images/syntronic_left.png'),),
            child: Opacity(
              opacity: animationOpacity.value,
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/syntronic_left.png', width: animationSize.value, height: animationSize.value,),
                ),
              ),
            ),
          ),

         RaisedButton(
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context){
               return AnimationSharePage2();
             }));
           },
           child: Text('Click'),
         )

        ],
      ),
    );
  }

}









