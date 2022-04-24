import 'dart:ui';

import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/providers/home_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:provider/provider.dart';

class AjanTile extends StatefulWidget {
  AjanModel ajan;

  AjanTile({
    required this.ajan,
    Key? key
  }) : super(key: key);

  @override
  _AjanTileState createState() => _AjanTileState();
}

class _AjanTileState extends State<AjanTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.7,
      height: MediaQuery.of(context).size.height*0.6,
      child: Swipable(
        onSwipeRight: (Offset offset) {
          Provider.of<HomeProvider>(context, listen: false).likeAjan();
        },
        onSwipeLeft: (Offset offset) {
          Provider.of<HomeProvider>(context, listen: false).dislikeAjan();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ListView(
                padding: EdgeInsets.zero,
                children: widget.ajan.images.map((image) => Image.network(image, fit: BoxFit.cover)).toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.11,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 7,
                    sigmaY: 7
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.ajan.displayName}, ${Utils.calculateAge(widget.ajan.birthDate)}",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: widget.ajan.preferences.map(
                              (pref) => Text(pref, style: const TextStyle(color: Colors.white60))
                            ).toList(),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
