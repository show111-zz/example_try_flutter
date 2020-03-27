import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/path_line_animation.dart';
import 'package:flutter_app/stagger_animation_page.dart';
import 'package:flutter_app/util/slide_left_route.dart';

import 'AnimatedDecoratedBox1.dart';
import 'TypeWriterWidget.dart';
import 'animated_switcher_page.dart';
import 'custom_icon_animation.dart';
import 'gesture_painter_widget.dart';
import 'gooey_animation_widget.dart';

class AnimationPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text('Animation Part'),
              leading: Icon(Icons.arrow_back_ios, color: Colors.white)),
          body: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Text("Path Line Animation",
                      style: TextStyle(fontSize: 30, color: Colors.green)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: PathLineAnimation()));
                  },
                ),
                GestureDetector(
                  child: Text("Custom Gesture Director",
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: GesturePainterWidget()));
                  },
                ),
                GestureDetector(
                  child: Text("Gooey Animation",
                      style: TextStyle(fontSize: 30, color: Colors.blueAccent)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: GooeyAnimationWidget()));
                  },
                ),

                GestureDetector(
                  child: Text("Custom Tween Animation",
                      style: TextStyle(fontSize: 30, color: Colors.amber)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: CustomIconAnimationPage()));
                  },
                ),

                GestureDetector(
                  child: Text("Stagger Animation",
                      style: TextStyle(fontSize: 30, color: Colors.cyan)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: StaggerAnimationPage()));
                  },
                ),

                GestureDetector(
                  child: Text("Animated Switcher",
                      style: TextStyle(fontSize: 30, color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: AnimatedSwitcherCounterRoute()));
                  },
                ),

                GestureDetector(
                  child: Text("Type Writer Animation",
                      style: TextStyle(fontSize: 30, color: Colors.teal)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: TypeWriterWidget()));
                  },
                ),

                GestureDetector(
                  child: Text("Animated Decorated Box",
                      style: TextStyle(fontSize: 30, color: Colors.lightGreen)),
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: AnimatedDecoratedBox1()));
                  },
                ),

              ],
            ),
          )),
    );
  }
}
