import 'dart:ui';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/providers/home_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_image/shimmer_image.dart';

class AjanTile extends StatefulWidget {
  final AjanModel ajan;

  const AjanTile({
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
      // width: MediaQuery.of(context).size.width*0.7,
      // height: MediaQuery.of(context).size.height*0.6,
      width: 300,
      height: 300,
      child: Swipable(
        onSwipeRight: (Offset offset) {
          Provider.of<HomeProvider>(context, listen: false).likeAjan(context, widget.ajan);
        },
        onSwipeLeft: (Offset offset) {
          Provider.of<HomeProvider>(context, listen: false).dislikeAjan(context, widget.ajan);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ListView(
                padding: EdgeInsets.zero,
                // children: widget.ajan.images.map((image) => Image.network(image, fit: BoxFit.cover)).toList(),
                children: widget.ajan.images.map((image) => ProgressiveImage(
                  image: image,
                  width: 300.0,
                  height: 300.0,
                  baseColor: Colors.white,
                  highlightColor: const Color.fromRGBO(255, 116, 198, 0.05),
                  imageError: "Pas de connexion",
                )).toList(),
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
                              (pref) => Text("$pref ${widget.ajan.preferences.indexOf(pref) == widget.ajan.preferences.length-1 ? '' : ' | '}", style: const TextStyle(color: Colors.white60))
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
