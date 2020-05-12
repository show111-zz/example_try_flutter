import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

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
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
