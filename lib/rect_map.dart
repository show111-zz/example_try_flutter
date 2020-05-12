import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';
import 'map/dragmarker.dart';
import 'map/rectangle_layer.dart';

class RectMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawRectPluginState();
  }
}

class DrawRectPluginState extends State<RectMapPage> {
  var point1 = LatLng(51.5, -0.09);
  var point2 = LatLng(48.8566, 2.3522);
  var centerPoint = LatLng(50.0967, 1.2391);
  String textStr = 'Create';

  MapController mapController;
  bool isShowMarkers = false;
  bool isShowRectangle = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    List<DragMarker> _showMarkers() {
      return [
        DragMarker(
          point: point1,
          width: 50.0,
          height: 50.0,

          builder: (ctx) => Container(
            child: SvgPicture.asset(
              'assets/marker_left.svg',
              fit: BoxFit.fill,
            ),
          ),
          onDragUpdate: (details, point) {
            setState(() {
              point1 = point;
            });
          },
          updateMapNearEdge: true,
          nearEdgeRatio: 2.0,
          nearEdgeSpeed: 1.0,
        ),
        DragMarker(
          point: point2,
          width: 50.0,
          height: 50.0,
          builder: (ctx) => Container(
            child: SvgPicture.asset(
              'assets/marker_right.svg',
              fit: BoxFit.fill,
            ),
          ),
          onDragUpdate: (details, point) {
            setState(() {
              point2 = point;
            });
          },
          updateMapNearEdge: false,
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Rectangle plugin on Map')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(center: centerPoint, zoom: 7.3, plugins: [
                RectangleCustomPlugin(),
                DragMarkerPlugin(),
              ]),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                  "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken':
                    'pk.eyJ1IjoiaHVpbGVlIiwiYSI6ImNrN20xazlmcjA4ankzaHBvcHhvNWV3aWgifQ.KSYTP_EopSvW9lmTcvglKw',
                    'id': 'mapbox.streets',
                  },
                ),
                DragMarkerPluginOptions(
                    markers:
                    isShowMarkers ? _showMarkers() : List<DragMarker>()),
                isShowRectangle ? RectanglePluginOptions(point1, point2, 2.0,
                    Colors.deepOrangeAccent.withOpacity(0.5), 5.0) : OverlayImageLayerOptions()
              ],
            ),
          ),
          Card(
            color: Color(0xFF2F709F),
            elevation: 3,
            shape: ContinuousRectangleBorder(
                side: BorderSide.none, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  if (textStr == 'Create') {
                    setState(() {
                      textStr = 'Set';
                      isShowMarkers = true;
                      isShowRectangle = true;
                    });
                  } else if (textStr == 'Set') {
                    setState(() {
                      textStr = 'Edit';
                      isShowMarkers = false;
                      isShowRectangle = true;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      textStr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0,),
                    ),

                    SvgPicture.asset(
                      'assets/rectangle_text.svg',
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
