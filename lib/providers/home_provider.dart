import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  List<AjanModel> ajanList = [];
  List<AjanModel> likedAjanList = [];
  late DocumentSnapshot lastReadAjan;
  bool isBusy = true;

  getAjanList() async {
    isBusy = true;
    try {
      List<AjanModel> ajanListTemp =[];
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("isActive", isEqualTo: true)
          .orderBy("createdAt")
          .limit(Globals.maximumAjanLimit)
          .get();
      data.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        ajanListTemp.add(
            AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id)
        );
      });
      ajanList = ajanListTemp;
      lastReadAjan = data.docs.last;
      notifyListeners();
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  getAdditionalAjanList() async {
    isBusy = true;
    notifyListeners();
    try {
      List<AjanModel> ajanListTemp =[];
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("isActive", isEqualTo: true)
          .orderBy("createdAt")
          .startAfter([lastReadAjan.data()])
          .limit(Globals.maximumAjanLimit)
          .get();
      data.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        ajanListTemp.add(
            AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id)
        );
      });
      ajanList = ajanListTemp;
      notifyListeners();
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  likeAjan() {
    ajanList.last.likingsAjans.add(FirebaseAuth.instance.currentUser!.uid);
    AjanModel likedAjan = ajanList.removeLast();
    likedAjanList.add(likedAjan);
    if(kDebugMode) { // saving writes in production: updating database only after ten likes
      if(likedAjanList.isNotEmpty) updateLikedAjanOnFirebase(likedAjanList);
    } else {
      if(likedAjanList.length == Globals.maximumAjanLimit) updateLikedAjanOnFirebase(likedAjanList);
    }

    checkIfAjanListIsEmpty();
  }

  checkIfAjanListIsEmpty() {
    if(ajanList.isEmpty) getAdditionalAjanList();
  }

  updateLikedAjanOnFirebase(List<AjanModel> likedAjanList) {
    for(AjanModel ajanModel in likedAjanList) {
      FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .doc(ajanModel.id)
          .update({'likingsAjans': ajanModel.likingsAjans})
          .then((value) => Utils.showToast("Liké !"))
          .catchError((onError) => throw onError);
    }
  }
}