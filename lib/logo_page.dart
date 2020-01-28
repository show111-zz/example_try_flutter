
import 'package:flutter/material.dart';
import 'package:flutter_app/util/slide_left_route.dart';

import 'detail_one.dart';


void main() {
  runApp(new MaterialApp(
    theme: new ThemeData(primaryColor: Colors.blue),
    home: new ListApp(),
//    routes: <String, WidgetBuilder>{
//      '/a': (BuildContext context) => new DetailOnePage(),
//    },
  ));
}

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(child: new Text("LOGO", textAlign: TextAlign.center)),
        actions: <Widget>[
          new Icon(Icons.add)
        ],
      ),
      body: new ListAppPage(),
    );
  }
}

class ListAppPage extends StatefulWidget {
  ListAppPage({Key key}) : super(key: key);

  @override
  _ListAppPageState createState() => new _ListAppPageState();
}

class _ListAppPageState extends State<ListAppPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(children: _getListData(context)),
    );
  }

  _getListData(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < 10; i++) {
      widgets.add(new Padding(padding: new EdgeInsets.only(left: 15.0, right: 15.0),
        child: new GestureDetector(
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: new ListTile(
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                flex: 3,
              ),
              Expanded(
                child: new ListTile(
                  title: new Text(
                    'Nov 13, 2019',
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 8.0),
                  ),
                  subtitle: new Text(
                    '07:48',
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 8.0),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                flex: 2,
              ),
              new Container(
                width: 50.0,
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
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
          onTap: (){
//          Navigator.of(context).pushNamed('/a');
//          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnePage(), maintainState: false));
          Navigator.push(context, SlideRightRoute(page: DetailOneDialog()));
          },
        ),
      ));
      // item
      widgets.add(new Divider());
    }
    return widgets;
  }
}
