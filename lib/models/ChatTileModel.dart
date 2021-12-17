import 'package:ajanchat/models/ERelationType.dart';

class ChatTileModel {
  String username;
  String lastMessage;
  int unreadCount;
  DateTime lastMessageTime;
  String assetImage;
  bool isOnline;
  ERelationType relationType;
  ChatTileModel({
    required this.username,
    required this.lastMessage,
    required this.unreadCount,
    required this.lastMessageTime,
    required this.assetImage,
    required this.relationType,
    this.isOnline = false
  });
}