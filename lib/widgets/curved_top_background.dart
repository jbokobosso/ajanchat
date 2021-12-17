import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/widgets/curved_top_clipper.dart';
import 'package:flutter/material.dart';

class CurvedTopBackground extends StatelessWidget {

  final double deviceHeight;
  final double clipBarSizeScale;
  CurvedTopBackground({
    required this.deviceHeight,
    required this.clipBarSizeScale
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.deviceHeight*this.clipBarSizeScale,
      child: ClipPath(
        clipper: CurvedTopClipper(),
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(FileAssets.bgImage),
                    fit: BoxFit.cover
                )
            )
        ),
      ),
    );
  }
}
