import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {

  late Stream<QuerySnapshot<Map<String, dynamic>>> streamData;
  List<ChatTileModel> chats = [];
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
}