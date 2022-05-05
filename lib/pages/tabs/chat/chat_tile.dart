import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatTile extends StatefulWidget {

  ChatTileModel chatContent;
  ChatTile({required this.chatContent, Key? key}) : super(key: key);

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(RouteNames.singleChat, arguments: widget.chatContent),
      title: Text(widget.chatContent.username ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      leading: Stack(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(widget.chatContent.assetImage ?? "")),
          widget.chatContent.isOnline == true ? Positioned(
            bottom: -1,
            right: -1,
            child: SvgPicture.asset(FileAssets.onlineIcon, width: MediaQuery.of(context).size.width*0.05,),
          ) : Container(width: 1, height: 1,)
        ],
      ),
      subtitle: Text(widget.chatContent.lastMessage ?? "", style: const TextStyle(color: Colors.blue, fontSize: 10.0)),
      trailing: Column(
        children: [
          Text('${widget.chatContent.lastMessageTime?.hour}:${widget.chatContent.lastMessageTime?.minute}', style: const TextStyle(color: Colors.grey),),
          widget.chatContent.unreadCount! > 0 ? Container(
            height: 25.0,
            width: 25.0,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
            ),
            child: Center(
              child: Text(widget.chatContent.unreadCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10.0)),
            ),
          ) : const SizedBox(width: 1, height: 1)
        ],
      ),
    );
  }
}
