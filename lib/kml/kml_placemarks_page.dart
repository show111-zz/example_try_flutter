import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:xml/xml.dart';

class KmlPlacemarksPage extends StatefulWidget {
  @override
  _KmlPlacemarksPageState createState() => _KmlPlacemarksPageState();
}

class _KmlPlacemarksPageState extends State<KmlPlacemarksPage> {
//  var centerPoint = LatLng(37.42229, -122.082204);
  LatLng centerPoint = LatLng(45.424721, -75.695);
  LatLng point;
  List<Marker> markers;

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = new MapController();
  }

  @override
  Widget build(BuildContext context) {
    markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.deepOrange,
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('KML Screen'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: centerPoint,
                zoom: 5.0,
              ),
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
                MarkerLayerOptions(
                    markers: point != null ? markers : List<Marker>()),
              ],
            ),
          ),
          FloatingActionButton(
            child: Text('Press'),
            onPressed: () async {
              LatLng pointKml = await parseKml();
              if (pointKml != null) {
                setState(() {
                  point = pointKml;
                });
              }
              mapController.move(point, 5.0);
            },
          )
        ],
      ),
    );
  }

  Future<String> getStringFromSvg() async {
    return await rootBundle.loadString('assets/kml_placemark_sample.kml');
  }

  Future<LatLng> parseKml() async {
    LatLng point;
    String doc = await getStringFromSvg();
    XmlDocument xmlDocument = parse(doc);
    Iterable<XmlElement> allElements = xmlDocument.rootElement.findAllElements("Placemark");
    allElements.forEach((element) {
      Iterable<XmlElement> findElements = element.findElements('Point');
      findElements.forEach((element) {
        Iterable<XmlElement> coordinate = element.findElements('coordinates');
        List<String> coordinateArray = coordinate.elementAt(0).text.split(',');
        var longitude = coordinateArray[0];
        var latitude = coordinateArray[1];
        point = new LatLng(double.parse(latitude), double.parse(longitude));
      });
    });
    return point;
  }
}
