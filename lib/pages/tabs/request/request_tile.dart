import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RequestTile extends StatefulWidget {

  ChatTileModel chatContent;
  RequestTile({required this.chatContent, Key? key}) : super(key: key);

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(widget.chatContent.assetImage ?? ""),
        Container(
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.check_circle, color: Colors.green, size: MediaQuery.of(context).size.width*0.08), onPressed: () {}),
              IconButton(icon: Icon(Icons.close, color: Colors.red, size: MediaQuery.of(context).size.width*0.08), onPressed: () {})
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 25,
          child: Container(
            decoration: BoxDecoration(
              color: Utils.getColorByRelationType(widget.chatContent.relationType!),
              borderRadius: const BorderRadius.all(Radius.circular(5.0))
            ),
            padding: const EdgeInsets.all(5.0),
            child: Text(EnumToString.convertToString(widget.chatContent.relationType), style: const TextStyle(color: Colors.white),),
          ),
        ),
      ],
    );
  }
}
