import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {

  List<ChatTileModel> chats = [
    ChatTileModel(username: "Aristide Karbou", lastMessage: "comment tu vas ?", lastMessageTime: DateTime.now(), unreadCount: 15, assetImage: "assets/images/person-3.jpg", isOnline: true, relationType: ERelationType.flirt),
    ChatTileModel(username: "Bineta Rasmane", lastMessage: "hellow world ?", lastMessageTime: DateTime.now(), unreadCount: 3, assetImage: "assets/images/person-2.jpg", relationType: ERelationType.flirt),
    ChatTileModel(username: "Mamadou Ouegraogo", lastMessage: "salut b ?", lastMessageTime: DateTime.now(), unreadCount: 150, assetImage: "assets/images/person-3.jpg", isOnline: true, relationType: ERelationType.flirt),
    ChatTileModel(username: "Ama KWATCHA", lastMessage: "nick ta mère 😪 ?", lastMessageTime: DateTime.now(), unreadCount: 5, assetImage: "assets/images/person-4.jpg", relationType: ERelationType.serious),
    ChatTileModel(username: "John Doe", lastMessage: "comment tu vas ?", lastMessageTime: DateTime.now(), unreadCount: 0, assetImage: "assets/images/person-3.jpg", relationType: ERelationType.friend),
    ChatTileModel(username: "Gloria", lastMessage: "comment tu vas ?", lastMessageTime: DateTime.now(), unreadCount: 15, assetImage: "assets/images/person-1.jpg", isOnline: true, relationType: ERelationType.serious),
    ChatTileModel(username: "Constance", lastMessage: "comment tu vas ?", lastMessageTime: DateTime.now(), unreadCount: 1, assetImage: "assets/images/person-1.jpg", relationType: ERelationType.friend),
  ];
}