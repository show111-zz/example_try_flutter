import 'dart:ui';

import 'package:flutter/material.dart';


void main() {
  // debugPaintSizeEnabled = true;
  runApp(DetailTwoPage());
}

class DetailTwoPage extends StatefulWidget {
  @override
  _DetailTwoPageState createState() => _DetailTwoPageState();
}

class _DetailTwoPageState extends State<DetailTwoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: ListTile(
            title: Text('AK, United Stated'),
            subtitle: Text('100km NE of Cape Yakataga'),
            leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
          ) ),
          body: Align(alignment: Alignment.bottomLeft,
              child: Container(
              child: _showBottomSheet(context),
//              width: MediaQuery.of(context).size.width,
          ))),
    );
  }
}

Widget _showBottomSheet(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _image(),
        _titleSection(),
        _toggleButton(),
        _buttonSection(context),
      ],
  );
}

Widget _image(){
  return Container(
    child:
      new Image.network('https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
        fit: BoxFit.fitWidth,
        width: 420,
        height: 200,
      ),
  );
}

Widget _titleSection(){
  return  Container(
    padding: const EdgeInsets.only(left:15.0, right: 15.0, top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text('AOI Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize:15.0),),
          Text('Exact Location, Location ', style: TextStyle(color: Colors.grey[500], fontSize:12.0),),
          Text('Minimum Depth       Maximum Depth', style: TextStyle(color: Colors.grey[500], fontSize:12.0),),
          Text('Method of Event Detection: Auto, Real ', style: TextStyle(color: Colors.grey[500], fontSize:14.0),),
          Text('Analysis Type: AI Analysis', style: TextStyle(color: Colors.grey[500], fontSize:14.0),),
      ],
    ),
  );
}

Widget _buttonSection(BuildContext context){
   return Container(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         _buildListColumn(Colors.orange),
         _buildListColumn(Colors.blueGrey),
         new Divider(),
       ],
     ),
   );
}

Widget _toggleButton(){
   return Container(
        padding: const EdgeInsets.only(left:15.0, right: 15.0),
        child: Row(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: new ListTile(
                 title: new Text(
                   'Notification Trigger',
                   style: new TextStyle(
                       fontWeight: FontWeight.w500, fontSize: 13.0),
                 ),
                 subtitle: new Text(
                   'Turning off notification trigger will remove event from main page',
                   style: new TextStyle(
                       fontWeight: FontWeight.w300, fontSize: 10.0),
                 ),
                 isThreeLine: true,
                 dense: true,
                 contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
               ),
               flex: 3,
             ),

              Expanded(
                child: Icon(Icons.account_circle, color: Colors.blue),
                flex: 1,
              )
           ],
        ),
   );
}



Column _buildListColumn(Color colors) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
         Container(
           padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
           alignment: Alignment.topLeft,
           child: Text('Rel. to Historical Seismicity', style: TextStyle(color: Colors.grey[500], fontSize:14.0)),
         ),
      Container(
        color: Colors.grey,
        height: 50.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
      Container(
        color: Colors.grey,
        height: 50.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      )
    ],
  );
}

Column _CupertinoSwitchButton() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Rel. to Historical Seismicity', style: TextStyle(color: Colors.grey[500], fontSize:14.0),),
    ],
  );
}


