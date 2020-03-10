import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/util/slide_left_route.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'detail_two.dart';

class DetailOneDialog extends StatefulWidget {
  @override
  _DetailOneDialogState createState() => _DetailOneDialogState();
}

class _DetailOneDialogState extends State<DetailOneDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<LatLng> tappedPoints = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              title: const Text('Detail Page One'),
              leading: Icon(Icons.arrow_back_ios, color: Colors.white)),
          body: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  child: _showBottomSheet(context),
              ))),
    );
  }
}

Container _showBottomSheet(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        _showMap(),
        _titleSection(),
        _titleEvent(context),
        Divider(),
        _buttonSection()
      ],
    ),
  );
}

Widget _showMap() {
  var markers = <Marker>[
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(53.3498, -6.2603),
      builder: (ctx) =>
          Container(child: Icon(Icons.fiber_manual_record, color: Colors.red)),
    ),
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(48.8566, 2.3522),
      builder: (ctx) => Container(
        child: Icon(Icons.fiber_manual_record, color: Colors.green),
      ),
    )
  ];

  var polygonLayer = <Polygon>[
    Polygon(
        points: [
          LatLng(53.3498, -6.2603),
          LatLng(48.8566, 2.3522),
          LatLng(51.5, -0.09)
        ],
        borderColor: Colors.greenAccent,
        borderStrokeWidth: 2,
        color: Colors.transparent)
  ];

  MapController mapController = MapController();

  return Container(
    child: Column(
      children: <Widget>[
        Flexible(
            child: FlutterMap(
          options: MapOptions(
            zoom: 5.0,
            center: LatLng(51.5, -0.09),
//            onLongPress: _handleLongPress,
//            onPositionChanged: _handlePositionChanged
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoiaHVpbGVlIiwiYSI6ImNrN20xazlmcjA4ankzaHBvcHhvNWV3aWgifQ.KSYTP_EopSvW9lmTcvglKw',
                'id': 'mapbox.streets',
              },
            ),
            MarkerLayerOptions(markers: markers),
//            OverlayImageLayerOptions(overlayImages: overlayImage)
//              PolylineLayerOptions(polylines: polylineLayer )
            PolygonLayerOptions(polygons: polygonLayer)
          ],
          mapController: mapController,
        ))
      ],
    ),
    height: 200,
    color: Colors.grey[350],
  );
}


Widget _titleEvent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15),
    alignment: Alignment.topLeft,
    child: Column(
      children: <Widget>[
        GestureDetector(
          child: Text(
            'Events',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: DetailTwoPage()));
          },
        ),
      ],
    ),
  );
}

Widget _titleSection() {
  return Container(
    padding: const EdgeInsets.all(8),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Oeschinen Lake Campground', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, height: 1.5),),
        Text(
          'Kandersteg, Switzerland',
          style:
              TextStyle(color: Colors.grey[500], fontSize: 12.0, height: 1.5),
        ),
        Text(
          'Minimum Depth: 12km    Maximum Depth: 52km',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0, height: 2.0),
        ),
        Text(
          'Minimum Depth: 12km ',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0, height: 2.0),
        ),
        Text(
          'Analysis Type: AI Analysis',
          style: TextStyle(color: Colors.grey[500], fontSize: 8.0, height: 2.0),
        ),
      ],
    ),
  );
}

Widget _buttonSection() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildListColumn(Colors.orange),
        new Divider(),
        _buildListColumn(Colors.red),
        new Divider(),
        _buildListColumn(Colors.blueGrey),
        new Divider(),
      ],
    ),
  );
}

Column _buildListColumn(Color colors) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
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


void _handleLongPress(LatLng point) {
  debugPrint('point latitude is--> ${point.latitude}, longtide is ${point.longitude}');
}

void _handlePositionChanged(MapPosition position, bool hasGesture) {
  debugPrint('position latitude is--> ${position.center.latitude}, longtide is ${position.center.longitude}, has getsture is $hasGesture');
}

void _handleTap(LatLng point) {
  debugPrint('tap point latitude is--> ${point.latitude}, longtide is ${point.longitude}');
}
