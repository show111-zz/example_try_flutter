import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/path_line_animation.dart';
import 'package:flutter_app/util/slide_left_route.dart';

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
                ListTile(
                  title: Text(
                    'Custom Animation',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, SlideRightRoute(page: CustomIconAnimationPage()));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
