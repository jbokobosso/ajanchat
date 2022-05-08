import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/providers/request_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_image/shimmer_image.dart';

class RequestTile extends StatefulWidget {

  AjanModel ajanModel;
  RequestTile({required this.ajanModel, Key? key}) : super(key: key);

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
      builder: (context, requestProvider, child) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Image.network(widget.ajanModel.images.first as String),
          ProgressiveImage(
            image: widget.ajanModel.images.first,
            width: double.maxFinite,
            height: double.maxFinite,
            baseColor: Colors.white,
            highlightColor: const Color.fromRGBO(255, 116, 198, 0.05),
            imageError: "Pas de connexion",
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.width*0.08
                  ),
                  onPressed: () => requestProvider.acceptRequest(widget.ajanModel.id)
              ),
                IconButton(
                  icon: Icon(
                    Icons.close, color: Colors.red,
                    size: MediaQuery.of(context).size.width*0.08),
                  onPressed: () => requestProvider.refuseRequest(widget.ajanModel.id)
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 25,
            child: Container(
              decoration: BoxDecoration(
                  color: Utils.getColorByRelationType(widget.ajanModel.relationPreferences!.relationType!),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(EnumToString.convertToString(widget.ajanModel.relationPreferences!.relationType), style: const TextStyle(color: Colors.white),),
            ),
          ),
        ],
      )
    );
  }
}
