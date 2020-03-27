import 'package:flutter/material.dart';

class TypeWriterWidget extends StatefulWidget {
  @override
  _TypeWriterWidgetState createState() => _TypeWriterWidgetState();
}

class _TypeWriterWidgetState extends State<TypeWriterWidget> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<String> animation;
  String logo = "Syntronic";

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = TypewriterTween(end: logo).animate(controller)..addStatusListener(
        (status){
          if(controller.status == AnimationStatus.completed) {
            controller.reverse();
          } else if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          }
        }
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: AnimatedBuilder(animation: animation, builder: (context, child){ return Text('${animation.value}', style: TextStyle(fontSize: 30.0,color: Colors.blue),); }),
            ),
          ],
        ),
      ),
    );
  }

}

class TypewriterTween extends Tween<String>{
  TypewriterTween({ String begin = '', String end }): super(begin: begin, end: end);

  String lerp(double time){
     var cutoff = (end.length * time).round();
     return end.substring(0, cutoff);
  }

}
