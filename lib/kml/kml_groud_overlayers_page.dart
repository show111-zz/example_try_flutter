import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class KmlGoundOverlayersPage extends StatefulWidget {
  @override
  _KmlGoundOverlayersPageState createState() => _KmlGoundOverlayersPageState();
}

class _KmlGoundOverlayersPageState extends State<KmlGoundOverlayersPage> {

  MapController mapController;
  LatLng center = LatLng(45.424721, -75.695);

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kml Gound Overlayers Page'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FlutterMap(mapController: mapController,
                options: MapOptions(center: center, zoom: 5.0),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}

