import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/pages/tabs/chat/chat_tile.dart';
import 'package:ajanchat/providers/core_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
        builder: (context, coreProvider, child) => ListView.builder(
            itemCount: coreProvider.chatProvider.chats.length,
            itemBuilder: (context, index) => ChatTile(
                chatContent: ChatTileModel(
                  relationType: coreProvider.chatProvider.chats[index].relationType,
                  isOnline: coreProvider.chatProvider.chats[index].isOnline,
                  assetImage: coreProvider.chatProvider.chats[index].assetImage,
                  lastMessageTime: coreProvider.chatProvider.chats[index].lastMessageTime,
                  unreadCount: coreProvider.chatProvider.chats[index].unreadCount,
                  lastMessage: coreProvider.chatProvider.chats[index].lastMessage,
                  username: coreProvider.chatProvider.chats[index].username,
                )
            )
        )
    );
  }
}
