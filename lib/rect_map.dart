import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class RectMapPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return DrawRectPluginState();
  }
}

class DrawRectPluginState extends State<RectMapPage>{
  var point1 = LatLng(51.5, -0.09);
  var point2 = LatLng(48.8566, 2.3522);

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {

    var _markers = _getMarkerList(point1, point2);

    return Scaffold(
      appBar: AppBar(title: Text('Rectangle plugin on Map')),
      body: Column(
        children: <Widget>[
           Flexible(child: FlutterMap(
             mapController: mapController,
             options: MapOptions(center: point1, zoom: 6.0, onPositionChanged: _handlePositionChanged , plugins: [RectangleCustomPlugin()]),
             layers: [
               TileLayerOptions(
                 urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                 additionalOptions: {
                   'accessToken': 'pk.eyJ1IjoiaHVpbGVlIiwiYSI6ImNrN20xazlmcjA4ankzaHBvcHhvNWV3aWgifQ.KSYTP_EopSvW9lmTcvglKw',
                   'id': 'mapbox.streets',
                 },
               ),
               MarkerLayerOptions(markers: _markers),
               RectanglePluginOptions(point1, point2, 2.0, Colors.deepOrange.withOpacity(0.5), 5.0)
             ],
           ))
        ],
      ),
    );
  }
}

class RectanglePluginOptions extends LayerOptions{
   LatLng point1;
   LatLng point2;
   Offset offset1 = Offset.zero;
   Offset offset2 = Offset.zero;
   double width;
   double lineWidth;
   Color lineColor;

  RectanglePluginOptions(point1, point2, width, lineColor, lineWidth){
    this.point1 = point1;
    this.point2 = point2;
    this.width = width;
    this.lineWidth = lineWidth;
    this.lineColor = lineColor;
  }
}

class RectangleCustomPlugin implements MapPlugin{
  @override
  Widget createLayer(LayerOptions options, MapState mapState, Stream<Null> stream) {
    if(options is RectanglePluginOptions){
       return RectangleLayer(options, mapState, stream);
    }
    throw Exception('Unknown options type for MyCustome plugin: $options');
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is RectanglePluginOptions;
  }
}


class RectangleLayer extends StatelessWidget{

  final RectanglePluginOptions options;
  final MapState mapState;
  final Stream<Null> stream;

  RectangleLayer(this.options, this.mapState, this.stream);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints bc){
         final size = Size(bc.maxWidth, bc.maxHeight);
         return _build(context, size);
      },
    );
  }

  Widget _build(BuildContext context, Size size) {
     return StreamBuilder<void>(
         stream: stream,
         builder:(BuildContext context,_) {
            var pos1 = mapState.project(options.point1);
            pos1 = pos1.multiplyBy(mapState.getZoomScale(mapState.zoom, mapState.zoom)) - mapState.getPixelOrigin();
            options.offset1 = Offset(pos1.x.toDouble(), pos1.y.toDouble());

            var pos2 = mapState.project(options.point2);
            pos2 = pos2.multiplyBy(mapState.getZoomScale(mapState.zoom, mapState.zoom)) - mapState.getPixelOrigin();
            options.offset2 = Offset(pos2.x.toDouble(), pos2.y.toDouble());

            return CustomPaint(
              painter: RectanglePainter(options.offset1, options.offset2, options.width, options.lineColor, options.lineWidth),
            );
         },
     );
  }
}

class RectanglePainter extends CustomPainter{
  final Offset offset1;
  final Offset offset2;
  final double width;
  final double lineWidth;
  Color lineColor;

  RectanglePainter(this.offset1,this.offset2, this.width, this.lineColor, this.lineWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromPoints(this.offset1, this.offset2);
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

List<Marker> _getMarkerList(LatLng point1, LatLng point2){
   if(point1 == null){
      point1 = LatLng(51.5, -0.09);
   }
   if(point2 == null){
      point2 = LatLng(48.8566, 2.3522);
   }
   var markers = <Marker>[
     Marker(
         width: 80.0,
         height: 80.0,
         point: point1,
         builder: (context) => Container(
             child: Draggable<Icon>(
               child: Icon(Icons.add_location, size: 50, color: Colors.green,), onDragStarted: _handleDragStart, onDragEnd:_handleDragEnd, onDragCompleted: _handleDragCompleted,
               feedback: Icon(Icons.add_location, size: 50, color: Colors.red),
             )
         )
     ),
     Marker(
         width: 80.0,
         height: 80.0,
         point: point2,
         builder: (context) => Container(child: Icon(Icons.add_location, size: 50,))
     )
   ];
   return markers;
}

void _handlePositionChanged(MapPosition position, bool hasGesture) {
  debugPrint("position changed: latitude is ${position.center.latitude},longtude is ${position.center.longitude}, hasGesture is $hasGesture");
}

void _handleDragStart() {
  debugPrint("on Drag Start");
}

void _handleDragEnd(DraggableDetails details) {
  Offset offset1 = details.offset;
  debugPrint("on Drag end: offset dx is ${offset1.dx}, offset dy is ${offset1.dy}");
}

void _handleDragCompleted() {
  debugPrint("on Drag completed");
}
