import 'package:flutter/material.dart';

class GradientTile extends StatelessWidget {

  final Alignment tileAlignment;
  final String tileText;
  final bool isBackgroundUnique;
  final double fontSizeScale;

  const GradientTile({
    required this.tileText,
    required this.tileAlignment,
    this.fontSizeScale=0.05,
    this.isBackgroundUnique=false
  });

  @override
  Widget build(BuildContext context) {
    
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    
    return Align(
      alignment: tileAlignment,
      child: Container(
        width: tileAlignment == Alignment.center ? deviceWidth : deviceWidth*0.7,
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth*0.1,
          vertical: deviceHeight*0.010,
        ),
        decoration: isBackgroundUnique ? const BoxDecoration(
          // borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0)),
            color: Colors.black
        ) :
        tileAlignment == Alignment.centerLeft
            ? const BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0)),
            gradient: RadialGradient(
                colors: [Colors.purple, Colors.pinkAccent],
                focal: Alignment.centerRight,
                radius: 5.0
            )):
        tileAlignment == Alignment.centerRight
            ? const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20.0)),
            gradient: RadialGradient(
                colors: [Colors.purple, Colors.pinkAccent],
                focal: Alignment.centerLeft,
                radius: 5.0
            )
        )
            : const BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.purple, Colors.pinkAccent],
                focal: Alignment.center,
                radius: 5.0
            )
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
              tileText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceWidth*fontSizeScale,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
      ),
    );
  }
}
