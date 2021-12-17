import 'package:flutter/material.dart';

class TileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = 0.55;
    final double _yScaling = 0.45;
    path.lineTo(274 * _xScaling,176.5 * _yScaling);
    path.cubicTo(274 * _xScaling,273.978 * _yScaling,274 * _xScaling,353 * _yScaling,137 * _xScaling,353 * _yScaling,);
    path.cubicTo(0 * _xScaling,353 * _yScaling,0 * _xScaling,273.978 * _yScaling,0 * _xScaling,176.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,79.0217 * _yScaling,0 * _xScaling,0 * _yScaling,137 * _xScaling,0 * _yScaling,);
    path.cubicTo(274 * _xScaling,0 * _yScaling,274 * _xScaling,79.0217 * _yScaling,274 * _xScaling,176.5 * _yScaling,);
    path.cubicTo(274 * _xScaling,176.5 * _yScaling,274 * _xScaling,176.5 * _yScaling,274 * _xScaling,176.5 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}