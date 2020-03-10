import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class DetailTwoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Page Two"),
        ),
        body: Column(
          children: <Widget>[
            _image(),
            _titleSection(),
            _toggleButton(),
            _buttonSection(context),
          ],
        )
    );
  }
}

Widget _image(){
  return Container(
    child: Column(
      children: <Widget>[
        Flexible(
            child: FlutterMap(
              options: MapOptions(zoom: 5.0),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'http://www.google.com/maps/vt?lyrs=m@189&gl=en&x={x}&y={y}&z={z}',
                  subdomains: [],
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
              ],
            )
        )
      ],
    ),
    height: 200,
    color: Colors.grey[300],
  );
}

Widget _titleSection(){
  return Container(
    alignment: Alignment.topLeft,
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AOI Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize:15.0, height: 1.5)),
        Text('Exact Location, Location ', style: TextStyle(color: Colors.grey[500], fontSize:10.0, height: 1.5),),
        Text('Minimum Depth       Maximum Depth', style: TextStyle(color: Colors.grey[500], fontSize:10.0, height: 1.5),),
        Text('Method of Event Detection: ', style: TextStyle(color: Colors.grey[500], fontSize:12.0, height: 2),),
        Text('Method of Event Detection: Auto, Real ', style: TextStyle(color: Colors.grey[500], fontSize:12.0, height: 2),),
        Text('Analysis Type: AI Analysis', style: TextStyle(color: Colors.grey[500], fontSize:12.0, height: 2),),
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
        color: Colors.grey[350],
        height: 40.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
      Container(
        color: Colors.grey[350],
        height: 40.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      )
    ],
  );
}
