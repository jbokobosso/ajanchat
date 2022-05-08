import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/pages/tabs/chat/chat_tile.dart';
import 'package:ajanchat/providers/chat_provider.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, chatProvider, child) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
          child: Stack(
            children: [
              chatProvider.chats.isNotEmpty
                  ? ListView.builder(
                  itemCount: chatProvider.chats.length,
                  itemBuilder: (context, index) => ChatTile(
                      chatContent: ChatTileModel(
                        relationType: chatProvider.chats[index].relationType,
                        isOnline: chatProvider.chats[index].isOnline,
                        assetImage: chatProvider.chats[index].assetImage,
                        lastMessageTime: chatProvider.chats[index].lastMessageTime,
                        unreadCount: chatProvider.chats[index].unreadCount,
                        lastMessage: chatProvider.chats[index].lastMessage,
                        username: chatProvider.chats[index].username,
                      )
                  )
              )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(FileAssets.lottieEmptyBox),
                        Text("Oupsss... Revenez plus tard", style: TextStyle(color: Theme.of(context).primaryColor))
                      ],
                    ),
              chatProvider.isBusy
                  ? const Loading()
                  : Container()
            ],
          ),
        )
    );
  }
}
