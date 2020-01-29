import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/util/slide_left_route.dart';

import 'detail_two.dart';

void main() {
  runApp(DetailOneDialog());
}

class DetailOneDialog extends StatefulWidget {
  @override
  _DetailOneDialogState createState() => _DetailOneDialogState();
}

class _DetailOneDialogState extends State<DetailOneDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: const Text('Persistent bottom sheet')),
          body: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: _showBottomSheet(context),
              ))),
      routes: <String, WidgetBuilder>{
          '/b': (BuildContext context) => new DetailTwoPage(),
      },
    );
  }
}

Container _showBottomSheet(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        _image(),
        _titleSection(),
        _titleEvent(context),
        _buttonSection()
      ],
    ),
  );
}

Widget _image() {
  return Container(
    child: new Image.network(
      'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
      fit: BoxFit.fitWidth,
      width: 420,
      height: 200,
    ),
  );
}

Widget _titleEvent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15),
    alignment: Alignment.topLeft,
    child: Column(
       children: <Widget>[
         GestureDetector(
           child:  Text(
             'Events',
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
           ),
           onTap: (){
             Navigator.of(context).pushNamed('/b');
//             Navigator.push(context, SlideRightRoute(page: DetailTwoPage()));
           },
         ),
       ],
    ),
  );
}

Widget _titleSection() {
  return Container(
    padding: const EdgeInsets.all(15),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Oeschinen Lake Campground',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        Text(
          'Kandersteg, Switzerland',
          style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
        ),
        Text(
          'Minimum Depth: 12km    Maximum Depth: 52km',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0),
        ),
        Text(
          'Minimum Depth: 12km ',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0),
        ),
        Text(
          'Analysis Type: AI Analysis',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0),
        ),
      ],
    ),
  );
}

Widget _buttonSection() {
  return GestureDetector(
    onTap: () {
//       Navigator.push(context, SlideRightRoute(page: DetailTwoDialog()));
//       Navigator.of(context).pushNamed('/b');
    },
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildListColumn(Colors.orange),
          new Divider(),
          _buildListColumn(Colors.red),
          new Divider(),
          _buildListColumn(Colors.blueGrey),
          new Divider(),
        ],
      ),
    ),
  );
}

Column _buildListColumn(Color colors) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(15),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new ListTile(
                leading: Icon(Icons.brightness_1, color: colors),
                title: new Text(
                  'AK, United States',
                  style: new TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 10.0),
                ),
                subtitle: new Text(
                  'fdsfds',
                  style: new TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 6.0),
                ),
                dense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              flex: 3,
            ),
            Expanded(
              child: new ListTile(
                title: new Text(
                  'Nov 13, 2019',
                  style:
                      new TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0),
                ),
                subtitle: new Text(
                  '07:48',
                  style: new TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 8.0),
                ),
                dense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              flex: 2,
            ),
            new Container(
              width: 50.0,
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
              decoration: new BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.5),
                borderRadius: new BorderRadius.circular(20.0),
              ),
              child: new Text(
                '2:43',
                style: new TextStyle(fontSize: 8.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
