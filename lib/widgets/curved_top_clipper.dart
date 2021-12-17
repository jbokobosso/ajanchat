import 'package:flutter/material.dart';

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 400;
    final double _yScaling = size.height / 400;
    path.lineTo(0.5 * _xScaling,0.5 * _yScaling);
    path.cubicTo(0.5 * _xScaling,0.5 * _yScaling,409.857 * _xScaling,0.5 * _yScaling,409.857 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(409.857 * _xScaling,0.5 * _yScaling,411.5 * _xScaling,199.7 * _yScaling,411.5 * _xScaling,199.7 * _yScaling,);
    path.cubicTo(411.5 * _xScaling,199.7 * _yScaling,411.5 * _xScaling,250.861 * _yScaling,411.5 * _xScaling,250.861 * _yScaling,);
    path.cubicTo(409.357 * _xScaling,253.243 * _yScaling,398.576 * _xScaling,257.361 * _yScaling,348 * _xScaling,254.998 * _yScaling,);
    path.cubicTo(294.55 * _xScaling,256.614 * _yScaling,301.247 * _xScaling,278.24399999999997 * _yScaling,298.617 * _xScaling,307.491 * _yScaling,);
    path.cubicTo(294.982 * _xScaling,347.907 * _yScaling,263.65500000000003 * _xScaling,328.835 * _yScaling,218.01700000000002 * _xScaling,309.762 * _yScaling,);
    path.cubicTo(159.6 * _xScaling,285.348 * _yScaling,77.745 * _xScaling,260.929 * _yScaling,0.5 * _xScaling,361.274 * _yScaling,);
    path.cubicTo(0.5 * _xScaling,361.274 * _yScaling,0.5 * _xScaling,0.5 * _yScaling,0.5 * _xScaling,0.5 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}