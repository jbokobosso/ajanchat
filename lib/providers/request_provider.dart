import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/models/ChatTileModel.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {

  bool isBusy = false;
  late Stream<QuerySnapshot<Map<String, dynamic>>> streamData;
  List<AjanModel> requests = [];
  TextEditingController chatController = TextEditingController();

  Future<bool> refuseRequest(String destinationAjanUid) async {
    isBusy = true;
    notifyListeners();
    try {
      var selfDocRef = FirebaseFirestore.instance.collection(Globals.FCN_ajan).doc(FirebaseAuth.instance.currentUser!.uid);
      var destinationAjanDocRef = FirebaseFirestore.instance.collection(Globals.FCN_ajan).doc(destinationAjanUid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Remove myself from his likes
        transaction.update(destinationAjanDocRef, {Globals.FDP_likedAjanList: FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
        // Put each other to one another's dislike list
        transaction.update(destinationAjanDocRef, {Globals.FDP_dislikedAjanList: FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
        transaction.update(selfDocRef, {Globals.FDP_dislikedAjanList: FieldValue.arrayUnion([destinationAjanUid])});
      });
      return true;
    } catch(exception) {
      Utils.showToast("Erreur, reéssayez !");
      return false;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  Future<bool> acceptRequest(String destinationAjanUid) async {
    isBusy = true;
    notifyListeners();
    try {
      String newRoom = 'room-${Timestamp.now().millisecondsSinceEpoch}';
      var selfDocRef = FirebaseFirestore.instance.collection(Globals.FCN_ajan).doc(FirebaseAuth.instance.currentUser!.uid);
      var destinationAjanDocRef = FirebaseFirestore.instance.collection(Globals.FCN_ajan).doc(destinationAjanUid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Put me and the other ajan in the same room for chat
        transaction.update(selfDocRef, {Globals.FDP_chatRooms: FieldValue.arrayUnion([newRoom])});
        transaction.update(destinationAjanDocRef, {Globals.FDP_chatRooms: FieldValue.arrayUnion([newRoom])});
        // Remove myself from his likes
        transaction.update(destinationAjanDocRef, {Globals.FDP_likedAjanList: FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
        // Put each other to one another's relation list
        transaction.update(destinationAjanDocRef, {Globals.FDP_inRelationAjanList: FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
        transaction.update(selfDocRef, {Globals.FDP_inRelationAjanList: FieldValue.arrayUnion([destinationAjanUid])});
      });
      return true;
    } catch(exception) {
      Utils.showToast("Erreur, reéssayez !");
      return false;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  notifyForInputChange() {
    notifyListeners();
  }

  loadRequests() async {
    if(requests.isEmpty) {
      streamData = FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where(Globals.FDP_likedAjanList, arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

      streamData.listen((QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshotEvent) async {
        List<AjanModel> ajanList = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot in queryDocumentSnapshotEvent.docs) {
          AjanModel ajanModel = AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id);
          List<dynamic> ajanImages = await getAjanListImages(queryDocumentSnapshot.id);
          ajanModel.images = ajanImages;
          ajanList.add(ajanModel);
        }
        requests = ajanList;
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