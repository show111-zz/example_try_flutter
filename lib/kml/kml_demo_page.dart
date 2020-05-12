import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:xml/xml.dart';


class KmlDemoPage extends StatefulWidget {
  @override
  _KmlDemoPageState createState() => _KmlDemoPageState();
}

class _KmlDemoPageState extends State<KmlDemoPage> {
  var centerPoint = LatLng(50.0967, 1.2391);
  String text = "";
  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = new MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KML Screen'),),
      body: Column(
         children: <Widget>[
           Flexible(
             child: FlutterMap(
               mapController: mapController,
               options: MapOptions(center: centerPoint, zoom: 7.3, ),
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
           ),
           FloatingActionButton(child: Text(text),onPressed: (){
             parseKml();
           },)
         ],
      ),
    );
  }

  Future<String> getStringFromSvg() async {
    return  await rootBundle.loadString('assets/kml_sample.kml');
  }

  void parseKml() async{
    String doc = await getStringFromSvg();
    XmlDocument xmlDocument = parse(doc);
    print(xmlDocument.rootElement.findElements('Placemark'));
  }

}
