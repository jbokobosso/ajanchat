import 'dart:ui';

import 'package:ajanchat/constants/file_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AjanTile extends StatefulWidget {
  const AjanTile({Key? key}) : super(key: key);

  @override
  _AjanTileState createState() => _AjanTileState();
}

class _AjanTileState extends State<AjanTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: MediaQuery.of(context).size.height*0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Image.asset(FileAssets.ajan1, fit: BoxFit.cover,),
                Image.asset(FileAssets.ajan2, fit: BoxFit.cover,)
              ],
            ),
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text("Samantha, 18", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text("Designer, Adorable, Cinema", style: TextStyle(color: Colors.white))
                ],
              ),
            )
          ),
        )
      ],
    );
  }
}
