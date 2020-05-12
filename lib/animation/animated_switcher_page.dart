
import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRoute extends StatefulWidget {

  const AnimatedSwitcherCounterRoute({Key key}): super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() => _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;
  List text = ['s','y','n'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               AnimatedSwitcher(duration: const Duration(milliseconds: 200),
                 transitionBuilder: (Widget child, Animation<double> animation){
                 var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                   return ScaleTransition(scale: animation, child: child,);
//                   return MySlideTransition(position: tween.animate(animation,),child: child);
                   return SlideTransitionX(position: animation, child: child, direction: AxisDirection.up,);
                 },
                 child: Text('${text[_count]}',key: ValueKey<int>(_count),style: Theme.of(context).textTheme.display1,),),
               RaisedButton(child: Text('next'), onPressed: (){ if(_count < text.length){setState(() {_count++;},);} },)
             ],
           ),
         ),
       ),
    );
  }

}

// advanced animated switcher
class MySlideTransition extends AnimatedWidget{

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  MySlideTransition({Key key, @required Animation<Offset> position, this.transformHitTests = true, this.child}): assert(position != null), super(key: key, listenable: position);

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if(position.status == AnimationStatus.reverse){
       offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(translation: offset, transformHitTests: transformHitTests, child: child,);
  }
}


// common used method
class SlideTransitionX extends AnimatedWidget{

  final Widget child;
  final bool transformHitTests;
  final AxisDirection direction;
  Animation<double> get position => listenable;
  Tween<Offset> _tween;

  SlideTransitionX({Key key, @required Animation<double> position, this.transformHitTests = true, this.direction= AxisDirection.down, this.child}): assert(position != null), super(key: key, listenable: position){
     switch(direction){
       case AxisDirection.up:
         _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
         break;
       case AxisDirection.right:
         _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
         break;
       case AxisDirection.down:
         _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
         break;
       case AxisDirection.left:
         _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
         break;
     }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if(position.status == AnimationStatus.reverse){
       switch(direction){
         case AxisDirection.up:
           offset = Offset(offset.dx, -offset.dy);
           break;
         case AxisDirection.right:
           offset = Offset(-offset.dx, offset.dy);
           break;
         case AxisDirection.down:
           offset = Offset(offset.dx, -offset.dy);
           break;
         case AxisDirection.left:
           offset = Offset(-offset.dx, offset.dy);
           break;
       }
    }
    return FractionalTranslation(translation: offset, transformHitTests: transformHitTests, child: child,);

  }

}

