import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/pages/tabs/chat/chat_tile.dart';
import 'package:ajanchat/pages/tabs/request/request_tile.dart';
import 'package:ajanchat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  _RequestTabState createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, chatProvider, child) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
          child: GridView.builder(
            itemCount: chatProvider.chats.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
            ),
            itemBuilder: (BuildContext context, index) => RequestTile(
                chatContent: ChatTileModel(
                  relationType: chatProvider.chats[index].relationType,
                  isOnline: chatProvider.chats[index].isOnline,
                  assetImage: chatProvider.chats[index].assetImage,
                  lastMessageTime: chatProvider.chats[index].lastMessageTime,
                  unreadCount: chatProvider.chats[index].unreadCount,
                  lastMessage: chatProvider.chats[index].lastMessage,
                  username: chatProvider.chats[index].username,
                )
            ),
          ),
        )
    );
  }
}
