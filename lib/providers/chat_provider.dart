import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatProvider extends ChangeNotifier {

  late Socket socket;

  bool isBusy = false;
  late Stream<QuerySnapshot<Map<String, dynamic>>> streamData;
  List<ChatTileModel> chats = [ChatTileModel(
    assetImage: "https://firebasestorage.googleapis.com/v0/b/ajan-chat.appspot.com/o/pictures%2Fprofile%2Fg27tLsCxxyLzda0c4FxjZkMH5To1%2F1.jpg?alt=media&token=ba6fdf6b-7749-4508-aaaa-9d66f82fc632",
    lastMessage: "hello o",
    lastMessageTime: DateTime.now(),
    relationType: ERelationType.friend,
    unreadCount: 14,
    username: "John DOE",
    isOnline: true
  )];
  TextEditingController chatController = TextEditingController();

  notifyForInputChange() {
    notifyListeners();
  }

  loadChats() async {
    if(chats.isEmpty) {
      streamData = FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where(Globals.FDP_inRelationAjanList, arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

      streamData.listen((QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshotEvent) async {
        List<ChatTileModel> chatTileList = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot in queryDocumentSnapshotEvent.docs) {
          AjanModel ajanModel = AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id);
          List<dynamic> ajanImages = await getAjanListImages(queryDocumentSnapshot.id);
          var tempChatTile = ChatTileModel(
              username: ajanModel.displayName,
              lastMessage: "Hello world !",
              unreadCount: 0,
              lastMessageTime: DateTime.now(),
              assetImage: ajanImages.first,
              relationType: ajanModel.relationPreferences!.relationType
          );
          chatTileList.add(tempChatTile);
        }
        chats = chatTileList;
        notifyListeners();
      });
    }
  }

  Future<List<dynamic>> getAjanListImages(String ajanUid)  async {
    List<dynamic> imagesDownloadUrls = [];
    ListResult listResult = await FirebaseStorage.instance.ref(Globals.FSN_profile_pictures).child(ajanUid).list();
    for (var element in listResult.items) {
      imagesDownloadUrls.add(await element.getDownloadURL());
    }
    return imagesDownloadUrls;
  }

  sendMessage(AjanModel loggedUser) {
    if(chatController.text.isNotEmpty) {
      socket.emit("message", {
        "room": "room-1001",
        "content": chatController.text
      });
    }
  }

  initSocket(){
    try {
      socket = io("ws://192.168.1.66:5000", OptionBuilder().setTransports(['websocket']).disableAutoConnect().setExtraHeaders({'data': 'Spartan'}).build());
      socket.connect();
      socket.on("message", (data) {
        Utils.showToast(data["content"]);
      });
    } catch(e) {
      rethrow;
    }
  }

  disposeSocket() {
    socket.dispose();
  }
}