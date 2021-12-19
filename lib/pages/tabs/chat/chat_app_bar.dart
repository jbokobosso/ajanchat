import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/relation_type_colors.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/widgets/bottom_navigation/TopClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {

  ChatTileModel chatContent;
  late Color relationTypeColor;
  TextStyle popStyle = const TextStyle(color: Colors.white);
  double popMenuBorderRadius = 45.0;

  ChatAppBar({required this.chatContent, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    switch(chatContent.relationType)
    {
      case ERelationType.friend :
        relationTypeColor = FriendColor;
        break;

      case ERelationType.serious :
        relationTypeColor = SeriousColor;
        break;

      case ERelationType.flirt :
        relationTypeColor = FlirtColor;
        break;
    }

    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(backgroundImage: AssetImage(chatContent.assetImage ?? "")),
              chatContent.isOnline == true ? Positioned(
                bottom: -1,
                right: -1,
                child: SvgPicture.asset(FileAssets.onlineIcon, width: MediaQuery.of(context).size.width*0.05,),
              ) : Container(width: 1, height: 1,)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatContent.username ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15.0)),
                Text('En ligne', style: TextStyle(color: relationTypeColor, fontSize: 10.0))
              ],
            ),
          )
        ],
      ),
      flexibleSpace: ClipPath(
        clipper: TopClipper(),
        child: Container(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        PopupMenuButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(popMenuBorderRadius),
            topRight: const Radius.circular(5.0),
            bottomLeft: Radius.circular(popMenuBorderRadius),
            bottomRight: Radius.circular(popMenuBorderRadius),
          )),
          color: relationTypeColor,
          child: SvgPicture.asset('assets/icons/options.svg', width: 33,),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                textStyle: const TextStyle(color: Colors.black),
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/lock.svg', width: 15),
                      Text("Bloquer l'utilisateur", style: popStyle)
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                textStyle: const TextStyle(color: Colors.black),
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/trash.svg', width: 15),
                      Text("Effacer l'historique", style: popStyle)
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                textStyle: const TextStyle(color: Colors.black),
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/silent-notif.svg', width: 15),
                      Text("Notif silencieuse", style: popStyle)
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                textStyle: const TextStyle(color: Colors.black),
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/search.svg', width: 15),
                      Text("Recherche", style: popStyle)
                    ],
                  ),
                ),
              ),
            ];
          },
          onCanceled: () => print('hey'),
          onSelected: (event) => print('Spartanovich_117'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);


}
