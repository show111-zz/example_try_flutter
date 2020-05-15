import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:xml/xml.dart';

class KmlGoundOverlayersPage extends StatefulWidget {
  @override
  _KmlGoundOverlayersPageState createState() => _KmlGoundOverlayersPageState();
}

class _KmlGoundOverlayersPageState extends State<KmlGoundOverlayersPage> {
  MapController mapController;
  LatLng center = LatLng(45.424721, -75.695);
  var polygons = <Polygon>[
    Polygon(points: [LatLng(45.424721, -75.695)], color: Colors.deepOrange.withOpacity(0.6))
  ];
  LatLng noImportant;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Future<List<LatLng>> initPolygon() async {
    List<LatLng> points = List();
    String polygonSample =
        await rootBundle.loadString('assets/kml_polygon_sample.kml');
    if (polygonSample != null) {
      XmlDocument xmlDocument = parse(polygonSample);
      Iterable<XmlElement> polygonElements =
          xmlDocument.findAllElements('Polygon');
      polygonElements.forEach((element) {
        Iterable<XmlElement> coordinates =
            element.findAllElements('coordinates');
        print(coordinates.first.text);
        List<String> allPointStr = coordinates.first.text.split(',0');
        List<String> sublist = allPointStr.sublist(0, 20);
        sublist.forEach((element) {
          String s0 = element.split(',')[0];
          String s1 = element.split(',')[1];
          noImportant = LatLng(double.parse(s1), double.parse(s0));
          points.add(LatLng(double.parse(s1), double.parse(s0)));
        });
      });
      return points;
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Kml Gound Overlayers Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FlutterMap(
                mapController: mapController,
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
                  PolygonLayerOptions(polygons: polygons)
                ],
              ),
            ),
            FloatingActionButton(child: Text('Polygon'),onPressed: ()async{
              List<LatLng> points = await initPolygon();
              final poly = Polygon(points: points, color: Colors.deepOrange.withOpacity(0.6));
              setState(() => polygons.add(poly));
              mapController.move(noImportant, 13.0);

            },)
          ],
        ),
      ),
    );
  }
}
