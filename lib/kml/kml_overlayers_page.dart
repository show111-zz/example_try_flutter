import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:xml/xml.dart';

class KmlGroundOverlayerPage extends StatefulWidget {
  @override
  _KmlGroundOverlayerPageState createState() => _KmlGroundOverlayerPageState();
}

class _KmlGroundOverlayerPageState extends State<KmlGroundOverlayerPage> {

  MapController mapController;
  LatLng center = LatLng(45.424721, -75.695);
  LatLngBounds bounds = LatLngBounds(LatLng(51.5, -0.09), LatLng(48.8566, 2.3522));
  ImageProvider provider = NetworkImage(
      'https://images.pexels.com/photos/231009/pexels-photo-231009.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=600');


  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    OverlayImage overlayImage = OverlayImage(bounds: bounds, opacity: 0.8, imageProvider: provider);
    var overlayImages = <OverlayImage>[
      overlayImage
    ];

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
                  OverlayImageLayerOptions(overlayImages: overlayImages)
                ],
              ),
            ),
            FloatingActionButton(child: Text('Overlayers'),onPressed: ()async{
             OverlayImage overlayImageinit = await initOverlayerImage();
             setState(() {
                overlayImage = overlayImageinit;
             });
             mapController.move(bounds.northEast, 10.0);
            },)
          ],
        ),
      ),
    );
  }

  Future<OverlayImage> initOverlayerImage() async {

    String overlayerSample = await rootBundle.loadString('assets/kml_overlayers_sample.kml');
    if (overlayerSample != null) {
      XmlDocument xmlDocument = parse(overlayerSample);
      Iterable<XmlElement> overlayerElements = xmlDocument.findAllElements('GroundOverlay');
      overlayerElements.forEach((element) {
         Iterable<XmlElement> latLonBox = element.findAllElements('LatLonBox');
         latLonBox.forEach((element) {
           Iterable<XmlElement> north = element.findElements('north');
           Iterable<XmlElement> south = element.findElements('south');
           Iterable<XmlElement> east = element.findElements('east');
           Iterable<XmlElement> west = element.findElements('west');
           var southWest = LatLng(double.parse(south.first.text),double.parse(west.first.text));
           var northEast = LatLng(double.parse(north.first.text),double.parse(east.first.text));
           bounds = LatLngBounds(southWest, northEast);
         });
      });
      overlayerElements.forEach((element) {
        Iterable<XmlElement> icon = element.findAllElements('Icon');
        icon.forEach((element) {
          Iterable<XmlElement> href = element.findElements('href');
          print(href.first.text);
          provider = NetworkImage(href.first.text);
        });
      });
    }
    return OverlayImage(bounds: bounds, opacity: 0.8, imageProvider: provider);
  }

}
