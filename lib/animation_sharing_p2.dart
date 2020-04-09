import 'package:flutter/material.dart';
import 'package:flutter_app/animation_sharing_3.dart';

class AnimationSharePage2 extends StatefulWidget {
  @override
  _AnimationSharePage2State createState() => _AnimationSharePage2State();
}

class _AnimationSharePage2State extends State<AnimationSharePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Image.asset('images/syntronic_left.png', ),
            ),
            SizedBox(height: 30.0,),
            Text('This is page 2'),
            RaisedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AnimationSharing3();
              }));
            }, child: Text('click'),)
          ],
        ),
      ),
    );
  }
}
